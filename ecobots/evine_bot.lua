evine = {}


----------------------------------------------------------------
--EVINE BOT RULES
-- a climbing vine, which can evolve
----------------------------------------------------------------
--EVOLUTIONARY TRADE OFFS
--Low values favour an r strategy, high value a K strategy
-- i.e live fast die young vs live slow die old. 

--SETTINGS
local rate = minetest.settings:get('ecobots_evolve_growth') or 18




--point where shaded to death
local min_light = 11

--how much light it needs to grow
local light_needs = 12

----------------------------------------------------------------
-- SPREADING REPLICATION
-- grows out over soil or up something

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = rate,
	chance = 6,
	catch_up = false,
	action = function(pos)

	-- timer, interval has to be controlled by the genome not the ABM.
		local timer = 0
		minetest.register_globalstep(function(dtime)
		timer = timer + dtime;
		local time_to_go = evine.activate_genome(pos)
		local time_limit = time_to_go + 1
			if timer > time_to_go and timer < time_limit  then


	
	--dispersal radius up and horizontal
		local upradius = 1
		local horizradius = 1

		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 6
		local poprad = 2
		

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_evine_bot"})
		num_bot = (cn["ecobots:ecobots_evine_bot"] or 0)
		

	
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-upradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check of positions

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_side = {x = randpos.x + math.random(-1,1), y = randpos.y, z = randpos.z + math.random(-1,1)}


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


	if  light_level >= light_needs and light_level_ranpos >= light_needs  then


-- do if above soil or attached
	if minetest.get_item_group(newplace_below.name, "soil") == 1 or minetest.get_node(randpos_side).name ~= "air" then



--is it empty space?

	if minetest.get_node(randpos).name == "air" then


	
--get genome and create bot 
		local g = evine.retain_genome (pos)

		minetest.set_node(randpos, {name = "ecobots:ecobots_evine_bot"})

-- transfer the genome
		evine.retain_genome_2 (randpos, g)

--stop timer
		timer = time_limit
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
	end
	end	
	end
	end
	end
	end)
end,
}


----------------------------------------------------------------
-- HANGING REPLICATION
-- grows down if suspended

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = rate,
	chance = 6,
	catch_up = false,
	action = function(pos)
	
-- timer, interval has to be controlled by the genome not the ABM.
		local timer = 0
		minetest.register_globalstep(function(dtime)
		timer = timer + dtime;
		local time_to_go = evine.activate_genome(pos)
		local time_limit = time_to_go + 1
			if timer > time_to_go and timer < time_limit  then



		
	-- population limit within area	
	--- stability occurs at radius x 3 -1. r x3 allows growth.
		local poplim = 6
		local poprad = 2
		

	--count bots

		local num_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - poprad, y = pos.y - poprad, z = pos.z - poprad},
			{x = pos.x + poprad, y = pos.y + poprad, z = pos.z + poprad}, {"ecobots:ecobots_evine_bot"})
		num_bot = (cn["ecobots:ecobots_evine_bot"] or 0)
		

		

-- get position below for new bot

	local newpos = {x = pos.x, y = pos.y - 1, z = pos.z}


-- for check light for parent and child positions

	local pos_side = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

	local newpos_side = {x = newpos.x + math.random(-1,1), y = newpos.y + math.random(-1,1), z = newpos.z + math.random(-1,1)}

	

	-- for check light level at a some side of parent
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light(pos_side)) or 0)

	-- for check light level at some side of destination
	 
		local light_level_newpos = {}
		local light_level_newpos  = ((minetest.get_node_light(newpos_side)) or 0)




-- do if below pop limits and position is empty

	if (num_bot) < poplim then


-- do if well lit


	if  light_level >= light_needs and light_level_newpos >= light_needs  then


-- do if above air

	if minetest.get_node(newpos).name == "air" then

	

--get genome and create bot 
		local g = evine.retain_genome (pos)

		minetest.set_node(newpos, {name = "ecobots:ecobots_evine_bot"})

-- transfer the genome
		evine.retain_genome_2 (newpos, g)

	--stop timer
		timer = time_limit

			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
	end
	end
	end
	end
	end)
end,
}





----------------------------------------------------------------
-- KILL BOT SHADE


minetest.register_abm{
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)


	--check light level above
		local lightsmother_level = {}
		local lightsmother_level = (minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z}) or 0)



	---get time
		local tod = minetest.get_timeofday()

		if tod > 0.3 and tod < 0.7 then	

		-- kill if shaded

		if  lightsmother_level < min_light then

		-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
		end
end,
}



----------------------------------------------------------------
-- KILL BOT SEAWATER gives tolerance for salt water

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_evine_bot"},
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
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)
	
	-- to kill if within radius
		local radius = 1


	--count seawater

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
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
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
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)
	
	-- to kill if within radius and more than tolerance
		local radius = 1
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
-- LIFESPAN

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = rate,
	chance = 40,
	catch_up = false,
	action = function(pos)

-- timer, interval has to be controlled by the genome not the ABM.
		local timer = 0
		minetest.register_globalstep(function(dtime)
		timer = timer + dtime;
		local time_to_go = evine.activate_genome(pos) * 100
		local time_limit = time_to_go + 1
			if timer > time_to_go and timer < time_limit  then


	
		pos = {x = pos.x, y = pos.y, z = pos.z},

			
		-- kill bot
		-- dig so it causes major damage, the vine actually dies. 
			
			minetest.dig_node(pos)
			
		
		--stop timer
		timer = time_limit
	end
	end)	
end,
}


------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_evine_bot"},
	interval = rate,
	chance = 100,
	catch_up = false,
	action = function(pos)


-- timer, interval has to be controlled by the genome not the ABM.
		local timer = 0
		minetest.register_globalstep(function(dtime)
		timer = timer + dtime;
		local time_to_go = evine.activate_genome(pos) * 10
		local time_limit = time_to_go + 1
			if timer > time_to_go and timer < time_limit  then

	
	--dispersal radius
		local upradius = 10
		local downradius = 10
		local horizradius = 10
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos below is soil or a side is a tree

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}


	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}


	local randpos_side = {x = randpos.x + math.random(-1,1), y = randpos.y, z = randpos.z + math.random(-1,1)}


--name for new node below for substrate check

	local newplace_below = minetest.get_node(randpos_below)
	local newplace_side = minetest.get_node(randpos_side)


	

	-- for check light level above
	 
		local light_level = {}
		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y + 1, z = pos.z})) or 0)

	-- for check light level above destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos_above)) or 0)


		
-- do if well lit

if  light_level >= 14 and light_level_ranpos >= 14  then




-- do if empty and above soil or side is tree
				
if minetest.get_item_group(newplace_below.name, "soil") == 1 or minetest.get_item_group(newplace_side.name, "tree") == 1 then


-- do if empty
 
if minetest.get_node(randpos).name == "air" then


--get genome and create bot 
		local g = evine.retain_genome (pos)

		minetest.set_node(randpos, {name = "ecobots:ecobots_evine_bot"})

-- transfer the genome
		evine.retain_genome_2 (randpos, g)

	--stop timer
		timer = time_limit

	
			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})

			
--tree growth sound
		minetest.sound_play("ecobots_wind", {pos = pos, gain = 0.7, max_hear_distance = 30,})
		
		end
		end
		end
		end
		end)
end,
}



------------------------------------------------------------------ FUNCTIONS FOR EVOLUTION

--TRANSFER GENOME WHEN CREATING NEW BOT
-- read the metadata

evine.retain_genome = function(pos)


  local meta = minetest.get_meta(pos)

  local g = {}
  g.grow_vs_age = meta:get_float("grow_vs_age")
  return g

end


--SECOND STEP OF RETAIN GENOME...
--put the metadata into new bot, with mutation. 

evine.retain_genome_2 = function(pos, genome_table)

  
  local g = genome_table
  

  local meta = minetest.get_meta(pos)

  meta:set_float("grow_vs_age", g.grow_vs_age + math.random(- 0.5, 0.5))

  local grow_vs_age_list_value = meta:get_float("grow_vs_age")
  meta:set_string("formspec",
    "size[10,10]"..
			"button[6,6;3,1;set_default_genome;Set Default Genome]"..
			"button[1,6;3,1;set_random_genome;Set Random Genome]"..
			"button_exit[3.5,4.5;3,1;exit_form;Exit]"..
			"label[2,1;Growth vs Lifespan]"..
			"label[2,3;Lower values live fast and die young]"..
						"textlist[2,2;2,1;grow_vs_age_list;"..grow_vs_age_list_value.."]"	
    
  )

end


--ACTIVATE GENE
evine.activate_genome = function(pos)
  local meta = minetest.get_meta(pos)
  local grow_vs_age = meta:get_float("grow_vs_age")
    return grow_vs_age

end


