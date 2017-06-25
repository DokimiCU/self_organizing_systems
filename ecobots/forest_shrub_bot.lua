

----------------------------------------------------------------
--FOREST SHRUB BOT aka swamp forest shrub
-- a shrub that tolerates shade
----------------------------------------------------------------
--SETTINGS
--Leafy is fastest, all others are based off this
--forest_growth controls the rate for all forest plants

--Grows the tree's overhanging leaves
local tree_leafygrowth = minetest.settings:get('forest_growth')

--Grows the tree's trunk
local tree_upgrowth = tree_leafygrowth * 2

-- Spreads to distant areas
local seed_spread = tree_leafygrowth * 10

----------------------------------------------------------------
-- UPWARDS REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
	interval = tree_upgrowth,
	chance = 12,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
		local horizradius_ph = 1

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 5
		local poprad = 2
		local wood_poplim = 4
		local wood_poprad = 4

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_forest_shrub_bot"})
		num_bot = (cn["ecobots:ecobots_shrub_bot"] or 0)
		

	--count wood
		local num_wood = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - wood_poprad, y = pos.y - wood_poprad, z = pos.z - wood_poprad},
			{x = pos.x + wood_poprad, y = pos.y + wood_poprad, z = pos.z + wood_poprad}, {"ecobots:ecobots_forest_shrub_trunk"})
		num_wood = (cn["ecobots:ecobots_forest_shrub_trunk"] or 0)

		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph,upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}

-- for check randpos is below not air above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

local randpos_belowthat = {x = randpos.x, y = randpos.y - 2, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}
	 local randpos_trunkbelow = {x = pos.x, y = pos.y - 4, z = pos.z}

	


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light level above destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos_above)) or 0)



-- do if below pop limits

if (num_bot) < poplim and (num_wood) < wood_poplim then

		
-- do if well lit
---lower than others so can get from floor up

if  light_level >= 10 and light_level_ranpos >=11
then

-- not if too bright
if  light_level <= 14 and light_level_ranpos <=14
then




-- Create new bot if location has an older bot or wood below
				
	if minetest.get_node(randpos_below).name == "ecobots:ecobots_forest_shrub_bot" or minetest.get_node(randpos_below).name == "ecobots:ecobots_forest_shrub_trunk" then
	


---check if air above and trunk not too long 

	if minetest.get_node(randpos_above).name == "air" and randpos_trunkbelow ~= "ecobots:ecobots_forest_shrub_trunk" then

--check not building to an unstable leaf
		if minetest.get_node(randpos_belowthat).name ~= "air" then

--create bot and wood

			minetest.set_node(randpos_above, {name = "ecobots:ecobots_forest_shrub_bot"})
			minetest.set_node(randpos, {name = "ecobots:ecobots_forest_shrub_trunk"})
			minetest.set_node(randpos_below, {name = "ecobots:ecobots_forest_shrub_trunk"})
			
			

			
		--tree growth sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		end
		end	
		end
		end
		end
	end
end,
}




----------------------------------------------------------------
--LEAFY REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
	interval = tree_leafygrowth,
	chance = 10,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
		local horizradius_ph = 1

		
	-- population limit within area	
		local poplim = 5
		local poprad = 2

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_forest_shrub_bot"})
		num_bot = (cn["ecobots:ecobots_forest_shrub_bot"] or 0)
		
		

-- get same level random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph, upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}

-- for check randpos is below air side another bot

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y + math.random(-1,1), z = randpos.z + math.random(-1,1)}

	


	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
		-- do if enviro suitable and below pop limit

---high level so shading becomes a factor
if  light_level >= 12 and (num_bot) < poplim then


-- not if too bright
if  light_level <= 14 then



		-- Create new bot if location suitable
				
		--- above empty space and grounded side growth

	if minetest.get_node(randpos_below).name == "air" and
	minetest.get_node(randpos_ranside).name == "ecobots:ecobots_forest_shrub_bot" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_forest_shrub_bot"})

			
		--tree build sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
			
		end
		end
	end
end,
}








----------------------------------------------------------------
-- KILL BOT SHADE

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
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

				if  lightsmother_level < 9 then
		
		--check if got shaded by another tree bot or wood
		local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(pos_above).name == "ecobots:ecobots_forest_shrub_bot" or minetest.get_node(pos_above).name == "ecobots:ecobots_forest_shrub_trunk" then	

		-- turn to wood
			minetest.set_node(pos, {name = "ecobots:ecobots_forest_shrub_trunk"})

		else
		-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
		end				
		end
	end
end,
}




----------------------------------------------------------------
-- KILL BOT SEAWATER gives tolerance for salt water

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
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
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
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
		

		

		if (num_water) > 3 then
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT SNOW.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
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
-- KILL BOT DRY

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 2
		local tolerance = 1

	--count dirt with dry grass

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:dirt_with_dry_grass"})
		num_bad1 = (cn["default:dirt_with_dry_grass"] or 0)
		
	--count desert sand

		local num_bad2= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:desert_sand"})
		num_bad2 = (cn["default:desert_sand"] or 0)
		

		if (num_bad1) > tolerance or (num_bad2) > tolerance  then
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}





----------------------------------------------------------------
-- KILL BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
	interval = 120,
	chance = 1500,
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
     	nodenames = {"ecobots:ecobots_forest_shrub_bot"},
	interval = seed_spread,
	chance = 200,
	action = function(pos)
	
	--dispersal radius
		local upradius = 5
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

if  light_level >= 12 and light_level_ranpos >= 10  then

-- inhibit if too if well lit

if  light_level <= 14 and light_level_ranpos <= 14  then



-- do if empty and above soil
				
if minetest.get_item_group(newplace_below.name, "soil") == 1 and  minetest.get_node(randpos).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_forest_shrub_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
		end
		end
		end
end,
}




