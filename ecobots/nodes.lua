------------------------------------------------------------------Nodes
---------------------------------------------------------------

-- Node photosynth bot

minetest.register_node('ecobots:ecobots_photosynth_bot', {
	description = 'Tree Bot',
	tiles = {"ecobots_photosynthetic_bot.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, attached_node = 1, oddly_breakable_by_hand=1, tree =1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	})


-- Node pioneer bot

minetest.register_node('ecobots:ecobots_pioneer_bot', {
	description = 'Pioneer Bot',
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.5,
	tiles = {"ecobots_pioneer_bot.png"},
	inventory_image = "ecobots_pioneer_bot.png",
	wield_image = "ecobots_pioneer_bot.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, flora = 1, attached_node = 1, grass = 1, falling_node = 1, oddly_breakable_by_hand=1, tree =1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 1.3, 7 / 16},
		},
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
	light_source = 3,
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



