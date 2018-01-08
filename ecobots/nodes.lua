------------------------------------------------------------------Nodes
----------------------------------------------------------------


------------------------------------------------------------------Swamp FOREST




-- Node forest herb bot

minetest.register_node('ecobots:ecobots_forest_herb_bot', {
	description = 'Swamp Forest Herb Bot',
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"ecobots_forest_herb_bot.png"},
	inventory_image = "ecobots_forest_herb_bot.png",
	wield_image = "ecobots_forest_herb_bot.png",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, flora = 1, falling_node = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'farming:seed_cotton'}, rarity = 16},
			{items = {'ecobots:ecobots_forest_herb_bot'}}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.6, -7 / 16, 7 / 16, 0.6, 7 / 16},
		},
	})





--Node forest shrub trunk

minetest.register_node("ecobots:ecobots_forest_shrub_trunk", {
	description = "Forest Shrub Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	climbable = true,
	tiles = {
		"default_tree_top.png",
		"default_tree_top.png",
		"default_tree.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,choppy=3,oddly_breakable_by_hand=2, flammable=3, falling_node = 1},
	sounds = default.node_sound_wood_defaults(),
	})




-- Node Forest Shrub bot

minetest.register_node('ecobots:ecobots_forest_shrub_bot', {
	description = 'Swamp Forest Shrub Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	walkable = true,
	tiles = {"ecobots_forest_shrub_bot.png"},
	special_tiles = {"ecobots_forest_shrub_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1},
	post_effect_color = {a = 200, r = 23, g = 109, b = 0},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'default:apple'}, rarity = 12},
			{items = {'ecobots:ecobots_forest_shrub_bot'}}
		}
	},
	})





-- Node Swamp Forest tree bot

minetest.register_node('ecobots:ecobots_forest_tree_bot', {
	description = 'Swamp Forest Tree Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	tiles = {"ecobots_forest_tree_bot.png"},
	special_tiles = {"ecobots_forest_tree_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	})


------------------------------------------------------------------PIONEERS

-- Node pioneer grass bot

minetest.register_node('ecobots:ecobots_pioneer_bot', {
	description = 'Pioneer Grass Bot',
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.27,
	tiles = {"ecobots_pioneer_bot.png"},
	inventory_image = "ecobots_pioneer_bot.png",
	wield_image = "ecobots_pioneer_bot.png",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, flora = 1, grass = 1, falling_node = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'farming:seed_wheat'}, rarity = 16},
			{items = {'ecobots:ecobots_pioneer_bot'}}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.3, -7 / 16, 7 / 16, 0.7, 7 / 16},
		},
	})




--Node Pioneer shrub trunk

minetest.register_node("ecobots:ecobots_pioneer_shrub_trunk", {
	description = "Pioneer Shrub Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	climbable = true,
	tiles = {
		"default_aspen_tree_top.png",
		"default_aspen_tree_top.png",
		"default_aspen_tree.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,choppy=3,oddly_breakable_by_hand=2,flammable=3, falling_node = 1},
	sounds = default.node_sound_wood_defaults(),
	})




-- Node Pioneer Shrub bot

minetest.register_node('ecobots:ecobots_pioneer_shrub_bot', {
	description = 'Pioneer Shrub Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	walkable = true,
	tiles = {"ecobots_pioneer_shrub_bot.png"},
	special_tiles = {"ecobots_pioneer_shrub_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1, flower = 1, color_yellow = 1},
	post_effect_color = {a = 200, r = 77, g = 109, b = 0},
	sounds = default.node_sound_leaves_defaults(),
	})






-- Node photosynth bot aka Pioneer tree

minetest.register_node('ecobots:ecobots_photosynth_bot', {
	description = 'Pioneer Tree Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	tiles = {"ecobots_photosynthetic_bot.png"},
	special_tiles = {"ecobots_photosynthetic_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	})



------------------------------------------------------------------GENERALISTS

-- Node generalist Tree bot

minetest.register_node('ecobots:ecobots_generalist_tree_bot', {
	description = 'Generalist Tree Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	tiles = {"ecobots_generalist_tree_bot.png"},
	special_tiles = {"ecobots_generalist_tree_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'default:apple'}, rarity = 9},
			{items = {'ecobots:ecobots_generalist_tree_bot'}}
		}
	},
	})



-- Node Generalist flower bot

minetest.register_node('ecobots:ecobots_generalist_flower_bot', {
	description = 'Generalist Flower Bot',
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.2,
	tiles = {"ecobots_generalist_flower_bot.png"},
	inventory_image = "ecobots_generalist_flower_bot.png",
	wield_image = "ecobots_generalist_flower_bot.png",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, flower = 1, color_white = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 4 / 16, 2 / 16},
		},
	})


----------------------------------------------------------------
--SNOW

-- Node snow Tree bot

minetest.register_node('ecobots:ecobots_snow_tree_bot', {
	description = 'Snow Tree Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	tiles = {"ecobots_snow_tree_bot.png"},
	special_tiles = {"ecobots_snow_tree_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	})

-- Node Snow flower bot

minetest.register_node('ecobots:ecobots_snow_flower_bot', {
	description = 'Snow Flower Bot',
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"ecobots_snow_flower_bot.png"},
	inventory_image = "ecobots_snow_flower_bot.png",
	wield_image = "ecobots_snow_flower_bot.png",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, flower = 1, color_red = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 4 / 16, 2 / 16},
		},
	})

-- Node Snow Shrub bot

minetest.register_node('ecobots:ecobots_snow_shrub_bot', {
	description = 'Snow Shrub Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	walkable = true,
	tiles = {"ecobots_snow_shrub_bot.png"},
	special_tiles = {"ecobots_snow_shrub_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'default:apple'}, rarity = 16},
			{items = {'ecobots:ecobots_snow_shrub_bot'}}
		}
	},
	})


--Node snow shrub trunk

minetest.register_node("ecobots:ecobots_snow_shrub_trunk", {
	description = "Snow Shrub Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	climbable = true,
	tiles = {
		"default_pine_tree_top.png",
		"default_pine_tree_top.png",
		"default_acacia_tree.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, falling_node = 1},
	sounds = default.node_sound_wood_defaults(),
	})





------------------------------------------------------------------HILL

-- Node Hill Tree bot

minetest.register_node('ecobots:ecobots_hill_tree_bot', {
	description = 'Hill Tree Bot',
	drawtype = "allfaces_optional",
	paramtype = "light",
	tiles = {"ecobots_hill_tree_bot.png"},
	special_tiles = {"ecobots_hill_tree_bot_simple.png"},
	groups = {snappy = 3, flammable = 2, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, leaves = 1, flower = 1, color_blue = 1},
	sounds = default.node_sound_leaves_defaults(),
	})




------------------------------------------------------------------SAND

-- Node sand grass bot

minetest.register_node('ecobots:ecobots_sand_grass_bot', {
	description = 'Sand Grass Bot',
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.3,
	tiles = {"ecobots_sand_grass_bot.png"},
	inventory_image = "ecobots_sand_grass_bot.png",
	wield_image = "ecobots_sand_grass_bot.png",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 1, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7 / 16, -0.5, -7 / 16, 7 / 16, 0.3, 7 / 16},
		},
	})

-- Node sand cactus bot

minetest.register_node("ecobots:ecobots_sand_cactus_bot", {
	description = "Sand Cactus Bot",
	tiles = {"ecobots_sand_cactus_bot.png"},
	groups = {choppy = 3, flammable = 1, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, tree=1},
	sounds = default.node_sound_wood_defaults(),
})


-- Node sand palm bot

minetest.register_node('ecobots:ecobots_sand_palm_bot', {
	description = 'Sand Palm Bot',
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.8,
	tiles = {"ecobots_sand_palm_bot.png"},
	inventory_image = "ecobots_sand_palm_bot.png",
	wield_image = "ecobots_sand_palm_bot.png",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 1, flora = 1, falling_node = 1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'farming:apple'}, rarity = 16},
			{items = {'ecobots:ecobots_sand_palm_bot'}}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.7, -0.5, -0.7, 0.7, 0.7, 0.7},
		},
	})

--Node sand palm trunk

minetest.register_node("ecobots:ecobots_sand_palm_trunk", {
	description = "Sand Palm Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	climbable = true,
	tiles = {
		"default_acacia_tree_top.png",
		"default_acacia_tree_top.png",
		"default_tree.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=2, flammable=3, falling_node = 1},
	sounds = default.node_sound_wood_defaults(),
	})



------------------------------------------------------------------SEA

-- Node coral bot
minetest.register_node("ecobots:ecobots_coral_bot", {
	description = "Coral Bot",
	tiles = {"ecobots_coral_bot.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_gravel_defaults(),
})

-- Beach Shellfish bot
minetest.register_node("ecobots:ecobots_beach_shellfish_bot", {
	description = "Beach Shellfish Bot",
	tiles = {"ecobots_beach_shellfish_bot.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
	--dig up the shellfish
	on_punch = function(pos, node, puncher)
		puncher:get_inventory():add_item('main', "ecobots:ecobots_beach_shellfish")				minetest.set_node(pos, {name = "default:sand"})
		end,
})


minetest.register_node("ecobots:ecobots_beach_shellfish", {
	description = "Beach Shellfish",
	drawtype = "plantlike",
	paramtype = "light",
	visual_scale = 0.6,
	tiles = {"ecobots_beach_shellfish.png"},
	inventory_image = "ecobots_beach_shellfish.png",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.2, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3},
	
	sounds = default.node_sound_sand_defaults(),
	on_use = minetest.item_eat(1),
})



-- Estuary Shellfish bot
minetest.register_node("ecobots:ecobots_estuary_shellfish_bot", {
	description = "Estuary Shellfish Bot",
	tiles = {"ecobots_estuary_shellfish_bot.png"},
	groups = {crumbly = 3, falling_node = 1, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
	--dig up the shellfish
	on_punch = function(pos, node, puncher)
		puncher:get_inventory():add_item('main', "ecobots:ecobots_estuary_shellfish")				minetest.set_node(pos, {name = "default:dirt"})
		end,
})


minetest.register_node("ecobots:ecobots_estuary_shellfish", {
	description = "Estuary Shellfish",
	drawtype = "plantlike",
	paramtype = "light",
	visual_scale = 0.6,
	tiles = {"ecobots_estuary_shellfish.png"},
	inventory_image = "ecobots_estuary_shellfish.png",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.2, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3},
	
	sounds = default.node_sound_sand_defaults(),
	on_use = minetest.item_eat(1),
})



------------------------------------------------------------------CAVE

-- Node cave slime bot
minetest.register_node("ecobots:ecobots_cave_slime_bot", {
	description = "Cave Slime Bot",
	light_source = 4,
	tiles = {"ecobots_cave_slime_bot.png"},
	groups = {crumbly = 3, flora = 1, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
})



------------------------------------------------------------------ANIMALS


-- Node Herbivore aka 1st trophic predator bot

minetest.register_node('ecobots:ecobots_predator_bot', {
	description = 'Herbivore Bot',
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"ecobots_predator_bot.png"},
	node_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	groups = {snappy = 3, fleshy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	on_use = minetest.item_eat(2),
	})


-- Node Herbivore aka 1st trophic predator bot FLASHING

minetest.register_node('ecobots:ecobots_predator_bot_flashing', {
	description = 'Herbivore Bot (Flashing)',
	drawtype = "nodebox",
	light_source = 5,
	paramtype = "light",
	tiles = {"ecobots_predator_bot.png"},
	node_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	groups = {snappy = 3, fleshy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	on_use = minetest.item_eat(2),
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
			{items = {'flowers:mushroom_brown'}, rarity = 9},
			{items = {'ecobots:ecobots_decomposer_bot'}}
		}
	},

	})


-- Node apex predator bot

minetest.register_node('ecobots:ecobots_apex_bot', {
	description = 'Apex Predator Bot',
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"ecobots_apex_bot.png"},
	groups = {snappy = 3, fleshy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	on_use = minetest.item_eat(4),
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-0.5)
    end,
		})


-- Node apex predator trap

minetest.register_node('ecobots:ecobots_apex_trap', {
	description = "Apex Predator's Trap",
	drawtype = "glasslike",
	waving = 1,
	light_source = 4,
	tiles = {"ecobots_apex_trap.png"},
	inventory_image = "ecobots_apex_trap.png",
	wield_image = "ecobots_apex_trap.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {flammable = 1, dig_immediate = 3},
	})

-- Node apex predator trap full

minetest.register_node('ecobots:ecobots_apex_trap_full', {
	description = "Apex Predator's Trap (full)",
	drawtype = "glasslike",
	waving = 1,
	light_source = 2,
	tiles = {"ecobots_apex_trap_full.png"},
	inventory_image = "ecobots_apex_trap_full.png",
	wield_image = "ecobots_apex_trap_full.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {flammable = 1, dig_immediate = 3},
	on_use = minetest.item_eat(1),
	})




-- Node detritivore bot

minetest.register_node('ecobots:ecobots_detritivore_bot', {
	description = 'Detritivore Bot',
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"ecobots_detritivore_bot.png"},
	groups = {snappy = 3, fleshy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	on_use = minetest.item_eat(1),
	})



-- Node detritivore Dormant
minetest.register_node("ecobots:ecobots_detritivore_dormant", {
	description = "Dormant Detritivore Bot",
	tiles = {"ecobots_detritivore_dormant.png"},
	groups = {crumbly = 3, falling_node = 1},
	sounds = default.node_sound_dirt_defaults(),
	--dig up the shellfish
	drop = "ecobots:ecobots_detritivore_bot",
})





------------------------------------------------------------------DEAD NODES

---dead bot

minetest.register_node("ecobots:ecobots_bot_dead", {
	description = "Dead Bot",
	tiles = {"ecobots_bot_dead.png"},
	groups = {crumbly = 3, falling_node = 1, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})


------------------------------------------------------------------EUSOCIAL BOT


--- Fed Nest

minetest.register_node("ecobots:ecobots_eusocial_nest_fed", {
	description = "Eusocial Bot Nest (fed)",
	tiles = {"ecobots_eusocial_nest_fed.png"},
	groups = {crumbly = 3, flammable = 2},
	sounds = default.node_sound_dirt_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'ecobots:ecobots_eusocial_bot_queen'}, rarity = 10},
			{items = {'ecobots:ecobots_eusocial_bot_returning'}}
		}
	},
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-1)
	-- battle!	
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 1, max_hear_distance = 30,})
    	end,
})


--- Hungry Nest

minetest.register_node("ecobots:ecobots_eusocial_nest_unfed", {
	description = "Eusocial Bot Nest (unfed)",
	tiles = {"ecobots_eusocial_nest.png"},
	groups = {crumbly = 3, flammable = 2},
	sounds = default.node_sound_dirt_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'ecobots:ecobots_eusocial_bot_queen'}, rarity = 10},
			{items = {'ecobots:ecobots_eusocial_bot_searching'}}
		}
	},

	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-1)
	-- battle!	
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 1, max_hear_distance = 30,})
    	end,
})


--- Storage Nest

minetest.register_node("ecobots:ecobots_eusocial_nest_storage", {
	description = "Eusocial Bot Nest (storage)",
	tiles = {"ecobots_eusocial_nest_storage.png"},
	groups = {crumbly = 3, flammable = 2},
	sounds = default.node_sound_dirt_defaults(),
	drop = {
		max_items = 1,
		items = {
			{items = {'ecobots:ecobots_pioneer_bot'}, rarity = 10},
			{items = {'ecobots:ecobots_eusocial_bot_returning'}}
		}
	},
})


--- Empty Storage Nest

minetest.register_node("ecobots:ecobots_eusocial_nest_empty_storage", {
	description = "Eusocial Bot Nest (empty storage)",
	tiles = {"ecobots_eusocial_nest_empty_storage.png"},
	groups = {crumbly = 3, flammable = 2},
	sounds = default.node_sound_dirt_defaults(),
	})




--- Eusocial Bot Trail

minetest.register_node("ecobots:ecobots_eusocial_trail", {
	description = "Eusocial Bot Trail",
	tiles = {"ecobots_eusocial_trail.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})


-- Eusocial bot searching

minetest.register_node('ecobots:ecobots_eusocial_bot_searching', {
	description = 'Eusocial Bot (searching)',
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"ecobots_eusocial_bot.png"},
	groups = {snappy = 3, fleshy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	on_use = minetest.item_eat(1),
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-0.5)
	-- battle!	
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 1, max_hear_distance = 30,})
    end,
		})


-- Eusocial bot return

minetest.register_node('ecobots:ecobots_eusocial_bot_returning', {
	description = 'Eusocial Bot (returning)',
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"ecobots_eusocial_bot_return.png"},
	groups = {snappy = 3, fleshy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	on_use = minetest.item_eat(1),
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-0.5)
	-- battle!	
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 1, max_hear_distance = 30,})
    end,
		})


-- Eusocial bot Queen

minetest.register_node('ecobots:ecobots_eusocial_bot_queen', {
	description = 'Eusocial Bot (Queen)',
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"ecobots_eusocial_bot_queen.png"},
	groups = {snappy = 3, fleshy = 3, flammable = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),
	node_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, -0.3, 0.1},
	},
	on_use = minetest.item_eat(1),
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-0.5)
	-- battle!	
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 1, max_hear_distance = 30,})
    end,
		})

------------------------------------------------------------------ E Vine


minetest.register_node('ecobots:ecobots_evine_bot', {
	description = 'Evolving Vine Bot',
	drawtype = "firelike",
	tiles = {"ecobots_evine_bot.png"},
	inventory_image = "ecobots_evine_bot.png",
	wield_image = "ecobots_evine_bot.png",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	waving = 1,
	climbable = true,
	buildable_to = false,
	groups = {snappy = 3, flammable = 1, flora = 1, falling_node = 1, oddly_breakable_by_hand=1, flower = 1, color_violet = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_float("grow_vs_age", 0)
		local grow_vs_age_list_value = meta:get_float("grow_vs_age")
		meta:set_string("formspec",
			"size[10,10]"..
			"button[6,6;3,1;set_default_genome;Set Default Genome]"..
			"button[1,6;3,1;set_random_genome;Set Random Genome]"..
			"button_exit[3.5,4.5;3,1;exit_form;Exit]"..
			"label[2,1;Growth vs Lifespan]"..
			"label[2,3;Lower values live fast and die young]"..			"textlist[2,2;2,1;grow_vs_age_list;"..grow_vs_age_list_value.."]"

		)
    end,

	
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)

			if fields.set_default_genome then
			meta:set_float("grow_vs_age", 0)
			local grow_vs_age_list_value = meta:get_float("grow_vs_age")
			meta:set_string("formspec",
			"size[10,10]"..
			"button[6,6;3,1;set_default_genome;Set Default Genome]"..
			"button[1,6;3,1;set_random_genome;Set Random Genome]"..
			"button_exit[3.5,4.5;3,1;exit_form;Exit]"..
			"label[2,1;Growth vs Lifespan]"..
			"label[2,3;Lower values live fast and die young]"..
						"textlist[2,2;2,1;grow_vs_age_list;"..grow_vs_age_list_value.."]"	
			)
		end


		if fields.set_random_genome then
			meta:set_float("grow_vs_age", math.random(0, 100))
			local grow_vs_age_list_value = meta:get_float("grow_vs_age")
			meta:set_string("formspec",
			"size[10,10]"..
			"button[6,6;3,1;set_default_genome;Set Default Genome]"..
			"button[1,6;3,1;set_random_genome;Set Random Genome]"..
			"button_exit[3.5,4.5;3,1;exit_form;Exit]"..
			"label[2,1;Growth vs Lifespan]"..
			"label[2,3;Lower values live fast and die young]"..
						"textlist[2,2;2,1;grow_vs_age_list;"..grow_vs_age_list_value.."]"				
			)
		end



	end,



	})



------------------------------------------------------------------- SWARMER BOT


minetest.register_node('ecobots:ecobots_swarmer_bot', {
	description = 'Swarmer Bot',
	drawtype = "glasslike",
	tiles = {
		{name="ecobots_swarmer_bot1.png",
		 animation = {type="vertical_frames", length=80.0}},
		{name="ecobots_swarmer_bot2.png",
		 animation = {type="vertical_frames", length=80.0}},
		{name="ecobots_swarmer_bot1.png",
		 animation = {type="vertical_frames", length=80.0}},
		{name="ecobots_swarmer_bot2.png",
		 animation = {type="vertical_frames", length=80.0}},
		{name="ecobots_swarmer_bot1.png",
		 animation = {type="vertical_frames", length=80.0}},
		{name="ecobots_swarmer_bot2.png",
		 animation = {type="vertical_frames", length=80.0}}
		 },
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, fleshy = 3},
	damage_per_second = 1,
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-1)
-- battle!	
		minetest.sound_play("ecobots_swarmer_nomnom", {pos = pos, gain = 1, max_hear_distance = 30,})
    	end,

--give it a heading so doesn't have nil
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("heading", "XP")
	end,
	})


--Swarmer Bot Eggs

minetest.register_node("ecobots:ecobots_swarmer_eggs", {
	description = "Swarmer Bot Eggs",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"ecobots_swarmer_eggs.png"},
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3},
	on_use = minetest.item_eat(0.5),
	sounds = default.node_sound_wood_defaults(),
	})


