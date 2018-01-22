




----------------------------------------------------------------
--NODES
----------------------------------------------------------------

-- Node road

minetest.register_node('selfrep:selfrep_road', {
	description = 'Self Replicating Road',
	light_source = 0,
	tiles = {"selfrep_road.png"},
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),

	--node lifespan
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(40)
	end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "selfrep:selfrep_road_dead"})
	end,
	})


--dead road

minetest.register_node('selfrep:selfrep_road_dead', {
	description = 'Dead Self Replicator',
	tiles = {"selfrep_road_dead.png"},
	groups = {cracky = 3, stone = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults()
	})



-- Node tower

minetest.register_node('selfrep:selfrep_tower', {
	description = 'Self Replicating Tower',
	light_source = 0,
	tiles = {"selfrep_tower.png"},
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),

	--node lifespan
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(20)
	end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "selfrep:selfrep_road_dead"})
	end,

	})



-- Node sponge

minetest.register_node('selfrep:selfrep_sponge', {
	description = 'Self Replicating Sponge',
	light_source = 0,
	tiles = {"selfrep_sponge.png"},
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),

	})

-- Node sinkhole

minetest.register_node('selfrep:selfrep_sinkhole', {
	description = 'Self Replicating Sinkhole',
	light_source = 3,
	tiles = {"selfrep_sinkhole.png"},
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),

	})


-- Node tunnel

minetest.register_node('selfrep:selfrep_tunnel', {
	description = 'Self Replicating Tunnel',
	light_source = 3,
	tiles = {"selfrep_tunnel.png"},
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),

	})


-- Node ladder

minetest.register_node('selfrep:selfrep_ladder', {
	description = 'Self Replicating Ladder',
	drawtype = "nodebox",
	--paramtype2 = "facedir",
	--light_source = 3,
	tiles = {"selfrep_ladder.png"},
	climbable = true,
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/6, 1/2, 1/2, 1/6},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/6, 1/2, 1/2, 1/6},
	},


--node lifespan
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(20)
	end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "selfrep:selfrep_ladder_dead"})
	end,

	})


--dead ladder

minetest.register_node('selfrep:selfrep_ladder_dead', {
	description = 'Dead Self Replicating Ladder',
	drawtype = "nodebox",
	--paramtype2 = "facedir",
	tiles = {"selfrep_ladder_dead.png"},
	climbable = true,
	groups = {cracky = 3, stone = 1, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/6, 1/2, 1/2, 1/6},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/6, 1/2, 1/2, 1/6},
	},

	sounds = default.node_sound_stone_defaults()
	})



-- Node dome

minetest.register_node('selfrep:selfrep_dome', {
	description = 'Self Replicating Dome',
	--light_source = 3,
	tiles = {"selfrep_dome.png"},
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),

	})


-- Dome gas
--provides a second type of air to hold the dome back

minetest.register_node('selfrep:selfrep_dome_gas', {
	description = 'Selfrep Dome gas',
	light_source = 10,
	tiles = {"selfrep_dome.png"},
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	groups = {not_in_creative_inventory = 1},
	})






