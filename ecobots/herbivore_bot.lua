

----------------------------------------------------------------
--HERBIVORE BOT  aka 1st Predator bot... it's a predator if you're a plant!
--

---------------------------------------------------------------
--SETTINGS
-- fastest growing of the animals. Other animals will be based on this.

local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5


local animal_move = 4

--die of old age
local animal_old = animal_growth * 170

--Maintenance eating needs to be ten times more common than eating for growth to reflect how little energy goes up the food web
---chance to eat
local animal_eat = 2
local eat_breed = animal_eat * 10


---------------------------------------------------------------
-- HERBIVORE BOT EATS
--wider range than for breeding

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = animal_growth,
	chance = animal_eat,
	catch_up = false,
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
 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	--neighbors = {"group:soil", "group:grass", "group:flower"},
	interval = animal_growth,
	chance = eat_breed,
	catch_up = false,
	action = function(pos)

	-----SETTINGS
	--dispersal radius up and horizontal
		local upradius_pr = 1
		local horizradius_pr = 1

		
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

		

--name for new node for group check

	local newplace_create = minetest.get_node(randpos)

-- for check randpos is supported

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}




----CONDITIONAL REPLICATION		
	
-- create if under pop limit
	if (num_pred_bot) < pred_poplim then



-- if new location has food and is supported				
	if minetest.get_item_group(newplace_create.name, "flora") == 1 and minetest.get_node(randpos_below).name ~= "air" then



-- create child in food item 

			minetest.set_node(randpos, {name = "ecobots:ecobots_predator_bot"})



--herbivore cry sound
			minetest.sound_play("ecobots_chirp", {pos = pos, gain = 0.5, max_hear_distance = 40,})
		
		
		end
		end	
end,
}


----------------------------------------------------------------
-- STARVATION KILL HERBIVORE BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 90,
	chance = 35,
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
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = animal_old,
	chance = 30,
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
	catch_up = false,
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
	catch_up = false,
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
			
	
--using random timer to decide when to flash
--simply using the abm interval auto-synchs them, defeating the purpose
		local timer = 0
		minetest.register_globalstep(function(dtime)
		timer = timer + dtime;
		local randflash = math.random(2,10)
		local randflash_limit = randflash + 1
			if timer > randflash and timer < randflash_limit  then

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
		local poplim = 5
			
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
	


--count flashing bots there for pop limits at destination

		local num_friend_there= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = randpos.x - radius, y = randpos.y - radius, z = randpos.z - radius},
			{x = randpos.x + radius, y = randpos.y + radius, z = randpos.z + radius}, {"ecobots:ecobots_predator_bot_flashing"})
		num_friend_there = (cn["ecobots:ecobots_predator_bot_flashing"] or 0)


-- for check light at current position
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light at destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos)) or 0)



--- do at night

		local tod = minetest.get_timeofday()

		if tod < 0.25 or tod > 0.75 then
		

--go to the light
	if light_level_ranpos > light_level then


--if the destination isn't overcrowded... should prevent insane pile ups

	if (num_bot_there) + (num_friend_there) < poplim then
		
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



---------------------------------------------------------------
--HERD DEFENCE
-- Attack apex bot if it is too close
-- a group herd defence, to give it some refuge against predation

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
	

	
--distance away for engaging in battle
		local battle_upradius = 1
		local battle_horizradius = 1


	
--count predator

		local num_apex = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - battle_horizradius, y = pos.y - battle_upradius, z = pos.z - battle_horizradius},
			{x = pos.x + battle_horizradius, y = pos.y + battle_upradius, z = pos.z + battle_horizradius}, {"ecobots:ecobots_apex_bot"})
		num_apex = (cn["ecobots:ecobots_apex_bot"] or 0)


--count friends

		local num_defender = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - battle_horizradius, y = pos.y - battle_upradius, z = pos.z - battle_horizradius},
			{x = pos.x + battle_horizradius, y = pos.y + battle_upradius, z = pos.z + battle_horizradius}, {"ecobots:ecobots_predator_bot"})
		num_defender = (cn["ecobots:ecobots_predator_bot"] or 0)

	
----POSITIONS

--Find a predator
	local randpos = {x = pos.x + math.random(-battle_horizradius,battle_horizradius), y = pos.y + math.random(-battle_upradius,battle_upradius), z = pos.z + math.random(-battle_horizradius,battle_horizradius)}

--retreat
	local randpos2 = {x = pos.x + math.random(-battle_horizradius,battle_horizradius), y = pos.y + math.random(-battle_upradius,battle_upradius), z = pos.z + math.random(-battle_horizradius,battle_horizradius)}


	local randpos2_below = {x = randpos2.x, y = randpos2.y - 1, z = randpos2.z}



-- Do if it found a predator and has back up

	if minetest.get_node(randpos).name == "ecobots:ecobots_apex_bot" and (num_defender) > 2 then

	
--Who will win the battle?
--defenders outnmber apex Defender wins 

if (num_apex) < (num_defender) then

	--repel apex 
	--is an escape possible?

	if minetest.get_node(randpos2).name == "air" and minetest.get_node(randpos2_below).name ~= "air" then

	--apex runs away
	minetest.set_node(randpos, {name = "air"})
	minetest.set_node(randpos2, {name = "ecobots:ecobots_apex_bot"})

	-- Sing!	
		minetest.sound_play("ecobots_friendly_chirp", {pos = pos, gain = 4, max_hear_distance = 40,})
	-- whimper!	
		minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 0.3, max_hear_distance = 40,})


--apex outnmber defenders Apex wins
if (num_apex) > (num_defender) then

	--escape to empty grounded space
	if minetest.get_node(randpos2).name == "air" and minetest.get_node(randpos2_below).name ~= "air" then

 	--defender runaway
	minetest.set_node(randpos2, {name = "ecobots:ecobots_predator_bot"})
	minetest.set_node(pos, {name = "air"})

	-- whimper!	
		minetest.sound_play("ecobots_friendly_chirp", {pos = pos, gain = 0.3, max_hear_distance = 40,})
	-- Sing!	
		minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 5, max_hear_distance = 40,})

	
	end
	end
	end
	end
	end	
end,
}


