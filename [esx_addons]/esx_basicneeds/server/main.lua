ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	xPlayer.showNotification(_U('used_bread'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	xPlayer.showNotification(_U('used_water'))
end)

ESX.RegisterCommand('heal', 'staff2', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.showNotification('You have been healed.')
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end

	TriggerClientEvent('esx_basicneeds:healPlayer', eventData.id)
end)

ESX.RegisterCommand({'setstatus'}, 'support', function(xPlayer, args, showError)
	local right = false
	if args.status == "hambre" or args.status == "hunger" then
		args.status = "hunger"
		args.amount = ((tonumber(args.amount) and args.amount ~= 0) and args.amount*10000 or 1000000) --args.amount/10000
		right = true
	end
	if args.status == "sed" or args.status == "thirst" then
		args.status = "thirst"
		args.amount = ((tonumber(args.amount) and args.amount ~= 0) and args.amount*10000 or 1000000) --10000-(args.amount*100)
		right = true
	end
	if args.status == "estrés" or args.status == "estres" or args.status == "stress" then
		args.status = "stress"
		args.amount = ((tonumber(args.amount) and args.amount ~= 0) and args.amount*10000 or 0) --args.amount*100
		right = true
	end
	if args.status == "drunk" then
		args.amount = ((tonumber(args.amount) and args.amount ~= 0) and args.amount*10000 or 0) --args.amount*100
		right = true
	end
	if right then
		if args.amount < 0 then
			args.amount = 0
		elseif args.amount > 1000000 then
			args.amount = 1000000
		end
		args.amount = math.floor(args.amount)
		args.playerId.triggerEvent('esx_status:set', args.status, args.amount)
		if xPlayer.source ~= args.playerId.source then
			args.playerId.triggerEvent("chat:addMessage", { args = { "^1^*SISTEMA: ", "^0un administrador te seteó el stat \"" .. args.status .. "\" a " .. args.amount .. "."}})
		end
		xPlayer.triggerEvent("chat:addMessage", { args = { "^1^*SISTEMA: ", "^0\"" .. args.status .. "\" seteado a " .. args.amount .. " al usuario " .. xPlayer.name .. "."}})
		--print('esx_status:set', args.status, args.amount/10000)
	else
		xPlayer.triggerEvent("chat:addMessage", { args = { "^1^*SISTEMA: ", "^0\"" .. args.status .. "\" no es un estado válido"}})
	end
end, true, {help = "Modificar el estrés de alguien", validate = true, arguments = {
	{name = 'playerId', help = 'ID del jugador', type = 'player'},
	{name = 'status', help = '[hambre|sed|estrés]', type = 'string'},
	{name = 'amount', help = 'Nueva cantidad (1-100)', type = 'number'},
}})