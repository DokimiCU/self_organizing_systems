
-------------------------------------------------------------
--Dome
----------------------------------------------------------



-- dome spread


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_dome"},
	interval = 1,
	chance = 1,
	action = function(pos)

	


		local growthlimitdome = 460

		local grow_radius = 5
		
	--count domes
		local num_domes = {}
		local radius = 5
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_dome"})
		num_domes = (cn["selfrep:selfrep_dome"] or 0)




		--is player near then build
		local all_objects = minetest.get_objects_inside_radius(pos, grow_radius)
		local players = {}
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
							

--directions
plusxpos = {x = pos.x + 1, y = pos.y, z = pos.z}
negxpos = {x = pos.x - 1, y = pos.y, z = pos.z}
plusypos = {x = pos.x, y = pos.y + 1, z = pos.z}
negypos = {x = pos.x, y = pos.y -1, z = pos.z}
pluszpos = {x = pos.x, y = pos.y, z = pos.z + 1}
negzpos = {x = pos.x, y = pos.y, z = pos.z - 1}


--Grow is less than limit and player is near
	if num_domes < growthlimitdome then 

		if minetest.get_node(plusxpos).name == "air" then
			--spread
			minetest.set_node(plusxpos, {name = "selfrep:selfrep_dome"})		
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end
	
		if minetest.get_node(negxpos).name == "air" then
			--spread
			minetest.set_node(negxpos, {name = "selfrep:selfrep_dome"})	
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end
			
		if minetest.get_node(plusypos).name == "air" then
			--spread
			minetest.set_node(plusypos, {name = "selfrep:selfrep_dome"})		
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end
	
		if minetest.get_node(negypos).name == "air" then
			--spread
			minetest.set_node(negypos, {name = "selfrep:selfrep_dome"})	
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end

		if minetest.get_node(pluszpos).name == "air" then
			--spread
			minetest.set_node(pluszpos, {name = "selfrep:selfrep_dome"})	
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			end


		if minetest.get_node(negzpos).name == "air" then
			--spread
			minetest.set_node(negzpos, {name = "selfrep:selfrep_dome"})		
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 8,})
			end

	end

	end
	end

end,
}


--REMOVE NEAR PLAYER

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_dome"},
	interval = 1,
	chance = 1,
	action = function(pos)
		
	--space around player
		local radius = 4

--is player near then space

		local all_objects = 				minetest.get_objects_inside_radius(pos, radius)
		local players = {}
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
			minetest.set_node(pos, {name = "selfrep:selfrep_dome_gas"})
			end
		end



end,
}


--- KILL dome


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_dome"},
	interval = 42,
	chance = 1,
	catch_up = false, 
	action = function(pos)

		minetest.set_node(pos, {name = "selfrep:selfrep_road_dead"})
	end,
}


--- KILL dome TO glass


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_dome"},
	interval = 42,
	chance = 5,
	catch_up = false,
	action = function(pos)

		minetest.set_node(pos, {name = "default:glass"})
	end,
}


--- KILL dome TO LIGHT


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_dome"},
	interval = 42,
	chance = 30,
	catch_up = false,
	action = function(pos)

		minetest.set_node(pos, {name = "default:meselamp"})
	end,
}




--- KILL gass back to air


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_dome_gas"},
	interval = 120,
	chance = 2,
	catch_up = false,
	action = function(pos)

		minetest.set_node(pos, {name = "air"})
	end,
}

