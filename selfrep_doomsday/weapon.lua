local killrate = minetest.setting_get("selfrep_doomsday_weapon_killrate") or 15



------------------------------------------------------------------ PROTECTOR
-- Bot dies instantly if neighbor is a protector

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapon", "selfrep_doomsday:selfrep_doomsday_weapon_residue_source", "selfrep_doomsday:selfrep_doomsday_weapongas"},
	neighbors = {"selfrep_doomsday:selfrep_doomsday_protector"},
	interval = 1,
	chance = 1,
	catch_up = true,
	action = function(pos)
				
		-- kill
			
			minetest.set_node(pos, {name = "air"})

		--Play sound
					
					minetest.sound_play("selfrep_doomsday_protector", {pos = pos, gain = 0.8, max_hear_distance = 8,})
					
		
end,
}



----------------------------------------------------------------
-- WEAPON RULE SET


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapon"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)


		local dispersal = 1	
	

	
	--Replicate 
			randpos = {x = pos.x + math.random(-dispersal,dispersal), y = pos.y + math.random(-dispersal,dispersal), z = pos.z + math.random(-dispersal,dispersal)}
		
		
	
		--if below limit and not gas

		if minetest.get_node(randpos).name ~= "selfrep_doomsday:selfrep_doomsday_weapongas" then

		--spread to not air or flowing residue
		if minetest.get_node(randpos).name ~= "selfrep_doomsday:selfrep_doomsday_weapon_residue_flowing"  and minetest.get_node(randpos).name ~= "air" then


		--spread to not self or residue

		if minetest.get_node(randpos).name ~= "selfrep_doomsday:selfrep_doomsday_weapon_residue_source" and minetest.get_node(randpos).name ~= "selfrep_doomsday:selfrep_doomsday_weapon" then


		--spread to not ice

		if minetest.get_node(randpos).name ~= "default:ice" then

			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_weapon"})
			
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		
		end
		end
		end
	end
	
		
	
end,
}



--WEAPON DEATH AND CHANGE TO RESIDUE

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapon"},
	interval = killrate,
	chance = 1,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
			
		-- make weapon a residue
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source"})
	
end,
}


--WEAPON RESIDUE TO GAS
-- to open up the massive area affected

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapon_residue_source"},
	interval = killrate,
	chance = 2,
	catch_up = true,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
			
		-- make residue a gas
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapongas"})
	
end,
}



--WEAPON GAS TO AIR
-- to open up the massive area affected

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapongas"},
	interval = killrate,
	chance = 4,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
			
		-- make gas air
			
			minetest.set_node(pos, {name = "air"})
	
end,
}


--GAS CORROSION


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapongas"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)
		
--area of damage
	local radius = 3
		


-- find what the gas will destroy

		local pos_eat = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}



----Conditions
	
	--spread to not self

	if minetest.get_node(pos_eat).name ~= "selfrep_doomsday:selfrep_doomsday_weapongas" then

		--spread to not air or flowing

	if minetest.get_node(pos_eat).name ~= "selfrep_doomsday:selfrep_doomsday_weapon_residue_flowing"  and minetest.get_node(pos_eat).name ~= "air" then


		--spread to not weapon or residue

		if minetest.get_node(pos_eat).name ~= "selfrep_doomsday:selfrep_doomsday_weapon_residue_source" and minetest.get_node(pos_eat).name ~= "selfrep_doomsday:selfrep_doomsday_weapon" then


		--destroy node	
			 	
			minetest.set_node(pos_eat, {name = "air"})
		end	
		end
		end
			
end,
}


------------------------------------------------------------------ Boom!
-- random explosions
-- residue occassionally explodes

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapon_residue_source"},
	neighbors = {"air", "group:stone"},
	interval = 30,
	chance = 1000,
	catch_up = false,
	action = function(pos)
			
	--boom!	
		tnt.boom(pos, {damage_radius=3,radius=3,ignore_protection=false})
					
		
end,
}




