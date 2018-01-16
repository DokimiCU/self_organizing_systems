local killrate = minetest.setting_get("selfrep_doomsday_blight_killrate") or 15


-------------------------------------------------------------
-- PROTECTOR
-- Bot dies instantly if neighbor is a protector

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_blight"},
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




---------------------------------------------------
--BLIGHT RULE SET
-----------------------------------------------------

--SPREAD

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_blight"},
	interval = 3,
	chance = 1,
	catch_up = false,
	action = function(pos)

		local growthlimit = 3
		local radius = 1
		local dispersal = 3

	--count blight

		local num_blight = {}
		
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_blight"})
		num_blight = (cn["selfrep_doomsday:selfrep_blight"] or 0)


	


	--Replicate

		randpos = {x = pos.x + math.random(-dispersal,dispersal), y = pos.y + math.random(-dispersal,dispersal), z = pos.z + math.random(-dispersal,dispersal)}
		

--name for new node

		local newplace = minetest.get_node(randpos)

		
	--Do if under poplim

		if num_blight < growthlimit then


	--Do if organic ie dirt or burnable

		if minetest.get_item_group(newplace.name, "soil") == 1 or minetest.get_item_group(newplace.name, "flammable") >= 1 then


	--stop doing in sand and spores
		if minetest.get_node(randpos).name ~= "default:desert_sand" and minetest.get_node(randpos).name ~= "selfrep_doomsday:selfrep_blightspore" then


	--Create Blight
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_blight"})
			
	--Play sound
					
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 1, max_hear_distance = 20,})
		end
	end
	end	
	
end,
}




--BLIGHT RUIN


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_blight"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)
	-----SETTINGS
		
--area of damage
	local radius = 3
		


-- find what the blight will eat ruin

		local pos_eat = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos_eat_above = {x = pos_eat.x, y = pos_eat.y + 1, z = pos_eat.z}

--name for new node

		local newplace = minetest.get_node(pos_eat)



----CONDITIONAL

	
--- if finds dirt in nearby node

		if minetest.get_item_group(newplace.name, "soil") == 1 then


-- change to a damaged node

			minetest.set_node(pos_eat, {name = "selfrep_doomsday:selfrep_doomsday_black_sand"})
		
		
		end

		

--- if parent finds flammable that isn't blight in nearby node

		if minetest.get_item_group(newplace.name, "flammable") >= 1 and minetest.get_node(pos_eat).name ~= "selfrep_doomsday:selfrep_blight" then
		

	--so doesn't create weird looking air gaps

			if minetest.get_node(pos_eat_above).name == "air" then


-- change to a damaged node

			minetest.set_node(pos_eat, {name = "selfrep_doomsday:selfrep_blightspore"})

		end
		end

			
end,
}




--BLIGHT DEATH AND CHANGE TO WASTE

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_blight"},
	neighbors = {"group:flammable"},
	interval = killrate,
	chance = 6,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		local under = {x = pos.x, y = pos.y-1, z = pos.z}
	
		--get rid of hanging nodes and collapse canopy

		if minetest.get_node(under).name == "air" or minetest.get_node(under).name == "selfrep_doomsday:selfrep_blightspore" then

			minetest.dig_node(pos)


		else 
			
		-- make blight a waste
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_blighted_waste"})

		--Play sound
					
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 1, max_hear_distance = 20,})
		
		end
		
end,
}


--BLIGHT DEATH AND CHANGE TO BLIGHTED SAND

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_blight"},
	interval = killrate,
	neighbors = {"group:sand"},
	chance = 8,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		local under = {x = pos.x, y = pos.y-1, z = pos.z}


		if minetest.get_node(under).name ~= "air" and minetest.get_node(under).name ~= "selfrep_doomsday:selfrep_blightspore" then
			
		-- make blight a sand
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_blighted_sand"})

		--Play sound
					
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 1, max_hear_distance = 20,})
	
		end		
end,
}



--BLIGHT SPORE DISAPPATE 

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_blightspore"},
	interval = killrate,
	chance = 35,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}	
		
		minetest.set_node(pos, {name = "air"})
				
end,
}


--BLIGHT WASTE DISAPPATE

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_blighted_waste"},
	interval = killrate,
	chance = 6,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
			
		-- make blight a spore
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_blightspore"})

	end,
}


--BLIGHT SAND DISAPPATE

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_blighted_sand"},
	interval = killrate,
	chance = 30,
	catch_up = false,
	action = function(pos)

		local pos = {x = pos.x, y = pos.y, z = pos.z}
	
		-- make blight a dormant blight
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_dormant"})

			
end,
}

--DORMANT DISAPPATE

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_dormant"},
	interval = killrate*240,
	chance = 15,
	catch_up = true,
	action = function(pos)

		local pos = {x = pos.x, y = pos.y, z = pos.z}
	
		-- make dormant die
			
			minetest.set_node(pos, {name = "default:desert_sand"})

			
end,
}



--BLACK SAND DISAPPATE

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_black_sand"},
	interval = 30,
	chance = 30,
	catch_up = false,
	action = function(pos)
	
		local pos = {x = pos.x, y = pos.y, z = pos.z}
		
					
		-- make blight a desert
			
			minetest.set_node(pos, {name = "default:desert_sand"})
			
		
end,
}



--SPORE CORROSION


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_blightspore"},
	interval = 3,
	chance = 2,
	neighbors = "air",
	catch_up = false,
	action = function(pos)
		
--area of damage
	local radius = 2
		

-- find what the gas will destroy

		local pos_eat = {x = pos.x + math.random(-radius,radius), y = pos.y + math.random(-radius,radius), z = pos.z + math.random(-radius,radius)}

		local pos = {x = pos.x, y = pos.y, z = pos.z}


--name for new node

		local newplace = minetest.get_node(pos_eat)



----Conditions
	
--- if finds dirt in nearby node

		if minetest.get_item_group(newplace.name, "flammable") == 1 then


-- spread to not self

		if minetest.get_node(pos_eat).name ~= "selfrep_doomsday:selfrep_blightspore" and minetest.get_node(pos_eat).name ~= "selfrep_doomsday:selfrep_blight" then



		--spread to target and destroy self	
			 	
			minetest.set_node(pos_eat, {name = "selfrep_doomsday:selfrep_blightspore"})

			minetest.set_node(pos, {name = "air"})
		end	
		end
			
end,
}


--DORMANT REACTIVATE

minetest.register_abm{
    nodenames = {"selfrep_doomsday:selfrep_doomsday_dormant"},
    interval = 1,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
     local objs = minetest.env:get_objects_inside_radius(pos, 1.1)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
			local meta = minetest.get_meta(pos)

    			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_blight"})

			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 1.0, max_hear_distance = 10,})
	end
	end	
end,
}




--INFECTION


