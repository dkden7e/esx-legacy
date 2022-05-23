local Charset = {}

for i = 48,  57 do table.insert(Charset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function ESX.GetRandomString(length)
	math.randomseed(GetGameTimer())

	if length > 0 then
		return ESX.GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

function ESX.GetConfig()
	return Config
end

function ESX.GetWeapon(weaponName)
	weaponName = string.upper(weaponName)

	for k,v in ipairs(Config.Weapons) do
		if v.name == weaponName then
			return k, v
		end
	end
end

function ESX.GetWeaponFromHash(weaponHash)
	for k,v in ipairs(Config.Weapons) do
		if GetHashKey(v.name) == weaponHash then
			return v
		end
	end
end

function ESX.GetWeaponList()
	return Config.Weapons
end

function ESX.GetWeaponLabel(weaponName)
	weaponName = string.upper(weaponName)

	for k,v in ipairs(Config.Weapons) do
		if v.name == weaponName then
			return v.label
		end
	end
end

function ESX.GetWeaponComponent(weaponName, weaponComponent)
	weaponName = string.upper(weaponName)
	local weapons = Config.Weapons

	for k,v in ipairs(Config.Weapons) do
		if v.name == weaponName then
			for k2,v2 in ipairs(v.components) do
				if v2.name == weaponComponent then
					return v2
				end
			end
		end
	end
end

function ESX.DumpTable(table, nb)
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. ESX.DumpTable(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

function ESX.Round(value, numDecimalPlaces)
	return ESX.Math.Round(value, numDecimalPlaces)
end

ESX.TableContainsValue = function(table, value)
	for k, v in pairs(table) do
		if v == value then
			return true
		end
	end

	return false
end

--
--

ESX.getMinutes = function(hours, minutes) 
	return (hours*60)+minutes
end

ESX.IsTimeBetween = function(StartH, StartM, StopH, StopM, TestH, TestM)
	if (StopH < StartH) then -- add 24 hours if endhours < starthours
		local StopHOrg=StopH
		StopH = StopH + 24
		if (TestH <= StopHOrg) then -- if endhours has increased the currenthour should also increase
			TestH = TestH + 24
		end
	end

	local StartTVal = ESX.getMinutes(StartH, StartM)
	local StopTVal = ESX.getMinutes(StopH, StopM)
	local curTVal = ESX.getMinutes(TestH, TestM)
	return (curTVal >= StartTVal and curTVal <= StopTVal)
end	

ESX.IsNowBetween = function(StartH,StartM,StopH,StopM)
	local time = os.date("*t")
	return ESX.IsTimeBetween(StartH, StartM, StopH, StopM, time.hour, time.min)
end
