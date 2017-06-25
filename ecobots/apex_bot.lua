


----------------------------------------------------------------
--APEX PREDATOR BOT
----------------------------------------------------------------
--SETTINGS
-- similar growth rate to herbivore

local animal_growth = minetest.settings:get('animal_growth')

local growth = animal_growth + 2

local animal_move = 1

--die of old age
local animal_old = animal_growth * 700


--Maintenance eating needs to be ten times more common than eating for growth to reflect how little energy goes up the food web
---chance to eat
local animal_eat = 5
local eat_breed = animal_eat * 10

----------------------------------------------------------------
-- APEX BOT EAT HERBI

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = animal_eat,
	action = function(pos)

-- find what the will eat

		local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


	--Is it a herbivore?
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_predator_bot" or minetest.get_node(pos_eat).name == "ecobots:ecobots_predator_bot_flashing" then


	-- eat						
			minetest.dig_node(pos_eat)

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})

	
	end
end,
}


----------------------------------------------------------------
-- APEX BOT EAT DETRITI

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = animal_eat,
	action = function(pos)

-- find what will eat 
		local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--Is it a detritivore?
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_detritivore_bot" then

		-- eat...					
			minetest.dig_node(pos_eat)

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})


	
	end
end,
}




----------------------------------------------------------------
-- APEX BOT EAT EUSOCIAL


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = animal_eat,
	action = function(pos)


-- find what will eat 
		local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


	--Is it a eusocial bug?
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_eusocial_bot_returning" or minetest.get_node(pos_eat).name == "ecobots:ecobots_eusocial_bot_searching" then


		-- eat the prey ...					
			minetest.dig_node(pos_eat)

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})		

		
	end
end,
}





----------------------------------------------------------------
-- REPLICATE APEX BOT HERBI

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = eat_breed,
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



----CONDITIONAL REPLICATION
		
-- create if under pop limit
	if (num_apex_bot) < apex_poplim then


	--Is it a herbivore?
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_predator_bot" or minetest.get_node(pos_eat).name == "ecobots:ecobots_predator_bot_flashing" then


	-- Replace the prey with a child...						
			minetest.set_node(pos_eat, {name = "ecobots:ecobots_apex_bot"})

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})

	
	end
	end
end,
}


----------------------------------------------------------------
-- REPLICATE APEX BOT DETRITI

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = eat_breed,
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



----CONDITIONAL REPLICATION
		
-- create if under pop limit
	if (num_apex_bot) < apex_poplim then



--Is it a detritivore?
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_detritivore_bot" then

		-- Replace the prey with a child...					
			minetest.set_node(pos_eat, {name = "ecobots:ecobots_apex_bot"})

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})


	
	end
	end
end,
}




----------------------------------------------------------------
-- REPLICATE APEX BOT EUSOCIAL


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = growth,
	chance = eat_breed,
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



----CONDITIONAL REPLICATION
		
-- create if under pop limit
	if (num_apex_bot) < apex_poplim then


	--Is it a eusocial bug?
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_eusocial_bot_returning" or minetest.get_node(pos_eat).name == "ecobots:ecobots_eusocial_bot_searching" then


		-- Replace the prey with a child...					
			minetest.set_node(pos_eat, {name = "ecobots:ecobots_apex_bot"})

		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})		

		
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

	

		-- do if no food


	if (num_prey1) + (num_prey2) + (num_prey3) + (num_prey4) < 1  then

		-- kill bot
 			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- DROWN BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = 1,
	chance = 1,
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
	chance = 20,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
end,
}




------------------------------------------------------------------RANDOM SEARCHING
--keep walking until find food



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = animal_move,
	chance = 3,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		
		

-- get a grounded random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos_below = {x = randpos.x, y = randpos.y -1, z = randpos.z}


-- for check one side to see if it has prey	

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y, z = randpos.z + math.random(-1,1)}

	
-- do if current location has no prey available	
	--no herbivores

	if minetest.get_node(randpos_ranside).name ~= "ecobots:ecobots_predator_bot" or minetest.get_node(randpos_ranside).name ~= "ecobots:ecobots_predator_bot_flashing" then

	--no detritivores
	if minetest.get_node(randpos_ranside).name ~= "ecobots:ecobots_detritivore_bot" then

	--no eusocial

	if minetest.get_node(randpos_ranside).name ~= "ecobots:ecobots_eusocial_bot_returning" or minetest.get_node(randpos_ranside).name ~= "ecobots:ecobots_eusocial_bot_searching" then



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






