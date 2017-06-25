


----------------------------------------------------------------
---DETRITIVORE BOT
----------------------------------------------------------------

--SETTINGS
-- similar growth rate to herbivore

local animal_growth = minetest.settings:get('animal_growth')

local growth = animal_growth + 2

local animal_move = 5

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
	action = function(pos)
	
	
-- find what will eat

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}



		-- if has food
		
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_decomposer_bot" then


-- eat

			minetest.dig_node(pos_eat)

	
		--sound
			minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 0.5, max_hear_distance = 20,})
		
	end
end,
}




----------------------------------------------------------------
--REPLICATE DETRITIVORE BOT
-- force to replicate near trees to limit growth, and balance out grassy tendency of the herbivore

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	neighbors = {"group:tree"},
	interval = growth,
	chance = eat_breed,
	action = function(pos)
	
	---SETTINGS
	--dispersal radius up and horizontal
		local upradius_detrit = 1
		local horizradius_detrit = 3

		
	-- population limit within area	
		local detrit_poplim = 6
		local detrit_poprad = 2

	---POP LIMITS
	--count detritivore bots

		local num_detrit_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - detrit_poprad, y = pos.y - detrit_poprad, z = pos.z - detrit_poprad},
			{x = pos.x + detrit_poprad, y = pos.y + detrit_poprad, z = pos.z + detrit_poprad}, {"ecobots:ecobots_predator_bot"})
		num_detrit_bot = (cn["ecobots:ecobots_detritivore_bot"] or 0)
		
		
---POSITIONS
	
-- find what the parent will eat inorder to reproduce

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}



---CONDITIONAL REPLICATION	

		
	-- create if under pop limit
	if (num_detrit_bot) < detrit_poplim then


	--- if selected nearby node is edible
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_decomposer_bot" then


		-- if has food
		
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_decomposer_bot" then


-- replace food with child

			minetest.set_node(pos_eat, {name = "ecobots:ecobots_detritivore_bot"})

	
		--sound
			minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 0.5, max_hear_distance = 20,})
		
	end	
	end
	end
end,
}


----------------------------------------------------------------
--  STARVATION KILL DETRITIVORE bot 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = 30,
	chance = 5,
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
-- DROWN BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
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
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
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
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = animal_move,
	chance = 2,
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


--- move

		minetest.set_node(randpos, {name = "ecobots:ecobots_detritivore_bot"})
		minetest.set_node(pos, {name = "air"})
			
--sound
		minetest.sound_play("ecobots_clicky", {pos = pos, gain = 1, max_hear_distance = 30,})

		end
		end
end,
}





