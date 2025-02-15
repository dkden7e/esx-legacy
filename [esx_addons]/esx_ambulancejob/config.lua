Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 700  -- Revive reward, set to 0 if you don't want it enabled
Config.SaveDeathStatus            = true -- Save Death Status?
Config.LoadIpl                    = false -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'es'

Config.EarlyRespawnTimer          = 120000 * 1  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 15 -- time til the player bleeds out

Config.EnablePlayerManagement     = false -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.OxInventory                = ESX.GetConfig().OxInventory
Config.RespawnPoints = {
	--{coords = vector3(341.0, -1397.3, 32.5), heading = 48.5}, -- DEFAULT Central LS Medical Center
	{coords = vector3(321.98, -584.41, 43.28), heading = 48.13} -- Pillbox Hill Hospital
}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
				coords = vector3(317.34, -599.39, 57.73),
				sprite = 61,
				scale  = 0.8,
				color  = 69
		},
		
		AmbulanceActions = {
		},

		Pharmacies = {
			--vector3(230.1, -1366.1, 38.5)
		},

		Vehicles = {
			--{
			--	Spawner = vector3(307.7, -1433.4, 30.0),
			--	InsideShop = vector3(446.7, -1355.6, 43.5),
			--	Marker = {type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true},
			--	SpawnPoints = {
			--		{coords = vector3(297.2, -1429.5, 29.8), heading = 227.6, radius = 4.0},
			--		{coords = vector3(294.0, -1433.1, 29.8), heading = 227.6, radius = 4.0},
			--		{coords = vector3(309.4, -1442.5, 29.8), heading = 227.6, radius = 6.0}
			--	}
			--}
		},

		Helicopters = {
			--{
			--	Spawner = vector3(317.5, -1449.5, 46.5),
			--	InsideShop = vector3(305.6, -1419.7, 41.5),
			--	Marker = {type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true},
			--	SpawnPoints = {
			--		{coords = vector3(313.5, -1465.1, 46.5), heading = 142.7, radius = 10.0},
			--		{coords = vector3(299.5, -1453.2, 46.5), heading = 142.7, radius = 10.0}
			--	}
			--}
		},

		FastTravels = {
			--{
			--	From = vector3(294.7, -1448.1, 29.0),
			--	To = {coords = vector3(272.8, -1358.8, 23.5), heading = 0.0},
			--	Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			--},
			--
			--{
			--	From = vector3(275.3, -1361, 23.5),
			--	To = {coords = vector3(295.8, -1446.5, 28.9), heading = 0.0},
			--	Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			--},
			--
			--{
			--	From = vector3(247.3, -1371.5, 23.5),
			--	To = {coords = vector3(333.1, -1434.9, 45.5), heading = 138.6},
			--	Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			--},
			--
			--{
			--	From = vector3(335.5, -1432.0, 45.50),
			--	To = {coords = vector3(249.1, -1369.6, 23.5), heading = 0.0},
			--	Marker = {type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}
			--},
			--
			--{
			--	From = vector3(234.5, -1373.7, 20.9),
			--	To = {coords = vector3(320.9, -1478.6, 28.8), heading = 0.0},
			--	Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			--},
			--
			--{
			--	From = vector3(317.9, -1476.1, 28.9),
			--	To = {coords = vector3(238.6, -1368.4, 23.5), heading = 0.0},
			--	Marker = {type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false}
			--}
		},

		FastTravelsPrompt = {
			--{
			--	From = vector3(237.4, -1373.8, 26.0),
			--	To = {coords = vector3(251.9, -1363.3, 38.5), heading = 0.0},
			--	Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
			--	Prompt = _U('fast_travel')
			--},
			--
			--{
			--	From = vector3(256.5, -1357.7, 36.0),
			--	To = {coords = vector3(235.4, -1372.8, 26.3), heading = 0.0},
			--	Marker = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false},
			--	Prompt = _U('fast_travel')
			--}
		}

	},

	PillboxHill = {
	
		Blip = {
				coords = vector3(317.34, -599.39, 57.73),
				sprite = 61,
				scale  = 0.8,
				color  = 69
		},
		
		AmbulanceActions = {
			--vector3(334.87, -594.28, 42.3), -- PILLBOX 0 (DESPACHO)
			--vector3(301.6, -599.42, 42.3), -- PILLBOX 1 (VESTUARIO)
			--vector3(306.80, -601.40, 43.2), -- PILLBOX 2 (SALA DESCANSO)
		},

		Pharmacies = {
			--vector3(312.52, -592.53, 43.28)
		},

		-- VIEJO -- Baul = {
		-- VIEJO -- 	vector3(304.65, -600.3, 42.3), -- Pillbox Hill
		-- VIEJO -- },

		-- VIEJO -- Cloakrooms = {
		-- VIEJO -- 	vector3(301.6, -599.42, 42.3),
		-- VIEJO -- },

		-- VIEJO -- BossActions = {
		-- VIEJO -- 	--vector3(334.87, -594.28, 42.3),
		-- VIEJO -- 	vector3(306.80, -601.40, 43.2),
		-- VIEJO -- },

		Vehicles = {
		},

		Helicopters = {
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}
	},

	SandyMedical = {

		Blip = {
			coords = vector3(1839.65, 3672.67, 34.3),
			sprite = 61,
			scale  = 0.8,
			color  = 69
		},
		
		AmbulanceActions = {
		},

		Pharmacies = {
		},
		
		-- VIEJO -- Baul = {
		-- VIEJO -- 	vector3(1843.7, 3681.25, 33.3) -- Sandy Medical Center
		-- VIEJO -- },
		
		-- VIEJO -- Cloakrooms = {
		-- VIEJO -- 	vector3(1825.35, 3675.15, 33.3),
		-- VIEJO -- },
		
		-- VIEJO -- BossActions = {
		-- VIEJO -- 	--vector3(1839.40, 3682.5, 33.3),
		-- VIEJO -- 	vector3(1844.82, 3679.57, 34.3),
		-- VIEJO -- },

		Vehicles = {
		},

		Helicopters = {
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}
	},
	
	PaletoMedical = {

		Blip = {
			coords = vector3(-238.65, 6322.35, 36),
			sprite = 61,
			scale  = 0.8,
			color  = 69
		},
		
		AmbulanceActions = {
		},

		Pharmacies = {
		},
		
		-- VIEJO -- Baul = {
		-- VIEJO -- 	vector3(-255.45, 6326.15, 31.45) -- Paleto Medical Center
		-- VIEJO -- },
				
		-- VIEJO -- Cloakrooms = {
		-- VIEJO -- 	vector3(-256.45, 6327.25, 31.45),
		-- VIEJO -- },
		
		-- VIEJO -- BossActions = {
		-- VIEJO -- 	--vector3(-262.81, 6319.25, 31.45),
		-- VIEJO -- 	vector3(-260.25, 6310.5, 32.43),
		-- VIEJO -- },

		Vehicles = {
		},

		Helicopters = {
		},

		FastTravels = {
		},

		FastTravelsPrompt = {
		}
	}

}

Config.AuthorizedVehicles = {
	car = {
		ambulance = {
			{model = 'ambulance', price = 5000}
		},

		doctor = {
			{model = 'ambulance', price = 4500}
		},

		chief_doctor = {
			{model = 'ambulance', price = 3000}
		},

		boss = {
			{model = 'ambulance', price = 2000}
		}
	},

	helicopter = {
		ambulance = {},

		doctor = {
			{model = 'buzzard2', price = 150000}
		},

		chief_doctor = {
			{model = 'buzzard2', price = 150000},
			{model = 'seasparrow', price = 300000}
		},

		boss = {
			{model = 'buzzard2', price = 10000},
			{model = 'seasparrow', price = 250000}
		}
	}
}
