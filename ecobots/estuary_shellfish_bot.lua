

----------------------------------------------------------------
--ESTUARY SHELLFISH BOT
-- Grows shellfish in shallow water dirt

----------------------------------------------------------------
--SETTINGS
--sea_growth controls the rate for all sea species

--Grows the coral
local sea_growth = minetest.settings:get('ecobots_sea_growth') or 5

--long distance spread
local seed_spread = sea_growth * 10

----------------------------------------------------------------
--REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish_bot"},
	interval = sea_growth,
	chance = 9,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 2
		local	downradius = 1
		local horizradius = 2

		
	-- population limit within area	
		local poplim = 5
		local poprad = 2
		
	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_estuary_shellfish_bot"})
		num_bot = (cn["ecobots:ecobots_estuary_shellfish_bot"] or 0)
		
	-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}
	
-- for check randpos above is water

	
	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


		
-- do if below pop limit

if (num_bot) < poplim then 


-- do if dirt

if minetest.get_node(randpos).name == "default:dirt" then

--do if below water
				
if minetest.get_node(randpos_above).name == "default:water_source" then

		
-- do if not too deep

if  randpos.y  >= -5 then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_estuary_shellfish_bot"})

--play sound		
		minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})
		
		end
		end
		end
		end		
	end,
}



----------------------------------------------------------------
-- KILL BOT SNOW AND ICE.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish_bot"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local tolerance = 2

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
		
		-- kill			
			minetest.set_node(pos, {name = "default:dirt"})
						
		end
	
end,
}



----------------------------------------------------------------
-- KILL BOT AIR.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish_bot"},
	interval = 5,
	chance = 4,
	catch_up = false,
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
		
		-- kill			
			minetest.set_node(pos, {name = "default:dirt"})
						
		end
	
end,
}



----------------------------------------------------------------
-- KILL BOT DEPTH.

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish_bot"},
	interval = 5,
	chance = 4,
	catch_up = false,
	action = function(pos)
	
	
		if pos.y < -6 then
		
		-- kill			
			minetest.set_node(pos, {name = "default:dirt"})

		--play sound		
			minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,}) 
						
		end
	
end,
}


----------------------------------------------------------------
-- KILL INADAQUATE WATER FLOW

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish_bot"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
		local need = 1

	--count

		local num_good= {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"default:water_source"})
		num_good = (cn["default:water_source"] or 0)
		
			

		if (num_good) < need then
		
		-- kill			
			minetest.set_node(pos, {name = "default:dirt"})
						
		end
	
end,
}




----------------------------------------------------------------
-- KILL BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish_bot"},
	interval = 120,
	chance = 4500,
	catch_up = false,
	action = function(pos)
	
		pos = {x = pos.x, y = pos.y, z = pos.z},

			
		-- kill			
			minetest.set_node(pos, {name = "default:dirt"})

		--play sound		
			minetest.sound_play("ecobots_surf", {pos = pos, gain = 0.6, max_hear_distance = 50,})
		
end,
}


------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish_bot"},
	interval = seed_spread,
	chance = 100,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius
		local upradius = 1
		local downradius = 1
		local horizradius = 15
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos above is water

	
	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


-- do if dirt

if minetest.get_node(randpos).name == "default:dirt" then

--do if below water
				
if minetest.get_node(randpos_above).name == "default:water_source" then

		
-- do if not too deep

if  randpos.y  >= -5 then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_estuary_shellfish_bot"})

--play sound		
		minetest.sound_play("ecobots_surf", {pos = randpos, gain = 0.6, max_hear_distance = 50,})
	
		
		end
		end
		end
end,
}



----------------------------------------------------------------
-- REBURY SHELLFISH... i.e. after the player places it somewhere

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_estuary_shellfish"},
	neighbors = {"group:water"},
	interval = 2,
	chance = 1,
	catch_up = false,
	action = function(pos)
			
		local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}
		if minetest.get_node(pos_below).name == "default:dirt" then	
			minetest.set_node(pos, {name = "air"})
			minetest.set_node(pos_below, {name = "ecobots:ecobots_estuary_shellfish_bot"})
		end
end,
}



