ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, target)
	target = GetPlayerFromServerId(target)
	if target == PlayerId() then return end

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPed)

	ESX.ShowAdvancedNotification(notification.title, notification.subject, notification.msg, mugshotStr, notification.iconType)
	UnregisterPedheadshot(mugshot)
end)

RegisterNetEvent('esx_service:vesmfShow')
AddEventHandler('esx_service:vesmfShow', function(msg)
	TriggerEvent("chat:addMessage", { args = { "^1SERVICIO: ", "^0información de miembros de servicio disponible en tu consola ^3(tecla F8)^0." } })
	print(msg)
end)