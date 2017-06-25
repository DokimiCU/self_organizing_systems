




------------------------------------------------------------------NODES
----------------------------------------------------------------
--------------------------------------------------------------
--GREY GOO NODES
--------------------------------------------------------------

--SOLID BLOCKS

minetest.register_node('selfrep_doomsday:selfrep_road_dead', {
	description = 'Solid Self Replicator',
	tiles = {"selfrep__doomsday_solid.png"},
	groups = {cracky = 3, stone = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_stone_defaults()
	})





-- GREY GOO

minetest.register_node('selfrep_doomsday:selfrep_doomsday_greygoo', {
	description = 'Self Replicating Grey Goo',
	light_source = 8,
	tiles = {"selfrep_greygoo.png"},
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1},
	sounds = default.node_sound_metal_defaults(),
	})



--------------------------------------------------------------
--WEAPON NODES
--------------------------------------------------------------


-- WEAPON

minetest.register_node('selfrep_doomsday:selfrep_doomsday_weapon', {
	description = 'Self Replicating Weapon',
	light_source = 8,
	tiles = {"selfrep_weapon.png"},
	walkable = false,
	damage_per_second = 1,
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1, igniter = 2},
	sounds = default.node_sound_metal_defaults(),
	})



-- WEAPON RESIDUE

minetest.register_node('selfrep_doomsday:selfrep_doomsday_weapon_residue_source', {
	description = 'Self Replicating Weapon Residue',
	light_source = 7,
	drawtype = "liquid",
	tiles = {
		{
			name="selfrep_weapon_residue_flowing.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		{
			name="selfrep_weapon_residue_flowing.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "selfrep_doomsday:selfrep_doomsday_weapon_residue_flowing",
	liquid_alternative_source = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	liquid_range = 3,
	damage_per_second = 1,
	post_effect_color = {a = 230, r = 80, g = 80, b = 50},
	groups = {flammable = 3, liquid = 2, igniter = 2, not_in_creative_inventory = 1},
})


minetest.register_node("selfrep_doomsday:selfrep_doomsday_weapon_residue_flowing", {
	description = "Flowing Self Replicating Weapon Residue",
	light_source = 7,
	drawtype = "flowingliquid",
	tiles = {"selfrep_weapon_residue_source.png"},
	special_tiles = {
		{
			image="selfrep_weapon_residue_flowing.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			image="selfrep_weapon_residue_flowing.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "selfrep_doomsday:selfrep_doomsday_weapon_residue_flowing",
	liquid_alternative_source = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 1,
	liquid_range = 3,
	post_effect_color = {a = 230, r = 80, g = 80, b = 50},
	groups = {igniter = 2, liquid = 2, not_in_creative_inventory = 1},

})


-- WEAPON GAS

minetest.register_node('selfrep_doomsday:selfrep_doomsday_weapongas', {
	description = 'Self Replicating Weapon Gas',
	light_source = 0,
	tiles = {"selfrep_weapongas.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = false,
	damage_per_second = 1,
	use_texture_alpha = true,
	post_effect_color = {a = 10, r = 212, g = 111, b = 81},
	groups = {not_in_creative_inventory = 1},
	})




--------------------------------------------------------------
--BLIGHT NODES
--------------------------------------------------------------



-- BLIGHT

minetest.register_node('selfrep_doomsday:selfrep_blight', {
	description = 'Self Replicating Blight',
	light_source = 3,
	sunlight_propagates = true,
	tiles = {"selfrep_blight.png"},
	walkable = false,
	damage_per_second = 1,
	groups = {crumbly = 3, flammable = 2, oddly_breakable_by_hand=1, falling_node = 1},
	post_effect_color = {a = 240, r = 70, g = 70, b = 60},
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-0.5)
    	end,
	})


-- BLIGHT SPORE

minetest.register_node('selfrep_doomsday:selfrep_blightspore', {
	description = 'Self Replicating Blight Spore',
	light_source = 10,
	tiles = {"selfrep_blightspore.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	damage_per_second = 1,
	groups = {crumbly = 3, flammable = 2},
	use_texture_alpha = true,
	post_effect_color = {a = 200, r = 51, g = 15, b = 3},
	groups = {not_in_creative_inventory = 1},
	})






--BLIGHTED SAND

minetest.register_node("selfrep_doomsday:selfrep_doomsday_blighted_sand", {
	description = "Blighted Sand",
	tiles = {"selfrep_blighted_sand.png"},
	groups = {crumbly = 3, falling_node = 1, sand = 1},
	sounds = default.node_sound_sand_defaults(),
	groups = {not_in_creative_inventory = 1},
	on_punch = function(pos, node, puncher)
      	local health = puncher:get_hp()
      	puncher:set_hp(health-0.5)
    end,

})


--BLACK SAND

minetest.register_node("selfrep_doomsday:selfrep_doomsday_black_sand", {
	description = "Black Sand",
	tiles = {"selfrep_black_sand.png"},
	drop = {
		max_items = 2,
		items = {
			{items = {'default:coal_lump'}, rarity = 10},
			{items = {'selfrep_doomsday:selfrep_doomsday_black_sand'}}
		}},
	groups = {crumbly = 3, falling_node = 1, sand = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_sand_defaults(),
	})


--BLIGHTED WASTE

minetest.register_node("selfrep_doomsday:selfrep_doomsday_blighted_waste", {
	description = "Blighted Waste",
	tiles = {"selfrep_blighted_waste.png"},
	groups = {crumbly = 3, falling_node = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_sand_defaults(),
		on_punch = function(pos, node)
			minetest.set_node(pos, {name = 	"selfrep_doomsday:selfrep_blight"})
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 1, max_hear_distance = 20,})
		end,
})


--DORMANT

minetest.register_node("selfrep_doomsday:selfrep_doomsday_dormant", {
	description = "Dormant Blight",
	tiles = {"default_desert_sand.png"},
	walkable = true,
	pointable = true,
	diggable = true,
	groups = {crumbly = 3, falling_node = 1, sand = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_sand_defaults(),
	})



--------------------------------------------------------------
--TERRAFORMER NODES
--------------------------------------------------------------


-- TERRAFORMER

minetest.register_node('selfrep_doomsday:selfrep_doomsday_terraformer', {
	description = 'Self Replicating Terraformer',
	light_source = 3,
	tiles = {"selfrep_doomsday_terraformer.png"},
	walkable = true,
	groups = {crumbly = 3, flammable = 2, oddly_breakable_by_hand=1, falling_node = 1},
	sounds = default.node_sound_sand_defaults(),
	})

