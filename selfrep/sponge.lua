
------------------------------------------------------------------SPONGE
--------------------------------------------------------------



-- sponge spread


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sponge"},
	--neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos)
		local growthlimitsponge = 460

		local grow_radius = 5
		
	--count sponges
		local num_sponges = {}
		local radius = 5
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep:selfrep_sponge"})
		num_sponges = (cn["selfrep:selfrep_sponge"] or 0)




		--is player near then build
		local all_objects = minetest.get_objects_inside_radius(pos, grow_radius)
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
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.1, max_hear_distance = 8,})
			
			end
	end
end
end


end,
}


--REMOVE NEAR PLAYER

minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sponge"},
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


--- KILL SPONGE


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sponge"},
	interval = 38,
	chance = 1,
	catch_up = false, 
	action = function(pos)

		minetest.set_node(pos, {name = "default:glass"})
	end,
}


--- KILL SPONGE TO LIGHT


minetest.register_abm{
     	nodenames = {"selfrep:selfrep_sponge"},
	interval = 38,
	chance = 30,
	catch_up = false,
	action = function(pos)

		minetest.set_node(pos, {name = "default:meselamp"})
	end,
}
