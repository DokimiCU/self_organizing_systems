------------------------------------------------------------------TOWER
--------------------------------------------------------------



-- Grow tower random


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_tower"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)
		

		local radius = 6
		local poplim = 3
		

		--count live towers

		local num_selfreptowers = {}

		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_tower"})
		num_selfreptowers = (cn["selfrep:selfrep_tower"] or 0)


	--positions
		
		randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(0,1), z = pos.z + math.random(-1,1)}
		
				
	--conditions
		if (num_selfreptowers) < poplim and     minetest.get_node(randpos).name == "air" then

			minetest.set_node(randpos, {name = "selfrep:selfrep_tower"})
			
				
		--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
			
		end
end,
}


-- Grow tower up


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_tower"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
		

		local radius = 5
		local poplim = 3
		local crowdlim = 4
		local crowdradius = 2


		--count live towers

		local num_selfreptowers = {}

		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_tower"})
		num_selfreptowers = (cn["selfrep:selfrep_tower"] or 0)


		--count dead

		local num_dead = {}

		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - crowdradius, y = pos.y - crowdradius, z = pos.z - crowdradius},
			{x = pos.x + crowdradius, y = pos.y + crowdradius, z = pos.z + crowdradius}, {"selfrep:selfrep_tower"})
		num_dead = (cn["selfrep:selfrep_road_dead"] or 0)


	--positions
		
		randpos = {x = pos.x, y = pos.y +1, z = pos.z}
		
				
	--conditions
		if (num_selfreptowers) < poplim and (num_dead) < crowdlim then 


   		if minetest.get_node(randpos).name == "air" then

			minetest.set_node(randpos, {name = "selfrep:selfrep_tower"})
			
				
		--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
		end	
		end
end,
}





--- BULK TOWER

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_tower"},
	interval = 1,
	chance = 2,
	action = function(pos)
		

		randside = {x = pos.x + math.random(-1,1), y = pos.y - 1, z = pos.z + math.random(-1,1)}


				
	--conditions
		if minetest.get_node(randside).name == "air" or minetest.get_node(randside).name == "selfrep:selfrep_tower" then

			minetest.set_node(randside, {name = "selfrep:selfrep_road_dead"})
					
		end
end,
}





--- KILL TOWER TO LIGHT


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_tower"},
	interval = 15,
	chance = 25,
	catch_up = false,
	action = function(pos)

		minetest.set_node(pos, {name = "default:meselamp"})
	end,
}



