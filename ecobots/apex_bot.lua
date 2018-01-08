


----------------------------------------------------------------
--APEX PREDATOR BOT
----------------------------------------------------------------
--SETTINGS
-- similar growth rate to herbivore

local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5

local growth = animal_growth + 3

local animal_move = 1

--die of old age
local animal_old = animal_growth * 700


--Maintenance eating needs to be ten times more common than eating for growth to reflect how little energy goes up the food web
---chance to eat
local animal_eat = 1
local eat_breed = animal_eat * 10

----------------------------------------------------------------
-- APEX BOT EAT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = animal_eat,
	catch_up = false,
	action = function(pos)

-- find what will eat

		local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--name for fleshy check

	local place_eat = minetest.get_node(pos_eat)


	--Is it a fleshy or full trap?

	if minetest.get_item_group(place_eat.name, "fleshy") >= 1 or minetest.get_node(pos_eat).name == "ecobots:ecobots_apex_trap_full" then


	-- don't do cannabilism guys!

	if minetest.get_node(pos_eat).name ~= "ecobots:ecobots_apex_bot" then
		

	-- eat						
			minetest.dig_node(pos_eat)

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})

	end
	end
end,
}




----------------------------------------------------------------
-- REPLICATE APEX BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = eat_breed,
	catch_up = false,
	action = function(pos)
----SETTINGS
		
	-- population limit within area	
		local apex_poplim = 6
		local apex_poprad = 2

		

----POP LIMITS
	--count apex bots

		local num_apex_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_poprad, y = pos.y - apex_poprad, z = pos.z - apex_poprad},
			{x = pos.x + apex_poprad, y = pos.y + apex_poprad, z = pos.z + apex_poprad}, {"ecobots:ecobots_predator_bot"})
		num_apex_bot = (cn["ecobots:ecobots_apex_bot"] or 0)
		
		
----POSITIONS

-- find what the parent will eat inorder to reproduce

		local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--name for fleshy check

	local place_eat = minetest.get_node(pos_eat)


----CONDITIONAL REPLICATION
		
-- create if under pop limit
	if (num_apex_bot) < apex_poplim then


	--Is it a fleshy or full trap?

	if minetest.get_item_group(place_eat.name, "fleshy") >= 1 or minetest.get_node(pos_eat).name == "ecobots:ecobots_apex_trap_full" then


-- don't do cannabilism guys!

	if minetest.get_node(pos_eat).name ~= "ecobots:ecobots_apex_bot" then


	-- Replace the prey with a child...						
			minetest.set_node(pos_eat, {name = "ecobots:ecobots_apex_bot"})

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})

	end
	end
	end
end,
}




----------------------------------------------------------------
-- STARVE KILL APEX BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = 90,
	chance = 100,
	catch_up = false,
	action = function(pos)

 		--distance to prey to sustain
		local apex_hungerradius = 1


	--count prey
		
		-- herbivores

		local num_prey1 = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_predator_bot"})
		num_prey1 = (cn["ecobots:ecobots_predator_bot"] or 0)


		--detritivores

		local num_prey2 = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_detritivore_bot"})
		num_prey2 = (cn["ecobots:ecobots_detritivore_bot"] or 0)


		--eusocial return

		local num_prey3 = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_eusocial_bot_returning"})
		num_prey3 = (cn["ecobots:ecobots_eusocial_bot_returning"] or 0)


		--eusocial search

		local num_prey4 = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_eusocial_bot_searching"})
		num_prey4 = (cn["ecobots:ecobots_eusocial_bot_searching"] or 0)

	--swarmer

		local num_prey5 = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_swarmer_bot"})
		num_prey5 = (cn["ecobots:ecobots_swarmer_bot"] or 0)

	--full trap

		local num_prey6 = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_apex_trap_full"})
		num_prey6 = (cn["ecobots:ecobots_apex_trap_full"] or 0)
	

		-- do if no food


	if (num_prey1) + (num_prey2) + (num_prey3) + (num_prey4) + (num_prey5) + (num_prey6) < 1  then

		-- kill bot
 			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- DROWN BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = 2,
	chance = 2,
	catch_up = false,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local tolerance = 1

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
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- LIFESPAN
-- because no one lives forever

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = animal_old,
	chance = 40,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
end,
}




------------------------------------------------------------------DAYTIME RANDOM SEARCHING
--keep walking until find food


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = animal_move,
	chance = 2,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		

-- get a grounded random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local randpos_below = {x = randpos.x, y = randpos.y -1, z = randpos.z}


-- for check current side to see if it has prey	

	local pos_ranside = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--name for fleshy check

	local place_prey = minetest.get_node(pos_ranside)




---get time
		local tod = minetest.get_timeofday()


--do during the day

	if tod > 0.3 and tod < 0.7 then



	
-- do if current location has no prey available	
--Is nothing a fleshy?

	if minetest.get_item_group(place_prey.name, "fleshy") == 0 then


--no traps nearby?

	if minetest.get_node(pos_ranside).name ~= "ecobots:ecobots_apex_trap" and minetest.get_node(pos_ranside).name ~= "ecobots:ecobots_apex_trap_full" then


-- new location is empty and grounded

	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then


-- to prevent stacking
	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_searching" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_returning" then

	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_queen" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_apex_bot" then

	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_detritivore_bot" then




--- move

		minetest.set_node(randpos, {name = "ecobots:ecobots_apex_bot"})
		minetest.set_node(pos, {name = "air"})
			
--sound
		minetest.sound_play("ecobots_flutter", {pos = pos, gain = 1.2, max_hear_distance = 40,})

		end
		end
		end
		end
		end
		end
		end
end,
}




------------------------------------------------------------------NIGHT TIME GO TO THE LIGHT RANDOM SEARCHING
--keep walking towards the light until find food
-- aim is to follow flashing herb bots and to go to traps


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = animal_move,
	chance = 2,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		

-- get a grounded random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local randpos_below = {x = randpos.x, y = randpos.y -1, z = randpos.z}


-- for check current side to see if it has prey	

	local pos_ranside = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--name for fleshy check

	local place_prey = minetest.get_node(pos_ranside)


-- for check light at current position
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light at destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos)) or 0)



---get time
	local tod = minetest.get_timeofday()


--do during the night

	if tod < 0.3 or tod > 0.7 then


--go to the light
	if light_level_ranpos >= light_level then

	
-- do if current location has no prey available	
--Is nothing a fleshy?

	if minetest.get_item_group(place_prey.name, "fleshy") == 0 then


--no traps nearby?

	if minetest.get_node(pos_ranside).name ~= "ecobots:ecobots_apex_trap" and minetest.get_node(pos_ranside).name ~= "ecobots:ecobots_apex_trap_full" then


-- new location is empty and grounded

	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then


-- to prevent stacking
	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_searching" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_returning" then

	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_queen" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_apex_bot" then

	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_detritivore_bot" then




--- move

		minetest.set_node(randpos, {name = "ecobots:ecobots_apex_bot"})
		minetest.set_node(pos, {name = "air"})
			
--sound
		minetest.sound_play("ecobots_flutter", {pos = pos, gain = 1.2, max_hear_distance = 40,})


		end
		end
		end
		end
		end
		end
		end
		end
end,
}



------------------------------------------------------------------PURSUIT
--go to locations adjacent to prey


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = animal_move,
	chance = 2,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		

-- get a grounded random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local randpos_below = {x = randpos.x, y = randpos.y -1, z = randpos.z}


-- for check new postion side to see if it has prey	

	local randpos_side = {x = randpos.x + math.random(-1,1), y = randpos.y + math.random(-1,1), z = randpos.z + math.random(-1,1)}


--name for fleshy check

	local place_prey = minetest.get_node(randpos_side)




--Is it a fleshy or a full trap to the new location?

	if minetest.get_item_group(place_prey.name, "fleshy") == 1 or minetest.get_node(randpos_side).name == "ecobots:ecobots_apex_trap_full" then

-- don't do cannabilism guys!

	if minetest.get_node(randpos_side).name ~= "ecobots:ecobots_apex_bot" then


-- is the new location empty and grounded?

	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then



--- move

		minetest.set_node(randpos, {name = "ecobots:ecobots_apex_bot"})
		minetest.set_node(pos, {name = "air"})
			
--sound
		minetest.sound_play("ecobots_flutter", {pos = pos, gain = 1.2, max_hear_distance = 40,})

		end
		end
		end
end,
}








------------------------------------------------------------------TRAPS

----------------------------------------------------------------
-- TRAP CATCH BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_trap"},
	interval = 2,
	chance = 3,
	catch_up = false,
	action = function(pos)

-- find what will eat

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

	

--name for fleshy check

	local place_eat = minetest.get_node(pos_eat)


	--Is it a fleshy and not an apex bot?

	if minetest.get_item_group(place_eat.name, "fleshy") >= 1 and minetest.get_node(pos_eat).name ~= "ecobots:ecobots_apex_bot" then


		

	-- trap it 
			
		minetest.set_node(pos, {name = "ecobots:ecobots_apex_trap_full"})
			
		minetest.set_node(pos_eat, {name = "air"})

		
	
	end
end,
}


----------------------------------------------------------------
-- APEX BOT SET TRAP

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = animal_eat + 5,
	catch_up = false,
	action = function(pos)

-- for find a spot above with a solid side

	local pos_place = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


	local pos_place_side = {x = pos_place.x + math.random(-1,1), y = pos_place.y, z = pos_place.z + math.random(-1,1)}


--name for fleshy check

	local place_side = minetest.get_node(pos_place_side)


	--Is the space empty?

	if minetest.get_node(pos_place).name == "air" then


	--Is the side solid and not a passing fleshy?

	if minetest.get_node(pos_place_side).name ~= "air" and minetest.get_item_group(place_side.name, "fleshy") == 0 then



	-- set the trap
						
		minetest.set_node(pos_place, {name = "ecobots:ecobots_apex_trap"})


		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 1, max_hear_distance = 50,})

	end
	end
end,
}



----------------------------------------------------------------
-- DEGRADE OLD TRAPS 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_trap", "ecobots:ecobots_apex_trap_full"},
	interval = 60,
	chance = 10,
	catch_up = false,
	action = function(pos)
	

	-- bye bye
			
		minetest.set_node(pos, {name = "air"})
			
end,
}




