function StartPayCheck()

	local cooldown = false

	local multiplicadoresServicioBase = {
		['police'] = 2.0,
		['police2'] = 2.0,
		['sheriff'] = 2.0,
		['sheriff2'] = 2.0,
		['fib'] = 1.5,
		['justice'] = 1.5,
		['ambulance'] = 2.0,
		['mechanic'] = 1.5,
		['taxi'] = 1.5,
	}
	local multiplicadoresHorarioBase = {
		{ hora1 = 10, minuto1 = 00, hora2 = 12, minuto2 = 00, multiplicador = 1.0 },
		{ hora1 = 14, minuto1 = 00, hora2 = 17, minuto2 = 00, multiplicador = 1.0 },
		{ hora1 = 19, minuto1 = 00, hora2 = 20, minuto2 = 00, multiplicador = 1.0 },
		{ hora1 = 22, minuto1 = 00, hora2 = 23, minuto2 = 00, multiplicador = 1.0 },
		{ hora1 = 1, minuto1 = 00, hora2 = 2, minuto2 = 59, multiplicador = 1.0 },
		{ hora1 = 3, minuto1 = 00, hora2 = 5, minuto2 = 00, multiplicador = 1.0 }
	}

	CreateThread(function()
		local divisa = GetConvar("server_divisa", "$")
		Citizen.Wait(60000)
		while true do
			local multiplicadoresServicio = GetConvar("mancos:multiplicadoresServicio", 'nil') ~= 'nil' and json.decode(GetConvar("mancos:multiplicadoresServicio", json.encode(multiplicadoresServicioBase))) or multiplicadoresServicioBase
			local multiplicadoresHorario = GetConvar("mancos:multiplicadoresHorario", 'nil') ~= 'nil' and json.decode(GetConvar("mancos:multiplicadoresHorario", json.encode(multiplicadoresHorarioBase))) or multiplicadoresHorarioBase
			local multiplicadorhorario = 1.0
			for k, v in ipairs(multiplicadoresHorario) do
				if ESX.IsNowBetween(v.hora1, v.minuto1, v.hora2, v.minuto2) then
					multiplicadorhorario = v.multiplicador
					print("MULTIPLICADOR DE SALARIO ACTIVADO: La hora actual (" .. os.date("%X") .. ") está en el rango que va entre las " .. v.hora1 .. ":" .. v.minuto1 .. ":00" .. " y las " .. v.hora2 .. ":" .. v.minuto2 .. ":00" .. ".")
					break
				end
			end
			Citizen.CreateThread(function()
				local xPlayers = ESX.GetExtendedPlayers()
				local inService = {}
				local asyncdone2 = false
				for k, v in pairs(multiplicadoresServicio) do
					local asyncdone = false
					TriggerEvent("esx_service:getInServiceList", function(list)
						inService[k] = list
						asyncdone = true
					end, k)
					for i = 1, 100, 1 do
						Citizen.Wait(0)
						if asyncdone then break end
					end
				end
				Citizen.Wait(50)
				for _, xPlayer in pairs(xPlayers) do
					local job     = xPlayer.job.grade_name
					local baseSalary  = xPlayer.job.grade_salary
					local multiplicadorJob = 1.0

					if multiplicadoresServicio[xPlayer.job.name] and inService[xPlayer.job.name] and inService[xPlayer.job.name][xPlayer.source] then
						multiplicadorJob = multiplicadoresServicio[xPlayer.job.name]
					end

					local extra1, extra2 = 0, 0
					if multiplicadorhorario > 1 then
						extra1 = (baseSalary*multiplicadorhorario)-baseSalary
					end

					if multiplicadorJob > 1 then
						extra2 = (baseSalary*multiplicadorJob)-baseSalary
					end

					local salary = math.floor(baseSalary+extra1+extra2)

					if salary > 0 then
						local unemployed = (job == 'unemployed')
						if unemployed then -- unemployed
							xPlayer.addAccountMoney('bank', salary)
							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 	'CHAR_BANK_MAZE', 9)
							if baseSalary ~= salary then
								TriggerClientEvent("chat:addMessage", xPlayer.source, {args={"^*^1PAGA EXTRA:^r", "recibiste " .. extra1 .. divisa .. " por tramo 	horario especial. Salario base: " .. baseSalary .. divisa .. "."}})
								print("^*^1PAGA EXTRA:^r", xPlayer.name, ("[ID:" .. xPlayer.source .. "]"), "cobró su sueldo completo con pagas extras (" .. extra1 .. 	divisa .. " por tramo horario especial). Salario base: " .. baseSalary .. divisa .. ".")
								TriggerEvent("okokBanking:AddTransferTransactionFromSocietyToP", salary, "nomina_desempleo", "Subsidio de desempleo", xPlayer.job.	label, xPlayer.identifier, xPlayer.getName())
							end
						elseif Config.EnableSocietyPayouts then -- possibly a society
							TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
								if society ~= nil then -- verified society
									TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
										if account.money >= salary then -- does the society money to pay its employees?
											xPlayer.addAccountMoney('bank', salary)
											account.removeMoney(salary)

											TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U	('received_salary', salary), 'CHAR_BANK_MAZE', 9)
											TriggerEvent("okokBanking:AddTransferTransactionFromSocietyToP", salary, "nomina_"..society.name, "Nómina de "..society.	label, xPlayer.identifier, xPlayer.getName())
										else
											TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 	'CHAR_BANK_MAZE', 1)
										end
									end)
								else -- not a society
									xPlayer.addAccountMoney('bank', salary)
									TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', 	salary), 'CHAR_BANK_MAZE', 9)
									TriggerEvent("okokBanking:AddTransferTransactionFromSocietyToP", salary, "nomina_"..xPlayer.job.name, "Nómina de "..xPlayer.job.	label, xPlayer.identifier, xPlayer.getName())
								end
							end)
						else -- generic job
							xPlayer.addAccountMoney('bank', salary)
							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 	'CHAR_BANK_MAZE', 9)
							TriggerEvent("okokBanking:AddTransferTransactionFromSocietyToP", salary, "nomina_"..xPlayer.job.name, "Nómina de "..xPlayer.job.label, 	xPlayer.identifier, xPlayer.getName())
						end
						if not unemployed and baseSalary ~= salary then
							TriggerClientEvent("chat:addMessage", xPlayer.source, {args={"^*^1PAGA EXTRA:^r", "recibiste " .. extra2 .. divisa .. " extra por estar de 	servicio y/o " .. extra1 .. divisa .. " por tramo horario especial. Salario base: " .. baseSalary .. divisa .. ".	"}})
							print("^*^1PAGA EXTRA:^r", xPlayer.name, ("[ID:" .. xPlayer.source .. "]"), "cobró su sueldo completo con pagas extras (" .. extra2 .. 	divisa .. " extra por estar de servicio y/o " .. extra1 .. divisa .. " por tramo horario especial). Salario base: " .. baseSalary .. 	divisa .. ".")
						end
					end
				end
			end)
			Wait(Config.PaycheckInterval)
		end
	end)
end
