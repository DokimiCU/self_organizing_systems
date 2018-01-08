

----------------------------------------------------------------
--DECOMPOSER BOT
----------------------------------------------------------------
--SETTINGS
-- similar growth rate to herbivore

local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5

local growth = animal_growth + 2

-- spread by spores ... note not migration like animals
local seed_spread = animal_growth * 2

----------------------------------------------------------------
--- REPLICATE DECOMPOSER BOT
-- SPREADING REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = growth,
	chance = 10,
	catch_up = false,
	action = function(pos)
	

	---SETTINGS
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- population limit within area	
		local poplim = 5
		local poprad = 2


	---POP LIMITS
	--count decomposer bots for pop limits

		local num_decom_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_decomposer_bot"})
		num_decom_bot = (cn["ecobots:ecobots_decomposer_bot"] or 0)
		
		
---LOCATIONS
-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check if food is above and not exposed below

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}

local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	
-- for check if too damp to grow for parent
 
	local pos_side = {x = pos.x + math.random (-1,1), y = pos.y, z = pos.z + math.random (-1,1)}



--name for new node for group check

	local newplace_create = minetest.get_node(randpos_above)




----CONDITIONAL REPLICATION
		
	-- do if under pop limit

	if (num_decom_bot) < poplim then


	

	--do if new location is in a dead bot

	if minetest.get_node(randpos).name == "ecobots:ecobots_bot_dead" then

		
	-- do if parent doesn't get inhibited by water nearby
		
	if minetest.get_node(pos_side).name ~= "default:water_source" and  minetest.get_node(pos_side).name ~= "default:river_water_source" then
		

--- do if child will have food or tree shelter above

	if minetest.get_node(randpos_above).name == "ecobots:ecobots_bot_dead" or minetest.get_item_group(newplace_create.name, "tree") == 1 then



-- do if not suspended so that doesn't float
	if minetest.get_node(randpos_below).name ~= "air" then


---create child below food

			minetest.set_node(randpos, {name = "ecobots:ecobots_decomposer_bot"})

			

			
		--decomposer sludge sound
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.4, max_hear_distance = 6,})

		end	
		end	
		end
		end
		end
end,
}



----------------------------------------------------------------
--- DECOMPOSER EATS WHATS ABOVE IT



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = growth,
	chance = 10,
	catch_up = false,
	action = function(pos)
	

			
		
---LOCATIONS

	

-- find what the parent eat 

	local pos_eat = {x = pos.x, y = pos.y + 1, z = pos.z}


	-- do if has found food 

	if minetest.get_node(pos_eat).name == "ecobots:ecobots_bot_dead" then

	
				
	-- eats food
		
			minetest.dig_node(pos_eat)


			
		--decomposer sludge sound
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.4, max_hear_distance = 6,})

	end

end,
}






---------------------------------------------------------------
-- DECOMPOSER BOT BREAK DOWN LEAVES
-- if in contact with soil


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = growth,
	chance = 5,
	catch_up = false,
	action = function(pos)
	

-- for find what will break down and if it is in contact with dirt

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

	local pos_eat_side = {x = pos_eat.x + math.random (-1,1), y = pos_eat.y + math.random (-1,1), z = pos_eat.z + math.random (-1,1)}

		

--name for node for group checks

	local newplace_eat = minetest.get_node(pos_eat)

	local newplace_eat_side = minetest.get_node(pos_eat_side)

	
--- if  finds leaves in nearby node and leaves are in contact with soil
		if minetest.get_item_group(newplace_eat.name, "leaves") == 1 and minetest.get_item_group(newplace_eat_side.name, "soil") == 1 then


-- mulch the leaves
		
			minetest.set_node(pos_eat, {name = "ecobots:ecobots_bot_dead"})


--decomposer sludge sound
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.4, max_hear_distance = 6,})		

		end	
end,
}


---------------------------------------------------------------
-- DECOMPOSER BOT BREAK DOWN TREES
-- if in contact with soil

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = growth,
	chance = 15,
	catch_up = false,
	action = function(pos)
	

-- for find what will break down and if it is in contact with dirt

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

	local pos_eat_side = {x = pos_eat.x + math.random (-1,1), y = pos_eat.y + math.random (-1,1), z = pos_eat.z + math.random (-1,1)}

		

--name for node for group checks

	local newplace_eat = minetest.get_node(pos_eat)

	local newplace_eat_side = minetest.get_node(pos_eat_side)

	
--- if  finds leaves in nearby node and leaves are in contact with soil
		if minetest.get_item_group(newplace_eat.name, "tree") == 1 and minetest.get_item_group(newplace_eat_side.name, "soil") == 1 then


-- mulch the tree
		
			minetest.set_node(pos_eat, {name = "ecobots:ecobots_bot_dead"})


--decomposer sludge sound
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.4, max_hear_distance = 6,})		

		end	
end,
}






----------------------------------------------------------------
-- STARVE KILL DECOMPOSER BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = 60,
	chance = 60,
	catch_up = false,
	action = function(pos)
 		--distance to food to sustain
		local foodradius = 1


	--count dead bots

		local num_fooda = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - foodradius, y = pos.y - foodradius, z = pos.z - foodradius},
			{x = pos.x + foodradius, y = pos.y + foodradius, z = pos.z + foodradius}, {"ecobots:ecobots_bot_dead"})
		num_fooda = (cn["ecobots:ecobots_bot_dead"] or 0)

	
			

		-- do if enviro unsuitable or over lim

	if  (num_fooda) < 1 then

		-- kill bot leaving behind persistent matter
 			minetest.set_node(pos, {name = "default:dirt"})				
		end
	
end,
}



------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = seed_spread,
	chance = 40,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 20
		local downradius = 30
		local horizradius = 40
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos is below is soil and above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}




-- do if new place is dead bot

	if minetest.get_node(randpos).name == "ecobots:ecobots_bot_dead" then


-- do if for new place below is dead and above is air
				
	if minetest.get_node(randpos_below).name == "ecobots:ecobots_bot_dead" and  minetest.get_node(randpos_above).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_decomposer_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.5, max_hear_distance = 5,})
		
		end
		end
end,
}



----------------------------------------------------------------
--EROSION
----------------------------------------------------------------
-- GET RID OF DEAD BOTS IN WATER
--had to stick this somewhere. Aim is to stop bodies of water filling up so much.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_bot_dead"},
	interval = 5,
	chance = 3,
	catch_up = false,
	action = function(pos)

 		-- to remove if within radius and more than tolerance
		local radius = 1
		local tolerance = 4

	--count

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:water_source"})
		num_bad1 = (cn["default:water_source"] or 0)
		
	--count

		local num_bad2= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:river_water_source"})
		num_bad2 = (cn["river_water_source"] or 0)
		

		if (num_bad1) > tolerance or (num_bad2) > tolerance  then
		
		-- remove bot 
			
			minetest.dig_node(pos)
	
						
		end
	
end,
}

----------------------------------------------------------------
-- GET RID OF DEAD BOTS IN Flowing WATER
--had to stick this somewhere. Aim is to stop bodies of water filling up so much.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_bot_dead"},
	interval = 2,
	chance = 2,
	catch_up = false,
	action = function(pos)

 		-- to remove if within radius and more than tolerance
		local radius = 1
		local tolerance = 2

	--count

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:water_flowing"})
		num_bad1 = (cn["default:water_flowing"] or 0)
		
	--count

		local num_bad2= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:river_water_flowing"})
		num_bad2 = (cn["river_water_flowing"] or 0)
		

		if (num_bad1) > tolerance or (num_bad2) > tolerance  then
		
		-- remove bot 
			
			minetest.dig_node(pos)
	
						
		end
	
end,
}


