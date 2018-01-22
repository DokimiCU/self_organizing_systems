
-------------------------------------------------------------
--platform
----------------------------------------------------------



-- platform spread


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_platform"},
	interval = 1,
	chance = 1,
	action = function(pos)

		local grow_radius = 4

		--is player near then build
		local all_objects = minetest.get_objects_inside_radius(pos, grow_radius)
		local players = {}
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
							

--directions
plusxpos = {x = pos.x + 1, y = pos.y, z = pos.z}
negxpos = {x = pos.x - 1, y = pos.y, z = pos.z}
pluszpos = {x = pos.x, y = pos.y, z = pos.z + 1}
negzpos = {x = pos.x, y = pos.y, z = pos.z - 1}


--Replicate

		if minetest.get_node(plusxpos).name == "air" then
			--spread
			minetest.set_node(plusxpos, {name = "selfrep:selfrep_platform"})		
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end
	
		if minetest.get_node(negxpos).name == "air" then
			--spread
			minetest.set_node(negxpos, {name = "selfrep:selfrep_platform"})	
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end
			
		
		if minetest.get_node(pluszpos).name == "air" then
			--spread
			minetest.set_node(pluszpos, {name = "selfrep:selfrep_platform"})	
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end


		if minetest.get_node(negzpos).name == "air" then
			--spread
			minetest.set_node(negzpos, {name = "selfrep:selfrep_platform"})		
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 8,})
			end

	
	end
	end

end,
}




--- KILL platform


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_platform"},
	interval = 18,
	chance = 1,
	catch_up = false, 
	action = function(pos)

		minetest.set_node(pos, {name = "selfrep:selfrep_road_dead"})
	end,
}




--- KILL platform TO LIGHT


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_platform"},
	interval = 18,
	chance = 30,
	catch_up = false,
	action = function(pos)

		minetest.set_node(pos, {name = "default:meselamp"})
	end,
}




