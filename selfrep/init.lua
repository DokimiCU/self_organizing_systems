-------------------------------------------------------------
--Do files
-------------------------------------------------------------
dofile(minetest.get_modpath("selfrep").."/nodes.lua")

dofile(minetest.get_modpath("selfrep").."/craft.lua")





------------------------------------------------------------------ABMS
---------------------------------------------------------------


--grow road

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_road"},
	interval = 1.4,
	chance = 1.5,
	action = function(pos)
		local radius = 9
		local num_selfreproads = {}
		local num_deadreproads = {}


		--count live roads
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_road"})
		num_selfreproads = (cn["selfrep:selfrep_road"] or 0)
		
		--count dead roads
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_road_dead"})
		num_deadreproads = (cn["selfrep:selfrep_road_dead"] or 0)
		
		--Crowding
		if (num_selfreproads) > 3 or (num_deadreproads) > 500 			then

			minetest.set_node(pos, {name = "selfrep:selfrep_road_dead"})
			
			else
				pos = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}
				minetest.set_node(pos, {name = "selfrep:selfrep_road"})


		--Check for reproads above
				local num_reproads_above = {}
				
				local ps, cn =
						 minetest.find_nodes_in_area(
						{x = pos.x, y = pos.y + 1, z = pos.z}, {x = pos.x, y = pos.y + 4, z = pos.z}, 								{"selfrep:selfrep_road_dead"})
				num_reproads_above = 			
						(cn["selfrep:selfrep_road_dead"] or 0)

if (num_reproads_above) >= 1 then
	return 
		
--clear space above

	else	
				
				minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = "air"})
				minetest.set_node({x = pos.x, y = pos.y + 2, z = pos.z}, {name = "air"})
				minetest.set_node({x = pos.x, y = pos.y + 3, z = pos.z}, {name = "air"})
				minetest.set_node({x = pos.x, y = pos.y + 4, z = pos.z}, {name = "air"})
					
		end	
				--road build sound
				minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 30,})
			
		end
end,
}






-- Grow tower


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_tower"},
	interval = 2.5,
	chance = 2,
	action = function(pos)
		local radius = 15
		local num_selfreptowers = {}
		local num_deadreproads = {}


		--count live towers
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_tower"})
		num_selfreptowers = (cn["selfrep:selfrep_tower"] or 0)
		
		--count dead roads
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_road_dead"})
		num_deadreproads = (cn["selfrep:selfrep_road_dead"] or 0)
		
		--Crowding
		if (num_selfreptowers) > 3 or (num_deadreproads) > 3000 			then

			minetest.set_node(pos, {name = "selfrep:selfrep_road_dead"})
			
			else 
			
				pos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(0,1), z = pos.z + math.random(-1,1)}
				minetest.set_node(pos, {name = "selfrep:selfrep_tower"})
								
			


				
				--road build sound
				minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
			
		end
end,
}



-- sponge spread


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sponge"},
	--neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos)
		local growthlimitsponge = 500
		
	--count sponges
		local num_sponges = {}
		local radius = 5
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_sponge"})
		num_sponges = (cn["selfrep:selfrep_sponge"] or 0)




		--is player near then build
		local all_objects = minetest.get_objects_inside_radius(pos, 6)
		local players = {}
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
							

	

--Grow is less than limit and player is near
if num_sponges < growthlimitsponge then 

	--expand x positive
		plusxpos = {x = pos.x + 1, y = pos.y, z = pos.z}

		if minetest.get_node(plusxpos).name == "default:water_source" 
		or minetest.get_node(plusxpos).name == "default:river_water_source"  then

			--spread
			minetest.set_node(plusxpos, {name = "selfrep:selfrep_sponge"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end

	--expand x negative
		negxpos = {x = pos.x - 1, y = pos.y, z = pos.z}

		if minetest.get_node(negxpos).name == "default:water_source" 
		or minetest.get_node(negxpos).name == "default:river_water_source"  then

			--spread
			minetest.set_node(negxpos, {name = "selfrep:selfrep_sponge"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end	
	
	--expand y positive
		plusypos = {x = pos.x, y = pos.y + 1, z = pos.z}

		if minetest.get_node(plusypos).name == "default:water_source" 
		or minetest.get_node(plusypos).name == "default:river_water_source"  then

			--spread
			minetest.set_node(plusypos, {name = "selfrep:selfrep_sponge"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end
	
	--expand y neg
		negypos = {x = pos.x, y = pos.y - 1, z = pos.z}

		if minetest.get_node(negypos).name == "default:water_source" 
		or minetest.get_node(negypos).name == "default:river_water_source"  then

			--spread
			minetest.set_node(negypos, {name = "selfrep:selfrep_sponge"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end

	--expand z posit
		pluszpos = {x = pos.x, y = pos.y, z = pos.z + 1}

		if minetest.get_node(pluszpos).name == "default:water_source" 
		or minetest.get_node(pluszpos).name == "default:river_water_source"  then

			--spread
			minetest.set_node(pluszpos, {name = "selfrep:selfrep_sponge"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end

	--expand z neg
		negzpos = {x = pos.x, y = pos.y, z = pos.z - 1}

		if minetest.get_node(negzpos).name == "default:water_source" 
		or minetest.get_node(negzpos).name == "default:river_water_source"  then

			--spread
			minetest.set_node(negzpos, {name = "selfrep:selfrep_sponge"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end
	end
end
end

--is player near then space
		local all_objects = minetest.get_objects_inside_radius(pos, 3)
		local players = {}
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
			minetest.set_node(negzpos, {name = "air"})
			end
		end

end,
}




