ESX                = nil
local InService    = {}
local MaxInService = {}

local timers = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local serviceAllowedJobs = {
	['reporter'] = true,
	['police'] = "police",
	['police2'] = "police",
	['sheriff'] = "police",
	['fib'] = "police",
	['mechanic'] = "mechanic",
	['bennys'] = "mechanic",
	['driftkingz'] = "mechanic",
	['chatarra'] = "mechanic",
	['sanders'] = "mechanic",
	['taxi'] = true,
	['ambulance'] = true,
}

function GetInServiceCount(name)
	local count = 0

	if InService[name] then
		for k,v in pairs(InService[name]) do
			if v == true then
				count = count + 1
			end
		end
	end

	return count
end

AddEventHandler('esx_service:activateService', function(name, max)
	name = ((type(serviceAllowedJobs[name]) == "string") and serviceAllowedJobs[name] or name)
	InService[name]    = {}
	MaxInService[name] = max
end)

RegisterServerEvent('esx_service:disableService')
AddEventHandler('esx_service:disableService', function(name)
	name = ((type(serviceAllowedJobs[name]) == "string") and serviceAllowedJobs[name] or name)
	InService[name][source] = nil
	endTimer(source, name)
end)

RegisterServerEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, name)
	name = ((type(serviceAllowedJobs[name]) == "string") and serviceAllowedJobs[name] or name)
	for k,v in pairs(InService[name]) do
		if v == true then
			TriggerClientEvent('esx_service:notifyAllInService', k, notification, source)
		end
	end
end)

function endTimer(source, name)
	if name == nil then
		if timers[source] == nil then
			return
		else
			if timers[source] == nil then
				for k,v in pairs(timers[source]) do
					endTimer(source, k)
				end
			end
			return
		end
	end
	if timers[source] ~= nil and timers[source][name] ~= nil and tonumber(timers[source][name]) then
		local duration = os.time() - timers[source][name]
		local extraSeconds = duration%60
		local minutes = (duration-extraSeconds)/60
		local msg = ""
		if duration >= 60 then
			if minutes >= 60 then
				local extraMinutes = minutes%60
				local hours = (minutes-extraMinutes)/60
				msg = math.floor(hours) .. " horas y " .. math.ceil(extraMinutes) .. " minutos"
			else
				msg = math.floor(minutes) .. " minutos y " .. extraSeconds .. " segundos"
			end
		else
			msg = "menos de 1 minuto"
		end
		timers[source] = nil
		if duration > 4 then
			local faccion, webhook = name, GetConvar("webhook_servicio", "1")
			local discordId = nil
			for _, id in ipairs(GetPlayerIdentifiers(source)) do
				if string.match(id, "discord:") then
					discordId = string.gsub(id, "discord:", "")
					--print("Found discord id: "..discordId)
					break
				end
			end
			if name == "police" or name == "sheriff" then
				faccion = "SAPD (LSPD/LSSD)"
				TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_sapdservicios", "1"), "SERVICIO TERMINADO", "❌ **__USUARIO__: `" .. GetPlayerName(source) .. " [ID:" .. source .. "]`** (<@" .. discordId .. ">). **__DURACIÓN__:** `" .. msg .. "`.", 'steam', true, source)
			elseif name == "ambulance" then
				faccion = "SAFD"
				TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_safdservicios", "1"), "SERVICIO TERMINADO", "❌ **__USUARIO__: `" .. GetPlayerName(source) .. " [ID:" .. source .. "]`** (<@" .. discordId .. ">). **__DURACIÓN__:** `" .. msg .. "`.", 'steam', true, source)
			elseif name == "mechanic" or name == "bennys" or name == "driftkingz" or name == "sanders" or name == "chatarra" then
				faccion = "trabajador del taller"
			elseif name == "taxi" then
				faccion = "taxista"
			end
			TriggerEvent('DiscordBot:ToDiscord', webhook, "SERVICIO TERMINADO", "❌ **__USUARIO__: `" .. GetPlayerName(source) .. " [ID:" .. source .. "]`** (<@" .. discordId .. ">). **__FACCIÓN:__ `" .. faccion .. "`**. **__DURACIÓN__:** `" .. msg .. "`.", 'steam', true, source)
		end
	end
end

ESX.RegisterServerCallback('esx_service:enableService', function(source, cb, name)

	name = ((type(serviceAllowedJobs[name]) == "string") and serviceAllowedJobs[name] or name)

	if InService[name] == nil then
		if serviceAllowedJobs[name] then
			InService[name] = {}
			MaxInService[name] = -1
		else
			cb(false)
		end
	end

	local inServiceCount = GetInServiceCount(name)

	if timers[source] == nil then
		timers[source] = { [name] = os.time() }
	else
		for k,v in pairs(timers[source]) do
			if k ~= name then
				endTimer(source, name)
			end
		end
	end

	if (MaxInService[name] ~= nil and MaxInService[name] ~= -1) then
		if (inServiceCount >= MaxInService[name]) then
			cb(false, MaxInService[name], inServiceCount)
		end
	end
	InService[name][source] = true
	cb(true, MaxInService[name], inServiceCount)
	--print("El usuario " .. GetPlayerName(source) .. "^0 [ID: " .. source .. "] ^2ENTRÓ DE SERVICIO EN " .. string.upper(name) .. ".")
	Citizen.CreateThread(function()
		local startTime, continue, duration = os.time(), false, 0
		for i=1, 500, 1 do
			if InService[name][source] == false then
				--print("InService[name][source] == false en i = " .. i .. ".")
				return
			end
			Citizen.Wait(10)
			if i > 490 then
				continue = true
			end
		end
		if continue then
			duration = math.floor((os.time() - startTime)*100)/100
			local faccion, webhook = name, GetConvar("webhook_servicio", "1")
			local discordId = nil
			for _, id in ipairs(GetPlayerIdentifiers(source)) do
				if string.match(id, "discord:") then
					discordId = string.gsub(id, "discord:", "")
					--print("Found discord id: "..discordId)
					break
				end
			end
			if name == "police" or name == "sheriff" then
				faccion = "SAPD (LSPD/LSSD)"
				TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_sapdservicios", "1"), "SERVICIO COMENZADO", "✅ **__USUARIO__: `" .. GetPlayerName(source) .. " [ID:" .. source .. "]`** (<@" .. discordId .. ">).", 'steam', true, source)
			elseif name == "ambulance" then
				faccion = "SAFD"
				TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_safdservicios", "1"), "SERVICIO COMENZADO", "✅ **__USUARIO__: `" .. GetPlayerName(source) .. " [ID:" .. source .. "]`** (<@" .. discordId .. ">).", 'steam', true, source)
			elseif name == "mechanic" or name == "bennys" or name == "driftkingz" or name == "sanders" or name == "chatarra" then
				faccion = "trabajador del taller"
			elseif name == "taxi" then
				faccion = "taxista"
			end
			TriggerEvent('DiscordBot:ToDiscord', webhook, "SERVICIO COMENZADO", "✅ **__USUARIO__: `" .. GetPlayerName(source) .. " [ID:" .. source .. "]`** (<@" .. discordId .. ">). **__FACCIÓN:__ `" .. faccion .. "`**.", 'steam', true, source)
		else
			print("El usuario " .. GetPlayerName(source) .. "^0 [ID: " .. source .. "] ^2ENTRÓ DE SERVICIO EN " .. string.upper(name) .. " pero estuvo menos de 5 segundos.")
		end
	end)
end)

ESX.RegisterServerCallback('esx_service:isInService', function(source, cb, name)
	local isInService = false
	--print("191")
	name = ((type(serviceAllowedJobs[name]) == "string") and serviceAllowedJobs[name] or name)
	--print("193")
	if InService[name] == nil then
		--print("195")
		if serviceAllowedJobs[name] then
			--print("esx_service:isInService", name)
			InService[name] = {}
			MaxInService[name] = -1
		else
			--print("cb false")
			cb(false)
		end
	end

	if InService[name][source] then
		--print("true")
		isInService = true
	end

	--print("cb")
	cb(isInService)
end)

AddEventHandler('esx_service:isInService', function(cb, payload)
	local isInService = false
	local name = ((type(serviceAllowedJobs[payload[2]]) == "string") and serviceAllowedJobs[payload[2]] or payload[2])
	--print("esx_service:isInService", name)

	if InService[name] == nil then
		if serviceAllowedJobs[name] then
			InService[name] = {}
			MaxInService[name] = -1
		else
			cb(false)
		end
	end

	if InService[name][payload[1]] then
		isInService = true
	end

	cb(isInService)
end)

ESX.RegisterServerCallback('esx_service:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

RegisterServerEvent('esx_service:getInServiceList')
AddEventHandler('esx_service:getInServiceList', function(callback, name)
    callback(InService[name])
end)

AddEventHandler('esx_service:getInServiceCount', function(callback, name)
	local inServiceCount
	if name then
		inServiceCount = GetInServiceCount(name)
		callback(inServiceCount)
	else
		inServiceCount = {}
		inServiceCount['police'] = GetInServiceCount('police')
		inServiceCount['ambulance'] = GetInServiceCount('ambulance')
		inServiceCount['taxi'] = GetInServiceCount('taxi')
		inServiceCount['mechanic'] = GetInServiceCount('mechanic')
		callback(inServiceCount)
	end
end)

ESX.RegisterServerCallback('esx_service:getInServiceCount', function(source, cb)
	local inServiceCount = {}
	inServiceCount['police'] = GetInServiceCount('police')
	inServiceCount['ambulance'] = GetInServiceCount('ambulance')
	inServiceCount['taxi'] = GetInServiceCount('taxi')
	inServiceCount['mechanic'] = GetInServiceCount('mechanic')
	cb(inServiceCount)
end)

local dropped = {}

AddEventHandler('playerDropped', function()
	local _source = source
	Citizen.Wait(5000)
	if not GetPlayerName(_source) then
		endTimer(_source, name)

		dropped[_source] = true

		for k,v in pairs(InService) do
			if v[_source] == true then
				v[_source] = nil
			end
		end
	end
end)

--[[TriggerEvent('es:addGroupCommand', 'listarenservicio', 'admin', function(source, args, user)
	local trabajo = ""
	if args[1] ~= nil then trabajo=args[1] end
	if trabajo == 'police' or trabajo == 'ambulance' or trabajo == 'mechanic' or trabajo == 'taxi' then
		--local textToPrint = ESX.DumpTable(InService[trabajo])
		--Citizen.Wait(300)
		--print(textToPrint)
		for k,v in pairs(InService[trabajo]) do
			if v == true then
				print(GetPlayerName(k).." ["..k.."]")
			end
		end
	end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { "^1DEBUG: ", "Permisos insuficientes!" } })
end, { help = "Listar miembros de facción en servicio", params =  {{ name = 'police|ambulance|mechanic|taxi' }}  })]]

local cooldown = false

local multipliers = {
	['police'] = 8.0,
	['sheriff'] = 8.0,
	['sheriff2'] = 8.0,
	['ambulance'] = 8.0,
	['mechanic'] = 6.0,
	['taxi'] = 6.0,
}

AddEventHandler('mancos:payInService', function(overridecooldown)
	if not cooldown or overridecooldown then
		--TriggerEvent("esx_xp:addToAll", 1)
		for service, multiplier in pairs(multipliers) do
			if InService[service] ~= nil and multiplier ~= nil and multiplier > 0 then
				for id, inService in pairs(InService[service]) do
					if inService then
						local xPlayer = ESX.GetPlayerFromId(id)
						local salary = xPlayer.job.grade_salary*multiplier
						cooldown = true
						xPlayer.addAccountMoney('bank', salary, 'Salario (Paga extra)')
						TriggerClientEvent("chat:addMessage", id, {args={"^*^1PAGA EXTRA:^r", "cobraste tu sueldo al completo (extra: " .. salary .. GetConvar("server_divisa", "$") .. ") por estar en servicio"}})
						print("^*^1PAGA EXTRA:^r", xPlayer.name, ("[ID:" .. xPlayer.source .. "]"), "cobró su sueldo al completo (extra: " .. salary .. GetConvar("server_divisa", "$") .. ") por estar en servicio")
					end
				end
			end
			Citizen.Wait(0)
		end

		Citizen.Wait(29*60*1000)
		cooldown = false

		--[[for k,v in pairs(InService['police']) do
		
			if v == true then
				local xPlayer = ESX.GetPlayerFromId(k)
				if xPlayer ~= nil then
					local salary = xPlayer.job.grade_salary*6
					cooldown = true
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent("chat:addMessage", k, {args={"^*^1PAGA EXTRA:^r", "cobraste tu sueldo al completo por estar en servicio"}})
					--print(GetPlayerName(k).." ["..k.."]")
				end
			else
				--no ganaste tu salario extra porque no estabas de servicio
			end
		end
		for k,v in pairs(InService['ambulance']) do
		
			if v == true then
				local xPlayer = ESX.GetPlayerFromId(k)
				if xPlayer ~= nil then
					local salary = xPlayer.job.grade_salary*4
					cooldown = true
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent("chat:addMessage", k, {args={"^*^1PAGA EXTRA:^r", "cobraste tu sueldo al completo por estar en servicio"}})
					--print(GetPlayerName(k).." ["..k.."]")
				end
			else
				--no ganaste tu salario extra porque no estabas de servicio
			end
		end
		for k,v in pairs(InService['mechanic']) do
		
			if v == true then
				local xPlayer = ESX.GetPlayerFromId(k)
				if xPlayer ~= nil then
					local salary = xPlayer.job.grade_salary*2
					cooldown = true
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent("chat:addMessage", k, {args={"^*^1PAGA EXTRA:^r", "cobraste tu sueldo al completo por estar en servicio"}})
					--print(GetPlayerName(k).." ["..k.."]")
				end
			else
				--no ganaste tu salario extra porque no estabas de servicio
			end
		end
		for k,v in pairs(InService['taxi']) do
		
			if v == true then
				local xPlayer = ESX.GetPlayerFromId(k)
				if xPlayer ~= nil then
					local salary = xPlayer.job.grade_salary*2
					cooldown = true
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent("chat:addMessage", k, {args={"^*^1PAGA EXTRA:^r", "cobraste tu sueldo al completo por estar en servicio"}})
					--print(GetPlayerName(k).." ["..k.."]")
				end
			else
				--no ganaste tu salario extra porque no estabas de servicio
			end
		end]]
	end
end)

--local count = 1
RegisterCommand("vesmf", function(source, args, rawCommand)
	--print("vesmf " .. count); count = count + 1;
	local done = false
	local stuff = "Pasos:"
	local xPlayer = ESX.GetPlayerFromId(source)
	Citizen.CreateThread(function()
		if source == 0 or IsPlayerAceAllowed(source, "staff") or ((xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff') and xPlayer.job.grade >= 7) or (xPlayer.job.grade_name == 'boss' and (xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'mechanic' or xPlayer.job.name == 'bennys' or xPlayer.job.name == 'chatarra' or xPlayer.job.name == 'taxi')) then
			local trueJobs = {}
			stuff = stuff .. " 1A"
			--print("vesmf " .. count); count = count + 1;
			local xPlayers, foundAny, InService2, gradeName, msg = ESX.GetPlayers(), false, {}, {}, "^2Estado de servicio de miembros de facciones oficiales:\n"
			for i=1, #xPlayers, 1 do
				--print("vesmf A");
				local id = tonumber(xPlayers[i])
				if dropped[id] == nil then
					--print("vesmf B")
					local zPlayer = ESX.GetPlayerFromId(id)
					local zJob = zPlayer.job.name
					trueJobs[id] = zPlayer.job.label
					if serviceAllowedJobs[zJob] ~= nil then
						local zJob = ((type(serviceAllowedJobs[zJob]) == "string") and serviceAllowedJobs[zJob] or zJob)
						--print("vesmf C")
						gradeName[id] = zPlayer.job.grade_label
						if InService2[zJob] == nil then InService2[zJob] = {} end
						--print("vesmf D")
						if InService[zJob] == nil then InService[zJob] = {} end
						if InService[zJob][id] then
							--print("vesmf E")
							InService2[zJob][id] = true
						else
							--print("vesmf F")
							InService2[zJob][id] = false
						end
					end
				end
				--print("vesmf G")
				Citizen.Wait(0)
			end
			stuff = stuff .. " 2"
			--print("vesmf " .. count); count = count + 1;
	
			--print("gradeName: " .. json.encode(gradeName))
			--print("xPlayers: " .. json.encode(xPlayers))
			--print("InService: " .. json.encode(InService))
			--print("InService2: " .. json.encode(InService2))
	
			msg = msg .. "^4POLICÍA:\n^0"
			if InService2["police"] ~= nil then
				stuff = stuff .. " 3"
				for k,v in pairs(InService2["police"]) do
					foundAny = true
					if v then
						msg = msg .. "- ^2DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. trueJobs[k] .. " - " .. gradeName[k] .. "]\n"
					else
						msg = msg .. "- ^1FUERA DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. trueJobs[k] .. " - " .. gradeName[k] .. "]\n"
					end
				end
			end
			if not foundAny then
				stuff = stuff .. " 4A"
				msg = msg .. "- NO HAY MIEMBROS DE ESTA FACCIÓN CONECTADOS^0"
			else
				stuff = stuff .. " 4B"
				foundAny = false
			end
			--print("vesmf " .. count); count = count + 1;
		
			msg = msg .. "\n^9SAFD:\n^0"
			if InService2["ambulance"] ~= nil then
				stuff = stuff .. " 5"
				for k,v in pairs(InService2["ambulance"]) do
					foundAny = true
					if v then
						msg = msg .. "- ^2DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. gradeName[k] .. "]\n"
					else
						msg = msg .. "- ^1FUERA DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. gradeName[k] .. "]\n"
					end
				end
			end
			if not foundAny then
				stuff = stuff .. " 6A"
				msg = msg .. "- NO HAY MIEMBROS DE ESTA FACCIÓN CONECTADOS^0"
			else
				stuff = stuff .. " 6B"
				foundAny = false
			end
			--print("vesmf " .. count); count = count + 1;
		
			msg = msg .. "\n^5TALLER:\n^0"
			if InService2["mechanic"] ~= nil then
				stuff = stuff .. " 7"
				for k,v in pairs(InService2["mechanic"]) do
					foundAny = true
					if v then
						msg = msg .. "- ^2DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. trueJobs[k] .. " - " .. gradeName[k] .. "]\n"
					else
						msg = msg .. "- ^1FUERA DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. trueJobs[k] .. " - " .. gradeName[k] .. "]\n"
					end
				end
			end
			if not foundAny then
				stuff = stuff .. " 8A"
				msg = msg .. "- NO HAY MIEMBROS DE ESTA FACCIÓN CONECTADOS^0"
			else
				stuff = stuff .. " 8B"
				foundAny = false
			end
			--print("vesmf " .. count); count = count + 1;
		
			msg = msg .. "\n^3TAXI:\n^0"
			if InService2["taxi"] ~= nil then
				stuff = stuff .. " 9"
				for k,v in pairs(InService2["taxi"]) do
					foundAny = true
					if v then
						msg = msg .. "- ^2DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. gradeName[k] .. "]\n"
					else
						msg = msg .. "- ^1FUERA DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. gradeName[k] .. "]\n"
					end
				end
			end
			if not foundAny then
				stuff = stuff .. " 10A"
				msg = msg .. "- NO HAY MIEMBROS DE ESTA FACCIÓN CONECTADOS^0"
			else
				stuff = stuff .. " 10B"
				foundAny = false
			end
			--print("vesmf " .. count); count = count + 1;
		
			msg = msg .. "\n^7REPORTEROS:\n^0"
			if InService2["reporter"] ~= nil then
				stuff = stuff .. " 9"
				for k,v in pairs(InService2["reporter"]) do
					foundAny = true
					if v then
						msg = msg .. "- ^2DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. gradeName[k] .. "]\n"
					else
						msg = msg .. "- ^1FUERA DE SERVICIO^0: " .. GetPlayerName(k) .. "^0 [ID: " .. k .. "] [RANGO: " .. gradeName[k] .. "]\n"
					end
				end
			end
			if not foundAny then
				stuff = stuff .. " 11A"
				msg = msg .. "- NO HAY MIEMBROS DE ESTA FACCIÓN CONECTADOS^0"
			else
				stuff = stuff .. " 11B"
				foundAny = false
			end
			--print("vesmf " .. count); count = count + 1;
	
			if source == 0 then
				stuff = stuff .. " 12A"
				print(msg)
			else
				stuff = stuff .. " 12B"
				print("VesMF enviado a " .. xPlayer.name .. " [ID: " .. xPlayer.source .. "]")
				TriggerClientEvent("esx_service:vesmfShow", source, msg)
			end
			--print("funca")

			done = true

		else
			stuff = stuff .. " 1B"
	
			TriggerClientEvent("chat:addMessage", source, { args = { "^1SERVICIO: ", "^0No tienes permiso para usar esto" } })

			done = true

		end
		stuff = stuff .. " 12"
		-- count = 1
	end)
	for i = 1, 20, 1 do
		if done then
			break
		end
		Citizen.Wait(250)
	end
	print(stuff)
end)

AddEventHandler("esx_service:TriggerEventToAllInService", function (eventName, faction, ...)
	if InService[faction] == nil then
		if serviceAllowedJobs[faction] then
			faction = ((type(serviceAllowedJobs[faction]) == "string") and serviceAllowedJobs[faction] or faction)
			InService[faction] = {}
			MaxInService[faction] = -1
		else
			return
		end
	else
		faction = ((type(serviceAllowedJobs[faction]) == "string") and serviceAllowedJobs[faction] or faction)
	end
	if InService[faction] ~= nil then
		for k,v in pairs(InService[faction]) do
			if v == true then
				TriggerClientEvent(eventName, k, ...)
			end
		end
	end
end)
