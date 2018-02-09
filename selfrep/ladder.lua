------------------------------------------------------------------ladder
--------------------------------------------------------------




-- Grow ladder up

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_ladder"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
		
		

	--positions
		
		randpos = {x = pos.x, y = pos.y +1, z = pos.z}
		
		
				
	--conditions
		if minetest.get_node(randpos).name == "air" then 

   		
			minetest.set_node(randpos, {name = "selfrep:selfrep_ladder"})
			
				
		--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})


			end
end,
}


-- Grow ladder down

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_ladder"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
		
		

	--positions
		
		randpos_2 = {x = pos.x, y = pos.y -1, z = pos.z}

		
		--grow down

	if minetest.get_node(randpos_2).name == "air" then 

   		
			minetest.set_node(randpos_2, {name = "selfrep:selfrep_ladder"})
			
				
		--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
		
		end
end,
}



