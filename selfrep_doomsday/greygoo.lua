local killrate = minetest.setting_get("selfrep_doomsday_greygoo_killrate") or 30
local growthrate = minetest.setting_get("selfrep_doomsday_greygoo_growthrate") or 1



---------------------------------------------------------
-- PROTECTOR
-- Bot dies instantly if neighbor is a protector

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	neighbors = {"selfrep_doomsday:selfrep_doomsday_protector"},
	interval = 1,
	chance = 1,
	catch_up = true,
	action = function(pos)
				
		-- kill
			
		minetest.set_node(pos, {name = "air"})

		--Play sound
					
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.8, max_hear_distance = 15,})
					
		
end,
}



----------------------------------------------------------------
-- GREY GOO RULE SET

--MAIN RANDOM GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = growthrate,
	chance = 1,
	catch_up = false,
	action = function(pos)


		local radius = 1
		local growthlimitgoo = 3
		local airlimit = 8
		local airradius = 1
		local crowdlimit = 18
		local crowdradius = 2

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
				local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - airradius, y = pos.y - airradius, z = pos.z - airradius},
			{x = pos.x + airradius, y = pos.y + airradius, z = pos.z + airradius}, {"air"})
		num_gooair = (cn["air"] or 0)


--Crowding
	--count dead
		local num_dead = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - crowdradius, y = pos.y - crowdradius, z = pos.z - crowdradius},
			{x = pos.x + crowdradius, y = pos.y + crowdradius, z = pos.z + crowdradius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)





	--Replicate
		
		randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}
		

	if num_goolim < growthlimitgoo and num_dead < crowdlimit then



	--spread to air

		if (num_gooair) > airlimit and minetest.get_node(randpos).name == "air" then
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
		
	end

end,
}


--DETERMINISTIC PLATFORM GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = growthrate,
	chance = 5,
	catch_up = false,
	action = function(pos)


		local radius = 2
		local growthlimitgoo = 5
		local airlimit = 24
		local airradius = 2

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
				local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - airradius, y = pos.y - airradius, z = pos.z - airradius},
			{x = pos.x + airradius, y = pos.y + airradius, z = pos.z + airradius}, {"air"})
		num_gooair = (cn["air"] or 0)


		
	--positions four directions one step up

	plusxpos = {x = pos.x + 1, y = pos.y, z = pos.z}
	negxpos = {x = pos.x - 1, y = pos.y, z = pos.z}
	pluszpos = {x = pos.x, y = pos.y, z = pos.z + 1}
	negzpos = {x = pos.x, y = pos.y, z = pos.z - 1}




		
	--Replicate conditions
	
	if num_goolim < growthlimitgoo and (num_gooair) > airlimit then
			
		--Positive x
 	
		if minetest.get_node(plusxpos).name == "air" then
			minetest.set_node(plusxpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 10,})
		end	
	
		--Negative x
 	
		if minetest.get_node(negxpos).name == "air" then
			minetest.set_node(negxpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 10,})
		end
	
		--Positive z
 	
		if minetest.get_node(pluszpos).name == "air" then
			minetest.set_node(pluszpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 10,})
		end

		--Negative z
 	
		if minetest.get_node(negzpos).name == "air" then
			minetest.set_node(negzpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 10,})
		end


	end
end,
}


----------------------------------------------------------------LIGHT BASED GROWTH FORMS


--LIGHT SPREADING RANDOM GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = growthrate,
	chance = 3,
	catch_up = false,
	action = function(pos)


		local radius = 2
		local growthlimitgoo = 8
		local airlimit = 20
		local airradius = 2

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
				local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - airradius, y = pos.y - airradius, z = pos.z - airradius},
			{x = pos.x + airradius, y = pos.y + airradius, z = pos.z + airradius}, {"air"})
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



-- DARK PILLARS GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	neighbors = {"group:soil", "group:sand", "group:water", "group:stone"},
	interval = growthrate,
	chance = 1,
	catch_up = false,
	action = function(pos)


		local radius = 1
		local growthlimitgoo = 7
		local airlimit = 12
		local airradius = 1
		local crowdlimit = 12
		local crowdradius = 1


	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
				local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - airradius, y = pos.y - airradius, z = pos.z - airradius},
			{x = pos.x + airradius, y = pos.y + airradius, z = pos.z + airradius}, {"air"})
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



--if under pop and crowd limits

	if num_goolim < growthlimitgoo and num_dead < crowdlimit then


--Water growth


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



--Air Growth		
-- do if not well lit 

	if  light_level_ranpos <=7 then	
	
		--spread to air

		if (num_gooair) > airlimit and minetest.get_node(randpos).name == "air" then
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
	end
	
	end
end,
}



----------------------------------------------------------------HEIGHT BASED GROWTH FORMS

-- LOWER TOWERS

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = growthrate,
	chance = 1,
	catch_up = false,
	action = function(pos)


		local radius = 2
		local growthlimitgoo = 5
		local airlimit = 21
		local airradius = 2
		local heightlim = 120
		local crowdlim = 5
		local crowdradius = 2

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
				local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - airradius, y = pos.y - airradius, z = pos.z - airradius},
			{x = pos.x + airradius, y = pos.y + airradius, z = pos.z + airradius}, {"air"})
		num_gooair = (cn["air"] or 0)



--count dead
		local num_dead = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - crowdradius, y = pos.y - crowdradius, z = pos.z - crowdradius},
			{x = pos.x + crowdradius, y = pos.y + crowdradius, z = pos.z + crowdradius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)



		
	-- upwards one step up

	uppos = {x = pos.x, y = pos.y + 1, z = pos.z}
	
		
	--Replicate conditions
	
	if num_goolim < growthlimitgoo and (num_gooair) > airlimit then
			

	if num_dead < crowdlim and pos.y <= heightlim then 

		--Grow up
 	
		if minetest.get_node(uppos).name == "air" then
			
			minetest.set_node(uppos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
		
		end
	end
end,
}



-- X AXIS CANOPY

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = growthrate,
	chance = 1,
	catch_up = false,
	action = function(pos)


		local radius = 1
		local growthlimitgoo = 4
		local airlimit = 16
		local airradius = 1
		local heightlim = 200
		local heightmin = 170
		local crowdlim = 4
		local crowdradius = 1

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
				local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - airradius, y = pos.y - airradius, z = pos.z - airradius},
			{x = pos.x + airradius, y = pos.y + airradius, z = pos.z + airradius}, {"air"})
		num_gooair = (cn["air"] or 0)



--count dead
		local num_dead = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - crowdradius, y = pos.y - crowdradius, z = pos.z - crowdradius},
			{x = pos.x + crowdradius, y = pos.y + crowdradius, z = pos.z + crowdradius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)



		
	-- outwards one step up x axis

	outpos = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z}
	
		
	--Replicate conditions
	
	if num_goolim < growthlimitgoo and (num_gooair) > airlimit then
			

	if num_dead < crowdlim then


	if pos.y >= heightmin and pos.y <= heightlim then 

		--Grow out
 	
		if minetest.get_node(outpos).name == "air" then
			
			minetest.set_node(outpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
		end
		end
	end
end,
}



-- Z AXIS CANOPY

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = growthrate,
	chance = 1,
	catch_up = false,
	action = function(pos)


		local radius = 1
		local growthlimitgoo = 4
		local airlimit = 16
		local airradius = 1
		local heightlim = 170
		local heightmin = 140
		local crowdlim = 4
		local crowdradius = 1



	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
				local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - airradius, y = pos.y - airradius, z = pos.z - airradius},
			{x = pos.x + airradius, y = pos.y + airradius, z = pos.z + airradius}, {"air"})
		num_gooair = (cn["air"] or 0)



--count dead
		local num_dead = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - crowdradius, y = pos.y - crowdradius, z = pos.z - crowdradius},
			{x = pos.x + crowdradius, y = pos.y + crowdradius, z = pos.z + crowdradius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)



		
	-- outwards one step up z axis

	outpos = {x = pos.x, y = pos.y, z = pos.z + math.random(-1,1)}
	
		
	--Replicate conditions
	
	if num_goolim < growthlimitgoo and (num_gooair) > airlimit then
			

	if num_dead < crowdlim then

	if pos.y >= heightmin and pos.y <= heightlim then  

		--Grow out
 	
		if minetest.get_node(outpos).name == "air" then
			
			minetest.set_node(outpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		end	
		end
		end
	end
end,
}


--------------------------------------------------------------
--WATER GROWTH

--DETERMINISTIC WATER GROWTH

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = growthrate,
	chance = 6,
	catch_up = false,
	action = function(pos)


		local radius = 1
		local growthlimitgoo = 4
		local waterradius = 3
		local waterlim = 328

	--count goolim
		local num_goolim = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)



	--count water
		local num_water = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - waterradius, y = pos.y - waterradius, z = pos.z - waterradius},
			{x = pos.x + waterradius, y = pos.y + waterradius, z = pos.z + waterradius}, {"default:water_source"})
		num_water = (cn["default:water_source"] or 0)


	--count riverwater
		local num_river = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - waterradius, y = pos.y - waterradius, z = pos.z - waterradius},
			{x = pos.x + waterradius, y = pos.y + waterradius, z = pos.z + waterradius}, {"default:river_water_source"})
		num_river = (cn["default:river_water_source"] or 0)

	
		
	--positions four directions one step up

	plusxpos = {x = pos.x + 1, y = pos.y, z = pos.z}
	negxpos = {x = pos.x - 1, y = pos.y, z = pos.z}
	pluszpos = {x = pos.x, y = pos.y, z = pos.z + 1}
	negzpos = {x = pos.x, y = pos.y, z = pos.z - 1}

	randside = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}


		
	--Replicate conditions
	
	if num_goolim < growthlimitgoo then

	if num_water > waterlim or num_river > waterlim then


	if minetest.get_node(randside).name == "default:water_source" or minetest.get_node(randside).name == "default:river_water_source" then
			
		--Positive x
		
		minetest.set_node(plusxpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})

		--Negative x

		minetest.set_node(negxpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
				
		--Positive z

		minetest.set_node(pluszpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})

		--Negative z

		minetest.set_node(negzpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})

		minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})

	end
	end
	end
end,
}






--------------------------------------------------------------

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




-- GOO DEATH CHANGE TO GOODIES MESE


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = killrate,
	chance = 8,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		local radius = 1
		local goodykill = 10
		local heightbegin = 200

	--Crowding
	--count dead
		local num_dead = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)


		--kill trapped goodies
			
			
		if (num_dead) > goodykill and pos.y >= heightbegin then
 
			minetest.set_node(pos, {name = "default:stone_with_mese"})
				
		end

end,
}



-- GOO DEATH CHANGE TO GOODIES DIAMOND


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = killrate,
	chance = 6,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		local radius = 1
		local goodykill = 10
		local heightbegin = 100

	--Crowding
	--count dead
		local num_dead = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)


		--kill trapped goodies
			
			
		if (num_dead) > goodykill and pos.y >= heightbegin then
 
			minetest.set_node(pos, {name = "default:stone_with_diamond"})
				
		end

end,
}



-- GOO DEATH CHANGE TO GOODIES GOLD


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = killrate,
	chance = 4,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		local radius = 1
		local goodykill = 10
		local heightbegin = 0

	--Crowding
	--count dead
		local num_dead = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)


		--kill trapped goodies
			
			
		if (num_dead) > goodykill and pos.y >= heightbegin then
 
			minetest.set_node(pos, {name = "default:stone_with_gold"})
				
		end

end,
}



-- GOO DEATH CHANGE TO GOODIES MESELAMP FOR DARK PLACES


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = killrate,
	chance = 19,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		local radius = 1
		local goodykill = 10
		local lightlim = 1

	--Crowding
	--count dead
		local num_dead = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)


	-- for check light level
	 
		local light_level = {}
		local light_level  = ((minetest.get_node_light(pos)) or 0)



		--kill trapped goodies
			
			
		if (num_dead) > goodykill and light_level <= lightlim then
 
			minetest.set_node(pos, {name = "default:meselamp"})
				
		end

end,
}
