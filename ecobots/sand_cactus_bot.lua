

----------------------------------------------------------------
--SAND CACTUS BOT
-- A desert cactus. Slow growing, but tolerant of deserts.
--Doesn't leave dead matter like other trees (so doesn't change desert).
----------------------------------------------------------------
--SETTINGS
--sand_growth controls the rate for all sand plants

--Grows the tree's up
local tree_upgrowth = minetest.settings:get('sand_growth')


--Grows the tree's out
local tree_branchgrowth = tree_upgrowth

--long distance spread
local seed_spread = tree_upgrowth * 10

----------------------------------------------------------------
-- UPWARDS REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = tree_upgrowth,
	chance = 34,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 6
		local poprad = 4
		
	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_sand_cactus_bot"})
		num_bot = (cn["ecobots:ecobots_sand_cactus_bot"] or 0)
		

	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

-- for check randpos is below not air above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

local randpos_belowthat = {x = randpos.x, y = randpos.y - 2, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}
	 local randpos_trunkbelow = {x = randpos.x, y = randpos.y - 5, z = randpos.z}

	


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light level above destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos_above)) or 0)


		
-- do if well lit
---high level so shading becomes a factor but lower than others so can get from floor up

if  light_level >= 14 and light_level_ranpos >=14
then


-- do if below pop limits

if (num_bot) < poplim then

-- Create new bot if location has an older bot below
				
	if minetest.get_node(randpos_below).name == "ecobots:ecobots_sand_cactus_bot" then
	


---check if air above and trunk not too long 

	if minetest.get_node(randpos_above).name == "air" and randpos_trunkbelow ~= "ecobots:ecobots_sand_cactus_bot" then

--check not building to an unstable leaf
		if minetest.get_node(randpos_belowthat).name ~= "air" then

--create bot

			minetest.set_node(randpos, {name = "ecobots:ecobots_sand_cactus_bot"})
			
			
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
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = tree_branchgrowth,
	chance = 23,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 0
		local horizradius = 1

		
	-- population limit within area	
		local poplim = 3
		local poprad = 1
		
	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_sand_cactus_bot"})
		num_bot = (cn["ecobots:ecobots_sand_cactus_bot"] or 0)
		

		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(0, upradius), z = pos.z + math.random(-horizradius,horizradius)}

-- for check randpos is below air, side cactus

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_belowthat = {x = randpos.x, y = randpos.y - 2, z = randpos.z}

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y + math.random(0,1), z = randpos.z + math.random(-1,1)}




	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
-- do if below pop limit

	if (num_bot) < poplim then 

---high level so shading becomes a factor
	if  light_level >= 14 then

-- space is empty
	if minetest.get_node(randpos).name == "air" then

						
--- above empty space 2 blocks

if minetest.get_node(randpos_belowthat).name == "air" then

-- if double grounded side growth
	if minetest.get_node(randpos_ranside).name == "ecobots:ecobots_sand_cactus_bot" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_sand_cactus_bot"})
			
		--tree build sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
	end
	end		
	end
	end
	end
end,
}







----------------------------------------------------------------
-- KILL BOT SHADE

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)


	--check light level above
		local lightsmother_level = {}
		local lightsmother_level = (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0)


--check if got shaded by another photobot or wood
		local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

--check if hovering
		local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
		local pos_belowthat = {x = pos.x, y = pos.y - 2, z = pos.z}

	--- don't do at night
		local tod = minetest.get_timeofday()

		if tod > 0.3 and tod < 0.7 then	

	-- do if shaded

		if  lightsmother_level < 13 then
		
	
	-- if part of trunk then leave be
		if minetest.get_node(pos_above).name == "ecobots:ecobots_sand_cactus_bot" then	

		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.1, max_hear_distance = 1,})

		else
		-- kill bot 			
			minetest.dig_node(pos)	
	
	end
	end				
	end
end,
}




----------------------------------------------------------------
-- KILL BOT SEAWATER gives tolerance for salt water

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius
		local searadius = 3


	--count seawater

		local num_seawater= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - searadius, y = pos.y - searadius, z = pos.z - searadius},
			{x = pos.x + searadius, y = pos.y + searadius, z = pos.z + searadius}, {"default:water_source"})
		num_seawater = (cn["default:water_source"] or 0)
		

		

		if (num_seawater) > 1 then
		
		-- kill bot 
			
			minetest.dig_node(pos)	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT Fresh WATER.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius
		local radius = 1


	--count water

		local num_water= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:river_water_source"})
		num_water = (cn["default:river_water_source"] or 0)
		

		

		if (num_water) > 1 then
		
		-- kill bot 
			
			minetest.dig_node(pos)	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT SNOW.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 3
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
			
			minetest.dig_node(pos)	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT DAMP i.e. climate rather than drowning

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local tolerance = 4

	--count dirt with dry grass

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:dirt_with_grass"})
		num_bad1 = (cn["default:dirt_with_grass"] or 0)
		
			

		if (num_bad1) > tolerance then
		
		-- kill bot 
			
			minetest.dig_node(pos)	
						
		end
	
end,
}





----------------------------------------------------------------
-- KILL BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = 120,
	chance = 3500,
	catch_up = false,
	action = function(pos)
	
		pos = {x = pos.x, y = pos.y, z = pos.z},

			
		-- dig bot 
			
			minetest.dig_node(pos)	
		
end,
}


------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = seed_spread,
	chance = 650,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 3
		local horizradius = 15
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos is below is sand and above is air

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



-- do if empty

if minetest.get_node(randpos).name == "air" then



--do if above sand or dry grass
				
if minetest.get_item_group(newplace_below.name, "sand") == 1 and  minetest.get_node(randpos_below).name == "default:dirt_with_dry_grass" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_sand_cactus_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
		end
		end
		end
end,
}


----------------------------------------------------------------
-- GET RID OF THE BLOODY DEFAULT DRY SHRUBS
-- these keep spawning under cactus!

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_cactus_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
		
		local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
		

		if minetest.get_node(pos_below).name == "default:dry_shrub" then
		
		-- replace shrub with bot 
			
			minetest.set_node(pos_below, {name = "ecobots:ecobots_sand_cactus_bot"})	
						
		end
	
end,
}




