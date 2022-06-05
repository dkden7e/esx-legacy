local AccountsIndex, Accounts, SharedAccounts = {}, {}, {}

AddEventHandler('onResourceStart', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		local accounts = MySQL.query.await('SELECT * FROM addon_account LEFT JOIN addon_account_data ON addon_account.name = addon_account_data.account_name UNION SELECT * FROM addon_account RIGHT JOIN addon_account_data ON addon_account.name = addon_account_data.account_name')

		local newAccounts = {}
		for i = 1, #accounts do
			local account = accounts[i]
			if account.shared == 0 then
				if not Accounts[account.name] then
					AccountsIndex[#AccountsIndex + 1] = account.name
					Accounts[account.name] = {}
				end
				Accounts[account.name][#Accounts[account.name] + 1] = CreateAddonAccount(account.name, account.owner, account.money)
			else
				if account.money then
					SharedAccounts[account.name] = CreateAddonAccount(account.name, nil, account.money)
				else
					newAccounts[#newAccounts + 1] = {account.name, 0}
				end
			end
		end

		if next(newAccounts) then
			MySQL.prepare('INSERT INTO addon_account_data (account_name, money) VALUES (?, ?)', newAccounts)
			for i = 1, #newAccounts do
				local newAccount = newAccounts[i]
				SharedAccounts[newAccount[1]] = CreateAddonAccount(newAccount[1], nil, 0)
			end
		end
	end
end)

function GetAccount(name, owner)
	for i=1, #Accounts[name], 1 do
		if Accounts[name][i].owner == owner then
			return Accounts[name][i]
		end
	end
end

function GetSharedAccount(name)
	return SharedAccounts[name]
end

AddEventHandler('esx_addonaccount:getAccount', function(name, owner, cb)
	cb(GetAccount(name, owner))
end)

AddEventHandler('esx_addonaccount:getSharedAccount', function(name, cb)
	cb(GetSharedAccount(name))
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local addonAccounts = {}

	for i=1, #AccountsIndex, 1 do
		local name    = AccountsIndex[i]
		local account = GetAccount(name, xPlayer.identifier)

		if account == nil then
			MySQL.insert('INSERT INTO addon_account_data (account_name, money, owner) VALUES (?, ?, ?)', {name, 0, xPlayer.identifier})

			account = CreateAddonAccount(name, xPlayer.identifier, 0)
			Accounts[name][#Accounts[name] + 1] = account
		end

		addonAccounts[#addonAccounts + 1] = account
	end

	xPlayer.set('addonAccounts', addonAccounts)
end)


            -- Jobs Creator integration (jobs_creator)
            RegisterNetEvent('esx_addonaccount:refreshAccounts')
            AddEventHandler('esx_addonaccount:refreshAccounts', function() 
                local result = MySQL.Sync.fetchAll('SELECT * FROM addon_account')

                for i=1, #result, 1 do
                    local name   = result[i].name
                    local label  = result[i].label
                    local shared = result[i].shared

                    local result2 = MySQL.Sync.fetchAll('SELECT * FROM addon_account_data WHERE account_name = @account_name', {
                        ['@account_name'] = name
                    })

                    if shared == 0 then
                        table.insert(AccountsIndex, name)
                        Accounts[name] = {}

                        for j=1, #result2, 1 do
                            local addonAccount = CreateAddonAccount(name, result2[j].owner, result2[j].money)
                            table.insert(Accounts[name], addonAccount)
                        end
                    else
                        local money = nil

                        if #result2 == 0 then
                            MySQL.Sync.execute('INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, NULL)', {
                                ['@account_name'] = name,
                                ['@money']        = 0
                            })

                            money = 0
                        else
                            money = result2[1].money
                        end

                        local addonAccount   = CreateAddonAccount(name, nil, money)
                        SharedAccounts[name] = addonAccount
                    end
                end
            end)
        