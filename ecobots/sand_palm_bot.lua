

----------------------------------------------------------------
--SAND PALM BOT RULES
-- a sand adapted palm,
----------------------------------------------------------------
--SETTINGS
local sand_growth = minetest.settings:get('ecobots_sand_growth') or 20

-- Spreads to distant areas
local seed_spread = sand_growth * 10

----------------------------------------------------------------
-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_bot"},
	neighbors = {"group:water"},
	interval = sand_growth,
	chance = 25,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 3
		local horizradius = 5

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 4
		local poprad = 2
		

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_sand_palm_bot"})
		num_bot = (cn["ecobots:ecobots_sand_palm_bot"] or 0)
		

	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check of positions

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

	if (num_bot) < poplim then

-- do if well lit


	if  light_level >= 14 and light_level_ranpos >= 14  then


-- do if above default sand or grass
	if minetest.get_node(randpos_below).name == "default:sand" or minetest.get_item_group(newplace_below.name, "soil") == 1  then

-- do if empty and below air
				
	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_above).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_sand_palm_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
	end	
	end
	end
	end
end,
}

----------------------------------------------------------------
-- UP REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_bot"},
	interval = sand_growth,
	chance = 3,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 8
		local poprad = 2
		local wood_poplim = 4
		local wood_poprad = 5
		

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_sand_palm_bot"})
		num_bot = (cn["ecobots:ecobots_sand_palm_bot"] or 0)
		
--count wood
		local num_wood = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - wood_poprad, y = pos.y - wood_poprad, z = pos.z - wood_poprad},
			{x = pos.x + wood_poprad, y = pos.y + wood_poprad, z = pos.z + wood_poprad}, {"ecobots:ecobots_sand_palm_trunk"})
		num_wood = (cn["ecobots:ecobots_sand_palm_trunk"] or 0)
	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check of positions

	
	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light level above destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos_above)) or 0)




-- do if below pop limits 

	if (num_bot) < poplim and (num_wood) < wood_poplim then

-- do if well lit


	if  light_level >= 14 and light_level_ranpos >= 14  then

-- do if empty
				
	if minetest.get_node(randpos).name == "air" then

-- do if attached below

	if minetest.get_node(randpos_below).name == "ecobots:ecobots_sand_palm_bot" then
	
--create bot and displace old with trunk

		minetest.set_node(randpos, {name = "ecobots:ecobots_sand_palm_bot"})

		minetest.set_node(randpos_below, {name = "ecobots:ecobots_sand_palm_trunk"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
	end	
	end
	end
	end
end,
}




----------------------------------------------------------------
-- KILL BOT SHADE

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)


	--check light level above
		local lightsmother_level = {}
		local lightsmother_level = (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0)

--check if got shaded by another tree bot or wood
		local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}


	---get time
		local tod = minetest.get_timeofday()

		if tod > 0.3 and tod < 0.7 then	

		-- kill if shaded

		if  lightsmother_level < 14 then
		
		--is it self shading?

		if minetest.get_node(pos_above).name == "ecobots:ecobots_sand_palm_bot" then	

		-- turn to wood
			minetest.set_node(pos, {name = "ecobots:ecobots_sand_palm_trunk"})

		else
			-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
		end
		end
end,
}




----------------------------------------------------------------
-- CLEAR TRUNK IN SEAWATER

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_trunk"},
	interval = 1,
	chance = 5,
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
			
			minetest.set_node(pos, {name = "default:sand"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- CLEAR TRUNK IN RIVER WATER

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_trunk"},
	interval = 1,
	chance = 5,
	catch_up = false,
	action = function(pos)
	
	-- to kill if within radius
		local searadius = 1


	--count seawater

		local num_seawater= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - searadius, y = pos.y - searadius, z = pos.z - searadius},
			{x = pos.x + searadius, y = pos.y + searadius, z = pos.z + searadius}, {"default:river_water_source"})
		num_seawater = (cn["default:river_water_source"] or 0)
		

		

		if (num_seawater) > 1 then
		
		-- kill bot 
			
			minetest.set_node(pos, {name = "default:sand"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT SNOW.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
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
			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})
						
		end
	
end,
}




----------------------------------------------------------------
-- KILL BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_bot"},
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
--rare long distance spread to a suitable location. Very rare as this is without water

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_palm_bot"},
	neighbors = {"ecobots:ecobots_sand_palm_bot" },
	interval = seed_spread,
	chance = 600,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 10
		local horizradius = 40
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos

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



-- do if above default sand
	if minetest.get_node(randpos_below).name == "default:sand" then

-- do if empty and below air
				
	if minetest.get_node(randpos).name == "air" and minetest.get_node(randpos_above).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_sand_palm_bot"})	
			
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
		end
		end
		end
end,
}


