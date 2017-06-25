local killrate = minetest.setting_get("weapon_killrate")

----------------------------------------------------------------
-- WEAPON RULE SET


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapon"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)

		local growthlimitweapon = 26
		local radius = 1
		local dispersal = 1	
	

	--count weapon
		local num_weapon = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_weapon"})
		num_weapon = (cn["selfrep_doomsday:selfrep_doomsday_weapon"] or 0)


	-- tnt
		--count tnt
		local num_tnt = {}
		local radius = 3
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"tnt:tnt"})
		num_tnt = (cn["tnt:tnt"] or 0)



	--Replicate 
			randpos = {x = pos.x + math.random(-dispersal,dispersal), y = pos.y + math.random(-dispersal,dispersal), z = pos.z + math.random(-dispersal,dispersal)}
		
		
	
		--if below limit and not gas

		if num_weapon < growthlimitweapon and minetest.get_node(randpos).name ~= "selfrep_doomsday:selfrep_doomsday_weapongas" then

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
	

	--place tnt


	if (num_tnt) < 1 and (num_weapon) > 21 then 
			minetest.set_node(pos, {name = "tnt:tnt"})
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = "fire:basic_flame"})
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
	catch_up = false,
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



