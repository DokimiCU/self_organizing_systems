


----------------------------------------------------------------
---DETRITIVORE BOT
----------------------------------------------------------------

--SETTINGS
-- similar growth rate to herbivore

local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5

local growth = animal_growth + 2

local animal_move = 3

--die of old age
local animal_old = animal_growth * 500

--Maintenance eating needs to be ten times more common than eating for growth to reflect how little energy goes up the food web
---chance to eat
local animal_eat = 10
local eat_breed = animal_eat * 10


----------------------------------------------------------------
-- DETRITIVORE BOT EATS
-- less restricted than replication

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = growth,
	chance = animal_eat,
	catch_up = false,
	action = function(pos)
	
	
-- find what will eat

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}



		-- if has food
		
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_decomposer_bot" then


		-- eat

		minetest.dig_node(pos_eat)

	
		--sound
			minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 1, max_hear_distance = 10,})
		
	end
end,
}




----------------------------------------------------------------
--REPLICATE DETRITIVORE BOT
-- 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = growth,
	chance = eat_breed,
	catch_up = false,
	action = function(pos)
	
	---SETTINGS
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- population limit within area	
		local detrit_poplim = 5
		local detrit_poprad = 2

	---POP LIMITS
	--count detritivore bots

		local num_detrit_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - detrit_poprad, y = pos.y - detrit_poprad, z = pos.z - detrit_poprad},
			{x = pos.x + detrit_poprad, y = pos.y + detrit_poprad, z = pos.z + detrit_poprad}, {"ecobots:ecobots_predator_bot"})
		num_detrit_bot = (cn["ecobots:ecobots_detritivore_bot"] or 0)
		
		
---POSITIONS

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


---CONDITIONAL REPLICATION	

		
	-- create if under pop limit

	if (num_detrit_bot) < detrit_poplim then



	-- is the childs place food?
		
	if minetest.get_node(randpos).name == "ecobots:ecobots_decomposer_bot" then



		-- place child in the food

		minetest.set_node(randpos, {name = "ecobots:ecobots_detritivore_bot"})


	
		--sound
		minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 1, max_hear_distance = 10,})

		
	end
	end
end,
}


----------------------------------------------------------------
--  STARVATION KILL DETRITIVORE bot 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = 60,
	chance = 60,
	catch_up = false,
	action = function(pos)

 	--distance to prey to sustain
		local hungerradius_detrit = 1


	--count decomposer prey

		local num_preydec = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_detrit, y = pos.y - hungerradius_detrit, z = pos.z - hungerradius_detrit},
			{x = pos.x + hungerradius_detrit, y = pos.y + hungerradius_detrit, z = pos.z + hungerradius_detrit}, {"ecobots:ecobots_decomposer_bot"})
		num_preydec = (cn["ecobots:ecobots_decomposer_bot"] or 0)
		
	if  (num_preydec) < 1  then

		-- kill bot 			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}


----------------------------------------------------------------
--  STARVATION GO DORMANT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = 60,
	chance = 2,
	catch_up = false,
	action = function(pos)

 	--distance to prey to sustain
		local hungerradius_detrit = 1

	-- for soil check

	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}


	local newplace_below = minetest.get_node(pos_below)


	--count decomposer prey

		local num_preydec = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_detrit, y = pos.y - hungerradius_detrit, z = pos.z - hungerradius_detrit},
			{x = pos.x + hungerradius_detrit, y = pos.y + hungerradius_detrit, z = pos.z + hungerradius_detrit}, {"ecobots:ecobots_decomposer_bot"})
		num_preydec = (cn["ecobots:ecobots_decomposer_bot"] or 0)


	--count dead

		local num_dead = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_detrit, y = pos.y - hungerradius_detrit, z = pos.z - hungerradius_detrit},
			{x = pos.x + hungerradius_detrit, y = pos.y + hungerradius_detrit, z = pos.z + hungerradius_detrit}, {"ecobots:ecobots_bot_dead"})
		num_dead = (cn["ecobots:ecobots_bot_dead"] or 0)



	--do if there is neither any prey or habitat
		
	if (num_preydec) + (num_dead) < 1  then



	--do if above soil

	if minetest.get_item_group(newplace_below.name, "soil") == 1 then


		-- go dormant			
			minetest.set_node(pos_below, {name = "ecobots:ecobots_detritivore_dormant"})

			minetest.set_node(pos, {name = "air"})

		--sound
		minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 1, max_hear_distance = 10,})
	
						
		end
		end
end,
}



----------------------------------------------------------------
--  Break DORMANCY

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_dormant"},
	interval = 60,
	chance = 2,
	catch_up = false,
	action = function(pos)

 	--distance to prey to sustain
		local hungerradius_detrit = 1

	-- for soil check

	local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}


	local newplace_above = minetest.get_node(pos_above)


	--count decomposer prey

		local num_preydec = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_detrit, y = pos.y - hungerradius_detrit, z = pos.z - hungerradius_detrit},
			{x = pos.x + hungerradius_detrit, y = pos.y + hungerradius_detrit, z = pos.z + hungerradius_detrit}, {"ecobots:ecobots_decomposer_bot"})
		num_preydec = (cn["ecobots:ecobots_decomposer_bot"] or 0)


	--count dead

		local num_dead = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_detrit, y = pos.y - hungerradius_detrit, z = pos.z - hungerradius_detrit},
			{x = pos.x + hungerradius_detrit, y = pos.y + hungerradius_detrit, z = pos.z + hungerradius_detrit}, {"ecobots:ecobots_bot_dead"})
		num_dead = (cn["ecobots:ecobots_bot_dead"] or 0)



	--do if there is either prey or habitat
		
	if (num_preydec) + (num_dead) > 2  then



	--do if above is soil or air for it to move into

	if minetest.get_item_group(newplace_above.name, "soil") == 1 or minetest.get_node(pos_above).name == "air" then


		-- emerge			
		minetest.set_node(pos_above, {name = "ecobots:ecobots_detritivore_bot"})
		
		-- kill nest
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})

		--sound
		minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 1, max_hear_distance = 10,})
	
						
		end
		end
end,
}




----------------------------------------------------------------
-- DROWN BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
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
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = animal_old,
	chance = 30,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
end,
}





------------------------------------------------------------------RANDOM SEARCHING
--keep walking until find food



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
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


	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}


-- for check if it has prey below	

	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}

	
-- do if current location has no prey available	
	--no decomposers

	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_decomposer_bot" then


-- new location is empty and grounded

	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then


-- to prevent stacking and climbing eachother into space
	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_detritivore_bot" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot" then


--- move

		minetest.set_node(randpos, {name = "ecobots:ecobots_detritivore_bot"})
		minetest.set_node(pos, {name = "air"})
			
--sound
		minetest.sound_play("ecobots_clicky", {pos = pos, gain = 1, max_hear_distance = 30,})

		end
		end
		end
end,
}



------------------------------------------------------------------DIGGING RANDOM SEARCHING
--keep digging through dead stuff until find food
-- moves stuff around rather than move it self
-- aim is to uncover things



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = animal_move,
	chance = 1,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
			
		

-- get a grounded random dead to dig

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	
-- get a grounded random position to move spoils to

	local randpos1 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local randpos_below1 = {x = randpos1.x, y = randpos1.y - 1, z = randpos1.z}



-- digging location is dead

	if minetest.get_node(randpos).name == "ecobots:ecobots_bot_dead" then


-- spoils location is empty and grounded

	if minetest.get_node(randpos1).name == "air" and minetest.get_node(randpos_below1).name ~= "air" then


--- dig and shift dead matter

		minetest.dig_node(randpos)
		minetest.set_node(randpos1, {name = "ecobots:ecobots_bot_dead"})

			
--sound
		minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 1, max_hear_distance = 10,})
		
		end
		end
end,
}




