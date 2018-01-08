


---------------------------------------------------------------
---SPAWNER
---------------------------------------------------------------
-- clear default mapgen decorations


minetest.clear_registered_decorations()

------------------------------------------------------------


--animal block

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	fill_ratio = 0.003,
	y_min = 2,
	y_max = 31000,
	biomes = {"rainforest", "deciduous_forest", "coniferous_forest", "savanna", "grassland", "floatland_coniferous_forest", "floatland_grassland"},
	schematic = {
		size = {x=2, y=3, z=2},
		data = {
			{name="ecobots:ecobots_decomposer_bot", param1=255, param2=0}, 
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_decomposer_bot", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_detritivore_bot", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_pioneer_bot", param1=255, param2=0},
			{name="ecobots:ecobots_pioneer_bot", param1=255, param2=0},
			{name="ecobots:ecobots_predator_bot", param1=255, param2=0},	
			{name="ecobots:ecobots_apex_bot", param1=255, param2=0}
			},
			},
		flags = {place_center_x = true, place_center_y = false, place_center_z = true},
		rotation = "random"

})


--Lucky Herbivore (might be by food... or might not)

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:snow", "default:sand", "default:desert_sand", "default:silver_sand", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.09,
			spread = {x = 50, y = 50, z = 50},
			seed = 444,
			octaves = 8,
			persist = 0.7
		},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_predator_bot",
	})

--Lucky Predator (might be by food... or might not)

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:snow", "default:sand", "default:desert_sand", "default:silver_sand", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.08,
			spread = {x = 100, y = 100, z = 100},
			seed = 444,
			octaves = 2,
			persist = 0.6
		},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_apex_bot",
	})

--Lucky Detritivore (might be by food... or might not)

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:snow", "default:sand", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.08,
			spread = {x = 100, y = 100, z = 100},
			seed = 444,
			octaves = 2,
			persist = 0.6
		},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_detritivore_bot",
	})





--Eusocial Nest 1

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	fill_ratio = 0.00002,
	y_min = 2,
	y_max = 31000,
	biomes = {"savanna"},
	schematic = minetest.get_modpath("ecobots") .. "/schematics/Eusocial_Nest_1",
	flags = "place_center_x, place_center_z",
})

--Eusocial Nest 2 (huge)

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_dry_grass"},
	sidelen = 16,
	fill_ratio = 0.00002,
	y_min = 2,
	y_max = 31000,
	biomes = {"savanna"},
	schematic = minetest.get_modpath("ecobots") .. "/schematics/Eusocial_Nest_2",
	flags = "place_center_x, place_center_z",
})



--Lucky Swarmer (might be by food... or might not)


minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:snow", "default:sand", "default:dirt_with_rainforest_litter", "group:leaves"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.08,
			spread = {x = 50, y = 50, z = 50},
			seed = 556,
			octaves = 14,
			persist = 0.9
		},
		y_min = 1,
		y_max = 31000,
		--biomes = {"rainforest", "rainforest_swamp", "deciduous_forest", "coniferous_forest"},
		decoration = "ecobots:ecobots_swarmer_bot",
	})



--swarmer eggs

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	fill_ratio = 0.0005,
	y_min = 1,
	y_max = 31000,
	biomes = {"rainforest", "deciduous_forest", "coniferous_forest", "floatland_coniferous_forest"},
	schematic = {
		size = {x=2, y=3, z=2},
		data = {
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0}, 
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0},	
			{name="ecobots:ecobots_swarmer_eggs", param1=255, param2=0}
			},
			},
		flags = {place_center_x = true, place_center_y = false, place_center_z = true},
		rotation = "random"

})



-------------------------------------------------------------------SWAMP FOREST
----------------------------------------------------------------



-- Swamp Forest tree 1

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_rainforest_litter"},
		spawn_by = "default:dirt_with_rainforest_litter",
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.02,
			spread = {x = 250, y = 250, z = 250},
			seed = 610,
			octaves = 1,
			persist = 0.76
		},
		biomes = {"rainforest", "rainforest_swamp"},
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Swamp_Forest_Tree_1",
		flags = "place_center_x, place_center_z",
	})


-- Swamp Forest tree 2

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_rainforest_litter"},
		spawn_by = "default:dirt_with_rainforest_litter",
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.03,
			spread = {x = 250, y = 250, z = 250},
			seed = 611,
			octaves = 1,
			persist = 0.26
		},
		biomes = {"rainforest", "rainforest_swamp"},
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Swamp_Forest_Tree_2",
		flags = "place_center_x, place_center_z",
	})


-- Swamp Forest tree 3

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_rainforest_litter"},
		spawn_by = "default:dirt_with_rainforest_litter",
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.03,
			spread = {x = 250, y = 250, z = 250},
			seed = 612,
			octaves = 1,
			persist = 0.26
		},
		biomes = {"rainforest", "rainforest_swamp"},
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Swamp_Forest_Tree_3",
		flags = "place_center_x, place_center_z",
	})



-- Swamp Forest tree 1 fill

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_rainforest_litter"},
		spawn_by = "default:dirt_with_rainforest_litter",
		num_spawn_by = 4,
		sidelen = 16,
		fill_ratio = 0.003,
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Swamp_Forest_Tree_1",
		flags = "place_center_x, place_center_z",
	})




-------------------------------------------------------------------PIONEERS
----------------------------------------------------------------

-- Pioneer tree 1

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_dry_grass"},
		spawn_by = "default:dirt_with_dry_grass",
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.004,
			spread = {x = 250, y = 250, z = 250},
			seed = 210,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Pioneer_Tree_1",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-- Pioneer tree 2

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_dry_grass"},
		spawn_by = "default:dirt_with_dry_grass",
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.004,
			spread = {x = 250, y = 250, z = 250},
			seed = 211,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Pioneer_Tree_2",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-- Pioneer tree 3

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_dry_grass"},
		spawn_by = "default:dirt_with_dry_grass",
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.004,
			spread = {x = 250, y = 250, z = 250},
			seed = 212,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Pioneer_Tree_3",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})



-- Pioneer Ground 1

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_dry_grass"},
		spawn_by = "default:dirt_with_dry_grass",
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.004,
			spread = {x = 250, y = 250, z = 250},
			seed = 213,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"savanna"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Pioneer_Ground_1",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-------------------------------------------------------------------GENERALISTS
----------------------------------------------------------------

-- Generalist Tree 1 (fairly small)

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		spawn_by = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 250, y = 250, z = 250},
			seed = 214,
			octaves = 2,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Generalist_Tree_1",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-- Generalist Tree 2

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		spawn_by = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.002,
			spread = {x = 250, y = 250, z = 250},
			seed = 610,
			octaves = 2,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Generalist_Tree_2",
		flags = "place_center_x, place_center_z",
	})

-- Generalist Tree 3

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		spawn_by = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.01,
			spread = {x = 250, y = 250, z = 250},
			seed = 611,
			octaves = 1,
			persist = 0.46
		},
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Generalist_Tree_3",
		flags = "place_center_x, place_center_z",
	})



-------------------------------------------------------------------HILL
----------------------------------------------------------------

-- Hill tree 1

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt", "default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		spawn_by = "default:stone",
		num_spawn_by = 1,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 210,
			octaves = 2,
			persist = 0.36
		},
		biomes = {"coniferous_forest", "deciduous_forest", "rainforest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Hill_Tree_1",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-- Hill tree 2

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt", "default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		spawn_by = "default:stone",
		num_spawn_by = 1,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 211,
			octaves = 2,
			persist = 0.56
		},
		biomes = {"coniferous_forest", "deciduous_forest", "rainforest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Hill_Tree_2",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})



-- Hill tree 3

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt", "default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		spawn_by = {"default:stone", "default:sandstone"},
		num_spawn_by = 1,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.015,
			spread = {x = 250, y = 250, z = 250},
			seed = 212,
			octaves = 3,
			persist = 0.76
		},
		biomes = {"coniferous_forest", "deciduous_forest", "rainforest"},
		y_min = 10,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Hill_Tree_3",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-------------------------------------------------------------------SNOW
----------------------------------------------------------------
-- Snow tree 1

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		spawn_by = {"default:dirt_with_snow", "default:dirt_with_grass"},
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 250, y = 250, z = 250},
			seed = 210,
			octaves = 6,
			persist = 0.9
		},
		biomes = {"taiga", "coniferous_forest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Snow_Tree_1",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})

-- Snow tree 2

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		spawn_by = {"default:dirt_with_snow", "default:dirt_with_grass"},
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 250, y = 250, z = 250},
			seed = 211,
			octaves = 6,
			persist = 0.8
		},
		biomes = {"taiga", "coniferous_forest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Snow_Tree_2",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-- Snow tree 3

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		spawn_by = {"default:dirt_with_snow", "default:dirt_with_grass"},
		num_spawn_by = 4,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.008,
			spread = {x = 250, y = 250, z = 250},
			seed = 212,
			octaves = 6,
			persist = 0.9
		},
		biomes = {"taiga", "coniferous_forest"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Snow_Tree_3",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})



-------------------------------------------------------------------SAND
----------------------------------------------------------------


-------------------------------------------------------------------ROGUES
--to add diveristy, mix some species into other areas
----------------------------------------------------------------

-- rogue Pioneer tree 1

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_rainforest_litter"},
		spawn_by = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		num_spawn_by = 4,
		sidelen = 80,
		fill_ratio = 0.0001,
		biomes = {"rainforest", "coniferous_forest", "deciduous_forest", "grassland", "floatland_coniferous_forest", "floatland_grassland"},
		y_min = -1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Pioneer_Tree_1",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-- rogue Generalist Tree 2

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_rainforest_litter"},
		spawn_by = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		num_spawn_by = 4,
		sidelen = 16,
		fill_ratio = 0.0001,
		biomes = {"rainforest", "coniferous_forest", "grassland", "floatland_coniferous_forest", "floatland_grassland"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Generalist_Tree_2",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})





-- rogue Swamp Forest tree 3

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_rainforest_litter"},
		spawn_by = "default:water_source",
		num_spawn_by = 1,
		sidelen = 16,
		fill_ratio = 0.001,
		biomes = {"deciduous_forest", "savanna", "grassland", "floatland_coniferous_forest", "floatland_grassland"},
		y_min = 1,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Swamp_Forest_Tree_3",
		flags = "place_center_x, place_center_z",
	})



-- rogue Snow tree 3

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_snow"},
		spawn_by = {"default:dirt_with_grass", "default:dirt", "default:dirt_with_snow"},
		num_spawn_by = 4,
		sidelen = 80,
		fill_ratio = 0.0001,
		biomes = {"deciduous_forest", "snowy_grassland", "grassland", "floatland_coniferous_forest", "floatland_grassland"},
		y_min = 10,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Snow_Tree_3",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})



-- rogue Hill tree 1

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt", "default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
		spawn_by = {"default:stone", "default:sandstone"},
		num_spawn_by = 1,
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.00015,
			spread = {x = 250, y = 250, z = 250},
			seed = 222,
			octaves = 2,
			persist = 0.36
		},
		biomes = {"savanna", "grassland", "floatland_coniferous_forest", "floatland_grassland"},
		y_min = 20,
		y_max = 31000,
		schematic = minetest.get_modpath("ecobots") .. "/schematics/Hill_Tree_1",
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})


-- rogue sand cactus in savanna

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_dry_grass",},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.00002,
			spread = {x = 100, y = 100, z = 100},
			seed = 4441,
			octaves = 6,
			persist = 0.9
		},
		biomes = {"savanna"},
		height = 2,
		height_max = 4,
		y_min = 2,
		y_max = 31000,
		decoration = "ecobots:ecobots_sand_cactus_bot",
	})


-------------------------------------------------------------------GROUND COVER
--herbs, flowers, shrubs etc
----------------------------------------------------------------

--pioneer grass on all

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 444,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_pioneer_bot",
	})

--pioneer grass on all fill

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		fill_ratio = 0.01,
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_pioneer_bot",
	})

--generalist flower on all fill

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		fill_ratio = 0.01,
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_generalist_flower_bot",
	})




--pioneer grass more abundant in grasslands/savanna

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.3,
			spread = {x = 100, y = 100, z = 100},
			seed = 4441,
			octaves = 4,
			persist = 0.5
		},
		y_min = 1,
		y_max = 31000,
		biomes = {"savanna", "grassland"},
		decoration = "ecobots:ecobots_pioneer_bot",
	})


--pioneer grass super abundant in forest

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.8,
			spread = {x = 100, y = 100, z = 100},
			seed = 4442,
			octaves = 2,
			persist = 0.2
		},
		y_min = 2,
		y_max = 31000,
		biomes = {"rainforest", "rainforest_swamp", "deciduous_forest"},
		decoration = "ecobots:ecobots_pioneer_bot",
	})


--pioneer shrub

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.001,
			spread = {x = 100, y = 100, z = 100},
			seed = 4443,
			octaves = 8,
			persist = 0.4
		},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_pioneer_shrub_bot",
	})


--generalist flower

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.1,
			spread = {x = 100, y = 100, z = 100},
			seed = 4444,
			octaves = 1,
			persist = 0.1
		},
		y_min = 1,
		y_max = 31000,
		biomes = {"grassland", "deciduous_forest"},
		decoration = "ecobots:ecobots_generalist_flower_bot",
	})

--more in grasslands generalist flower

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.05,
			spread = {x = 100, y = 100, z = 100},
			seed = 4445,
			octaves = 3,
			persist = 0.4
		},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_generalist_flower_bot",
	})


-- swamp forest herb

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.03,
			spread = {x = 100, y = 100, z = 100},
			seed = 4446,
			octaves = 5,
			persist = 0.6
		},
		biomes = {"rainforest", "coniferous_forest", "deciduous_forest", "rainforest_swamp"},
		y_min = 2,
		y_max = 31000,
		decoration = "ecobots:ecobots_forest_herb_bot",
	})


-- swamp forest shrub

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 4447,
			octaves = 5,
			persist = 0.6
		},
		biomes = {"rainforest", "coniferous_forest", "deciduous_forest", "rainforest_swamp"},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_forest_shrub_bot",
	})


-- abundant swamp forest shrub in forest

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.3,
			spread = {x = 100, y = 100, z = 100},
			seed = 4448,
			octaves = 2,
			persist = 0.4
		},
		biomes = {"rainforest", "rainforest_swamp", "deciduous_forest"},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_forest_shrub_bot",
	})

-- abundant pioneer shrub in forest

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.3,
			spread = {x = 100, y = 100, z = 100},
			seed = 4449,
			octaves = 4,
			persist = 0.3
		},
		biomes = {"rainforest", "rainforest_swamp", "deciduous_forest"},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_pioneer_shrub_bot",
	})

--snow flower

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 44410,
			octaves = 8,
			persist = 0.9
		},
		biomes = {"coniferous_forest", "taiga", "snowy_grassland", "floatland_coniferous_forest", "floatland_grassland"},
		y_min = 4,
		y_max = 31000,
		decoration = "ecobots:ecobots_snow_flower_bot",
	})


--more snow flower in forest

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.03,
			spread = {x = 100, y = 100, z = 100},
			seed = 44411,
			octaves = 2,
			persist = 0.3
		},
		biomes = {"coniferous_forest"},
		y_min = 4,
		y_max = 31000,
		decoration = "ecobots:ecobots_snow_flower_bot",
	})

--snow shrub

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:silver_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.003,
			spread = {x = 100, y = 100, z = 100},
			seed = 44412,
			octaves = 8,
			persist = 0.9
		},
		biomes = {"cold_desert", "taiga", "snowy_grassland", "coniferous_forest"},
		y_min = 4,
		y_max = 31000,
		decoration = "ecobots:ecobots_snow_shrub_bot",
	})


--more snow shrub in forest

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:silver_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.03,
			spread = {x = 100, y = 100, z = 100},
			seed = 44413,
			octaves = 2,
			persist = 0.2
		},
		biomes = {"taiga", "coniferous_forest"},
		y_min = 4,
		y_max = 31000,
		decoration = "ecobots:ecobots_snow_shrub_bot",
	})



--sand grass

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand", "default:desert_sand", "default:silver_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.06,
			spread = {x = 100, y = 100, z = 100},
			seed = 444,
			octaves = 5,
			persist = 0.8
		},
		biomes = {"grassland_dunes", "coniferous_forest_dunes", "sandstone_desert", "cold_desert", "floatland_sandstone_desert"},

		y_min = 2,
		y_max = 31000,
		decoration = "ecobots:ecobots_sand_grass_bot",
	})


-- sand cactus in desert

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand",},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.0005,
			spread = {x = 100, y = 100, z = 100},
			seed = 444,
			octaves = 4,
			persist = 0.7
		},
		biomes = {"desert"},
		height = 2,
		height_max = 4,
		y_min = 2,
		y_max = 31000,
		decoration = "ecobots:ecobots_sand_cactus_bot",
	})


-- sand palm on sand and rainforest

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.008,
			spread = {x = 100, y = 100, z = 100},
			seed = 544,
			octaves = 5,
			persist = 0.5
		},
		biomes = {"grassland_dunes", "savanna", "rainforest","sandstone_desert", "sandstone_desert_ocean", "desert_ocean", "grassland_ocean", "floatland_sandstone_desert", "rainforest"},
		y_min = 1,
		y_max = 31000,
		decoration = "ecobots:ecobots_sand_palm_bot",
	})


--evine in forest

minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.005,
			spread = {x = 100, y = 100, z = 100},
			seed = 4143,
			octaves = 2,
			persist = 0.2
		},
		y_min = 2,
		y_max = 31000,
		biomes = {"rainforest", "rainforest_swamp", "deciduous_forest"},
		decoration = "ecobots:ecobots_evine_bot",
	})



------------------------------------------------------------------SEA
----------------------------------------------------------------


--coral REEF



minetest.register_ore({
		ore_type        = "puff",
		ore             = "ecobots:ecobots_coral_bot",
		wherein         = {"default:sand"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_min           = -5,
		y_max           = 0,
		noise_threshold = 0.2,
		noise_params    = {
			offset = 0,
			scale = 0.3,
			spread = {x = 5, y = 5, z = 5},
			seed = 666,
			octaves = 2,
			persist = 0.6
		},
		biomes = {"desert_ocean", "sandstone_desert_ocean", "savanna_ocean","rainforest_ocean"},
	})


--beach shellfish beds

minetest.register_ore({
		ore_type        = "puff",
		ore             = "ecobots:ecobots_beach_shellfish_bot",
		wherein         = {"default:sand"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_min           = -9,
		y_max           = 0,
		noise_threshold = 0.2,
		noise_params    = {
			offset = 0,
			scale = 0.3,
			spread = {x = 5, y = 5, z = 5},
			seed = 661,
			octaves = 2,
			persist = 0.6
		},
		biomes = { "savanna_ocean","rainforest_ocean", "tundra_ocean", "taiga_ocean", "snowy_grassland_ocean", "grassland_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "desert_ocean", "sandstone_desert_ocean", "cold_desert_ocean",
},
	})

--estuary shellfish beds

minetest.register_ore({
		ore_type        = "puff",
		ore             = "ecobots:ecobots_estuary_shellfish_bot",
		wherein         = {"default:dirt", "default:dirt_with_rainforest_litter"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 5,
		y_min           = -8,
		y_max           = 0,
		noise_threshold = 0.1,
		noise_params    = {
			offset = 0,
			scale = 0.4,
			spread = {x = 5, y = 5, z = 5},
			seed = 662,
			octaves = 2,
			persist = 0.6
		},
		biomes = { "savanna_ocean","rainforest_ocean", "tundra_ocean", "taiga_ocean", "snowy_grassland_ocean", "grassland_ocean", "coniferous_forest_ocean", "deciduous_forest_ocean", "desert_ocean", "sandstone_desert_ocean", "cold_desert_ocean", "rainforest_swamp", "deciduous_forest_shore", "savanna_shore" 
},
	})


------------------------------------------------------------------CAVE
----------------------------------------------------------------


--Cave slime



minetest.register_ore({
		ore_type        = "puff",
		ore             = "ecobots:ecobots_cave_slime_bot",
		wherein         = {"default:water_source", "default:river_water_source"},
		clust_scarcity  = 16 * 16 * 16,
		clust_size      = 3,
		y_min           = -20000,
		y_max           = -10,
		noise_threshold = 0.2,
		noise_params    = {
			offset = 0,
			scale = 0.02,
			spread = {x = 5, y = 5, z = 5},
			seed = 666,
			octaves = 2,
			persist = 0.6
		},
		biomes = {"underground"},
	})



