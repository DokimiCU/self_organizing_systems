local killrate = minetest.setting_get("selfrep_doomsday_terraformer_killrate") or 15

-------------------------------------------------------------
-- PROTECTOR
-- Bot dies instantly if neighbor is a protector

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"selfrep_doomsday:selfrep_doomsday_protector"},
	interval = 1,
	chance = 1,
	catch_up = true,
	action = function(pos)
				
		-- kill
			
			minetest.set_node(pos, {name = "air"})

		--Play sound
					
			minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.8, max_hear_distance = 15,})
					
		
end,
}




-----------------------------------------------------------
--TERRAFORMER RULE SET
------------------------------------------------------------

--SPREAD OVER SAND AND STONE

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)

		local growthlimit = 10
		local radius = 2
		local dispersal = 1

	--count terra

		local num_terra = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_terraformer"})
		num_terra = (cn["selfrep_doomsday:selfrep_doomsday_terraformer"] or 0)


	


	--Positions

		randpos = {x = pos.x + math.random(-dispersal,dispersal), y = pos.y + math.random(-dispersal,dispersal), z = pos.z + math.random(-dispersal,dispersal)}

randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

		-- for check light level at destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos)) or 0)


		
-- do if well lit

	if  light_level_ranpos >=12 then




--name for new node

		local newplacebelow = minetest.get_node(randpos_below)

		
	--Do if under poplim

		if num_terra < growthlimit then


	--Do if above stone or sand

		if minetest.get_item_group(newplacebelow.name, "stone") == 1 or minetest.get_item_group(newplacebelow.name, "sand") == 1 then


	--Do if space is empty
	if minetest.get_node(randpos).name == "air" then


	--Create Terra
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_terraformer"})
			
	--Play sound
					
							minetest.sound_play("selfrep_doomsday_wah", {pos = pos, gain = 0.6, max_hear_distance = 30,})
	
	end
	end
	end	
	end
end,
}



-- TERRA DEATH TO DIRT

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	interval = killrate,
	chance = 5,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}

		---get time
		local tod = minetest.get_timeofday()

			if tod > 0.3
			and tod < 0.7 then
	 
							
		-- make terra a dirt
			
		minetest.set_node(pos, {name = "default:dirt"})

	end					
end,
}




-- PLANT GRASS


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	interval = 3,
	chance = 6,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:grass_1"})
		
		end
		end
		end
			
end,
}


-- PLANT APPLE TREE NEAR GRASS


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:grass"},
	interval = 10,
	chance = 31,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:sapling"})
		
		end
		end
		end
			
end,
}


-- PLANT JUNGLE GRASS NEAR WATER


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:water"},
	interval = 3,
	chance = 6,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:junglegrass"})
		
		end
		end
		end
			
end,
}


-- PLANT JUNGLE TREE NEAR junglegrass


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = "default:junglegrass",
	interval = 10,
	chance = 5,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:junglesapling"})
		
		end
		end
		end
			
end,
}




-- PLANT rose FLOWERS NEAR GRASS


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:grass"},
	interval = 6,
	chance = 10,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "flowers:rose"})
		
		end
		end
		end
			
end,
}


-- PLANT PINES NEAR STONE


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:stone"},
	interval = 20,
	chance = 40,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:pine_sapling"})
		
		end
		end
		end
			
end,
}



-- PLANT ASPEN NEAR STONE AND WET


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:stone", "group:puts_out_fire"},
	interval = 20,
	chance = 40,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:aspen_sapling"})
		
		end
		end
		end
			
end,
}



-- PLANT ACACIA NEAR SAND


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:sand"},
	interval = 20,
	chance = 40,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:acacia_sapling"})
		
		end
		end
		end
			
end,
}


-- PLANT PAPYRUS NEAR WATER


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:water"},
	interval = 8,
	chance = 12,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "default:papyrus"})
		
		end
		end
		end
			
end,
}


-- CREATE WATER


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:grass", "group:water"},
	interval = 10,
	chance = 60,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=10 then


	
--- if finds solid in below planting position and air above

		if minetest.get_node(pos_plant_below).name ~= "air" and minetest.get_node(pos_plant_above).name == "air" then


-- if empty space above and dirt or  flowing to replace

		if minetest.get_node(pos_plant).name == "default:dirt" or minetest.get_node(pos_plant).name == "default:river_water_flowing" then

-- create water

			minetest.set_node(pos_plant, {name = "default:river_water_source"})
		
		end
		end
		end
			
end,
}



-- CREATE CONCENTRATIONS OF WATER


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:water"},
	interval = 10,
	chance = 15,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 1
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=10 then


	
--- if finds solid in below planting position air above

		if minetest.get_node(pos_plant_below).name ~= "air" and minetest.get_node(pos_plant_above).name == "air" then


-- if empty space above and dirt or flow to replace

		if minetest.get_node(pos_plant).name == "default:dirt" or minetest.get_node(pos_plant).name == "default:river_water_flowing"  then

-- create water

			minetest.set_node(pos_plant, {name = "default:river_water_source"})
		
		end
		end
		end
			
end,
}




-- PLANT mushroom_brown NEAR WATER


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:water"},
	interval = 8,
	chance = 12,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "flowers:mushroom_brown"})
		
		end
		end
		end
			
end,
}


-- PLANT geranium NEAR WATER


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:water"},
	interval = 8,
	chance = 12,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "flowers:geranium"})
		
		end
		end
		end
			
end,
}


-- PLANT dandelion_white FLOWERS NEAR dirt with GRASS


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = "default:dirt_with_grass",
	interval = 6,
	chance = 10,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "flowers:dandelion_white"})
		
		end
		end
		end
			
end,
}


-- PLANT dandelion_yellow FLOWERS NEAR stone


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:stone"},
	interval = 6,
	chance = 10,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "flowers:dandelion_yellow"})
		
		end
		end
		end
			
end,
}


-- PLANT viola FLOWERS NEAR sand


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:sand"},
	interval = 6,
	chance = 10,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "flowers:viola"})
		
		end
		end
		end
			
end,
}

-- PLANT tulip FLOWERS NEAR sapling


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_terraformer"},
	neighbors = {"group:sapling"},
	interval = 6,
	chance = 10,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of planting
	local radius = 2
		


-- find where it will plant

		local pos_plant = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_plant_below = {x = pos_plant.x, y = pos_plant.y - 1, z = pos_plant.z}
 
		local pos_plant_above = {x = pos_plant.x, y = pos_plant.y + 1, z = pos_plant.z}



-- for check light level at destination
	 
		local light_level_pos_plant_above  = {}
		local light_level_pos_plant_above   = ((minetest.get_node_light(pos_plant_above)) or 0)


-- conditions
	
-- do if well lit

	if  light_level_pos_plant_above  >=14 then


	
--- if finds dirt in below planting position

		if minetest.get_node(pos_plant_below).name == "default:dirt" then


-- if empty space

		if minetest.get_node(pos_plant).name == "air"  and minetest.get_node(pos_plant_above).name == "air" then

-- plant grass

			minetest.place_node(pos_plant, {name = "flowers:tulip"})
		
		end
		end
		end
			
end,
}


