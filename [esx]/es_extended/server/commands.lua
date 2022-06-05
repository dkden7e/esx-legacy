QueServer = GetConvar("server_number", "1")
local isTencity = (QueServer == "TENCITY")
local divisa = GetConvar("server_divisa", "$")

ESX.RegisterCommand('setcoords', 'staff2', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', 'staff2', function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
		local job = ESX.Jobs[args.job]
		local jobLabel, jobGrade = (job and job.label or false), (job and (job.grades[args.grade] and job.grades[args.grade].label or false) or false)
		if jobLabel and jobGrade then
			local hora = os.date("%X")
			local discord1 = string.gsub(xPlayer.discord, "discord:", "")
			if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
			TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha cambiado el trabajo del usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] a  (`/setjob " .. args.job .. " " .. args.grade .. "`).", 'steam', true, xPlayer.source)
		end
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('car', 'staff3', function(xPlayer, args, showError)
	local playerPed = GetPlayerPed(xPlayer.source)
	local vehicle = GetVehiclePedIsIn(playerPed)
	if vehicle then DeleteEntity(vehicle) end

	ESX.OneSync.SpawnVehicle(args.car or `baller2`, GetEntityCoords(playerPed), GetEntityHeading(playerPed), function(car)
		local timeout = 50
		repeat
			Wait(0)
			timeout -= 1
			SetPedIntoVehicle(playerPed, car, -1)
		until GetVehiclePedIsIn(playerPed, false) ~= 0 or timeout < 1
		Citizen.Wait(100)
		local netID = NetworkGetNetworkIdFromEntity(car)
		if netID then
			xPlayer.triggerEvent('cd_garage:AddKeys2', netID)
		end
	end)

	local hora = os.date("%X")
	local discord1 = string.gsub(xPlayer.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/car " .. args.car .. "`** para  spawnear un vehículo.", 'steam', true, xPlayer.source)

end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car', help = _U('command_car_car'), type = 'any'}
}})

ESX.RegisterCommand({'dv'}, 'admin', function(xPlayer, args, showError)
	local playerPed = GetPlayerPed(xPlayer.source)
	local vehicle = GetVehiclePedIsIn(playerPed)

	if vehicle ~= 0 then
		DeleteEntity(vehicle)
	else
		vehicle = ESX.OneSync.GetVehiclesInArea(GetEntityCoords(playerPed), tonumber(args.radius) or 3)
		for i = 1, #vehicle do
			DeleteEntity(vehicle[i].entity)
		end
	end

	local hora = os.date("%X")
	local discord1 = string.gsub(xPlayer.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/dv" .. (tonumber(args.radius) and (" " .. args.radius) or "") .. "`** para eliminar vehículo/s dentro del radio elegido en las coordenadas `" .. tostring(GetEntityCoords(playerPed)) .. "`.", 'steam', true, xPlayer.source)
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius', help = _U('command_cardel_radius'), type = 'any'}
}})

ESX.RegisterCommand({'dv2'}, 'admin', function(xPlayer, args, showError)
	local playerPed = GetPlayerPed(args.playerId.source)
	local vehicle = GetVehiclePedIsIn(playerPed)

	local count = 0
	if vehicle ~= 0 then
		DeleteEntity(vehicle)
	else
		vehicle = ESX.OneSync.GetVehiclesInArea(GetEntityCoords(playerPed), tonumber(args.radius) or 3)
		count = #vehicle
		for i = 1, count do
			DeleteEntity(vehicle[i].entity)
		end
	end

	local hora = os.date("%X")
	local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/dv2 " .. args.playerId.source .. "`** para eliminar " .. ((count > 0) and (count .. " vehículos cercanos al") or "el vehículo del") .. " usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ") en las coordenadas `" .. tostring(GetEntityCoords(playerPed)) .. "`.", 'steam', true, xPlayer.source)
end, false, {help = _U('command_cardel'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('setaccountmoney', 'admin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)

		local hora = os.date("%X")
		local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
		if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
		if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
		TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/setaccountmoney " .. args.playerId.source .. " " .. args.account .. " " .. args.amount .. "`** para asignar " .. args.amount .. divisa .. " a la cuenta " .. args.account .. " del usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ").", 'steam', true, xPlayer.source)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_setaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_setaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('giveaccountmoney', 'admin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		local prev = args.playerId.getAccount(args.account).money
		args.playerId.addAccountMoney(args.account, args.amount)

		local hora = os.date("%X")
		local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
		if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
		if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
		TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/giveaccountmoney " .. args.playerId.source .. " " .. args.account .. " " .. args.amount .. "`** para sumar **`" .. args.amount .. divisa .. "`** a la cuenta **`" .. args.account .. "`** del usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. "), que previamente tenía **`" .. prev .. divisa .. "`**.", 'steam', true, xPlayer.source)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_giveaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_giveaccountmoney_amount'), type = 'number'}
}})

if not Config.OxInventory then
	ESX.RegisterCommand('giveitem', 'admin', function(xPlayer, args, showError)
		args.playerId.addInventoryItem(args.item, args.count)
	end, true, {help = _U('command_giveitem'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'item', help = _U('command_giveitem_item'), type = 'item'},
		{name = 'count', help = _U('command_giveitem_count'), type = 'number'}
	}})

	ESX.RegisterCommand('giveweapon', 'admin', function(xPlayer, args, showError)
		if args.playerId.hasWeapon(args.weapon) then
			showError(_U('command_giveweapon_hasalready'))
		else
			args.playerId.addWeapon(args.weapon, args.ammo)
		end
	end, true, {help = _U('command_giveweapon'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'weapon', help = _U('command_giveweapon_weapon'), type = 'weapon'},
		{name = 'ammo', help = _U('command_giveweapon_ammo'), type = 'number'}
	}})

	ESX.RegisterCommand('giveweaponcomponent', 'admin', function(xPlayer, args, showError)
		if args.playerId.hasWeapon(args.weaponName) then
			local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

			if component then
				if args.playerId.hasWeaponComponent(args.weaponName, args.componentName) then
					showError(_U('command_giveweaponcomponent_hasalready'))
				else
					args.playerId.addWeaponComponent(args.weaponName, args.componentName)
				end
			else
				showError(_U('command_giveweaponcomponent_invalid'))
			end
		else
			showError(_U('command_giveweaponcomponent_missingweapon'))
		end
	end, true, {help = _U('command_giveweaponcomponent'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'weaponName', help = _U('command_giveweapon_weapon'), type = 'weapon'},
		{name = 'componentName', help = _U('command_giveweaponcomponent_component'), type = 'string'}
	}})
end

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = _U('command_clear')})

ESX.RegisterCommand({'clearall', 'clsall'}, 'staff3', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
	local hora = os.date("%X")
	local discord1 = string.gsub(xPlayer.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/clearall`** para limpiar los chats de todos los jugadores.", 'steam', true, xPlayer.source)
end, false, {help = _U('command_clearall')})

if not Config.OxInventory then
	ESX.RegisterCommand('clearinventory', 'admin', function(xPlayer, args, showError)
		for k,v in ipairs(args.playerId.inventory) do
			if v.count > 0 then
				args.playerId.setInventoryItem(v.name, 0)
			end
		end
	end, true, {help = _U('command_clearinventory'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
	}})

	ESX.RegisterCommand('clearloadout', 'admin', function(xPlayer, args, showError)
		for i=#args.playerId.loadout, 1, -1 do
			args.playerId.removeWeapon(args.playerId.loadout[i].name)
		end
	end, true, {help = _U('command_clearloadout'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
	}})
end

ESX.RegisterCommand('setgroup', 'admin', function(xPlayer, args, showError)
	if not args.playerId then args.playerId = xPlayer.source end
	if args.group == "superadmin" then args.group = "admin" end
	args.playerId.setGroup(args.group)
	local hora = os.date("%X")
	local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/setgroup " .. args.playerId.source .. " " .. args.group .. "`** para asignar el grupo " .. args.group .. " al usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ").", 'steam', true, xPlayer.source)
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('save', 'staff2', function(xPlayer, args, showError)
	Core.SavePlayer(args.playerId)
	print("[^2Info^0] Saved Player!")
end, true, {help = _U('command_save'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('saveall', 'staff4', function(xPlayer, args, showError)
	Core.SavePlayers()
end, true, {help = _U('command_saveall')})

ESX.RegisterCommand('group', {"user", "staff1"}, function(xPlayer, args, showError)
	print(xPlayer.getName()..", You are currently: ^5".. xPlayer.getGroup() .. "^0")
end, true)

ESX.RegisterCommand('job', {"user", "staff1"}, function(xPlayer, args, showError)
print(xPlayer.getName()..", You are currently: ^5".. xPlayer.getJob().name.. "^0 - ^5".. xPlayer.getJob().grade_label .. "^0")
end, true)

ESX.RegisterCommand('info', {"user", "staff1"}, function(xPlayer, args, showError)
	local job = xPlayer.getJob().name
	local jobgrade = xPlayer.getJob().grade_name
	print("^2ID : ^5"..xPlayer.source.." ^0| ^2Name:^5"..xPlayer.getName().." ^0 | ^2Group:^5"..xPlayer.getGroup().."^0 | ^2Job:^5".. job.."^0")
	end, true)

ESX.RegisterCommand('coords', "staff1", function(xPlayer, args, showError)
	local coords = GetEntityCoords(GetPlayerPed(xPlayer.source), false)
  local heading = GetEntityHeading(GetPlayerPed(xPlayer.source))
	print("Coords - Vector3: ^5".. vector3(coords.x,coords.y,coords.z).. "^0")
	print("Coords - Vector4: ^5".. vector4(coords.x, coords.y, coords.z, heading) .. "^0")
end, true)



ESX.RegisterCommand('tpm', "staff1", function(xPlayer, args, showError)
	xPlayer.triggerEvent("esx:tpm")
	local hora = os.date("%X")
	local discord1 = string.gsub(xPlayer.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/tpm`** para teletransportarse a un marcador.", 'steam', true, xPlayer.source)
end, true)

ESX.RegisterCommand('goto', "admin", function(xPlayer, args, showError)
		local targetCoords = args.playerId.getCoords()
		xPlayer.setCoords(targetCoords)
		local hora = os.date("%X")
		local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
		if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
		if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
		TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/goto " .. args.playerId.source .. "`** para teletransportarse al usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ") (coordenadas `" .. tostring(GetEntityCoords(GetPlayerPed(args.playerId.source))) .. "`).", 'steam', true, xPlayer.source)
end, true, {help = _U('goto'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('bring', "admin", function(xPlayer, args, showError)
		local playerCoords = xPlayer.getCoords()
		args.playerId.setCoords(playerCoords)
		local hora = os.date("%X")
		local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
		if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
		if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
		TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/goto " .. args.playerId.source .. "`** para teletransportar hacia su localización (coordenadas `" .. tostring(GetEntityCoords(GetPlayerPed(xPlayer.source))) .. "`) al usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ").", 'steam', true, xPlayer.source)
end, true, {help = _U('bring'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('kill', "admin", function(xPlayer, args, showError)
	args.playerId.triggerEvent("esx:killPlayer")
	local hora = os.date("%X")
	local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/kill " .. args.playerId.source .. "`** para matar al usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ") (coordenadas `" .. tostring(GetEntityCoords(GetPlayerPed(args.playerId.source))) .. "`).", 'steam', true, xPlayer.source)
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('freeze', "admin", function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:freezePlayer', "freeze")
	local hora = os.date("%X")
	local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/freeze " .. args.playerId.source .. "`** para (des?)congelar al usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ") (coordenadas `" .. tostring(GetEntityCoords(GetPlayerPed(args.playerId.source))) .. "`).", 'steam', true, xPlayer.source)
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('unfreeze', "admin", function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:freezePlayer', "unfreeze")
	local hora = os.date("%X")
	local discord1, discord2 = string.gsub(xPlayer.discord, "discord:", ""), string.gsub(args.playerId.discord, "discord:", "")
	if discord1 == "" then discord1 = "_Discord no disponible_" else discord1 = '<@' .. discord1 .. '>' end
	if discord2 == "" then discord2 = "_Discord no disponible_" else discord2 = '<@' .. discord2 .. '>' end
	TriggerEvent('DiscordBot:ToDiscord', GetConvar("webhook_staffcmd", "1"), '[🤖] ' .. (isTencity and 'TENDERETE CITY' or 'MANCOS.ES') .. ' ~ ACCIONES DEL STAFF (HORA: ' .. hora .. ')', xPlayer.name .. " [ID:" .. xPlayer.source .. "] (" .. discord1 .. ") ha usado **`/unfreeze " .. args.playerId.source .. "`** para **des**congelar al usuario " .. args.playerId.name .. " [ID:" .. args.playerId.source .. "] (" .. discord2 .. ") (coordenadas `" .. tostring(GetEntityCoords(GetPlayerPed(args.playerId.source))) .. "`).", 'steam', true, xPlayer.source)
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

--ESX.RegisterCommand("noclip", 'admin', function(xPlayer, args, showError)
--	xPlayer.triggerEvent('esx:noclip')
--end, false)

ESX.RegisterCommand('players', "staff1", function(xPlayer, args, showError)
	local xAll = ESX.GetPlayers()
	print("^5"..#xAll.." ^2online player(s)^0")
	for i=1, #xAll, 1 do
		local xPlayer = ESX.GetPlayerFromId(xAll[i])
		print("^1[ ^2ID : ^5"..xPlayer.source.." ^0| ^2Name : ^5"..xPlayer.getName().." ^0 | ^2Group : ^5"..xPlayer.getGroup().." ^0 | ^2Identifier : ^5".. xPlayer.identifier .."^1]^0\n")
	end
end, true)
