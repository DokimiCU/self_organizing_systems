




------------------------------------------------------------------NODES
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




