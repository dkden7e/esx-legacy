Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 20, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableESXOptionalneeds     = true -- Enable if you're using esx_optionalneeds
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = true -- Enable esx service?
Config.MaxInService               = -1 -- How many people can be in service at once? Set as -1 to have no limit

Config.Locale                     = 'es'

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 57
		},

		Cloakrooms = {
			vector3(458.95, -997.70, 30.5),
			vector3(462.35, -999.45, 30.5)
		},

		Armories = {
			vector3(482.62, -995.50, 30.5)
		},

		Vehicles = {
		--	{
		--		Spawner = vector3(454.6, -1017.4, 28.4),
		--		InsideShop = vector3(228.5, -993.5, -99.5),
		--		SpawnPoints = {
		--			{coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
		--			{coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
		--			{coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0},
		--			{coords = vector3(450.9, -1016.5, 28.1), heading = 90.0, radius = 6.0}
		--		}
		--	},
--
		--	{
		--		Spawner = vector3(473.3, -1018.8, 28.0),
		--		InsideShop = vector3(228.5, -993.5, -99.0),
		--		SpawnPoints = {
		--			{coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0},
		--			{coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0}
		--		}
		--	}
		},

		Helicopters = {
			--{
			--	Spawner = vector3(461.1, -981.5, 43.6),
			--	InsideShop = vector3(477.0, -1106.4, 43.0),
			--	SpawnPoints = {
			--		{coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
			--	}
			--}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	}

}

Config.AuthorizedWeapons = {
	recruit = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 1500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 80}
	},

	officer = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	sergeant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	lieutenant = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	},

	boss = {
		{weapon = 'WEAPON_APPISTOL', components = {0, 0, 1000, 4000, nil}, price = 10000},
		{weapon = 'WEAPON_ADVANCEDRIFLE', components = {0, 6000, 1000, 4000, 8000, nil}, price = 50000},
		{weapon = 'WEAPON_PUMPSHOTGUN', components = {2000, 6000, nil}, price = 70000},
		{weapon = 'WEAPON_NIGHTSTICK', price = 0},
		{weapon = 'WEAPON_STUNGUN', price = 500},
		{weapon = 'WEAPON_FLASHLIGHT', price = 0}
	}
}

Config.AuthorizedVehicles = {
	car = {
		recruit = {},

		officer = {
			{model = 'police3', price = 20000}
		},

		sergeant = {
			{model = 'policet', price = 18500},
			{model = 'policeb', price = 30500}
		},

		lieutenant = {
			{model = 'riot', price = 70000},
			{model = 'fbi2', price = 60000}
		},

		boss = {}
	},

	helicopter = {
		recruit = {},

		officer = {},

		sergeant = {},

		lieutenant = {
			{model = 'polmav', props = {modLivery = 0}, price = 200000}
		},

		boss = {
			{model = 'polmav', props = {modLivery = 0}, price = 100000}
		}
	}
}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	plc_corta_wear = { -- UNIFORME MANGA CORTA (POLICIA LOCAL)
		 male = {
			['tshirt_1'] = 194,  ['tshirt_2'] = 0,
			['torso_1'] = 481,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 172,   ['pants_2'] = 0,
			['shoes_1'] = 97,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 59,   ['bproof_2'] = 0,
			['chain_1'] = 164,    ['chain_2'] = 0,
			['bags_1'] = 0,    ['bags_2'] = 0
		},
		female = {
			['tshirt_1'] = 246,  ['tshirt_2'] = 0,
			['torso_1'] = 555,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 198,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 87,   ['bproof_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bags_1'] = 0,    ['bags_2'] = 0
		}
		--[[male = {
			['torso_1'] = 15,   ['torso_2'] = 5,
		},
		female = {
			['torso_1'] = 15,   ['torso_2'] = 0,
		} ]]
	},

	cgpc_corta_wear = { -- UNIFORME MANGA CORTA (POLICIA CANARIA)
		male = {
			['tshirt_1'] = 194,  ['tshirt_2'] = 0,
			['torso_1'] = 486,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 172,   ['pants_2'] = 0,
			['shoes_1'] = 97,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 0,   ['bproof_2'] = 0,
			['chain_1'] = 164,    ['chain_2'] = 0,
			['bags_1'] = 0,    ['bags_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 246,  ['tshirt_2'] = 0,
			['torso_1'] = 560,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 198,   ['pants_2'] = 0,
			['shoes_1'] = 29,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 87,   ['bproof_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bags_1'] = 0,    ['bags_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	},

	bullet_wear = { -- Chaleco LSPD I
	male = {
			['bproof_1'] = 78,   ['bproof_2'] = 0,
		},
	female = {
			['bproof_1'] = 99,   ['bproof_2'] = 0,
		}
	},

	bullet_sinchaleco_wear = { -- Chaleco invisible
	male = {
			['bproof_1'] = 0,   ['bproof_2'] = 0
		},
	female = {
			['bproof_1'] = 0,   ['bproof_2'] = 0
		}
	},

	cap_wear = { -- QUITAR GORRA/CASCO LSPD
		male = {
			['helmet_1'] = -1,  ['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = -1,  ['helmet_2'] = 0,
		}
	},

	gorro_plc_wear = { -- GORRO PLC
		male = {
			['helmet_1'] = 190,  ['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = 191,  ['helmet_2'] = 0,
		}
	},

	casco_plc_wear = { --CASCO MOTO PLC
		male = {
			['helmet_1'] = 182,  ['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = 181,  ['helmet_2'] = 0,
		}
	},

	cnp_mangacorta_wear = { -- UNIFORME CNP MANGA CORTA
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 1,
			['torso_1'] = 396,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 26,
			['pants_1'] = 144,   ['pants_2'] = 0,
			['shoes_1'] = 59,   ['shoes_2'] = 20,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 0,   ['bproof_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bags_1'] = 98,      ['bags_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0
		},

		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 1,
			['torso_1'] = 407,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 161,   ['pants_2'] = 1,
			['shoes_1'] = 62,   ['shoes_2'] = 20,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 0,   ['bproof_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bags_1'] = 95,	['bags_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['glasses_1'] = 5, ['glasses_2'] = 0
		}
	},
	
	gc_mangacorta_wear = { -- UNIFORME GC MANCA CORTA
		male = {
			['tshirt_1'] = 219,  ['tshirt_2'] = 0,
			['torso_1'] = 485,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 30,
			['pants_1'] = 171,   ['pants_2'] = 0,
			['shoes_1'] = 59,   ['shoes_2'] = 20,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 59,   ['bproof_2'] = 0,
			['chain_1'] = 157,    ['chain_2'] = 0,
			['bags_1'] = 0,      ['bags_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0
		},
		female = {
			['tshirt_1'] = 219,  ['tshirt_2'] = 0,
			['torso_1'] = 559,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 197,   ['pants_2'] = 0,
			['shoes_1'] = 62,   ['shoes_2'] = 20,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 87,   ['bproof_2'] = 0,
			['chain_1'] = 126,     ['chain_2'] = 0,
			['bags_1'] = 92,	['bags_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['glasses_1'] = 5, ['glasses_2'] = 0
		}
	},
	
	intervencion_gc_wear = { -- INTERVENCION GC
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 1,
			['torso_1'] = 371,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 31,
			['pants_1'] = 144,   ['pants_2'] = 0,
			['shoes_1'] = 59,   ['shoes_2'] = 20,
			['helmet_1'] =-1,  ['helmet_2'] = -1,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 100,   ['bproof_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 0,    ['bags_2'] = 0,
			['glasses_1'] = 0, ['glasses_2'] = 0
		},
		female = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 382,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 36,
			['pants_1'] = 161,   ['pants_2'] = 1,
			['shoes_1'] = 62,   ['shoes_2'] = 20,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['mask_1'] = 121, ['mask_2'] = 0,
			['bproof_1'] = 100,   ['bproof_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 0,    ['bags_2'] = 0,
			['glasses_1'] = 5, ['glasses_2'] = 0
		}
	},

	placa_gc_wear = { -- Placa Guardia Civil
		male = {
			['chain_1'] = 183,    ['chain_2'] = 0,
		},
		female = {
			['chain_1'] = 166,    ['chain_2'] = 0,
		}
	},

	gorro_gc_wear = { -- GORRO Guardia Civil
	male = {
		['helmet_1'] = 191,  ['helmet_2'] = 0,
	},
	female = {
		['helmet_1'] = 192,  ['helmet_2'] = 0,
	}
},

	pistol_wear = { -- Pistolera en la pierna
		male = {
			['chain_1'] = 157,    ['chain_2'] = 0,
		},
		female = {
			['chain_1'] = 126,    ['chain_2'] = 0,
		}
	},

	pistol2_wear = { -- Pistoleras en los hombros
		male = {
			['tshirt_1'] = 183,    ['tshirt_2'] = 0,
		},
		female = {
			['tshirt_1'] = 250,    ['tshirt_2'] = 0,
		}
	},

	bullet5_wear = { -- Chaleco LSSD I
		male = {
				['bproof_1'] = 95,   ['bproof_2'] = 1,
				['bags_1'] = 92,    ['bags_2'] = 0
			},
		female = {
				['bproof_1'] = 96,   ['bproof_2'] = 1,
				['bags_1'] = 92,    ['bags_2'] = 0
			}
	}
	--cap3_wear = { -- SOMBRERO LSSD I
	--	male = {
	--		['helmet_1'] = 180,    ['helmet_2'] = 0,
	--	},
	--	female = {
	--		['helmet_1'] = 180,    ['helmet_2'] = 0,
	--	}
	--}
}