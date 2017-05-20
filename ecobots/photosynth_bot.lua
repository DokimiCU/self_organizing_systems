

----------------------------------------------------------------
--PHOTOSYNTH BOT aka Tree bot
----------------------------------------------------------------
local tree_upgrowth = minetest.setting_get('tree_upgrowth')
local tree_branchgrowth = minetest.setting_get('branch_upgrowth')
local tree_leafygrowth = minetest.setting_get('tree_leafygrowth')
local tree_rootgrowth = minetest.setting_get('tree_rootgrowth')

----------------------------------------------------------------
-- UPWARDS REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = tree_upgrowth,
	chance = 12,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
		local horizradius_ph = 1

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local photosynth_poplim = 5
		local photosynth_poprad = 2
		local wood_poplim = 8
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
			{x = pos.x + wood_poprad, y = pos.y + wood_poprad, z = pos.z + wood_poprad}, {"default:tree"})
		num_wood = (cn["default:tree"] or 0)

		

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

if  light_level >= 12 and light_level_ranpos >=10
then

-- do if below pop limits

if (num_photosynth_bot) < photosynth_poplim and (num_wood) < wood_poplim then

-- Create new bot if location has an older bot or wood below
				
	if minetest.get_node(randpos_below).name == "ecobots:ecobots_photosynth_bot" or minetest.get_node(randpos_below).name == "default:tree" then
	


---check if air above and trunk not too long 

	if minetest.get_node(randpos_above).name == "air" and randpos_trunkbelow ~= "default:wood" then

--check not building to an unstable leaf
		if minetest.get_node(randpos_belowthat).name ~= "air" then

--create bot and wood

			minetest.set_node(randpos_above, {name = "ecobots:ecobots_photosynth_bot"})
			minetest.set_node(randpos, {name = "default:tree"})

			
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
	chance = 24,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 0
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

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph, upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}

-- for check randpos is below air side wood

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_belowthat = {x = randpos.x, y = randpos.y - 2, z = randpos.z}

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y - 1, z = randpos.z + math.random(-1,1)}

	


	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
		-- do if enviro suitable and below pop limit

---high level so shading becomes a factor
if  light_level >= 14 and (num_photosynth_bot) < photosynth_poplim then

		-- Create new bot if location suitable
				
		--- above empty space 2 blocks and grounded side growth
	if minetest.get_node(randpos_belowthat).name == "air" and
	minetest.get_node(randpos_ranside).name == "default:tree" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_photosynth_bot"})

			minetest.set_node(randpos_below, {name = "default:tree"})
			
		--tree build sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
			
		end
	end
end,
}



----------------------------------------------------------------
--LEAFY REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = tree_leafygrowth,
	chance = 12,
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

		-- Create new bot if location suitable
				
		--- above empty space and grounded side growth
	if minetest.get_node(randpos_below).name == "air" and
	minetest.get_node(randpos_ranside).name == "ecobots:ecobots_photosynth_bot" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_photosynth_bot"})

			
		--tree build sound
			minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
			
		end
	end
end,
}







----------------------------------------------------------------
--ROOT SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = tree_rootgrowth,
	chance = 24,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
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

	


	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
-- do if lit and below pop limit
---high level so shading becomes a factor

if  light_level >= 13 and (num_photosynth_bot) < photosynth_poplim then

				
--- if grounded or a pioneer bot

	if minetest.get_node(randpos_below).name == "default:dirt_with_grass" or minetest.get_node(randpos_below).name == "ecobots:ecobots_bot_dead" then

--- if the side of a tree

	if minetest.get_node(randpos_ranside).name == "default:tree" then


--Create bot and roots

			minetest.set_node(randpos, {name = "ecobots:ecobots_photosynth_bot"})
			minetest.set_node(randpos_below, {name = "default:tree"})

			
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
	action = function(pos)


	--check light level above
		local lightsmother_level = {}
		local lightsmother_level = (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0)

	---get time
		local tod = minetest.get_timeofday()

			if tod > 0.3
			and tod < 0.7 then	

		-- kill if shaded

				if  lightsmother_level < 12 then
		
		--check if got shaded by another photobot or wood
		local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if minetest.get_node(pos_above).name == "ecobots:ecobots_photosynth_bot" or minetest.get_node(pos_above).name == "default:tree" then	

		-- turn to wood
			minetest.set_node(pos, {name = "default:tree"})

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
-- KILL PHOTSYNTH BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_photosynth_bot"},
	interval = 120,
	chance = 1500,
	action = function(pos)
	
		pos = {x = pos.x, y = pos.y, z = pos.z},

			
		-- dig bot 
			
			minetest.dig_node(pos)	
		
end,
}





