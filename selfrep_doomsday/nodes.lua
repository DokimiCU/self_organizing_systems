




------------------------------------------------------------------NODES
----------------------------------------------------------------


--DEAD BLOCKS borrowed from selfrep road

minetest.register_node('selfrep_doomsday:selfrep_road_dead', {
	description = 'Dead Self Replicator',
	tiles = {"selfrep_road_dead.png"},
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

	--node lifespan
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(60)
	end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_road_dead"})
	end,
	})


-- WEAPON

minetest.register_node('selfrep_doomsday:selfrep_doomsday_weapon', {
	description = 'Self Replicating Weapon',
	light_source = 8,
	tiles = {"selfrep_weapon.png"},
	walkable = false,
	damage_per_second = 1,
	groups = {cracky = 3, flammable = 2, oddly_breakable_by_hand=1, igniter = 2},
	sounds = default.node_sound_metal_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(60)
	end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source"})
	end,
	})



-- WEAPON RESIDUE

minetest.register_node('selfrep_doomsday:selfrep_doomsday_weapon_residue_source', {
	description = 'Self Replicating Weapon Residue',
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
	groups = {flammable = 2, liquid = 2, igniter = 2},
})


minetest.register_node("selfrep_doomsday:selfrep_doomsday_weapon_residue_flowing", {
	description = "Flowing Self Replicating Weapon Residue",
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
	groups = {flammable = 3, liquid = 2, not_in_creative_inventory = 1},

})














