


---------------------------------------------------------------
---SPAWNER
---------------------------------------------------------------


minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.001,
	noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
	spawn_by = "default:dirt_with_grass",
	num_spawn_by = 4,
	schematic = {
		size = {x=2, y=3, z=2},
		data = {
			{name="ecobots:ecobots_decomposer_bot", param1=255, param2=0}, 
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_detritivore_bot", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_decomposer_bot", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_bot_dead", param1=255, param2=0},
			{name="ecobots:ecobots_apex_bot", param1=255, param2=0},
			{name="ecobots:ecobots_predator_bot", param1=255, param2=0},
			{name="ecobots:ecobots_pioneer_bot", param1=255, param2=0},	
			{name="ecobots:ecobots_photosynth_bot", param1=255, param2=0}
			},
			},
		flags = {place_center_x = true, place_center_y = false, place_center_z = true},
		rotation = "random"

})


