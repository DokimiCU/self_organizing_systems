

----------------------------------------------------------------
--HERBIVORE BOT  aka 1st Predator bot... it's a predator if you're a plant!
--

---------------------------------------------------------------
--SETTINGS
-- fastest growing of the animals. Other animals will be based on this.

local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5


local animal_move = 7

--die of old age
local animal_old = animal_growth * 100

--Maintenance eating needs to be ten times more common than eating for growth to reflect how little energy goes up the food web
---chance to eat
local animal_eat = 5
local eat_breed = animal_eat * 10


---------------------------------------------------------------
-- HERBIVORE BOT EATS
--wider range than for breeding

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = animal_growth,
	chance = animal_eat,
	action = function(pos)
	

-- find what will eat 

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

		

--name for eaten node for group check

	local newplace_eat = minetest.get_node(pos_eat)

	
--- if  finds food in nearby node
		if minetest.get_item_group(newplace_eat.name, "flora") == 1 then


-- eat food item 
		
			minetest.dig_node(pos_eat)


--herbivore cry sound
			minetest.sound_play("ecobots_chirp", {pos = pos, gain = 0.5, max_hear_distance = 40,})
		

		end	
end,
}




---------------------------------------------------------------
--REPLICATE HERBIVORE BOT
--force it to go to the ground to reproduce to limit pops 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	neighbors = {"group:soil", "group:grass", "group:flower"},
	interval = animal_growth,
	chance = eat_breed,
	action = function(pos)
	-----SETTINGS
	--dispersal radius up and horizontal
		local upradius_pr = 2
		local horizradius_pr = 2

		
	-- population limit within area	
		local pred_poplim = 5
		local pred_poprad = 2


-----POP LIMITS
--count pred bots for pop limits

		local num_pred_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - pred_poprad, y = pos.y - pred_poprad, z = pos.z - pred_poprad},
			{x = pos.x + pred_poprad, y = pos.y + pred_poprad, z = pos.z + pred_poprad}, {"ecobots:ecobots_predator_bot"})
		num_pred_bot = (cn["ecobots:ecobots_predator_bot"] or 0)
		
		

----POSITIONS
-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_pr,horizradius_pr), y = pos.y + math.random(-upradius_pr,upradius_pr), z = pos.z + math.random(-horizradius_pr,horizradius_pr)}

--for check space is empty

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


-- find what the parent will eat inorder to reproduce

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

		

--name for new node for group check

	local newplace_create = minetest.get_node(randpos)

--name for eaten node for group check

	local newplace_eat = minetest.get_node(pos_eat)



----CONDITIONAL REPLICATION		
	
-- create if under pop limit
	if (num_pred_bot) < pred_poplim then


	
--- if parent finds food in nearby node
		if minetest.get_item_group(newplace_eat.name, "flora") == 1 then


-- if new location has food child				
		if minetest.get_item_group(newplace_create.name, "flora") == 1 then

-- if has space on top of food	
		if minetest.get_node(randpos_above).name == "air" then

-- create child on top of food item to 

			minetest.set_node(randpos_above, {name = "ecobots:ecobots_predator_bot"})


--parent eats food
		
			minetest.dig_node(pos_eat)


--herbivore cry sound
			minetest.sound_play("ecobots_chirp", {pos = pos, gain = 0.5, max_hear_distance = 40,})
		
		end
		end	
		end
		end	
end,
}


----------------------------------------------------------------
-- STARVATION KILL HERBIVORE BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 60,
	chance = 30,
	catch_up = false,
	action = function(pos)
 		--distance to prey to sustain
		local hungerradius = 1


	-- find what will eat 
		local pos_eat = {x = pos.x + math.random(-hungerradius,hungerradius), y = pos.y + math.random(-hungerradius,hungerradius), z = pos.z + math.random(-hungerradius,hungerradius)}


--name for new node for group check

	local newplace = minetest.get_node(pos_eat)

		

		-- do if doesn't find food

	if minetest.get_item_group(newplace.name, "flora") == 0 then

		-- kill bot 			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}



----------------------------------------------------------------
-- DROWN BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 1,
	chance = 2,
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
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = animal_old,
	chance = 10,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
end,
}





------------------------------------------------------------------MIGRATION SPREAD
--day time movement... goes until is on top of food
-- only if on the ground


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	neighbors = {"group:soil", "group:sand", "group:stone"},
	interval = 2,
	chance = 1,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		

-- get random position of a node to move to
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos
	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

--to check if they already have food
	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}

--name for new node for food checks
	
	local place = minetest.get_node(pos_below)


--- do at day... dissappates the night's gathering to randomly explore the space

	local tod = minetest.get_timeofday()

	if tod > 0.25 or tod < 0.75 then

--do if has no food under it
	if minetest.get_item_group(place.name, "flora") == 0 then


-- do if space is empty and grounded
				
	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then


-- to prevent stacking
if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_searching" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_returning" then

if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_apex_bot" then


--create bot and remove original

		minetest.set_node(randpos, {name = "ecobots:ecobots_predator_bot"})
		minetest.set_node(pos, {name = "air"})
	
			
--sound
		minetest.sound_play("ecobots_doublechirp", {pos = pos, gain = 0.5, max_hear_distance = 20,})
		
		end
		end
		end
		end
		end
end,
}


----------------------------------------------------------------
-- AMBIENCE... WITH FRIENDS
-- sing if in a group at night

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 4,
	chance = 5,
	action = function(pos)
	
	-- to chirp if within radius and more than tolerance
		local radius = 1
		local tolerance = 2

	--count

		local num_friend= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"ecobots:ecobots_predator_bot"})
		num_friend = (cn["ecobots:ecobots_predator_bot"] or 0)
		
	
	--- do at night

		local tod = minetest.get_timeofday()

		if tod < 0.25 or tod > 0.75 then

		if (num_friend) > tolerance then
		
		-- Sing!
			
			minetest.sound_play("ecobots_friendly_chirp", {pos = pos, gain = 0.5, max_hear_distance = 40,})	
		end				
		end
	
end,
}


----------------------------------------------------------------
-- TURN FLASH ON RANDOM
-- force to do near flora i.e. has food

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	neighbors = {"group:flora"},
	interval = 5,
	chance = 5,
	catch_up = false,
	action = function(pos)
			
	
	
--use random timer to decide when to flash
--simply using the abm interval auto-synchs them, defeating the purpose
		local timer = 0
		minetest.register_globalstep(function(dtime)
		timer = timer + dtime;
		local randflash = math.random(2,10)
		local randflash_limit = randflash + 1
			if if timer > randflash and timer < randflash_limit then

			--- do at night
			local tod = minetest.get_timeofday()
			if tod < 0.25 or tod > 0.75 then

			minetest.set_node(pos, {name = "ecobots:ecobots_predator_bot_flashing"})
			timer = randflash_limit
			end
			end
		end)	
					
end,
}

----------------------------------------------------------------
-- TURN FLASH OFF

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot_flashing"},
	interval = 5,
	chance = 1.2,
	catch_up = false,
	action = function(pos)
				
				
		minetest.set_node(pos, {name = "ecobots:ecobots_predator_bot"})		
	
	end,
}


----------------------------------------------------------------
-- TURN ON WITH NEIGHBOURS
-- only join in if has food

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	neighbors = {"group:flora"},
	interval = 3,
	chance = 1.5,
	catch_up = false,
	action = function(pos)
	
	-- to flash if within radius and more than tolerance
		local radius = 1
		local tolerance = 2

	--count

		local num_friend= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"ecobots:ecobots_predator_bot_flashing"})
		num_friend = (cn["ecobots:ecobots_predator_bot_flashing"] or 0)
		
	
	--- do at night

		local tod = minetest.get_timeofday()

		if tod < 0.25 or tod > 0.75 then

		if (num_friend) > tolerance then
		
		-- Sing!
			
			minetest.set_node(pos, {name = "ecobots:ecobots_predator_bot_flashing"})	
		end				
		end
	
end,
}

----------------------------------------------------------------
-- SMALL WORLD LONG DISTANCE LINK
-- only link if has food

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	neighbors = {"group:flora"},
	interval = 3,
	chance = 1.5,
	catch_up = false,
	action = function(pos)
							
	--radius
		local upradius = 5
		local downradius = 2
		local horizradius = 10
		

-- get a random position

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	--name for new random below for group check

	local newplace = minetest.get_node(randpos)

-- don't do if the other bug is on leaves
-- mainly in the hopes of improving performance in forest
-- simulates obscured sight lines, will inhibit synch

	if minetest.get_item_group(newplace.name, "leaves") == 0 then


-- if it "sees" someone on then turn on

	if minetest.get_node(randpos).name == "ecobots:ecobots_predator_bot_flashing" then

		minetest.set_node(pos, {name = "ecobots:ecobots_predator_bot_flashing"})		
	
	end
	end
end,
}


----------------------------------------------------------------
-- SOME PURPOSE TO ALL THIS FLASHING... swarming into a herd
-- the group best able to synchronise will attract most new members. It will gather them to the largest most well connected populations... possibly the ones with the best food.
-- in combo with day time exploring this will allow the swarm to intelligently find the best food, communicate it's position and gather there.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 20,
	chance = 15,
	catch_up = false,
	action = function(pos)


	-- population limit within area	
		local poplim = 3
			
	-- radius for population group
		local radius = 1
		
	-- distance to travel
		local upradius = 2
		local downradius = 2
		local horizradius = 3

--Positions
		local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

		local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

---Counts
	--count non flashing pred bots for pop limits at destination

		local num_bot_there = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"ecobots:ecobots_predator_bot"})
		num_bot_there = (cn["ecobots:ecobots_predator_bot"] or 0)
	
	--count flashing bots here

		local num_friend= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"ecobots:ecobots_predator_bot_flashing"})
		num_friend = (cn["ecobots:ecobots_predator_bot_flashing"] or 0)


--count flashing bots there

		local num_friend_there= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = randpos.x - radius, y = randpos.y - radius, z = randpos.z - radius},
			{x = randpos.x + radius, y = randpos.y + radius, z = randpos.z + radius}, {"ecobots:ecobots_predator_bot_flashing"})
		num_friend_there = (cn["ecobots:ecobots_predator_bot_flashing"] or 0)


--- do at night

		local tod = minetest.get_timeofday()

		if tod < 0.25 or tod > 0.75 then
		

--go to the brightest group
	if (num_friend_there) > (num_friend) then


--if the destination isn't overcrowded... should prevent insane pile ups

	if (num_bot_there) + (num_friend_there) > poplim then
		
--is the space empty and grounded?

	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then

--below is not a bot

	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot_flashing" then
		

--move to the new group
			minetest.set_node(randpos, {name = "ecobots:ecobots_predator_bot"})
			minetest.set_node(pos, {name = "air"})

--sound
		minetest.sound_play("ecobots_doublechirp", {pos = pos, gain = 0.8, max_hear_distance = 30,})
		end
		end
		end				
		end
		end
end,
}



