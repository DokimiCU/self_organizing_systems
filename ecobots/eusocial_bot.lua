

----------------------------------------------------------------
--EUSOCIAL BOT
-- Based on the way ant colonies behave to give rise to swarm intelligence.
-- bots lay down trails which other bots then are more likely to follow.
-- searching bots randomly search for food, which a mix between following trails and random movement.
-- returning bots (which have eaten food) return via trails, with very little random movement
-- trails degrade over time so only used trails get maintained.
-- unfed nests slowly starve so the colony risks dying.
-- fed nests have a chance of producing a new bot then switching to an unfed state.
-- returning bots will either feed unfed nests or if none are available expand the nest.
-- to stop them becoming a super intelligent nightmare pest they are limited to eating the pioneer grass and setting trails on dry grass.

---------------------------------------------------------------
--SETTINGS

local animal_growth = minetest.settings:get('animal_growth')

--MOVING

--how fast bots move around on trails and elsewhere
local animal_move_trail = 1
local animal_move = animal_move_trail * 4

--trail formation chance
local trail_chance = 5

-- how fast a trail will degrade
local trail_degrade = 20

--GROWTH

-- Nest Metabolism. So that growth and survival are a trade off. Low is fast. More bots will be born but it will starve quicker.
local metabolism = 25

--how fast nests produce new bots
local bot_birth = (animal_growth * (metabolism/100)*3) + 1

--how fast nests will use it's food to expand
local nest_expand = (animal_growth * ((metabolism/100)*10)) + 1

--how fast nests produce queens
local nest_queen = (animal_growth * ((metabolism/100)*60)) + 1

--how fast nests uses up it's food on maintenance
local nest_deplete = (animal_growth * ((metabolism/100)*20)) + 1


--how fast nests and bots starve to death
--bot starvation may have a big impact on the nest's sphere of influence
local nest_starve = (animal_growth * ((metabolism/100)*50)) + 1
local bot_starve = (animal_growth * ((metabolism/100)*90)) + 1


--BUILDING
--how quickly searchers build tunnels and walls etc
local build_rate = 1
local build_chance = 1.5
local build_internal = build_chance * 2
local open_tunnel_build_chance = build_chance * 3


------------------------------------------------------------------SEARCHER MOVE TO TRAIL
--movement of bots in search of food via trails


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = animal_move_trail,
	chance = 5,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		
		

-- get random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}



-- do if empty space

if minetest.get_node(randpos).name == "air" then


-- go to trails

if minetest.get_node(randpos_below).name == "ecobots:ecobots_eusocial_trail" then

	-- create at new place and remove original
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_bot_searching"})
	minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.3, max_hear_distance = 3,})


	end
	end
end,
}


------------------------------------------------------------------SEARCHER MOVE TO ANYWHERE
--movement of bots in search of food via random moving


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = animal_move,
	chance = 1,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		
		

-- get random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}



-- do if empty space

if minetest.get_node(randpos).name == "air" then

-- to prevent stacking
if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_searching" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_returning" then

if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_queen" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_apex_bot" then

if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_detritivore_bot" then


-- go to solid

if minetest.get_node(randpos_below).name ~= "air" then

	-- create at new place and remove original
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_bot_searching"})
	minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.3, max_hear_distance = 3,})
	end
	end
	end
	end
	end
end,
}




------------------------------------------------------------------RETURNING MOVE TO TRAIL OR NEST
--movement of bots in returning with food via trails


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = animal_move_trail,
	chance = 1,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		
		

-- get random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}


-- do if empty space

if minetest.get_node(randpos).name == "air" then

-- go to trails or unfed

if minetest.get_node(randpos_below).name == "ecobots:ecobots_eusocial_trail" or minetest.get_node(randpos_below).name == "ecobots:ecobots_eusocial_nest_unfed" then

	-- create at new place and remove original
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_bot_returning"})
	minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack2", {pos = pos, gain = 0.3, max_hear_distance = 3,})

	end
	end
end,
}





------------------------------------------------------------------RETURNING MOVE TO ANYWHERE
--movement of bots in returning with food via random moving, in case they can't find a trail



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = animal_move,
	chance = 6,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		
		

-- get random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}


-- do if empty space

if minetest.get_node(randpos).name == "air" then

-- to prevent stacking
if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_searching" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_returning" then

if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_queen" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_apex_bot" then

if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_predator_bot" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_detritivore_bot" then

-- go to solid

if minetest.get_node(randpos_below).name ~= "air" then

	-- create at new place and remove original
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_bot_returning"})
	minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack2", {pos = pos, gain = 0.3, max_hear_distance = 3,})
	end
	end
	end
	end
	end
end,
}



---------------------------------------------------------------
--EAT GRASS AND SWITCH
--collects food from grass

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = 1,
	chance = 2,
	action = function(pos)
	

	--distance from food item
		local upradius = 1
		local horizradius = 1
		

----POSITIONS
	---look for food
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	
--- do if bot finds grass in nearby node

	if minetest.get_node(randpos).name == "ecobots:ecobots_pioneer_bot" then



--eat grass and change

		minetest.dig_node(randpos)
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_bot_returning"})
		-- Sing!		
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})

	end	
end,
}

---------------------------------------------------------------
--EAT STORE AND SWITCH
--collects food from stores
--must be low chance or gets caught in a loop or eating and placing

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = 3,
	chance = 15,
	action = function(pos)
	
	--distance from food item
		local upradius = 1
		local horizradius = 1

----POSITIONS
	---look for food
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

		
--- do if bot finds a store in nearby node

	if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_storage" then


--remove eaten food from store and change behaviour
		minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_nest_empty_storage"})
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_bot_returning"})
		
		-- Sing!
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})


	end	
end,
}



---------------------------------------------------------------
--FEEDING HUNGRY NEST
--highest priority

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = 1,
	chance = 1,
	action = function(pos)
	

	--distance from nest
		local upradius = 1
		local horizradius = 1

	
	--look for an unfed nest 

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	
--- do if bot finds hungry nest in nearby node

	if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_unfed" then

--remove eaten food and change behaviour

		minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_nest_fed"})
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_bot_searching"})
-- Sing!		
	minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})

	end	
end,
}

---------------------------------------------------------------
--FEEDING STORE
--nest highest priority

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = 2,
	chance = 2,
	action = function(pos)
	

	--distance from store
		local upradius = 1
		local horizradius = 1


----POSITIONS
	--look for an empty store

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


--was it a store?	
	if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_empty_storage" then


--- fill up the stores 
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_nest_storage"})

--change behaviour
	minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_bot_searching"})

-- Sing!		
	minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})

	end	
end,
}



---------------------------------------------------------------
-- USE COLLECTED FOOD TO EXPAND NEST
--lowest priority for incoming food

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = 6,
	chance = 6,
	action = function(pos)
	

	--distance from nest
		local upradius = 1
		local horizradius = 1

	--distance for a new nest
		local upradius_new = 1
		local horizradius_new = 1

		
	-- population limit for nests within area	
		local poplim = 11
		local poprad = 2


	--count fed nests for pop limits

		local num_nests_fed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_eusocial_nest_fed"})
		num_nests_fed = (cn["ecobots:ecobots_eusocial_nest_fed"] or 0)

	--count unfed nests for pop limits

		local num_nests_unfed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_eusocial_nest_unfed"})
		num_nests_unfed = (cn["ecobots:ecobots_eusocial_nest_unfed"] or 0)


----POSITIONS
	--look for a fed nest

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	--potential site for a new nest

	local randpos_newnest = {x = pos.x + math.random(-horizradius_new,horizradius_new), y = pos.y + math.random(-upradius_new,upradius_new), z = pos.z + math.random(-horizradius_new,horizradius_new)}

	local randpos_newnest_side = {x = randpos_newnest.x + math.random(-horizradius_new,horizradius_new), y = randpos_newnest.y + math.random(-upradius_new,upradius_new), z = randpos_newnest.z + math.random(-horizradius_new,horizradius_new)}

	--name for soil check
	local newplace = minetest.get_node(randpos_newnest)


--was it a fed nest?

	if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_fed" then

--do if below pop limits
 
	if (num_nests_fed) + (num_nests_unfed) < poplim then

-- do if it is the space is empty or soil

	if minetest.get_node(randpos_newnest).name == "air" or minetest.get_item_group(newplace.name, "soil") == 1 then

--do if attached to another nest

	if minetest.get_node(randpos_newnest_side).name == "ecobots:ecobots_eusocial_nest_fed" then


--build new nest and change behaviour
--new nest is unfed as food is used up in making it
		minetest.set_node(randpos_newnest, {name = "ecobots:ecobots_eusocial_nest_unfed"})
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_bot_searching"})
-- Sing!	
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})

	end
	end
	end
	end	
end,
}




---------------------------------------------------------------
--NEST MAKE NEW BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_fed"},
	interval = bot_birth,
	chance = 30,
	catch_up = false,
	action = function(pos)
	

	--distance away for spawned bot
		local upradius = 1
		local horizradius = 1

	
----POSITIONS

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	
--- do if empty space and grounded

	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then


--spawn bot and run out of food
		minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_bot_searching"})
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_unfed"})
-- Sing!
			
			minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})	

	end	
end,
}




----------------------------------------------------------------
-- STORE DECAY
--must be rare of nest structure will become unworkable

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_storage"},
	interval = nest_starve,
	chance = 5000,
	catch_up = false,
	action = function(pos)
 		
		-- rot nest 			
			minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_empty_storage"})end,
}


----------------------------------------------------------------
-- EMPTY STORE DECAY
--must be rare of nest structure will become unworkable

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_empty_storage"},
	interval = nest_starve,
	chance = 5000,
	catch_up = false,
	action = function(pos)
 		
		-- rot nest 			
			minetest.set_node(pos, {name = "default:dirt"})end,
}


----------------------------------------------------------------
-- NEST STARVE 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_unfed"},
	interval = nest_starve,
	chance = 150,
	catch_up = false,
	action = function(pos)
 		
		-- kill nest 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})end,
}


----------------------------------------------------------------
-- NEST RUN OUT OF FOOD
-- so that food must go towards maintenance 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_fed"},
	interval = nest_deplete,
	chance = 2,
	catch_up = false,
	action = function(pos)
 		
		-- no food in nest 			
			minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_fed"})
end,
}



----------------------------------------------------------------
-- SEARCHER LIFESPAN
-- to prevent them running around forever even if their nest dies

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = bot_starve,
	chance = 8,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.5, max_hear_distance = 15,})
end,
}


----------------------------------------------------------------
-- RETURNER LIFESPAN
-- to prevent them running around forever even if their nest dies

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = bot_starve,
	chance = 15,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.5, max_hear_distance = 15,})
end,
}


----------------------------------------------------------------
-- QUEEN LIFESPAN
-- to prevent them running around forever even if they can't find a good site

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_queen"},
	interval = bot_starve,
	chance = 100,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.5, max_hear_distance = 15,})
end,
}



----------------------------------------------------------------
-- DROWN SEARCHER

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
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
-- DROWN RETURNING

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
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
-- DROWN QUEEN

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_queen"},
	interval = 1,
	chance = 4,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local tolerance = 2

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
-- TRAIL DEGRADE
-- to prevent them running around forever even if their nest dies

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_trail"},
	interval = trail_degrade,
	chance = 20,
	catch_up = false,
	action = function(pos)
 		
		-- kill trail 			
			minetest.set_node(pos, {name = "default:dirt_with_dry_grass"})
end,
}




----------------------------------------------------------------
-- SEARCHER CREATE TRAIL
-- to prevent them running around forever even if their nest dies

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = 2,
	chance = trail_chance,
	catch_up = false,
	action = function(pos)

	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}

	if minetest.get_node(pos_below).name == "default:dirt_with_dry_grass" or minetest.get_node(pos_below).name == "default:dirt" then

 		
		-- make trail			
			minetest.set_node(pos_below, {name = "ecobots:ecobots_eusocial_trail"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.5, max_hear_distance = 15,})
	end
end,
}


----------------------------------------------------------------
-- RETURNING CREATE TRAIL
-- reinforce trails
-- allow to move to any soil type so the nest doesn't get overgrown

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = 1,
	chance = trail_chance,
	catch_up = false,
	action = function(pos)

	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
	
	local newplace = minetest.get_node(pos_below)

	--do if soil
	if minetest.get_item_group(newplace.name, "soil") == 1 then

	--don't do if will destroy nest
	if minetest.get_node(pos_below).name ~= "ecobots:ecobots_eusocial_nest_fed" and minetest.get_node(pos_below).name ~= "ecobots:ecobots_eusocial_nest_unfed" then
 		
		-- make trail			
			minetest.set_node(pos_below, {name = "ecobots:ecobots_eusocial_trail"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.5, max_hear_distance = 15,})
	end
	end
end,
}




---------------------------------------------------------------
--NEST CREATE QUEEN
-- The queen will go and set up new nests

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_fed"},
	interval = nest_queen,
	chance = 200,
	catch_up = false,
	action = function(pos)
	

	--distance away for spawned bot
		local upradius = 1
		local horizradius = 1


-- minimum number of fed nests needed in an area	

		local poprad = 3
		local nestmin = 2


	--count fed nests for pop limits

		local num_nests_fed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_eusocial_nest_fed"})
		num_nests_fed = (cn["ecobots:ecobots_eusocial_nest_fed"] or 0)



	
----POSITIONS

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	
--do if above size minimum for the nest
 
	if (num_nests_fed) > nestmin then

--- do if empty space and grounded

	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_below).name ~= "air" then


--spawn bot and run out of food
		minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_bot_queen"})
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_unfed"})
-- Sing!
			
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 5, max_hear_distance = 50,})	
	
	end
	end	
end,
}




------------------------------------------------------------------QUEEN'S SEARCH FOR A NEW HOME... MOVEMENT



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_queen"},
	interval = animal_move,
	chance = 2,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		
		

-- get random position to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}



-- do if empty space

if minetest.get_node(randpos).name == "air" then


-- go to solid

if minetest.get_node(randpos_below).name ~= "air" then

-- to prevent stacking
if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_searching" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_returning" then

if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_eusocial_bot_queen" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_apex_bot" then


	-- create at new place and remove original
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_bot_queen"})
	minetest.set_node(pos, {name = "air"})
-- Sing!
			
			minetest.sound_play("ecobots_clack", {pos = pos, gain = 0.8, max_hear_distance = 15,})
	end
	end
	end
	end
end,
}


---------------------------------------------------------------
--QUEEN FINDS WANT SHE WANTS... a new nest is born
-- she wants... lots of food... room for expansion i.e. dirt with dry grass

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_queen"},
	interval = 1,
	chance = 5,
	action = function(pos)
	

	-- build nest distance
		local upradius = 0
		local horizradius = 1

		
	-- search area for resources
		local poprad = 4

	-- search area for other nests
		local poprad_nest = 10

 	-- resource minimums	
		local foodmin = 12
		local dirtmin = 15


	--count food

		local num_food = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_pioneer_bot"})
		num_food = (cn["ecobots:ecobots_pioneer_bot"] or 0)

--count dirt

		local num_dirt = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"default:dirt_with_dry_grass"})
		num_dirt = (cn["default:dirt_with_dry_grass"] or 0)


--count fed nests for pop limits

		local num_nests_fed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad_nest, y = pos.y - poprad_nest, z = pos.z - poprad_nest},
			{x = pos.x + poprad_nest, y = pos.y + poprad_nest, z = pos.z + poprad_nest}, {"ecobots:ecobots_eusocial_nest_fed"})
		num_nests_fed = (cn["ecobots:ecobots_eusocial_nest_fed"] or 0)

--count unfed nests for pop limits

		local num_nests_unfed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad_nest, y = pos.y - poprad_nest, z = pos.z - poprad_nest},
			{x = pos.x + poprad_nest, y = pos.y + poprad_nest, z = pos.z + poprad_nest}, {"ecobots:ecobots_eusocial_nest_unfed"})
		num_nests_unfed = (cn["ecobots:ecobots_eusocial_nest_unfed"] or 0)



----POSITIONS


	local randpos_newnest = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}



-- do if isn't already occupied

	if (num_nests_fed) + (num_nests_unfed) < 1 then

-- do if it has the goods

	if (num_food) > foodmin and (num_dirt) > dirtmin then

-- do if the new site is dirt

	if minetest.get_node(randpos_newnest).name == "default:dirt_with_dry_grass" then


--the queen becomes a nest
		minetest.set_node(randpos_newnest, {name = "ecobots:ecobots_eusocial_nest_fed"})
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_bot_searching"})
-- Sing!
			
			minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})

	end
	end
	end
end,
}






----------------------------------------------------------------
-- AMBIENCE... WITH FRIENDS

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to chirp if within radius and more than tolerance
		local radius = 1
		local tolerance = 2

	--count

		local num_friend= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"ecobots:ecobots_eusocial_bot_searching", "ecobots:ecobots_eusocial_bot_returning"})
		num_friend = (cn[{"ecobots:ecobots_eusocial_bot_searching", "ecobots:ecobots_eusocial_bot_returning"}] or 0)
		
	
		if (num_friend) > tolerance then
		
		-- Sing!
			
			minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})	
						
		end
	
end,
}




---------------------------------------------------------------
--NEST INTERNAL EXPANSION
-- Splits and builds upwards giving two hungry nests

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_fed"},
	interval = nest_expand,
	chance = 5,
	catch_up = false,
	action = function(pos)
	

	--distance away for spawned nest
		local upradius = 1
		local horizradius = 1


-- minimum number of fed nests needed in an area	

		local poprad = 2
		local nestmin = 2

--max nest size in pop radius
	local nestmax = 4


	--count fed nests for pop limits

		local num_nests_fed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_eusocial_nest_fed"})
		num_nests_fed = (cn["ecobots:ecobots_eusocial_nest_fed"] or 0)

--count unfed nests for pop limits

		local num_nests_unfed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_eusocial_nest_unfed"})
		num_nests_unfed = (cn["ecobots:ecobots_eusocial_nest_unfed"] or 0)

	
----POSITIONS

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_side  = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y, z = pos.z + math.random(-horizradius,horizradius)}
	
--do if above size minimum for the nest but below max
 
	if (num_nests_fed) > nestmin and (num_nests_fed) + (num_nests_unfed) < nestmax  then

--- do if empty space and grounded

	if minetest.get_node(randpos).name == "air" then

---do if above a current nest or dirt

	if minetest.get_node(randpos_below).name == "ecobots:ecobots_eusocial_nest_fed" or minetest.get_node(randpos_side).name == "ecobots:ecobots_eusocial_nest_fed" then


--spawn nest and run out of food
		minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_nest_unfed"})
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_unfed"})
-- Sing!
			
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})	
	
	end
	end
	end	
end,
}

---------------------------------------------------------------
--NEST DEFENCE
-- Attack apex bot if it is too close to the nest

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
	

	--distance away from nest 
		local upradius = 2
		local horizradius = 4

--distance away for engaging in battle
		local battle_upradius = 1
		local battle_horizradius = 1




	--count fed nests

		local num_nests_fed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - horizradius, y = pos.y - upradius, z = pos.z - horizradius},
			{x = pos.x + horizradius, y = pos.y + upradius, z = pos.z + horizradius}, {"ecobots:ecobots_eusocial_nest_fed"})
		num_nests_fed = (cn["ecobots:ecobots_eusocial_nest_fed"] or 0)

--count unfed nests

		local num_nests_unfed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - horizradius, y = pos.y - upradius, z = pos.z - horizradius},
			{x = pos.x + horizradius, y = pos.y + upradius, z = pos.z + horizradius}, {"ecobots:ecobots_eusocial_nest_unfed"})
		num_nests_unfed = (cn["ecobots:ecobots_eusocial_nest_unfed"] or 0)


--count predator

		local num_apex = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - battle_horizradius, y = pos.y - battle_upradius, z = pos.z - battle_horizradius},
			{x = pos.x + battle_horizradius, y = pos.y + battle_upradius, z = pos.z + battle_horizradius}, {"ecobots:ecobots_apex_bot"})
		num_apex = (cn["ecobots:ecobots_apex_bot"] or 0)


--count searching bots

		local num_defender = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - battle_horizradius, y = pos.y - battle_upradius, z = pos.z - battle_horizradius},
			{x = pos.x + battle_horizradius, y = pos.y + battle_upradius, z = pos.z + battle_horizradius}, {"ecobots:ecobots_eusocial_bot_searching"})
		num_defender = (cn["ecobots:ecobots_eusocial_bot_searching"] or 0)

	
----POSITIONS

--Find a predator
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

--retreat
	local randpos2 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local randpos2_below = {x = randpos2.x, y = randpos2.y - 1, z = randpos2.z}


--Do if near a nest
if (num_nests_fed) + (num_nests_unfed) > 1 then


-- Do if it found a predator and has back up

if minetest.get_node(randpos).name == "ecobots:ecobots_apex_bot" and (num_defender) > 2 then
	
--Who will win the battle?
--defenders outnmber apex 
if (num_apex) < (num_defender) then

	--kill apex 
	minetest.set_node(randpos, {name = "air"})
	-- Sing!	
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 4, max_hear_distance = 40,})
	-- whimper!	
		minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 0.3, max_hear_distance = 40,})


--apex outnmber defenders 
if (num_apex) > (num_defender) then

	--escape to empty trail grounded space
	if minetest.get_node(randpos2).name == "air" and minetest.get_node(randpos2_below).name == "ecobots:ecobots_eusocial_trail" then

 	--eusocial runaway
	minetest.set_node(randpos2, {name = "ecobots:ecobots_eusocial_bot_searching"})
	minetest.set_node(pos, {name = "air"})

	-- whimper!	
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 0.3, max_hear_distance = 40,})
	-- Sing!	
		minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 5, max_hear_distance = 40,})

	
	end
	end
	end
	end
	end	
end,
}


---------------------------------------------------------------
--NEST DEFENCE AGAINST PLAYER
-- Attack player if it is too close to the nest

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = 2,
	chance = 2,
	catch_up = false,
	action = function(pos)

--distance away from nest to start defending 
		local upradius = 3
		local horizradius = 4


--count fed nests

		local num_nests_fed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - horizradius, y = pos.y - upradius, z = pos.z - horizradius},
			{x = pos.x + horizradius, y = pos.y + upradius, z = pos.z + horizradius}, {"ecobots:ecobots_eusocial_nest_fed"})
		num_nests_fed = (cn["ecobots:ecobots_eusocial_nest_fed"] or 0)

--count unfed nests

		local num_nests_unfed = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - horizradius, y = pos.y - upradius, z = pos.z - horizradius},
			{x = pos.x + horizradius, y = pos.y + upradius, z = pos.z + horizradius}, {"ecobots:ecobots_eusocial_nest_unfed"})
		num_nests_unfed = (cn["ecobots:ecobots_eusocial_nest_unfed"] or 0)



--Do if near a nest
if (num_nests_fed) + (num_nests_unfed) > 1 then


---attack player

local objs = minetest.env:get_objects_inside_radius(pos, 1.6)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
			local health = player:get_hp()
      		player:set_hp(health-0.5)
			
		--Sing
		minetest.sound_play("ecobots_battle_clack", {pos = pos, gain = 7, max_hear_distance = 20,})
	
			end
	end

	end	
end,
}




---------------------------------------------------------------
--BUILD WALLS
-- Builds dirt walls near nest

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = build_rate,
	chance = build_chance,
	catch_up = false,
	action = function(pos)
	

	--distance away from nest 
		local upradius = 3
		local horizradius = 4

	
----POSITIONS

--Find a nest
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}



--Do if found a nest
if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_unfed" or minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_fed" then  


-- Do if on top of dirt or trail if

if minetest.get_node(pos_below).name == "default:dirt" or minetest.get_node(pos_below).name == "ecobots:ecobots_eusocial_trail" then


--do if new will have space above

if minetest.get_node(pos_above).name == "air" then
	
--Build up and sit on top

	minetest.set_node(pos, {name = "default:dirt"})
	minetest.set_node(pos_above, {name = "ecobots:ecobots_eusocial_bot_searching"})

	-- Sing!	
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.8, max_hear_distance = 30,})
	
	end
	end
	end	
end,
}


---------------------------------------------------------------
--DIG HOLES
-- Builds holes near nest

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = build_rate,
	chance = build_chance,
	catch_up = false,
	action = function(pos)
	

	--distance away from nest 
		local upradius = 1
		local horizradius = 1

	
----POSITIONS

--Find a nest
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local pos_belowthat = {x = pos.x, y = pos.y - 2, z = pos.z}
	
	local newplace = minetest.get_node(pos_below)


--Do if found a nest
if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_unfed" or minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_fed" then  


-- Do if soil
if minetest.get_item_group(newplace.name, "soil") == 1 then

--don't do if will destroy nest
	if minetest.get_node(pos_below).name ~= "ecobots:ecobots_eusocial_nest_fed" and minetest.get_node(pos_below).name ~= "ecobots:ecobots_eusocial_nest_unfed" then


--do so long as it wont go straight through to empty space

if minetest.get_node(pos_belowthat).name ~= "air" then
	
--Dig

	minetest.dig_node(pos_below)

	-- Sing!	
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.8, max_hear_distance = 30,})
	end
	end
	end
	end	
end,
}


---------------------------------------------------------------
--DIG TUNNELS
-- Builds tunnels near nest

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = build_rate,
	chance = build_chance,
	catch_up = false,
	action = function(pos)
	

	--distance away from nest 
		local upradius = 1
		local horizradius = 4

	
----POSITIONS

--Find a nest
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

--find somewhere to tunnel
	local randpos_dig = {x = pos.x + math.random(-1,1), y = pos.y + math.random(0,1), z = pos.z + math.random(-1,1)}


	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local randpos_dig_above = {x = randpos_dig.x, y = randpos_dig.y + 1, z = randpos_dig.z}

	--make sure the tunnel always has supporting sides
	local randpos_dig_side = {x = randpos_dig.x + math.random(-1,1), y = randpos_dig.y + math.random(-1,1), z = randpos_dig.z + math.random(-1,1)}


--Do if found a nest
if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_unfed" or minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_fed" then  


--Do if dig site is dirt

if minetest.get_node(randpos_dig).name == "default:dirt" or minetest.get_node(randpos_dig).name == "default:dirt_with_dry_grass" then

--Do if one of the sides is supported...stop hovering nodes 
if minetest.get_node(randpos_dig_side).name ~= "air" then

--Do if dig is underground
if minetest.get_node(randpos_dig_above).name ~= "air" then

--Do if dig site will not leave a nest hanging
if minetest.get_node(randpos_dig_above).name ~= "ecobots:ecobots_eusocial_nest_unfed" and minetest.get_node(randpos_dig_above).name ~= "ecobots:ecobots_eusocial_nest_fed" then

	
--Dig

	minetest.dig_node(randpos_dig)

	-- Sing!	
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.8, max_hear_distance = 30,})
	
	end
	end
	end
	end
	end	
end,
}


---------------------------------------------------------------
--DIG OPEN TUNNELS
-- Builds tunnels near nest that can be open to air
--rarer, allows them to get out

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = build_rate,
	chance = open_tunnel_build_chance,
	catch_up = false,
	action = function(pos)
	

	--distance away from nest 
		local upradius = 1
		local horizradius = 8

	
----POSITIONS

--Find a nest
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

--find somewhere to tunnel
	local randpos_dig = {x = pos.x + math.random(-1,1), y = pos.y + math.random(0,1), z = pos.z + math.random(-1,1)}

--make sure the tunnel always has supporting sides
	local randpos_dig_side = {x = randpos_dig.x + math.random(-1,1), y = randpos_dig.y + math.random(-1,1), z = randpos_dig.z + math.random(-1,1)}


	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
	local randpos_dig_above = {x = randpos_dig.x, y = randpos_dig.y + 1, z = randpos_dig.z}

	

--Do if found a nest
if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_unfed" or minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_fed" then  


--Do if dig site is dirt

if minetest.get_node(randpos_dig).name == "default:dirt" or minetest.get_node(randpos_dig).name == "default:dirt_with_dry_grass" then

--Do if one of the sides is supported...stop hovering nodes 

if minetest.get_node(randpos_dig_side).name ~= "air" then


--Do if dig site will not leave a nest hanging
if minetest.get_node(randpos_dig_above).name ~= "ecobots:ecobots_eusocial_nest_unfed" and minetest.get_node(randpos_dig_above).name ~= "ecobots:ecobots_eusocial_nest_fed" then

	
--Dig

	minetest.dig_node(randpos_dig)

	-- Sing!	
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.8, max_hear_distance = 30,})
	
	end
	end
	end
	end	
end,
}


---------------------------------------------------------------
--BUILD BRIDGE
-- Builds dirt nodes above air near nest

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_searching"},
	interval = build_rate,
	chance = build_chance,
	catch_up = false,
	action = function(pos)
	

	--distance away from nest 
		local upradius = 3
		local horizradius = 4

	
----POSITIONS

--Find a nest
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

--find somewhere to build
	local randpos_build = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}


	local randpos_build_above = {x = randpos_build.x, y = randpos_build.y + 1, z = randpos_build.z}
	local randpos_build_below = {x = randpos_build.x, y = randpos_build.y - 1, z = randpos_build.z}
	

--Do if found a nest
if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_unfed" or minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_fed" then  



--Do if build site is above air or a bot 
if minetest.get_node(randpos_build_below).name == "air" or minetest.get_node(randpos_build_below).name == "ecobots:ecobots_eusocial_bot_searching" then

--will have walking space above

if minetest.get_node(randpos_build_above).name == "air" then

	
--Build

	minetest.set_node(randpos_build, {name = "default:dirt"})

	-- Sing!	
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.8, max_hear_distance = 30,})
	
	end
	end
	end	
end,
}


---------------------------------------------------------------
--NEST BUILD IT'S OWN BRIDGE STORES
-- Builds dirt nodes above air from a nest
-- to stop nests from getting cut off. Done when the nest is up a "cliff" of sorts.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_fed"},
	interval = build_rate,
	chance = build_internal,
	catch_up = false,
	action = function(pos)
	

	--find somewhere to build
	local randpos_build = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}


	local randpos_build_above = {x = randpos_build.x, y = randpos_build.y + 1, z = randpos_build.z}
	local randpos_build_below = {x = randpos_build.x, y = randpos_build.y - 1, z = randpos_build.z}
	local randpos_build_belowthat = {x = randpos_build.x, y = randpos_build.y - 2, z = randpos_build.z}
	



--Do if build site is above air or a bot 
if minetest.get_node(randpos_build_below).name == "air" or minetest.get_node(randpos_build_below).name == "ecobots:ecobots_eusocial_bot_searching" then

--will have walking space above and is above a deeper air gap

if minetest.get_node(randpos_build_above).name == "air" and minetest.get_node(randpos_build_belowthat).name == "air"  then

	
--Build

	minetest.set_node(randpos_build, {name = "ecobots:ecobots_eusocial_nest_empty_storage"})

	-- Sing!	
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.8, max_hear_distance = 30,})
	
	end
	end	
end,
}



---------------------------------------------------------------
--TRANSFER FOOD INTERNALLY
-- Gives fed nests a chance of moving their food into an adjacent unfed nest. Should allow food storage.
-- Cycles stored food increasing chance a returner will encounter a unfed nest
--allows bridge construction by fed nests

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_nest_unfed"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
	

	--distance away from nest 
		local upradius = 1
		local horizradius = 1

	
----POSITIONS

--Find a nest
	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	

--Do if found a fed nest or store
	if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_fed" or minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_storage" then  


--Transfer
--is it a store? 
	if minetest.get_node(randpos).name == "ecobots:ecobots_eusocial_nest_storage" then

-- empty the store
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_nest_empty_storage"})

--fill up the hungry nest
	minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_fed"})

--is it another nest?
else

--empty that nest
	minetest.set_node(randpos, {name = "ecobots:ecobots_eusocial_nest_unfed"})

--fill this nest
	minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_fed"})

	end
	end	
end,
}




---------------------------------------------------------------
--DENSITY DEPENDANT TASK SWITCH BACK TO SEARCH AND MAKE STORE
--to stop them all getting stuck in one behaviour. If too many of the same are around and none are doing the other then replant create an unfed nest as a storage depot i.e. grid lock is a sign to expand.
--allows them to do a bit more exploring, rejoin paths

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_eusocial_bot_returning"},
	interval = 5,
	chance = 5,
	action = function(pos)
	
	--radius for local group
	local horizradius = 1
	local upradius = 1

	--the minimum of those doing the same
	local same_min = 8


	--count same tasked bots

		local num_bots = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - horizradius, y = pos.y - upradius, z = pos.z - horizradius},
			{x = pos.x + horizradius, y = pos.y + upradius, z = pos.z + horizradius}, {"ecobots:ecobots_eusocial_bot_returning"})
		num_bots = (cn["ecobots:ecobots_eusocial_bot_returning"] or 0)


	--count other tasked bots

		local num_other_bots = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - horizradius, y = pos.y - upradius, z = pos.z - horizradius},
			{x = pos.x + horizradius, y = pos.y + upradius, z = pos.z + horizradius}, {"ecobots:ecobots_eusocial_bot_searching"})
		num_other_bots = (cn["ecobots:ecobots_eusocial_bot_searching"] or 0)

--count trails

		local num_trail = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - horizradius, y = pos.y - upradius, z = pos.z - horizradius},
			{x = pos.x + horizradius, y = pos.y + upradius, z = pos.z + horizradius}, {"ecobots:ecobots_eusocial_trail"})
		num_trail = (cn["ecobots:ecobots_eusocial_trail"] or 0)


--positions

	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

	local newplace = minetest.get_node(pos_below)


	
-- do if no one is searching and too many are returning
	if (num_other_bots) == 0 and (num_bots) >= same_min then



		--- do if bot soil below and space above
		if minetest.get_item_group(newplace.name, "soil") == 1  and minetest.get_node(pos_above).name == "air" then
		--create store and jump on top
		minetest.set_node(pos, {name = "ecobots:ecobots_eusocial_nest_storage"})
		minetest.set_node(pos_above, {name = "ecobots:ecobots_eusocial_bot_searching"})
		-- Sing!
		minetest.sound_play("ecobots_friendly_clack", {pos = pos, gain = 0.6, max_hear_distance = 20,})

	
	end
	end	
end,
}




