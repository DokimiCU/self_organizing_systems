

-------------------------------------------------------------
---BUILDINGS
------------------------------------------------------------

local spawn_on_building = {"default:dirt", "default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_snow", "default:dirt_with_rainforest_litter", "default:sand",  "default:desert_sand", "default:silver_sand", "default:snow", "default:snowblock",}


---Clean Lab
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = spawn_on_building,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.0001,
			spread = {x = 1600, y = 1600, z = 1600},
			seed = 6661,
			octaves = 1,
			persist = 1
		},
		y_min = 2,
		y_max = 20,
		schematic = minetest.get_modpath("selfrep_doomsday") .. "/schematics/doomsday_lab_clean.mts",
		flags = {place_center_x = true, place_center_y = true, place_center_z = true, force_placement = true},
	})


---Big Lab
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = spawn_on_building,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.0001,
			spread = {x = 1600, y = 1600, z = 1600},
			seed = 7772,
			octaves = 1,
			persist = 1
		},
		y_min = 2,
		y_max = 20,
		schematic = minetest.get_modpath("selfrep_doomsday") .. "/schematics/doomsday_lab_big.mts",
		flags = {place_center_x = true, place_center_y = true, place_center_z = true, force_placement = true},
	})


---Lab forest
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = spawn_on_building,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.0001,
			spread = {x = 1600, y = 1600, z = 1600},
			seed = 6663,
			octaves = 1,
			persist = 1
		},
		y_min = 2,
		y_max = 20,
		schematic = minetest.get_modpath("selfrep_doomsday") .. "/schematics/doomsday_lab_forest.mts",
		flags = {place_center_x = true, place_center_y = true, place_center_z = true, force_placement = true},
	})

