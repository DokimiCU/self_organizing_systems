
------------------------------------------------------------------sinkhole
--------------------------------------------------------------



-- sinkhole spread


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sinkhole"},
	interval = 1,
	chance = 1,
	action = function(pos)

	


		local growthlimitsinkhole = 460

		local grow_radius = 5
		
	--count sinkholes
		local num_sinkholes = {}
		local radius = 5
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_sinkhole"})
		num_sinkholes = (cn["selfrep:selfrep_sinkhole"] or 0)




		--is player near then build
		local all_objects = minetest.get_objects_inside_radius(pos, grow_radius)
		local players = {}
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
							



--Grow is less than limit and player is near
if num_sinkholes < growthlimitsinkhole then 

	--expand x positive
		plusxpos = {x = pos.x + 1, y = pos.y, z = pos.z}

	--name for stone check
	local xp_new = minetest.get_node(plusxpos)

		if minetest.get_item_group(xp_new.name, "stone") == 1 then

			--spread
			minetest.set_node(plusxpos, {name = "selfrep:selfrep_sinkhole"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end

	--expand x negative
		negxpos = {x = pos.x - 1, y = pos.y, z = pos.z}

	--name for stone check
		local xn_new = minetest.get_node(negxpos)

		if minetest.get_item_group(xn_new.name, "stone") == 1 then

			--spread
			minetest.set_node(negxpos, {name = "selfrep:selfrep_sinkhole"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end
	
	
	--expand y positive
		plusypos = {x = pos.x, y = pos.y + 1, z = pos.z}

	--name for stone check
		local yp_new = minetest.get_node(plusypos)

		if minetest.get_item_group(yp_new.name, "stone") == 1 then

			--spread
			minetest.set_node(plusypos, {name = "selfrep:selfrep_sinkhole"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end

	
	--expand y neg
		negypos = {x = pos.x, y = pos.y -1, z = pos.z}


		--name for stone check
	local yn_new = minetest.get_node(negypos)

		if minetest.get_item_group(yn_new.name, "stone") == 1 then

			--spread
			minetest.set_node(negypos, {name = "selfrep:selfrep_sinkhole"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end


	--expand z posit
		pluszpos = {x = pos.x, y = pos.y, z = pos.z + 1}

	--name for stone check
		local zp_new = minetest.get_node(pluszpos)
	
		if minetest.get_item_group(zp_new.name, "stone") == 1 then

			--spread
			minetest.set_node(pluszpos, {name = "selfrep:selfrep_sinkhole"})
					
			--road build sound
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.3, max_hear_distance = 15,})
			
			end


	--expand z neg
		negzpos = {x = pos.x, y = pos.y, z = pos.z - 1}


		--name for stone check
		local zn_new = minetest.get_node(negzpos)

		if minetest.get_item_group(zn_new.name, "stone") == 1 then

			--spread
			minetest.set_node(negzpos, {name = "selfrep:selfrep_sinkhole"})
					
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
     	nodenames = {"selfrep:selfrep_sinkhole"},
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
			minetest.set_node(pos, {name = "air"})
			end
		end



end,
}


--- KILL sinkhole


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sinkhole"},
	interval = 38,
	chance = 1,
	catch_up = false, 
	action = function(pos)

		minetest.set_node(pos, {name = "air"})
	end,
}


--- KILL sinkhole TO LIGHT


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sinkhole"},
	interval = 38,
	chance = 30,
	catch_up = false,
	action = function(pos)

		minetest.set_node(pos, {name = "default:meselamp"})
	end,
}
