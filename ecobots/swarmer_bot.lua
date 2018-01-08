
swarmer = {}

----------------------------------------------------------------
--SWARMER BOT 
-- Swarming, flying, leaf eating animal.
-- dangerous
--lays eggs in wood
-- aim is to demonstrate swarming behaviour (i.e. like fish or starlings), and to get a herbivore that can survive in dense forest (i.e. get to tree tops, survive leaf fall).

---------------------------------------------------------------
--SETTINGS

local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5

local growth = animal_growth + 2

--should be long to get boom and bust swarms
local egg_hatch = growth * 200


--die of old age
local animal_old = animal_growth * 120

--Maintenance eating needs to be ten times more common than eating for growth to reflect how little energy goes up the food web

---chance to eat
local animal_eat = 4

-- finding nest sites is difficult so make common
local eat_breed = 2



---------------------------------------------------------------
-- SWARMER BOT EATS


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = growth,
	chance = animal_eat,
	catch_up = false,
	action = function(pos)
	

-- find what will eat 

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

		

--name for eaten node for group check

	local newplace_eat = minetest.get_node(pos_eat)

	
--- if  finds food in nearby node
		if minetest.get_item_group(newplace_eat.name, "leaves") == 1 then


-- eat food item 
		
			minetest.dig_node(pos_eat)


--swarmer nom nom sound
			minetest.sound_play("ecobots_swarmer_nomnom", {pos = pos, gain = 2, max_hear_distance = 40,})
		

		end	
end,
}




---------------------------------------------------------------
--SWARMER BOT LAY EGGS AT TREE TOPS
 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = growth,
	chance = eat_breed,
	catch_up = false,
	action = function(pos)

	-----SETTINGS
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- egg population limit within area	
		local poplim = 7
		local poprad = 2


-----POP LIMITS
--count pred bots for pop limits

		local num_eggs = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_swarmer_eggs"})
		num_eggs = (cn["ecobots:ecobots_swarmer_eggs"] or 0)
		
		

----POSITIONS
-- get random position for new eggs

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check egg is at top or under an egg

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


--name for new node for group check

	local newplace_create = minetest.get_node(randpos)




----CONDITIONAL REPLICATION		
	
-- create if under pop limit
	if (num_eggs) < poplim then



-- if new location is a tree
				
	if minetest.get_item_group(newplace_create.name, "tree") == 1 then


-- if new location is the top of the tree or under an egg
--stops them cutting trees in half

	if minetest.get_node(randpos_above).name == "air" or minetest.get_node(randpos_above).name == "ecobots:ecobots_swarmer_eggs" then


-- create eggs in tree

		minetest.set_node(randpos, {name = "ecobots:ecobots_swarmer_eggs"})


-- kill parent

		minetest.set_node(pos, {name = "air"})


--swarmer nom nom
		minetest.sound_play("ecobots_swarmer_nomnom", {pos = pos, gain = 5, max_hear_distance = 40,})
		
		end
		end
		end	
end,
}

---------------------------------------------------------------
--SWARMER BOT LAY EGGS AT TREE SIDES ON A SUPPORT
-- mainly here to make up for their inability to find tree tops
 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = growth,
	chance = eat_breed,
	catch_up = false,
	action = function(pos)

	-----SETTINGS
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- egg population limit within area	
		local poplim = 3
		local poprad = 1


-----POP LIMITS
--count pred bots for pop limits

		local num_eggs = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_swarmer_eggs"})
		num_eggs = (cn["ecobots:ecobots_swarmer_eggs"] or 0)
		
		

----POSITIONS
-- get random position for new eggs

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check egg is on the side of a tree and supported

	local randpos_side = {x = randpos.x + math.random(-1,1), y = randpos.y, z = randpos.z + math.random(-1,1)}

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}


--name for new node for group check

	local newplace_create = minetest.get_node(randpos_side)




----CONDITIONAL REPLICATION		
	
-- create if under pop limit
	if (num_eggs) < poplim then



-- if new location at the side of a tree
				
	if minetest.get_item_group(newplace_create.name, "tree") == 1  then


-- do if supported by something other than another bot

	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_swarmer_bot" and minetest.get_node(randpos_below).name ~= "air" then


-- if new location empty

	if minetest.get_node(randpos).name == "air" then


-- create eggs in tree

		minetest.set_node(randpos, {name = "ecobots:ecobots_swarmer_eggs"})


-- kill parent

		minetest.set_node(pos, {name = "air"})


--swarmer nom nom
		minetest.sound_play("ecobots_swarmer_nomnom", {pos = pos, gain = 3, max_hear_distance = 40,})
		
		end
		end
		end
		end	
end,
}


---------------------------------------------------------------
--HATCH EGGS SWARMER BOT
-- a new mini swarm is created
-- must create enough to make up for so many bots that fail to reproduce
--must create a large enough swarm
-- will create at least one bot

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_eggs"},
	--neighbors = {"group:soil", "group:grass", "group:flower"},
	interval = egg_hatch,
	chance = 1,
	catch_up = false,
	action = function(pos)

	-----SETTINGS
	--dispersal radius up and horizontal
		local upradius = 2
		local horizradius = 2

		
	

----POSITIONS
-- get random positions for new bots

	local randpos1 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos2 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos3 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos4 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos5 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos6 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local randpos7 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


		

-- Pos 1
-- if new location is a empty		
	if minetest.get_node(randpos1).name == "air" then


-- create swarm bot
		minetest.set_node(randpos1, {name = "ecobots:ecobots_swarmer_bot"})


-- kill egg
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})



-- Pos 2
-- if new location is a empty		
	if minetest.get_node(randpos2).name == "air" then


-- create swarm bot
		minetest.set_node(randpos2, {name = "ecobots:ecobots_swarmer_bot"})


-- kill egg
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})



-- Pos 3
-- if new location is a empty		
	if minetest.get_node(randpos3).name == "air" then


-- create swarm bot
		minetest.set_node(randpos3, {name = "ecobots:ecobots_swarmer_bot"})


-- kill egg
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})


-- Pos 4
-- if new location is a empty		
	if minetest.get_node(randpos4).name == "air" then


-- create swarm bot
		minetest.set_node(randpos4, {name = "ecobots:ecobots_swarmer_bot"})


-- kill egg
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})


-- Pos 5
-- if new location is a empty		
	if minetest.get_node(randpos5).name == "air" then


-- create swarm bot
		minetest.set_node(randpos5, {name = "ecobots:ecobots_swarmer_bot"})


-- kill egg
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})


-- Pos 6
-- if new location is a empty		
	if minetest.get_node(randpos6).name == "air" then


-- create swarm bot
		minetest.set_node(randpos6, {name = "ecobots:ecobots_swarmer_bot"})


-- kill egg
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})

-- Pos 7
-- if new location is a empty		
	if minetest.get_node(randpos7).name == "air" then


-- create swarm bot
		minetest.set_node(randpos7, {name = "ecobots:ecobots_swarmer_bot"})


-- kill egg
		minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})


		end
		end
		end
		end
		end
		end
		end	
end,
}


----------------------------------------------------------------
-- STARVATION KILL BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 60,
	chance = 40,
	catch_up = false,
	action = function(pos)
 		--distance to prey to sustain
		local hungerradius = 1


	-- find what will eat 
		local pos_eat = {x = pos.x + math.random(-hungerradius,hungerradius), y = pos.y + math.random(-hungerradius,hungerradius), z = pos.z + math.random(-hungerradius,hungerradius)}


--name for new node for group check

	local newplace = minetest.get_node(pos_eat)

		

		-- do if doesn't find food

	if minetest.get_item_group(newplace.name, "leaves") == 0 then

		-- kill bot 			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}



----------------------------------------------------------------
-- DROWN BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 1,
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
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = animal_old,
	chance = 5,
	catch_up = false,
	action = function(pos)
 		
		-- kill bot 			
			minetest.set_node(pos, {name = "air"})
end,
}

----------------------------------------------------------------
-- AMBIENCE... 
-- buzz

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
			
	
		--buzzing sound
		minetest.sound_play("ecobots_swarmer_buzz", {pos = pos, gain = 0.04, max_hear_distance = 10,})	
			
	
	
end,
}


------------------------------------------------------------------ SWARMING
----------------------------------------------------------------


------------------------------------------------------------------SWARMING 1a GOAL SEEK
--seek out food by moving to any adjacent space which is also next to food or tree but only if it can't find adjacent food or tree already



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 2,
	chance = 2,
	catch_up = false,
	action = function(pos)



	
	--dispersal radius

		local upradius = 1
		local downradius = 1
		local horizradius = 1
		

-- get random position of a node to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}



-- for check randpos has food or tree

	local randpos_side = {x = randpos.x + math.random(-1,1), y = randpos.y + math.random(-1,1), z = randpos.z + math.random(-1,1)}


--to check if they already have food or tree

	local pos_side = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--name for node for food group checks

	local newplace_side = minetest.get_node(randpos_side)
	local current_side = minetest.get_node(pos_side)


--pop limits to avoid crowding
-- population limit within area
-- allow high density around food	
		local poplim = 20
			
	-- radius for population group
		local radius = 1

--count swarmers there

		local num_friend_there= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = randpos.x - radius, y = randpos.y - radius, z = randpos.z - radius},
			{x = randpos.x + radius, y = randpos.y + radius, z = randpos.z + radius}, {"ecobots:ecobots_swarmer_bot"})
		num_friend_there = (cn["ecobots:ecobots_swarmer_bot"] or 0)


--do if can't find food or tree already

	if minetest.get_item_group(current_side.name, "leaves") == 0 and minetest.get_item_group(current_side.name, "tree") == 0 then


--do if has new place has food or tree


	if minetest.get_item_group(newplace_side.name, "leaves") == 1 or minetest.get_item_group(newplace_side.name, "tree") == 1 then



--if the destination isn't overcrowded

	if (num_friend_there) < poplim then


-- do if the new position is empty
				
	if minetest.get_node(randpos).name == "air" then





		
--create bot and remove original

		minetest.set_node(randpos, {name = "ecobots:ecobots_swarmer_bot"})

		minetest.set_node(pos, {name = "air"})


--set heading to NA so that it stops as it has found food

		local heading = "NA"
		swarmer.new_heading(randpos, heading)

		
	
		end
		end			
		end
		end
end,
}





----------------------------------------------------------------
--SWARMING 1b RANDOM SEARCH
--seek out food by just moving somewhere... but only if has no food
-- occurs when lost, or in the middle of the swarm

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 15,
	chance = 7,
	catch_up = false,
	action = function(pos)



	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		

-- get random position of a node to move to

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


--to check if they already have food

	local pos_side = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--name for node for food group checks

	local current_side = minetest.get_node(pos_side)

--pop limits to avoid crowding
-- population limit within area
-- seek out low density so it explores	
		local poplim = 8
			
	-- radius for population group
		local radius = 1

--count swarmers there

		local num_friend_there= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = randpos.x - radius, y = randpos.y - radius, z = randpos.z - radius},
			{x = randpos.x + radius, y = randpos.y + radius, z = randpos.z + radius}, {"ecobots:ecobots_swarmer_bot"})
		num_friend_there = (cn["ecobots:ecobots_swarmer_bot"] or 0)

-- for check light at current position
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light at destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos)) or 0)



--do if can't find food already

	if minetest.get_item_group(current_side.name, "leaves") == 0 then


--if the destination isn't overcrowded

	if (num_friend_there) < poplim then


-- fly to the light to escape forest floor and head to tops

	if light_level_ranpos >= light_level then

-- do if the new position is empty
				
	if minetest.get_node(randpos).name == "air" then



--get current heading

		local heading = swarmer.read_heading (pos)

--create bot and remove original

		minetest.set_node(randpos, {name = "ecobots:ecobots_swarmer_bot"})

		minetest.set_node(pos, {name = "air"})


--transfer heading to new location

		swarmer.new_heading(randpos, heading)
	
		end	
		end
		end
		end
end,
}




----------------------------------------------------------------
-- SWARMING 2 FOLLOW THE GROUP
-- follow your neighbours as long as not too crowded
-- no need for a seperate ABM to control crowding, it is included here
 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 3,
	chance = 3,
	catch_up = false,
	action = function(pos)


	-- population limit within area
	-- should control density of main swarm	
		local poplim = 200
			
	-- radius for population group
	--allow bigger area to scan
		local radius = 3
		
	-- distance to travel
		local upradius = 1
		local downradius = 1
		local horizradius = 1


--Positions
		local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


--to check if they already have food

	local pos_side = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}


--name for node for food group checks

	local current_side = minetest.get_node(pos_side)

		
---Counts
		
	--count swarmers here

		local num_friend = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"ecobots:ecobots_swarmer_bot"})
		num_friend = (cn["ecobots:ecobots_swarmer_bot"] or 0)


--count swarmers there

		local num_friend_there= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = randpos.x - radius, y = randpos.y - radius, z = randpos.z - radius},
			{x = randpos.x + radius, y = randpos.y + radius, z = randpos.z + radius}, {"ecobots:ecobots_swarmer_bot"})
		num_friend_there = (cn["ecobots:ecobots_swarmer_bot"] or 0)


--do if can't find food already

	if minetest.get_item_group(current_side.name, "leaves") == 0 then	

--go to the bigger group
	if (num_friend_there) > (num_friend) then


--if the destination isn't overcrowded

	if (num_friend_there) < poplim then

		
--is the space empty 
	if minetest.get_node(randpos).name == "air" then

		

--get current heading

		local heading = swarmer.read_heading (pos)

--create bot and remove original

		minetest.set_node(randpos, {name = "ecobots:ecobots_swarmer_bot"})

		minetest.set_node(pos, {name = "air"})


--transfer heading to new location

		swarmer.new_heading(randpos, heading)

		
		end
		end				
		end
		end
end,
}


----------------------------------------------------------------
-- SWARMING 3 MOVE IN THE DIRECTION OF YOUR HEADING
-- Go somewhere with purpose!

 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 5,
	chance = 3,
	catch_up = false,
	action = function(pos)

		

--Positions
		local pos_xp = {x = pos.x + 1, y = pos.y, z = pos.z}
		local pos_xn = {x = pos.x - 1, y = pos.y, z = pos.z}

		local pos_zp = {x = pos.x, y = pos.y, z = pos.z + 1}
		local pos_zn = {x = pos.x, y = pos.y, z = pos.z - 1}

		local pos_yp = {x = pos.x, y = pos.y + 1, z = pos.z}
		local pos_yn = {x = pos.x, y = pos.y - 1, z = pos.z}

		

--get current heading

		local heading = swarmer.read_heading (pos)


-- Choose an action based on the heading

-- NA means don't move so can skip
	if heading == "NA" then
	end

--XP means x positive

		if heading == "XP" and minetest.get_node(pos_xp).name == "air" then

		--create bot and remove original
		minetest.set_node(pos_xp, {name = "ecobots:ecobots_swarmer_bot"})
		minetest.set_node(pos, {name = "air"})

		--transfer heading to new location
		swarmer.new_heading(pos_xp, heading)

		end

--XN means x negative

		if heading == "XN" and minetest.get_node(pos_xn).name == "air" then

		--create bot and remove original
		minetest.set_node(pos_xn, {name = "ecobots:ecobots_swarmer_bot"})
		minetest.set_node(pos, {name = "air"})

		--transfer heading to new location
		swarmer.new_heading(pos_xn, heading)

		end


--ZP means z positive

		if heading == "ZP" and minetest.get_node(pos_zp).name == "air" then

		--create bot and remove original
		minetest.set_node(pos_zp, {name = "ecobots:ecobots_swarmer_bot"})
		minetest.set_node(pos, {name = "air"})

		--transfer heading to new location
		swarmer.new_heading(pos_zp, heading)

		end


--ZN means z negative

		if heading == "ZN" and minetest.get_node(pos_zn).name == "air" then

		--create bot and remove original
		minetest.set_node(pos_zn, {name = "ecobots:ecobots_swarmer_bot"})
		minetest.set_node(pos, {name = "air"})

		--transfer heading to new location
		swarmer.new_heading(pos_zn, heading)

		end


--YP means y positive

		if heading == "YP" and minetest.get_node(pos_yp).name == "air" then

		--create bot and remove original
		minetest.set_node(pos_yp, {name = "ecobots:ecobots_swarmer_bot"})
		minetest.set_node(pos, {name = "air"})

		--transfer heading to new location
		swarmer.new_heading(pos_yp, heading)

		end


--YN means y negative

		if heading == "YN" and minetest.get_node(pos_yn).name == "air" then

		--create bot and remove original
		minetest.set_node(pos_yn, {name = "ecobots:ecobots_swarmer_bot"})
		minetest.set_node(pos, {name = "air"})

		--transfer heading to new location
		swarmer.new_heading(pos_yn, heading)

		end

		
end,
}



----------------------------------------------------------------
-- COPY A FRIENDS HEADING...NEIGHBOUR
-- should turn them into a network and allow for global coordination

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 2,
	chance = 1,
	catch_up = false,
	action = function(pos)
							
	--radius
		local upradius = 1
		local downradius = 1
		local horizradius = 1
		

-- get a random position

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


	
	
-- do if it "sees" someone

	if minetest.get_node(randpos).name == "ecobots:ecobots_swarmer_bot" then



--check out your friends heading

	local heading = swarmer.read_heading(randpos)
	
	--don't copy nil
	if heading ~= {} then
	
--copy their heading

	swarmer.new_heading(pos, heading)

end				
end
	
end,
}



----------------------------------------------------------------
-- COPY A FRIENDS HEADING...SMALL WORLD 1
-- should turn them into a network and allow for global coordination


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 20,
	chance = 30,
	catch_up = false,
	action = function(pos)
							
	--radius
		local upradius = 10
		local downradius = 10
		local horizradius = 10
		

-- get a random position

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


		
-- do if it "sees" someone

	if minetest.get_node(randpos).name == "ecobots:ecobots_swarmer_bot" then


--check out your friends heading

	local heading = swarmer.read_heading(randpos)

--don't copy nil
	if heading ~= {} then

--copy their heading

	swarmer.new_heading(pos, heading)


	end
	end				
	
end,
}





----------------------------------------------------------------
-- SWARMING  CHOOSE A HEADING
-- randomly change direction
-- this sets a heading even when it is currently nil
 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_swarmer_bot"},
	interval = 20,
	chance = 20,
	catch_up = false,
	action = function(pos)

		

--Positions
		local pos_xp = {x = pos.x + 1, y = pos.y, z = pos.z}
		local pos_xn = {x = pos.x - 1, y = pos.y, z = pos.z}

		local pos_zp = {x = pos.x, y = pos.y, z = pos.z + 1}
		local pos_zn = {x = pos.x, y = pos.y, z = pos.z - 1}

		local pos_yp = {x = pos.x, y = pos.y + 1, z = pos.z}
		local pos_yn = {x = pos.x, y = pos.y - 1, z = pos.z}

		


-- Choose heading based on the something...or chance

local chance = math.random(1,6)

--XP means x positive

		if chance <= 6 then

		--head in that direction
		swarmer.new_heading(pos, "XP")

		end

--XN means x negative

		if chance <= 5 then

		--head in that direction
		swarmer.new_heading(pos, "XN")

		end


--ZP means z positive

		if chance <= 4 then

		--head in that direction
		swarmer.new_heading(pos, "ZP")

		end


--ZN means z negative

		if chance <= 3 then

		--head in that direction
		swarmer.new_heading(pos, "ZN")

		end


--YP means y positive

		if chance <= 2 then

		--head in that direction
		swarmer.new_heading(pos, "YP")

		end


--YN means y negative

		if chance <= 1 then

		--head in that direction
		swarmer.new_heading(pos, "YN")

		end

		
end,
}




------------------------------------------------------------------ FUNCTIONS FOR HEADING
-- it is necessary to give the bot a set direction to head in so the swarm moves
-- this requires metadata as a block has no inherent direction


-- READ the metadata
-- also use for when applying it to movement


swarmer.read_heading = function(pos)


  local meta = minetest.get_meta(pos)

  local heading = meta:get_string("heading")
  return heading
end




--INPUT A NEW HEADING

swarmer.new_heading = function(pos, heading)

  
  local newheading = heading

  local meta = minetest.get_meta(pos)

  meta:set_string("heading", newheading)


--for troubleshooting, so you can read the metadata for the block
--[[
		local heading_list_value = meta:get_string("heading")
		meta:set_string("formspec",
			"size[10,10]"..
			"button_exit[3.5,4.5;3,1;exit_form;Exit]"..
			"label[2,1;Heading]"..		"textlist[2,2;2,1;heading_list;"..heading_list_value.."]"

		)
	]]


  
end


