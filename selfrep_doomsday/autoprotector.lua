--how long they last
local killrate = 80



----------------------------------------------------------------
-- PROTECTOR
-- Bot dies instantly if neighbor is a protector
-- smaller chance
-- helps clear itself out
-- removes

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_autoprotector"},
	neighbors = {"selfrep_doomsday:selfrep_doomsday_protector"},
	interval = 10,
	chance = 15,
	catch_up = true,
	action = function(pos)
				
		-- kill
			
			minetest.set_node(pos, {name = "air"})

		--Play sound
					
					minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.8, max_hear_distance = 15,})
					
		
end,
}





----------------------------------------------------------------
-- autoprotector RULE SET
--can only be created near player


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_autoprotector"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)

	--what can it grow through?
		local medium = "air"

		local grow_radius = 20
			
--is player near then build
		local all_objects = minetest.get_objects_inside_radius(pos, grow_radius)
		local players = {}
		local _,obj
		for _,obj in ipairs(all_objects) do
			if obj:is_player() then
	




--positions
			
		randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

		
		d = math.random(-15,15)
		randpos_b = {x = randpos.x + d, y = randpos.y + d, z = randpos.z + d}



--Replicate

	
 

	if minetest.get_node(randpos).name == "air" and  minetest.get_node(randpos_b).name ~= "air" then
	

	if minetest.get_node(randpos_b).name ~= "selfrep_doomsday:selfrep_doomsday_autoprotector" then 
		 
	
			--spread
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_autoprotector"})

	

		end
		
end
end

end

end,
}






--autoprotector DEATH 

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_autoprotector"},
	interval = killrate,
	chance = 1,
	--can walk away and kill it
	catch_up = true,
	action = function(pos)
				
		-- make autoprotector a residue
			
			minetest.set_node(pos, {name = "air"})
	
end,
}






--CONVERT other devices



minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_autoprotector"},
	interval = 1,
	chance = 1,
	catch_up = true,
	action = function(pos)
		

-- find what will destroy

	randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

	



----Conditions
	
-- finds goo?

		if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_greygoo"  then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.3, max_hear_distance = 10,})
end


-- finds weapon?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_weapon"  then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.3, max_hear_distance = 10,})
end


-- finds blight?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_blight"  then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.3, max_hear_distance = 10,})
end


-- finds flash?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_flash"  then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.3, max_hear_distance = 10,})
end

-- finds terra?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_terraformer"  then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.3, max_hear_distance = 10,})
end


-- finds weapon residue?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_weapon_residue_source" or minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_weapon_residue_flowing"  then

			minetest.set_node(randpos, {name = "air"})
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.1, max_hear_distance = 5,})
end


-- finds weapon gas?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_weapongas" then

			minetest.set_node(randpos, {name = "air"})
	minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.1, max_hear_distance = 5,})
end


-- finds flash residue?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_flash_glow" then

			minetest.set_node(randpos, {name = "air"})
	minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.1, max_hear_distance = 5,})
end


-- finds blight residue?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_blightspore" then

			minetest.set_node(randpos, {name = "air"})
	minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.1, max_hear_distance = 5,})
end

		-- finds chaos?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_chaos"  then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
		minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.3, max_hear_distance = 10,})
end



-- finds chaos glow?

	if minetest.get_node(randpos).name == "selfrep_doomsday:selfrep_doomsday_glow" then

			minetest.set_node(randpos, {name = "air"})
	minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.1, max_hear_distance = 5,})
end


						
end,
}









