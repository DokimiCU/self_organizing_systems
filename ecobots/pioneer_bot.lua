

----------------------------------------------------------------
--PIONEER BOT RULES
----------------------------------------------------------------


----------------------------------------------------------------
-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_pioneer_bot"},
	interval = 3,
	chance = 3,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
		local horizradius_ph = 2

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local pioneer_poplim = 11
		local pioneer_poprad = 4
		

	--count pioneer bots

		local num_pioneer_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - pioneer_poprad, y = pos.y - pioneer_poprad, z = pos.z - pioneer_poprad},
			{x = pos.x + pioneer_poprad, y = pos.y + pioneer_poprad, z = pos.z + pioneer_poprad}, {"ecobots:ecobots_pioneer_bot"})
		num_pioneer_bot = (cn["ecobots:ecobots_pioneer_bot"] or 0)
		

	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph,upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}


-- for check randpos is below is dirt not another pioneer and above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


	


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
-- do if well lit and on ground


if  light_level >= 14 and minetest.get_node(randpos_below).name ~= "air" then

-- do if below pop limits and position is empty

if (num_pioneer_bot) < pioneer_poplim and minetest.get_node(randpos).name == "air" then

-- Create new bot if location doesn't have an older bot below
				
	if minetest.get_node(randpos_below).name ~= "ecobots:ecobots_pioneer_bot" and  minetest.get_node(randpos_above).name == "air" then
	


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_pioneer_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
			
		end
		end
	end
end,
}



----------------------------------------------------------------
-- VERTICAL REPLICATION rare
--- the idea is to help them build soil and self shade

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_pioneer_bot"},
	interval = 5,
	chance = 60,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_ph = 1
		local horizradius_ph = 2

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local pioneer_poplim = 11
		local pioneer_poprad = 4
		

	--count pioneer bots

		local num_pioneer_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - pioneer_poprad, y = pos.y - pioneer_poprad, z = pos.z - pioneer_poprad},
			{x = pos.x + pioneer_poprad, y = pos.y + pioneer_poprad, z = pos.z + pioneer_poprad}, {"ecobots:ecobots_pioneer_bot"})
		num_pioneer_bot = (cn["ecobots:ecobots_pioneer_bot"] or 0)
		

	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ph,horizradius_ph), y = pos.y + math.random(-upradius_ph,upradius_ph), z = pos.z + math.random(-horizradius_ph,horizradius_ph)}


-- for check randpos is below is another pioneer and above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


	


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
-- do if well lit and on ground


if  light_level >= 14 and minetest.get_node(randpos_below).name ~= "air" then

-- do if below pop limits and position is empty

if (num_pioneer_bot) < pioneer_poplim and minetest.get_node(randpos).name == "air" then

-- Create new bot if location does have an older bot below
				
	if minetest.get_node(randpos_below).name == "ecobots:ecobots_pioneer_bot" and  minetest.get_node(randpos_above).name == "air" then
	


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_pioneer_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
			
		end
		end
	end
end,
}



----------------------------------------------------------------
-- KILL PIONEER BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_pioneer_bot"},
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

		-- kill if shaded very sensitive to shade

				if  lightsmother_level < 15 then
		
				-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	end
end,
}






