

----------------------------------------------------------------
--CORAL BOT
-- A shallow water coral.
-- Death chain... live to brown to skeleton to (slowly) gravel
----------------------------------------------------------------
--SETTINGS
--sea_growth controls the rate for all sea species

--Grows the coral
local coral_growth = minetest.settings:get('sea_growth')

--long distance spread
local seed_spread = coral_growth * 10

----------------------------------------------------------------
--REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = coral_growth,
	chance = 8,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- population limit within area	
		local poplim = 7
		local poprad = 2
		
	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_coral_bot"})
		num_bot = (cn["ecobots:ecobots_coral_bot"] or 0)
		

		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius, upradius), z = pos.z + math.random(-horizradius,horizradius)}

-- for check randpos surrounds

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}
	
	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y + math.random(-1,1), z = randpos.z + math.random(-1,1)}




	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
-- do if below pop limit

	if (num_bot) < poplim then 

---high level so shading becomes a factor
	if  light_level >= 9 then

-- space is empty ocean water with water above
	if minetest.get_node(randpos).name == "default:water_source" and minetest.get_node(randpos_above).name == "default:water_source" then
					

-- grounded side growth
	if minetest.get_node(randpos_ranside).name == "ecobots:ecobots_coral_bot" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_coral_bot"})

		--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})	
		
	end
	end		
	end
	end
end,
}







----------------------------------------------------------------
-- KILL BOT SHADE

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos)


	--check light level above
		local lightsmother_level = {}
		local lightsmother_level = (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0)



	--- don't do at night
		local tod = minetest.get_timeofday()

		if tod > 0.3 and tod < 0.7 then	

	-- do if shaded

		if  lightsmother_level < 10 then
		
	

	-- bot begins dying process			
			minetest.set_node(pos, {name = "default:coral_brown"})

	--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})
	
	end
	end				
end,
}


------------------------------------------------------------------DECAY PROCESS...BROWN CORAL DEATH TO SKELE



minetest.register_abm{
     	nodenames = {"default:coral_brown"},
	interval = 10,
	chance = 10,
	catch_up = false,
	action = function(pos)

	-- population limit within area	
		local poplim = 2
		local poprad = 1
		
	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"default:coral_brown"})
		num_bot = (cn["default:coral_brown"] or 0)
	


	--if a lot is around let it decay
		if (num_bot) > poplim then 
		
	

	-- bot fully dies			
			minetest.set_node(pos, {name = "default:coral_skeleton"})

		--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})
	
	end				
end,
}


------------------------------------------------------------------DECAY PROCESS... SKELE ERODES TO GRAVEL



minetest.register_abm{
     	nodenames = {"default:coral_skeleton"},
	interval = 40,
	chance = 500,
	catch_up = false,
	action = function(pos)

	-- population limit within area	
		local poplim = 15
		local poprad = 1
		
	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"default:coral_skeleton"})
		num_bot = (cn["default:coral_skeleton"] or 0)
	


	--if a lot is around let it decay
		if (num_bot) > poplim then 
		
	

	-- bot fully dies			
			minetest.set_node(pos, {name = "default:gravel"})

	--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})
	
	end				
end,
}




----------------------------------------------------------------
-- KILL BOT Fresh WATER.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius
		local radius = 3


	--count water

		local num_water= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:river_water_source"})
		num_water = (cn["default:river_water_source"] or 0)
		

		

		if (num_water) > 1 then
		
		-- bot begins dying process			
			minetest.set_node(pos, {name = "default:coral_brown"})
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT SNOW AND ICE.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 6
		local tolerance = 1

	--count ice

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:ice"})
		num_bad1 = (cn["default:ice"] or 0)
		
	--count snow blocks

		local num_bad2= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:snowblock"})
		num_bad2 = (cn["default:snowblock"] or 0)
		

		if (num_bad1) > tolerance or (num_bad2) > tolerance  then
		
		-- bot begins dying process			
			minetest.set_node(pos, {name = "default:coral_brown"})
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL BOT DIRTY i.e. muddy bottom, water clarity

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 4
		local tolerance = 1

	--count dirt

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:dirt"})
		num_bad1 = (cn["default:dirt"] or 0)
		
			

		if (num_bad1) > tolerance then
		
		-- bot begins dying process			
			minetest.set_node(pos, {name = "default:coral_brown"})
						
		end
	
end,
}



----------------------------------------------------------------
-- KILL BOT AIR.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = 3,
	chance = 1.5,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local tolerance = 1

	--count

		local num_bad1= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"air"})
		num_bad1 = (cn["air"] or 0)
		
			

		if (num_bad1) > tolerance then
		
		-- kill instantly			
			minetest.set_node(pos, {name = "default:coral_skeleton"})

						
		end
	
end,
}


----------------------------------------------------------------
-- KILL INADAQUATE WATER FLOW

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = 1,
	chance = 1,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local need = 2

	--count

		local num_good= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:water_source"})
		num_good = (cn["default:water_source"] or 0)
		
			

		if (num_good) < need then
		
		-- bot begins dying process			
			minetest.set_node(pos, {name = "default:coral_brown"})
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL OPEN OCEAN
--to stop from overgrowing the whole ocean

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot", "default:coral_skeleton"},
	interval = 10,
	chance = 2,
	action = function(pos)
	
		--ocean below	
		local pos_deep = {x = pos.x, y = pos.y - 7, z = pos.z}


		if minetest.get_node(pos_deep).name == "default:water_source" then
		
		-- remove... dig so like rough waves damaging it			
			minetest.dig_node(pos)

		--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})
						
		end
	
end,
}




----------------------------------------------------------------
-- KILL BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = 120,
	chance = 4500,
	catch_up = false,
	action = function(pos)
	
			
		-- bot begins dying process			
			minetest.set_node(pos, {name = "default:coral_brown"})

		--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.8, max_hear_distance = 50,})
		
end,
}


----------------------------------------------------------------
-- REMOVE DEAD RANDOMLY to create space
--without this the reef may reach its limits and clog up with dead skeletons

minetest.register_abm{
     	nodenames = {"default:coral_skeleton"},
	interval = 120,
	chance = 5500,
	catch_up = false,
	action = function(pos)
	

		-- to kill if within radius and more than need
		local radius = 1
		local need = 3

		--count
		local num_good= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:water_source"})
		num_good = (cn["default:water_source"] or 0)
	
		if (num_good) > need then
			
		-- remove			
			minetest.set_node(pos, {name = "air"})

		--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})

		end
		
end,
}


----------------------------------------------------------------
-- RECOVERY CHANCE 
--without this the reef may reach its limits and clog up with dead skeletons

minetest.register_abm{
     	nodenames = {"default:coral_skeleton"},
	interval = 120,
	chance = 5500,
	catch_up = false,
	action = function(pos)
	
		-- to kill if within radius and more than need
		local radius = 1
		local need = 3

		--count
		local num_good= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:water_source"})
		num_good = (cn["default:water_source"] or 0)
	
		if (num_good) > need then
			
		-- remove			
			minetest.set_node(pos, {name = "ecobots:ecobots_coral_bot"})

		--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})

		end	
end,
}


------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_coral_bot"},
	interval = seed_spread,
	chance = 100,
	action = function(pos)
	
	--dispersal radius
		local upradius = 0
		local downradius = 0
		local horizradius = 80
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos is below is sand and above is water

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light level above destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos_above)) or 0)


		
-- do if well lit

if  light_level >= 12 and light_level_ranpos >= 12  then



-- do if empty

if minetest.get_node(randpos).name == "default:water_source" then



--do if above sand
				
if minetest.get_node(randpos_below).name == "default:sand" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_coral_bot"})

		--play sound		
		minetest.sound_play("ecobots_surf", {pos = randpos, gain = 0.6, max_hear_distance = 50,})
		
		end
		end
		end
end,
}




