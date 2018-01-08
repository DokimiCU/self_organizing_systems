

----------------------------------------------------------------
--CAVE SLIME BOT
-- Lives in dark wet stone.
----------------------------------------------------------------
--SETTINGS
--cave_growth controls the rate for all cave species

--Grows the cave
local cave_growth = minetest.settings:get('ecobots_cave_growth') or 5

local cave_death = cave_growth * 100

----------------------------------------------------------------
--REPLICATION


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_cave_slime_bot"},
	interval = cave_growth,
	chance = 8,
	catch_up = false,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- population limit within area	
		local poplim = 6
		local poprad = 2
		
	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_cave_slime_bot"})
		num_bot = (cn["ecobots:ecobots_cave_slime_bot"] or 0)
		

		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius, upradius), z = pos.z + math.random(-horizradius,horizradius)}

-- for check randpos surrounds

	local randpos_ranside = {x = randpos.x + math.random(-1,1), y = randpos.y + math.random(-1,1), z = randpos.z + math.random(-1,1)}
	


--name for new node below for substrate check

	local newplace = minetest.get_node(randpos)


	--check light level above
	
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	

		
-- do if below pop limit

	if (num_bot) < poplim then 

---do if dark 
	if  light_level <= 9 then

-- space is stone or dead
	if minetest.get_item_group(newplace.name, "stone") == 1 or minetest.get_node(randpos).name == "ecobots:ecobots_bot_dead" then

--water on a side
	if minetest.get_node(randpos_ranside).name == "default:water_source" or minetest.get_node(randpos_ranside).name == "default:river_water_source" then
					

			minetest.set_node(randpos, {name = "ecobots:ecobots_cave_slime_bot"})

		--play sound		
		minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.6, max_hear_distance = 50,})	
		
	end
	end		
	end
	end
end,
}







----------------------------------------------------------------
-- KILL BOT SUN

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_cave_slime_bot"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos)


	--check light level above
		local lightsmother_level = {}
		local lightsmother_level = (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0)



	
	-- do if sunny

		if  lightsmother_level > 9 then
		
	

	-- bot dies	
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})

	--play sound		
		minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.6, max_hear_distance = 50,})
	
	
	end				
end,
}





----------------------------------------------------------------
-- KILL BOT RANDOMLY to add dynamism

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_cave_slime_bot"},
	interval = cave_death,
	chance = 500,
	catch_up = false,
	action = function(pos)
	
			
		-- bot dies			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})

		--play sound		
		minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.6, max_hear_distance = 50,})

		
end,
}



