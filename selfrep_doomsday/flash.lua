--how long they last
local killrate = minetest.setting_get("selfrep_doomsday_flash_killrate") or 35

local glow_killrate = 10


------------------------------------------------------------------ PROTECTOR
-- Bot dies instantly if neighbor is a protector

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_flash"},
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
-- flash RULE SET



minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_flash"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)

	--what can it grow through?
		local medium = "air"


	
	--Replicate
		
		randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

		
		d = math.random(-5,5)
		randpos_b = {x = randpos.x + d, y = randpos.y + d, z = randpos.z + d}

	if minetest.get_node(randpos).name == "air" and  minetest.get_node(randpos_b).name ~= "air" then

		if minetest.get_node(randpos_b).name ~= "selfrep_doomsday:selfrep_doomsday_flash" and minetest.get_node(randpos_b).name ~= "selfrep_doomsday:selfrep_doomsday_flash_glow" then 
	
			--spread
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_flash"})

	--sound

	minetest.sound_play("selfrep_doomsday_flash", {pos = pos, gain = 0.5, max_hear_distance = 10,})

		end
	end		

end,
}






--flash DEATH AND CHANGE TO Glowing air

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_flash"},
	interval = killrate,
	chance = 1,
	catch_up = false,
	action = function(pos)
				
		-- make flash a residue
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_flash_glow"})
	
end,
}


--flash RESIDUE TO disperse

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_flash_glow"},
	interval = glow_killrate,
	chance = 15,
	catch_up = false,
	action = function(pos)
					
		-- make residue a gas
			
			minetest.set_node(pos, {name = "air"})
	
end,
}



--SCORCH



minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_flash_glow"},
	interval = 1,
	chance = 1,
	catch_up = true,
	action = function(pos)
		

-- find what the gas will destroy

	randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

	

--name for new node

		local newplace = minetest.get_node(randpos)


----Conditions
	
-- finds flamm?

		if minetest.get_item_group(newplace.name, "flammable") >= 1 then

			minetest.set_node(randpos, {name = "default:coalblock"})
end


-- finds soil?

		if minetest.get_item_group(newplace.name, "soil") == 1 then

			minetest.set_node(randpos, {name = "default:clay"})
end



-- finds water?

		if minetest.get_item_group(newplace.name, "water") >= 1 then
	 	
			minetest.set_node(randpos, {name = "air"})
end

-- finds sand?

		if minetest.get_item_group(newplace.name, "sand") == 1 then
	 	
			minetest.set_node(randpos, {name = "default:glass"})
end

						
end,
}









