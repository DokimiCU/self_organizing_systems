


---------------------------------------------------------------
---NODES
----------------------------------------------------------------

--------------------------------------------------------------
--PROTECTOR
-- defends against all doomsday devices

minetest.register_node("selfrep_doomsday:selfrep_doomsday_protector", {
	description = "Doomsday Protector",
	tiles = {"selfrep_doomsday_protector.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, cracky = 3},
	sounds = default.node_sound_metal_defaults(),
})


--AUTOPROTECTOR
-- defends against all doomsday devices
-- self replicating

minetest.register_node("selfrep_doomsday:selfrep_doomsday_autoprotector", {
	description = "Doomsday Auto-Protector",
	tiles = {"selfrep_doomsday_autoprotector.png"},
	light_source = 5,
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	--pointable = false,
	--diggable = false,
	buildable_to = true,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, cracky = 3},
	sounds = default.node_sound_metal_defaults(),
})


--PROTECTOR DOME
-- creates a dome of protectors around player

minetest.register_node("selfrep_doomsday:selfrep_doomsday_dome", {
	description = "Doomsday Protector Dome",
	tiles = {"selfrep_doomsday_dome.png"},
	light_source = 12,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, cracky = 3},
	sounds = default.node_sound_metal_defaults(),
})

-- dome gas... helps it function.. invisible

minetest.register_node("selfrep_doomsday:selfrep_doomsday_dome_gas", {
	description = "Doomsday Protector Dome Gas",
	tiles = {"selfrep_doomsday_dome.png"},
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	groups = {not_in_creative_inventory = 1},
	--sounds = default.node_sound_metal_defaults(),
})


----------------------------------------------------------------------------

-- MYSTERY BOX
-- what will it be?

minetest.register_node("selfrep_doomsday:selfrep_doomsday_mystery", {
	description = "Doomsday Mystery Box",
	tiles = {"selfrep_doomsday_mystery.png"},
	is_ground_content = false,
	groups = {oddly_breakable_by_hand=3, cracky = 3},
	sounds = default.node_sound_metal_defaults(),
		on_punch = function(pos, node, puncher)
			local q = math.random (1,10)
			if q ==1 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
			end
			
			if q ==2 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			end

			if q ==3 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon"})
			end

			if q ==4 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_blight"})
			end

			if q ==5 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_terraformer"})
			end

			if q ==6 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_flash"})
			end

			if q ==7 then
				minetest.set_node(pos, {name = "default:mese_block"})
			end

			if q ==8 then
				minetest.set_node(pos, {name = "tnt:tnt"})
			end

			if q ==9 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source"})
			end

			if q ==10 then
				minetest.set_node(pos, {name = "default:sand"})
			end
		end,

	on_blast = function(pos)
			
		local q = math.random (1,10)
			if q ==1 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
			end
			
			if q ==2 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			end

			if q ==3 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon"})
			end

			if q ==4 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_blight"})
			end

			if q ==5 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_terraformer"})
			end

			if q ==6 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_flash"})
			end

			if q ==7 then
				minetest.set_node(pos, {name = "default:mese_block"})
			end

			if q ==8 then
				minetest.set_node(pos, {name = "tnt:tnt"})
			end

			if q ==9 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source"})
			end

			if q ==10 then
				minetest.set_node(pos, {name = "default:sand"})
			end
	end,
})



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
	groups = {flammable = 2, oddly_breakable_by_hand=3, cracky = 3},
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
	groups = {flammable = 2, oddly_breakable_by_hand=3, igniter = 2, cracky = 3},
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
	groups = {flammable = 2, oddly_breakable_by_hand=3, falling_node = 1, crumbly = 3},
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
	groups = {not_in_creative_inventory = 1, crumbly = 3},
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
	groups = {flammable = 2, oddly_breakable_by_hand=3, falling_node = 1, cracky = 3},
	sounds = default.node_sound_sand_defaults(),
	})



--------------------------------------------------------------
--FLASH NODES
--------------------------------------------------------------



-- FLASH NODE


minetest.register_node('selfrep_doomsday:selfrep_doomsday_flash', {
	description = 'Self Replicating Flash',
	light_source = 14,
	tiles = {"selfrep_doomsday_flash.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	--pointable = false,
	--diggable = false,
	buildable_to = true,
	damage_per_second = 3,
	groups = {igniter = 2, oddly_breakable_by_hand=3, cracky = 3},
	use_texture_alpha = true,
	post_effect_color = {a = 100, r = 255, g = 255, b = 255},
	})






-- FLASH GLOW

minetest.register_node('selfrep_doomsday:selfrep_doomsday_flash_glow', {
	description = 'Self Replicating Flash Glow',
	light_source = 14,
	tiles = {"selfrep_doomsday_flash_glow.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	damage_per_second = 1,
	--puts out fire by being starved of oxygen
	groups = {not_in_creative_inventory = 1, puts_out_fire = 1},
	use_texture_alpha = true,
	post_effect_color = {a = 50, r = 255, g = 255, b = 255},
	})


--------------------------------------------------------------
--CHAOS NODES
--------------------------------------------------------------



-- CHAOS NODE


minetest.register_node('selfrep_doomsday:selfrep_doomsday_chaos', {
	description = 'Self Replicating Chaos',
	light_source = 10,
	tiles = {"selfrep_doomsday_chaos.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	--pointable = false,
	--diggable = false,
	buildable_to = true,
	--damage_per_second = 3,
	groups = {oddly_breakable_by_hand=3, cracky = 3, fall_damage_add_percent=-80, bouncy=80},
	use_texture_alpha = true,
	post_effect_color = {a = 180, r = 255, g = 255, b = 255},
	})




-- CHAOS GLOW

minetest.register_node('selfrep_doomsday:selfrep_doomsday_chaos_glow', {
	description = 'Self Replicating Chaos Gas',
	light_source = 4,
	tiles = {"selfrep_doomsday_chaos_glow.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	--damage_per_second = 1,
	groups = {not_in_creative_inventory = 1, puts_out_fire = 1, cools_lava = 1},
	use_texture_alpha = true,
	post_effect_color = {a = 20, r = 255, g = 255, b = 255},
	})

-- CHAOS SPARK

minetest.register_node('selfrep_doomsday:selfrep_doomsday_chaos_spark', {
	description = 'Self Replicating Chaos Spark',
	light_source = 14,
	tiles = {"selfrep_doomsday_chaos_spark.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	--damage_per_second = 1,
	groups = {not_in_creative_inventory = 1},
	use_texture_alpha = true,
	post_effect_color = {a = 200, r = 255, g = 255, b = 255},
	})


--CHAOS CRYSTAL

minetest.register_node('selfrep_doomsday:selfrep_doomsday_chaos_crystal', {
	description = 'Chaos Crystal',
	drawtype = "glasslike",
	paramtype = "light",
	light_source = 7,
	sunlight_propagates = false,
	tiles = {"selfrep_doomsday_chaos_crystal.png"},
	use_texture_alpha = true,
	groups = {cracky = 3, stone = 1, not_in_creative_inventory = 1, fall_damage_add_percent=-80, bouncy=95},
	sounds = default.node_sound_stone_defaults()
	})




