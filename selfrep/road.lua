
----------------------------------------------------------------
--ROAD
--------------------------------------------------------------


--GROW road random

--grow road

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_road"},
	interval = 1,
	chance = 1,
	action = function(pos)
		local radius = 8
		local num_selfreproads = {}
		local num_deadreproads = {}


		--count live roads
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_road"})
		num_selfreproads = (cn["selfrep:selfrep_road"] or 0)
		
		--positions
		randpos = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}
	
				
		--Conditions

		if (num_selfreproads) > 3	then

			minetest.set_node(pos, {name = "selfrep:selfrep_road_dead"})
			
			else
			minetest.set_node(randpos, {name = "selfrep:selfrep_road"})

			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})


		end		
end,
}






--DIG ABOVE

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_road"},
	interval = 1,
	chance = 1,
	action = function(pos)
		
		--positions

		local above1 = {x = pos.x, y = pos.y + 1, z = pos.z}
		local above2 = {x = pos.x, y = pos.y + 2, z = pos.z}
		local above3 = {x = pos.x, y = pos.y + 3, z = pos.z}



	if minetest.get_node(above1).name ~= "air" or minetest.get_node(above2).name ~= "air" then

		minetest.dig_node(above1)
		minetest.dig_node(above2)
		minetest.dig_node(above3)
	end

end,
}



--FILLERS

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_road"},
	interval = 1,
	chance = 1,
	action = function(pos)
		
		--positions

		local randside = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}
		
		--conditions

		
		if minetest.get_node(randside).name ~= "selfrep:selfrep_road" or minetest.get_node(randside).name ~= "selfrep:selfrep_road_dead" then

		minetest.set_node(randside, {name = "selfrep:selfrep_road_dead"})

		--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})

		
		end
end,
}



--FILLERS LIGHT

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_road"},
	interval = 2,
	chance = 40,
	action = function(pos)
		
		--positions

		local randside = {x = pos.x + math.random(-1,1), y = pos.y, z = pos.z + math.random(-1,1)}

		--conditions

		if minetest.get_node(randside).name == "air" then

		
		minetest.set_node(randside, {name = "default:meselamp"})

		--road build sound
		minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})


		
		end
end,
}


