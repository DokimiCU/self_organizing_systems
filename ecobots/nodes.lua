------------------------------------------------------------------Nodes
---------------------------------------------------------------

-- Node photosynth bot

minetest.register_node('ecobots:ecobots_photosynth_bot', {
	description = 'Photosynthetic Bot',
	tiles = {"ecobots_photosynthetic_bot.png"},
	groups = {snappy = 3, flammable = 2, falling_node = 1, oddly_breakable_by_hand=1, tree =1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	})


-- Node pioneer bot

minetest.register_node('ecobots:ecobots_pioneer_bot', {
	description = 'Pioneer Bot',
	tiles = {"ecobots_pioneer_bot.png"},
	groups = {snappy = 3, flammable = 2, falling_node = 1, oddly_breakable_by_hand=1, tree =1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	})



-- Node Herbivore aka 1st trophic predator bot

minetest.register_node('ecobots:ecobots_predator_bot', {
	description = 'Herbivore Bot',
	tiles = {"ecobots_predator_bot.png"},
	groups = {snappy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	drop = {
		  max_items = 1,
		  items = {
			{items = {'ecobots:ecobots_predator_bot'},rarity = 1},
				}
			},
	})


-- Node decomposer bot

minetest.register_node('ecobots:ecobots_decomposer_bot', {
	description = 'Decomposer Bot',
	tiles = {"ecobots_decomposer_bot.png"},
	groups = {crumbly = 2, flammable = 2, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
	drop = {
		  max_items = 1,
		  items = {
			{items = {'ecobots:ecobots_decomposer_bot'},rarity = 1},
				}
			},
	})


-- Node apex predator bot

minetest.register_node('ecobots:ecobots_apex_bot', {
	description = 'Apex Predator Bot',
	tiles = {"ecobots_apex_bot.png"},
	groups = {snappy = 1, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-0.5)
    end,
		})

-- Node detritivore bot

minetest.register_node('ecobots:ecobots_detritivore_bot', {
	description = 'Detritivore Bot',
	tiles = {"ecobots_detritivore_bot.png"},
	groups = {snappy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	drop = {
		  max_items = 1,
		  items = {
			{items = {'ecobots:ecobots_detritivore_bot'},rarity = 1},
				}
			},
	})





----DEAD NODES

---dead bot

minetest.register_node("ecobots:ecobots_bot_dead", {
	description = "Dead Bot",
	tiles = {"ecobots_bot_dead.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})



