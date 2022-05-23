Config = {}
Config.Locale = 'es'

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

Config.StartingAccountMoney 	= json.decode(GetConvar("esx:startingAccountMoney", "{\"money\":2000,\"bank\":5000}"))

Config.EnableSocietyPayouts 	= false -- pay from the society account that the player is employed at? Requirement: esx_society
Config.EnableHud            	= false -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.MaxWeight            	= 24   -- the max inventory weight without backpack
Config.PaycheckInterval         = 30 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug              = false -- Use Debug options?
Config.EnableDefaultInventory   = false -- Display the default Inventory ( F2 )
Config.EnableWantedLevel    	= false -- Use Normal GTA wanted Level?
Config.EnablePVP                = true -- Allow Player to player combat

Config.Multichar                = true -- Enable support for esx_multicharacter
Config.Identity                 = true -- Select a characters identity data before they have loaded in (this happens by default with multichar)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30000)
		Config.StartingAccountMoney 	= json.decode(GetConvar("esx:startingAccountMoney", "{\"money\":2000,\"bank\":5000}"))
	end
end)