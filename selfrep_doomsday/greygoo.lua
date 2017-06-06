local killrate = minetest.setting_get("greygoo_killrate")



----------------------------------------------------------------
-- GREY GOO RULE SET
--MAIN RANDOM GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = 1.5,
	chance = 1,
	catch_up = false,
	action = function(pos)


		local radius = 1
		local growthlimitgoo = 3
		local airlimit = 15

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
		local radius = 1
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"air"})
		num_gooair = (cn["air"] or 0)



	--Replicate
		
		randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}
		

	if num_goolim < growthlimitgoo then

		--spread to air
		if (num_gooair) > airlimit and minetest.get_node(randpos).name == "air" then
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
			
	end
	
--Crowding
	--count dead
		local num_dead = {}
		local radius = 1
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)



		--kill trapped goodies
		if (num_dead) > 10 then
			minetest.set_node(pos, {name = "default:stone_with_mese"})
		
	
		end



end,
}



--LIGHT SPREADING RANDOM GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = 1,
	chance = 3,
	catch_up = false,
	action = function(pos)


		local radius = 2
		local growthlimitgoo = 8
		local airlimit = 10

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
		local radius = 1
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"air"})
		num_gooair = (cn["air"] or 0)



	-- for Replicate sideways
		
		randpos = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}


	-- for check light level at destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos)) or 0)


		
-- do if well lit

	if  light_level_ranpos >=14 then

		

	if num_goolim < growthlimitgoo then

		--spread to air
		if (num_gooair) > airlimit and minetest.get_node(randpos).name == "air" then
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
			
	end
	end
end,
}



--PILLARS GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	neighbors = {"group:soil", "group:sand", "group:water", "group:stone"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)


		local radius = 2
		local growthlimitgoo = 6
		local airlimit = 10
		local crowdlimit = 10
		local crowdradius = 1


	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
		local radius = 1
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"air"})
		num_gooair = (cn["air"] or 0)


	--Crowding
	--count dead
		local num_dead = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - crowdradius, y = pos.y - crowdradius, z = pos.z - crowdradius},
			{x = pos.x + crowdradius, y = pos.y + crowdradius, z = pos.z + crowdradius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)



	-- for Replicate up or down
		
		randpos = {x = pos.x, y = pos.y + math.random(-1,1), z = pos.z}


-- for check light level at destination
	 
		local light_level_ranpos = {}
		local light_level_ranpos  = ((minetest.get_node_light(randpos)) or 0)


		
-- do if not well lit 
	if  light_level_ranpos <=13 then

		
	--if under pop and crowd limits

	if num_goolim < growthlimitgoo and num_dead < crowdlimit then

		--spread to air

		if (num_gooair) > airlimit and minetest.get_node(randpos).name == "air" then
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
		
		--spread to ocean

		if minetest.get_node(randpos).name == "default:water_source" then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end

		--spread to river

		if minetest.get_node(randpos).name == "default:river_water_source" then
			
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end

	end	
	end
end,
}



--GOO DEATH AND CHANGE TO ROAD

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = killrate,
	chance = 1,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
			
		-- make goo a road
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_road_dead"})
	
end,
}




		

