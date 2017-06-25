

----------------------------------------------------------------
--PHOTOSYNTH BOT aka Pioneer Tree bot
-- a spreading tree with accacia wood that likes high light
----------------------------------------------------------------
--SETTINGS
--Leafy is fastest, all others are based off this
--pioneer_growth controls the rate for all pioneer plants

--Grows the tree's overhanging leaves
local tree_leafygrowth = minetest.settings:get('pioneer_growth')

--Grows the tree's trunk
local tree_upgrowth = tree_leafygrowth * 3

--Grows the tree's woody branches
local tree_branchgrowth = tree_leafygrowth * 2


--Grows the tree at ground level
local tree_rootgrowth = tree_leafygrowth

-- Spreads to distant areas
local seed_spread = tree_leafygrowth * 10


----------------------------------------------------------------
-- UPWARDS REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = tree_upgrowth,
	chance = 18,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
		local horizradius_ph = 1

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local photosynth_poplim = 5
		local photosynth_poprad = 2
		local wood_poplim = 6
		local wood_poprad = 3

	--count photosynth bots

		local num_photosynth_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - photosynth_poprad, y = pos.y - photosynth_poprad, z = pos.z - photosynth_poprad},
			{x = pos.x + photosynth_poprad, y = pos.y + photosynth_poprad, z = pos.z + photosynth_poprad}, {"ecobots:ecobots_photosynth_bot"})
		num_photosynth_bot = (cn["ecobots:ecobots_photosynth_bot"] or 0)
		

	--count wood
		local num_wood = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - wood_poprad, y = pos.y - wood_poprad, z = pos.z - wood_poprad},
			{x = pos.x + wood_poprad, y = pos.y + wood_poprad, z = pos.z + wood_poprad}, {"default:acacia_tree"})
		num_wood = (cn["default:acacia_tree"] or 0)

		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph,upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}

-- for check randpos is below not air above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

local randpos_belowthat = {x = randpos.x, y = randpos.y - 2, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}
	 local randpos_trunkbelow = {x = randpos.x, y = randpos.y - 30, z = randpos.z}

	


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light level above destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos_above)) or 0)


		
-- do if well lit
---high level so shading becomes a factor but lower than others so can get from floor up

if  light_level >= 13 and light_level_ranpos >=14
then


-- do if below pop limits

if (num_photosynth_bot) < photosynth_poplim and (num_wood) < wood_poplim then

-- Create new bot if location has an older bot or wood below
				
	if minetest.get_node(randpos_below).name == "ecobots:ecobots_photosynth_bot" or minetest.get_node(randpos_below).name == "default:acacia_tree" then
	


---check if air above and trunk not too long 

	if minetest.get_node(randpos_above).name == "air" and randpos_trunkbelow ~= "default:acacia_tree" then

--check not building to an unstable leaf
		if minetest.get_node(randpos_belowthat).name ~= "air" then

--create bot and wood

			minetest.set_node(randpos_above, {name = "ecobots:ecobots_photosynth_bot"})
			minetest.set_node(randpos, {name = "default:acacia_tree"})

			
		--tree growth sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		end
		end	
		end
		end
		end
end,
}


----------------------------------------------------------------
--BRANCHING REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = tree_branchgrowth,
	chance = 12,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 4
		local horizradius_ph = 1

		
	-- population limit within area	
		local photosynth_poplim = 5
		local photosynth_poprad = 2

	--count photosynth bots

		local num_photosynth_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - photosynth_poprad, y = pos.y - photosynth_poprad, z = pos.z - photosynth_poprad},
			{x = pos.x + photosynth_poprad, y = pos.y + photosynth_poprad, z = pos.z + photosynth_poprad}, {"ecobots:ecobots_photosynth_bot"})
		num_photosynth_bot = (cn["ecobots:ecobots_photosynth_bot"] or 0)
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(0, upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}

-- for check randpos is below air, side wood

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_belowthat = {x = randpos.x, y = randpos.y - 2, z = randpos.z}

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y - 1, z = randpos.z + math.random(-1,1)}

	


	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		


---high level so shading becomes a factor, below pop limit
	if  light_level >= 14 and (num_photosynth_bot) < photosynth_poplim then

-- space is empty
	if minetest.get_node(randpos).name == "air" then

					
--- above empty space 2 blocks and grounded side growth
	if minetest.get_node(randpos_belowthat).name == "air" and
	minetest.get_node(randpos_ranside).name == "default:acacia_tree" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_photosynth_bot"})

			minetest.set_node(randpos_below, {name = "default:acacia_tree"})
			
		--tree build sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
			
	end
	end
	end
end,
}



----------------------------------------------------------------
--LEAFY REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = tree_leafygrowth,
	chance = 8,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 0
		local horizradius_ph = 1

		
	-- population limit within area	
		local photosynth_poplim = 17
		local photosynth_poprad = 6

	--count photosynth bots

		local num_photosynth_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - photosynth_poprad, y = pos.y - photosynth_poprad, z = pos.z - photosynth_poprad},
			{x = pos.x + photosynth_poprad, y = pos.y + photosynth_poprad, z = pos.z + photosynth_poprad}, {"ecobots:ecobots_photosynth_bot"})
		num_photosynth_bot = (cn["ecobots:ecobots_photosynth_bot"] or 0)
		
		

-- get same level random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph, upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}

-- for check randpos is below air side another bot

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y, z = randpos.z + math.random(-1,1)}

	


	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
		-- do if enviro suitable and below pop limit

---high level so shading becomes a factor
if  light_level >= 14 and (num_photosynth_bot) < photosynth_poplim then

		
-- space is empty
	if minetest.get_node(randpos).name == "air" then

				
--- above empty space and grounded side growth
	if minetest.get_node(randpos_below).name == "air" and
	minetest.get_node(randpos_ranside).name == "ecobots:ecobots_photosynth_bot" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_photosynth_bot"})

			
		--tree build sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
	end	
	end
	end
end,
}







----------------------------------------------------------------
--ROOT SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = tree_rootgrowth,
	chance = 15,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 3
		local horizradius_ph = 1

		
	-- population limit within area	
		local photosynth_poplim = 5
		local photosynth_poprad = 2

	--count photosynth bots

		local num_photosynth_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - photosynth_poprad, y = pos.y - photosynth_poprad, z = pos.z - photosynth_poprad},
			{x = pos.x + photosynth_poprad, y = pos.y + photosynth_poprad, z = pos.z + photosynth_poprad}, {"ecobots:ecobots_photosynth_bot"})
		num_photosynth_bot = (cn["ecobots:ecobots_photosynth_bot"] or 0)
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph, horizradius_ph), y = pos.y + math.random(-upradius_ph,0), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}

-- for check randpos is below dirt and ranside wood

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y, z = randpos.z + math.random(-1,1)}

	
--name for new node below for substrate check

	local newplace_below = minetest.get_node(randpos_below)


	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	
	


		
-- do if lit and below pop limit
---high level so shading becomes a factor

if  light_level >= 13 and (num_photosynth_bot) < photosynth_poplim then

				
--- if grounded in soil and at surface i.e. shallow roots

	if minetest.get_item_group(newplace_below.name, "soil") == 1 and minetest.get_node(randpos).name == "air" then

--- if the side of a tree

	if minetest.get_node(randpos_ranside).name == "default:acacia_tree" then


--Create bot and roots

			minetest.set_node(randpos, {name = "ecobots:ecobots_photosynth_bot"})
			minetest.set_node(randpos_below, {name = "default:acacia_tree"})

			
		--tree build sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 40,})
		
		end	
		end
	end
end,
}





----------------------------------------------------------------
-- KILL PHOTOSYNTH BOT SHADE

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)


	--check light level above
		local lightsmother_level = {}
		local lightsmother_level = (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0)

	---get time
		local tod = minetest.get_timeofday()

			if tod > 0.3
			and tod < 0.7 then	

		-- kill if shaded

				if  lightsmother_level < 13 then
		
		--check if got shaded by another photobot or wood
		local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(pos_above).name == "ecobots:ecobots_photosynth_bot" or minetest.get_node(pos_above).name == "default:acacia_tree" then	

		-- turn to wood
			minetest.set_node(pos, {name = "default:acacia_tree"})

		else
		-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
		end				
		end
	end
end,
}




----------------------------------------------------------------
-- KILL PHOTSYNTH BOT SEAWATER gives tolerance for salt water

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius
		local searadius = 1


	--count seawater

		local num_seawater= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - searadius, y = pos.y - searadius, z = pos.z - searadius},
			{x = pos.x + searadius, y = pos.y + searadius, z = pos.z + searadius}, {"default:water_source"})
		num_seawater = (cn["default:water_source"] or 0)
		

		

		if (num_seawater) > 1 then
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT Fresh WATER.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius
		local radius = 1


	--count seawater

		local num_water= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:river_water_source"})
		num_water = (cn["default:river_water_source"] or 0)
		

		

		if (num_water) > 2 then
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}

----------------------------------------------------------------
-- KILL BOT SNOW.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 2
		local tolerance = 1

	--count snow

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:snow"})
		num_bad1 = (cn["default:snow"] or 0)
		
	--count snow blocks

		local num_bad2= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:snowblock"})
		num_bad2 = (cn["default:snowblock"] or 0)
		

		if (num_bad1) > tolerance or (num_bad2) > tolerance  then
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}

----------------------------------------------------------------
-- KILL BOT DRY note... not killed by dry grass like others

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local tolerance = 9

	
		
	--count desert sand

		local num_bad2= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:desert_sand"})
		num_bad2 = (cn["default:desert_sand"] or 0)
		

		if (num_bad2) > tolerance  then
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}




----------------------------------------------------------------
-- KILL PHOTSYNTH BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = 120,
	chance = 2500,
	catch_up = false,
	action = function(pos)
	
		pos = {x = pos.x, y = pos.y, z = pos.z},

			
		-- dig bot 
			
			minetest.dig_node(pos)
		-- sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 5, max_hear_distance = 30,})	
		
end,
}


------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = seed_spread,
	chance = 200,
	action = function(pos)
	
	--dispersal radius
		local upradius = 2
		local downradius = 10
		local horizradius = 30
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos is below is soil and above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


--name for new node below for substrate check

	local newplace_below = minetest.get_node(randpos_below)

	

	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light level above destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos_above)) or 0)


		
-- do if well lit

if  light_level >= 14 and light_level_ranpos >= 14  then



-- do if empty and above soil
				
if minetest.get_item_group(newplace_below.name, "soil") == 1 and  minetest.get_node(randpos).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_photosynth_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
	
		end
		end
end,
}






