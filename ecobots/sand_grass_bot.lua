

----------------------------------------------------------------
--SAND GRASS BOT RULES
-- a grass that grows only in sand. An extremophile. Doesn't produce organic matter (i.e. when dead it's gone). Builds sand dunes
----------------------------------------------------------------
--SETTINGS
local sand_growth = minetest.settings:get('sand_growth')

--formation of dunes
local dune_growth = sand_growth * 3

local up_growth = sand_growth * 3

-- Spreads to distant areas
local seed_spread = sand_growth * 10

----------------------------------------------------------------
-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = sand_growth,
	chance = 15,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1
		
			
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 5
		local poprad = 2
		

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_sand_grass_bot"})
		num_bot = (cn["ecobots:ecobots_sand_grass_bot"] or 0)
		

	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos surrounds

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


if  light_level >= 14 and light_level_ranpos >= 14  then



-- do is below air and above sand
				
if minetest.get_item_group(newplace_below.name, "sand") == 1 and  minetest.get_node(randpos_above).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_sand_grass_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
	
		end
		end
		end

end,
}


----------------------------------------------------------------
-- VERTICAL REPLICATION rare
--- the idea is to help them build sand dunes under them

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = up_growth,
	chance = 500,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 1
		
		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 5
		local poprad = 2
		

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_sand_grass_bot"})
		num_bot = (cn["ecobots:ecobots_sand_grass_bot"] or 0)
		

	
		

-- get position for new bot. Must be random to prevent towers.

	local pos_above = {x = pos.x + math.random(-1,1), y = pos.y + 1, z = pos.z + math.random(-1,1)}


-- for check pos
	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}

	local pos_below_new = {x = pos_above.x, y = pos_above.y - 1, z = pos_above.z}

	local pos_belowthat_new = {x = pos_above.x, y = pos_above.y - 2, z = pos_above.z}


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)


	
-- do if below pop limits 

	if (num_bot) < poplim then

-- do if there is space above the new site and below i.e. two empty blocks

	if minetest.get_node(pos_above).name == "air" and minetest.get_node(pos_below_new).name == "air" then

--do if not floating

if minetest.get_node(pos_belowthat_new).name ~= "air" then

		
-- do if well lit 


	if  light_level >= 14 then


--What type of sand was under the original bot?

--Is it sand?

	if minetest.get_node(pos_below).name == "default:sand" then

		--place sand and bot above
		minetest.set_node(pos_below_new, {name = "default:sand"})
		minetest.set_node(pos_above, {name = "ecobots:ecobots_sand_grass_bot"})

		--wind sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})

else


--Is it desert sand?

	if minetest.get_node(pos_below).name == "default:desert_sand" then

		--place sand and bot above
		minetest.set_node(pos_below_new, {name = "default:desert_sand"})
		minetest.set_node(pos_above, {name = "ecobots:ecobots_sand_grass_bot"})

		--wind sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
			
else

--Is it silver sand?

	if minetest.get_node(pos_below).name == "default:silver_sand" then

		--place sand and bot above
		minetest.set_node(pos_below_new, {name = "default:silver_sand"})
		minetest.set_node(pos_above, {name = "ecobots:ecobots_sand_grass_bot"})

		--wind sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
	
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
-- SAND DUNE GROWTH
--builds up sand around the plant

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = dune_growth,
	chance = 100,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 3
		
			
		

-- get random position for sand

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}
	
-- for side check
	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y, z = randpos.z + math.random(-1,1)}

-- for sand type check
	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}


-- for check randpos surrounds

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}

--name for new node below for substrate check

	local newplace = minetest.get_node(randpos)



-- do if position is empty or will bury a plant
if minetest.get_node(randpos).name == "air" or minetest.get_item_group(newplace.name, "flora") == 1 then

--do if a side is against a solid i.e a slow air area
if minetest.get_node(randpos_ranside).name ~= "air" then


-- do if position isn't hanging and is below air

if minetest.get_node(randpos_below).name ~= "air" and minetest.get_node(randpos_above).name == "air" then
	

--What type of sand?

--Is it sand?

if minetest.get_node(pos_below).name == "default:sand" then

		--place sand
		minetest.set_node(randpos, {name = "default:sand"})

		--wind sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})

else


--Is it desert sand?

if minetest.get_node(pos_below).name == "default:desert_sand" then

		--place sand
		minetest.set_node(randpos, {name = "default:desert_sand"})

		--wind sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
			
else

--Is it silver sand?

if minetest.get_node(pos_below).name == "default:silver_sand" then

		--place sand
		minetest.set_node(randpos, {name = "default:silver_sand"})

		--wind sound
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
-- SAND DUNE DESTRUCTION
--hopefully to prevent infinite dune growth
-- remove as many nodes as it is less likely to occur, like a storm blowing them away (currently 5)

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = dune_growth,
	chance = 500,
	action = function(pos)
	
	--dispersal radius up and horizontal (keep up 1 so stays at surface. Horiz should be larger than for dune growth so that over time sand is lost in the gaps between plants and accumulated around them)
		local upradius = 1
		local horizradius = 6
		
			
		

-- get random positions for sand and name them for check and get a side for check

	local randpos1 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local newplace1 = minetest.get_node(randpos1)

	local ranside1 = {x = randpos1.x + math.random(-1,1), y = randpos1.y, z = randpos1.z + math.random(-1,1)}


	local randpos2 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local newplace2 = minetest.get_node(randpos2)

	local ranside2 = {x = randpos2.x + math.random(-1,1), y = randpos2.y, z = randpos2.z + math.random(-1,1)}


	local randpos3 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local newplace3 = minetest.get_node(randpos3)

	local ranside3 = {x = randpos3.x + math.random(-1,1), y = randpos3.y, z = randpos3.z + math.random(-1,1)}


	local randpos4 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local newplace4 = minetest.get_node(randpos4)

	local ranside4 = {x = randpos4.x + math.random(-1,1), y = randpos4.y, z = randpos4.z + math.random(-1,1)}


	local randpos5 = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}

	local newplace5 = minetest.get_node(randpos5)

	local ranside5 = {x = randpos5.x + math.random(-1,1), y = randpos5.y, z = randpos5.z + math.random(-1,1)}


--if sand and has a side exposed then dig so that it collapses

	if minetest.get_item_group(newplace1.name, "sand") == 1 and minetest.get_node(ranside1).name == "air" then
		minetest.dig_node(randpos1)
	end

	if minetest.get_item_group(newplace2.name, "sand") == 1 and minetest.get_node(ranside2).name == "air" then
		minetest.dig_node(randpos2)
	end

	if minetest.get_item_group(newplace3.name, "sand") == 1 and minetest.get_node(ranside3).name == "air" then
		minetest.dig_node(randpos3)
	end

	if minetest.get_item_group(newplace4.name, "sand") == 1 and minetest.get_node(ranside4).name == "air" then
		minetest.dig_node(randpos4)
	end

	if minetest.get_item_group(newplace5.name, "sand") == 1 and minetest.get_node(ranside5).name == "air" then
		minetest.dig_node(randpos5)
	end	

end,
}




----------------------------------------------------------------
-- KILL BOT SHADE

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
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

				if  lightsmother_level < 14 then
		
				-- remove bot 
			
			minetest.dig_node(pos)	
						
		end
	end
end,
}



----------------------------------------------------------------
-- KILL BOT SEAWATER gives tolerance for salt water

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius
		local searadius = 2


	--count seawater

		local num_seawater= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - searadius, y = pos.y - searadius, z = pos.z - searadius},
			{x = pos.x + searadius, y = pos.y + searadius, z = pos.z + searadius}, {"default:water_source"})
		num_seawater = (cn["default:water_source"] or 0)
		

		

		if (num_seawater) > 1 then
		
		-- remove bot 
			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT Fresh WATER.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius
		local radius = 2


	--count water

		local num_water= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:river_water_source"})
		num_water = (cn["default:river_water_source"] or 0)
		

		

		if (num_water) > 1 then
		
		-- remove bot 
			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT SNOW.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local tolerance = 6

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
		
		-- remove bot 
			
			minetest.set_node(pos, {name = "air"})	
						
		end
	
end,
}



----------------------------------------------------------------
-- KILL BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = 120,
	chance = 1500,
	catch_up = false,
	action = function(pos)
	
		pos = {x = pos.x, y = pos.y, z = pos.z},

			
		-- remove bot 
			
			minetest.set_node(pos, {name = "air"})
		
end,
}



------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_sand_grass_bot"},
	interval = seed_spread,
	chance = 100,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 5
		local horizradius = 10
		
		
		

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


-- do if empty and above sand
				
if minetest.get_item_group(newplace_below.name, "sand") == 1 and  minetest.get_node(randpos).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_sand_grass_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
		end
		end
end,
}


