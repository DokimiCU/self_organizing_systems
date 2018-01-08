

----------------------------------------------------------------
--FOREST HERB BOT RULES aka swamp forest herb
-- a shade loving ground cover herbaceous plant
----------------------------------------------------------------
--SETTINGS
local forest_growth = minetest.settings:get('ecobots_forest_growth') or 31

-- Spreads to distant areas
local seed_spread = forest_growth * 10

----------------------------------------------------------------
-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
	interval = forest_growth,
	chance = 5,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
		local horizradius_ph = 2
		
			
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 11
		local poprad = 4
		

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_forest_herb_bot"})
		num_bot = (cn["ecobots:ecobots_forest_herb_bot"] or 0)
		

	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph,upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}


-- for check randpos is below is dirt not another bot and above is air

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



-- do if below pop limits and position is empty

if (num_bot) < poplim and minetest.get_node(randpos).name == "air" then

		
-- do if well lit


if  light_level >= 11 and light_level_ranpos >= 11  then


-- But not too bright

if  light_level <= 14 and light_level_ranpos <= 14  then



-- do if above soil or leaves
				
if minetest.get_item_group(newplace_below.name, "soil") == 1 or minetest.get_item_group(newplace_below.name, "leaves") == 1 then

-- do if below air 

if minetest.get_node(randpos_above).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_forest_herb_bot"})
	
			
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
-- KILL BOT SHADE

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
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

		-- kill if shaded... not very sensitive to shade

				if  lightsmother_level < 9 then
		
				-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	end
end,
}



----------------------------------------------------------------
-- KILL BOT SEAWATER gives tolerance for salt water

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
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
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
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
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT SNOW.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
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
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
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
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
	interval = 120,
	chance = 1500,
	catch_up = false,
	action = function(pos)
	
		pos = {x = pos.x, y = pos.y, z = pos.z},

			
		-- mulch bot 
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})
		
end,
}



------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_forest_herb_bot"},
	interval = seed_spread,
	chance = 100,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 2
		local downradius = 8
		local horizradius = 40
		
		
		

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

		minetest.set_node(randpos, {name = "ecobots:ecobots_forest_herb_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
		end
		end
		end
end,
}


