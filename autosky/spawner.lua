


---------------------------------------------------------------
---SPAWNER
---------------------------------------------------------------


--cloud

minetest.register_ore({
		ore_type        = "scatter",
		ore             = "autosky:autosky_cloud",
		wherein         = {"air"},
		clust_scarcity  = 8 * 8 * 8,
		clust_size      = 5,
		y_min           = 75,
		y_max           = 90,
		--noise_threshold = 0.5,
		noise_params    = {
			offset = 0,
			scale = 1,
			spread = {x = 100, y = 100, z = 100},
			seed = 666,
			octaves = 5,
			persist = 0.7
		},
		--biomes = {},
	})


	--warm

	minetest.register_ore({
			ore_type        = "scatter",
			ore             = "autosky:autosky_warm_wet",
			wherein         = {"air"},
			clust_scarcity  = 8 * 8 * 8,
			clust_size      = 5,
			y_min           = 20,
			y_max           = 75,
			--noise_threshold = 0.5,
			noise_params    = {
				offset = 0,
				scale = 1,
				spread = {x = 100, y = 100, z = 100},
				seed = 661,
				octaves = 4,
				persist = 0.4
			},
			--biomes = {},
		})


		--cold

		minetest.register_ore({
				ore_type        = "scatter",
				ore             = "autosky:autosky_cold_wet",
				wherein         = {"air"},
				clust_scarcity  = 8 * 8 * 8,
				clust_size      = 5,
				y_min           = 20,
				y_max           = 75,
				--noise_threshold = 0.5,
				noise_params    = {
					offset = 0,
					scale = 1,
					spread = {x = 100, y = 100, z = 100},
					seed = 662,
					octaves = 4,
					persist = 0.5
				},
				--biomes = {},
			})
