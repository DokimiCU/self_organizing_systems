--how long they last
local killrate = minetest.setting_get("selfrep_doomsday_chaos_killrate") or 35

local glow_killrate = killrate/2


------------------------------------------------------------------ PROTECTOR
-- Bot dies instantly if neighbor is a protector

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos","selfrep_doomsday:selfrep_doomsday_chaos_glow"},
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




---------------------------------------------------------
--PHYSICS

local skybox_chaos = {
	"chaos_skybox_y.png",
	"chaos_skybox.png",
	"chaos_skybox.png",
	"chaos_skybox.png",
	"chaos_skybox.png",
	"chaos_skybox.png"
}





minetest.register_globalstep(function(dtime)
	for _, player in ipairs(minetest.get_connected_players()) do
		if math.random() < 2 then -- set gravity, skybox and override light
			local pdef = nil
			local in_radmax = false -- player within radmax of planet
			local pos = player:getpos()
			local pos_a = {x = pos.x, y=pos.y+0.8,z =pos.z}
			
			if minetest.get_node(pos_a).name == "selfrep_doomsday:selfrep_doomsday_chaos" or minetest.get_node(pos_a).name == "selfrep_doomsday:selfrep_doomsday_chaos_glow" then 


	-- speed, jump, gravity				
				player:set_physics_override(0.2, 1.3, 0.01)
				player:set_sky({r = 0, g = 0, b = 0, a = 0}, "skybox", skybox_chaos)
 				--player:override_day_night_ratio(1)

			else
				player:set_physics_override(1, 1, 1)
				player:set_sky({}, "regular", {})

			end

		end
	end
end)


----------------------------------------------------------------
-- chaos RULE SET



minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)

	--what can it grow through?
		local medium = "air"


	
	--Replicate
		
		randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

		
		d = math.random(-7,7)
		randpos_b = {x = randpos.x + d, y = randpos.y + d, z = randpos.z + d}

	if minetest.get_node(randpos).name == "air" and  minetest.get_node(randpos_b).name ~= "air" then

		if minetest.get_node(randpos_b).name ~= "selfrep_doomsday:selfrep_doomsday_chaos" and minetest.get_node(randpos_b).name ~= "selfrep_doomsday:selfrep_doomsday_chaos_glow" then 
	
			--spread
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_chaos"})

	--sound

	minetest.sound_play("selfrep_doomsday_chaos", {pos = pos, gain = 0.2, max_hear_distance = 10,})

		end
	end		

end,
}






--chaos DEATH AND CHANGE TO Glowing air

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos"},
	interval = killrate,
	chance = 1,
	catch_up = false,
	action = function(pos)
				
		-- make chaos a residue
			
			minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos_glow"})

			minetest.sound_play("selfrep_doomsday_chaos", {pos = pos, gain = 0.2, max_hear_distance = 10,})
	
end,
}





--CHAOS Rearrange the world RANDOM


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos"},
	interval = 11,
	chance = 11,
	catch_up = false,
	action = function(pos)

	--where will be swapped?
		local pos_1 = {x = pos.x + math.random(-5,5), y = pos.y + math.random(0,5), z = pos.z + math.random(-5,5)}

		local pos_2 = {x = pos.x + math.random(-5,5), y = pos.y + math.random(-5,0), z = pos.z + math.random(-5,5)}


	--what will be swapped?
		local node_1 = minetest.get_node(pos_1).name

		local node_2 = minetest.get_node(pos_2).name


	if node_1 ~= "ignore" and node_2 ~= "ignore" then


	--don't move crystals
	if node_1 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal"  and node_2 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal" then
			
	--swap 'em
	
		minetest.set_node(pos_1, {name = node_2})
		minetest.set_node(pos_2, {name = node_1})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_3", {pos = pos, gain = 0.1, max_hear_distance = 10,})
		
end
end

end,
}




--CHAOS Glow Solidify

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = glow_killrate,
	chance = 15,
	catch_up = false,
	action = function(pos)

	--where will be copied?
		local pos_1 = {x = pos.x + math.random(-1,1), y = pos.y - 1, z = pos.z + math.random(-1,1)}

		

	--what will be copied?
		local node_1 = minetest.get_node(pos_1).name

	if node_1 ~= "ignore" and node_1 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal" then

	--make itself into what is saw
	
		minetest.set_node(pos, {name = node_1})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos", {pos = pos, gain = 0.1, max_hear_distance = 10,})
		
	end
end,
}

--CHAOS Glow dissapate
--rarely become spark
--next ABM will trigger positive feedback to clear build up

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = glow_killrate,
	chance = 6500,
	catch_up = false,
	action = function(pos)

	
		minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos_spark"})
		
end,
}



--CHAOS spark
--chain reaction
--sparks spread through cloud

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow", "selfrep_doomsday:selfrep_doomsday_chaos"},
	neighbors = {"selfrep_doomsday:selfrep_doomsday_chaos_spark"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(pos)


		minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos_spark"})

		
end,
}

--CHAOS spark
--sparks mutually annihilate

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_spark"},
	neighbors = {"selfrep_doomsday:selfrep_doomsday_chaos_spark"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)

	
		minetest.add_particlespawner({
    		amount = 1,
    		time = 0.2,
    		minpos = {x = pos.x, y = pos.y, z = pos.z },
    		maxpos = {x = pos.x, y = pos.y, z = pos.z },
    		minvel = {x = 0, y = 0, z = 0},
    		maxvel = {x = 0, y = 0, z = 0},
    		minacc = {x = 0, y = 0, z = 0},
    		maxacc = {x = 0, y = 0, z = 0},
    		minexptime = 0.1,
    		maxexptime = 0.2,
    		minsize = 10,
    		maxsize = 40,
    		collisiondetection = true,
    		vertical = true,
    		texture = "selfrep_doomsday_lightning.png",
    		glow = 14,
    	})		


		minetest.set_node(pos, {name = "air"})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_4", {pos = pos, gain = 1, max_hear_distance = 30,})
		
end,
}



--CHAOS spark relax


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_spark"},
	interval = 4,
	chance = 2,
	catch_up = false,
	action = function(pos)

	
		
		minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos_glow"})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos", {pos = pos, gain = 0.2, max_hear_distance = 10,})
		
end,
}



--CHAOS Create Cavites
-- try to group air pockets
-- if pos_1 is air, and pos_2 is next to air but is solid, swap the air in so that two air are next to eachother


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = 2,
	chance = 1,
	catch_up = false,
	action = function(pos)

	--where will be swapped?
		local pos_1 = {x = pos.x + math.random(-3,3), y = pos.y - 1, z = pos.z + math.random(-3,3)}

		local pos_2 = {x = pos.x + math.random(-3,3), y = pos.y + 1, z = pos.z + math.random(-1,1)}



		local pos_2_side = {x = pos_2.x + math.random(-1,1), y = pos_2.y + math.random(-1,1), z = pos_2.z + math.random(-1,1)}



	--what will be swapped?
		local node_1 = minetest.get_node(pos_1).name

		local node_2 = minetest.get_node(pos_2).name
		
		local node_3 = minetest.get_node(pos_2_side).name


	if node_1 ~= "ignore" and node_2 ~= "ignore" then

--don't move crystals
	if node_1 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal"  and node_2 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal" then


	--checks
	-- 1st is air, the next is not

	if node_1 == "air" and node_2 ~= "air" then

	--that solid is not chaos
	if node_2 ~= "selfrep_doomsday:selfrep_doomsday_chaos" and node_2 ~= "selfrep_doomsday:selfrep_doomsday_chaos_glow" then


	--the solid is next to air
	if node_3 == "air" then


		
	--swap 'em
	
		minetest.set_node(pos_1, {name = node_2})
		minetest.set_node(pos_2, {name = node_1})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_3", {pos = pos, gain = 0.1, max_hear_distance = 10,})
	
end
end	
end
end
end

end,
}


--CHAOS Create Clumps
-- try to group solids
-- if pos_1 is solid, and pos_2 is next to solid but is air, swap the solid in so that two solid are next to eachother


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = 2,
	chance = 1,
	catch_up = false,
	action = function(pos)

	--where will be swapped?
		local pos_1 = {x = pos.x + math.random(-3,3), y = pos.y + math.random(0,1), z = pos.z + math.random(-3,3)}

		local pos_2 = {x = pos.x + math.random(-3,3), y = pos.y, z = pos.z + math.random(-3,3)}



		local pos_2_side = {x = pos_2.x + math.random(-1,1), y = pos_2.y + math.random(-1,1), z = pos_2.z + math.random(-1,1)}



	--what will be swapped?
		local node_1 = minetest.get_node(pos_1).name

		local node_2 = minetest.get_node(pos_2).name
		
		local node_3 = minetest.get_node(pos_2_side).name



	--checks

	if node_1 ~= "ignore" and node_2 ~= "ignore" then

	--don't move crystals
	if node_1 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal"  and node_2 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal" then


	

	-- 1st is solid, the next is not

	if node_1 ~= "air" and node_2 == "air" then


	--the air is next to solid
	if node_3 ~= "air" then


	--that solid is not chaos
	if node_3 ~= "selfrep_doomsday:selfrep_doomsday_chaos" and node_3 ~= "selfrep_doomsday:selfrep_doomsday_chaos_glow" then

		
	--swap 'em
	
		minetest.set_node(pos_1, {name = node_2})
		minetest.set_node(pos_2, {name = node_1})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_3", {pos = pos, gain = 0.1, max_hear_distance = 10,})
	
end
end	
end
end
end

end,
}



--CHAOS Create Pillars
-- try to group solids
-- if pos_1 is solid, and pos_2 grounded air, swap the solid in so that two solid are stacked


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = 2,
	chance = 1,
	catch_up = false,
	action = function(pos)

	--where will be swapped?
		local pos_1 = {x = pos.x + math.random(-3,3), y = pos.y + 1, z = pos.z + math.random(-3,3)}

		local pos_2 = {x = pos.x + math.random(-3,3), y = pos.y + math.random(-3,3), z = pos.z + math.random(-3,3)}



		local pos_2_side = {x = pos_2.x, y = pos_2.y - 1, z = pos_2.z}



	--what will be swapped?
		local node_1 = minetest.get_node(pos_1).name

		local node_2 = minetest.get_node(pos_2).name
		
		local node_3 = minetest.get_node(pos_2_side).name



	--checks

	if node_1 ~= "ignore" and node_2 ~= "ignore" then

	--don't move crystals
	if node_1 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal"  and node_2 ~= "selfrep_doomsday:selfrep_doomsday_chaos_crystal" then


	

	-- 1st is solid, the next is not

	if node_1 ~= "air" and node_2 == "air" then


	--the air is next to solid
	if node_3 ~= "air" then


	--that solid is not chaos
	if node_3 ~= "selfrep_doomsday:selfrep_doomsday_chaos" and node_3 ~= "selfrep_doomsday:selfrep_doomsday_chaos_glow" then

		
	--swap 'em
	
		minetest.set_node(pos_1, {name = node_2})
		minetest.set_node(pos_2, {name = node_1})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_3", {pos = pos, gain = 0.1, max_hear_distance = 10,})
	
end
end	
end
end
end

end,
}





--CHAOS FREEZE WATER
-- to stop it just being a flood machine


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos", "selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = 3,
	chance = 1,
	catch_up = false,
	action = function(pos)

	--find a node
		local pos_1 = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

		
	--name for group check
	
	local pos_name = minetest.get_node(pos_1)


	-- finds water? freeze it

		if minetest.get_item_group(pos_name.name, "water") >= 1 then
	 	
			minetest.set_node(pos_1, {name = "default:ice"})


	--sound

		minetest.sound_play("selfrep_doomsday_chaos_3", {pos = pos, gain = 0.1, max_hear_distance = 10,})
	
end

end,
}



-- TELEPORT player through connected chaos

minetest.register_abm{
    nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
    neighbors = {"selfrep_doomsday:selfrep_doomsday_chaos", "selfrep_doomsday:selfrep_doomsday_chaos_glow"},
    interval = 1,
    chance = 3,
    action = function(pos, node, active_object_count, active_object_count_wider)

	
     local objs = minetest.env:get_objects_inside_radius(pos, 1.2)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
			local meta = minetest.get_meta(pos)
    			local target = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}
			local target_a = {x = target.x, y = target.y +1, z = target.z}

			--so doesn't put in solid blocks
			if minetest.get_node(target).name == "air" or minetest.get_node(target).name == "selfrep_doomsday:selfrep_doomsday_chaos_glow" then

			if minetest.get_node(target_a).name == "air" or minetest.get_node(target_a).name == "selfrep_doomsday:selfrep_doomsday_chaos_glow" then


	
			player:moveto(target, false)
			minetest.sound_play("selfrep_doomsday_chaos_2", {pos = target, gain = 1.0, max_hear_distance = 15,})

	end
	end
	end
	end	
end,
}

-- TELEPORT 2
-- spit up into air

minetest.register_abm{
    nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos"},
    interval = 3,
    chance = 5,
    action = function(pos, node, active_object_count, active_object_count_wider)

	
     local objs = minetest.env:get_objects_inside_radius(pos, 1.2)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
			local meta = minetest.get_meta(pos)
    			local target = {x = pos.x, y = pos.y + math.random(0,8), z = pos.z}
			local target_a = {x = target.x, y = target.y +1, z = target.z}

			--so doesn't put in solid blocks
			if minetest.get_node(target).name == "air" or minetest.get_node(target).name == "selfrep_doomsday:selfrep_doomsday_chaos_glow" then

			if minetest.get_node(target_a).name == "air" or minetest.get_node(target_a).name == "selfrep_doomsday:selfrep_doomsday_chaos_glow" then


	
			player:moveto(target, false)
			minetest.sound_play("selfrep_doomsday_chaos_2", {pos = target, gain = 1.0, max_hear_distance = 15,})

	end
	end
	end
	end	
end,
}




--CHAOS Glow Solidify to Crystal

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = glow_killrate,
	chance = 1000,
	catch_up = false,
	action = function(pos)
		
		local pos_b = {x = pos.x, y = pos.y - 1, z = pos.z}


		--only if on ground and not chaos

		if minetest.get_node(pos_b).name ~= "air" then

		if minetest.get_node(pos_b).name ~= "selfrep_doomsday:selfrep_doomsday_chaos_glow" and minetest.get_node(pos_b).name ~= "selfrep_doomsday:selfrep_doomsday_chaos" then

		


	--create crystal

	minetest.add_particlespawner({
    		amount = 1,
    		time = 0.2,
    		minpos = {x = pos.x, y = pos.y, z = pos.z },
    		maxpos = {x = pos.x, y = pos.y, z = pos.z },
    		minvel = {x = 0, y = 0, z = 0},
    		maxvel = {x = 0, y = 0, z = 0},
    		minacc = {x = 0, y = 0, z = 0},
    		maxacc = {x = 0, y = 0, z = 0},
    		minexptime = 0.1,
    		maxexptime = 0.2,
    		minsize = 10,
    		maxsize = 40,
    		collisiondetection = true,
    		vertical = true,
    		texture = "selfrep_doomsday_lightning.png",
    		glow = 14,
    	})	

		
		minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos_crystal"})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_4", {pos = pos, gain = 1, max_hear_distance = 20,})
	
end
end
	
	
end,
}


--CHAOS Glow Solidify to Crystal LINES
-- to create long straight crystal lines

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_glow"},
	interval = 3,
	chance = 1,
	catch_up = false,
	action = function(pos)
		
		--add above or below
		
		local pos_b = {x = pos.x, y = pos.y + math.random(-1,1), z = pos.z}


		--only if in line with a crystal

		
		if minetest.get_node(pos_b).name == "selfrep_doomsday:selfrep_doomsday_chaos_crystal" then


	--create crystal

	minetest.add_particlespawner({
    		amount = 1,
    		time = 0.2,
    		minpos = {x = pos.x, y = pos.y, z = pos.z },
    		maxpos = {x = pos.x, y = pos.y, z = pos.z },
    		minvel = {x = 0, y = 0, z = 0},
    		maxvel = {x = 0, y = 0, z = 0},
    		minacc = {x = 0, y = 0, z = 0},
    		maxacc = {x = 0, y = 0, z = 0},
    		minexptime = 0.1,
    		maxexptime = 0.2,
    		minsize = 10,
    		maxsize = 40,
    		collisiondetection = true,
    		vertical = true,
    		texture = "selfrep_doomsday_lightning.png",
    		glow = 14,
    	})	
		
		minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos_crystal"})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_4", {pos = pos, gain = 1, max_hear_distance = 20,})
	
end	
	
end,
}



-- TELEPORT player through Crystals

minetest.register_abm{
    nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_crystal"},
    interval = 1,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)

	
     local objs = minetest.env:get_objects_inside_radius(pos, 1.4)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
			local meta = minetest.get_meta(pos)
    			local target = {x = pos.x, y = pos.y + 1, z = pos.z}
			
			player:moveto(target, false)
			minetest.sound_play("selfrep_doomsday_chaos_2", {pos = target, gain = 1.0, max_hear_distance = 15,})

	end
	end	
end,
}




-- EXPLODE SPARK on player

minetest.register_abm{
    nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_spark"},
    interval = 1,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)

	
     local objs = minetest.env:get_objects_inside_radius(pos, 1)
		for k, player in pairs(objs) do
			if player:get_player_name()~=nil then 
			
				
		--zap

	minetest.add_particlespawner({
    		amount = 1,
    		time = 0.2,
    		minpos = {x = pos.x, y = pos.y, z = pos.z },
    		maxpos = {x = pos.x, y = pos.y, z = pos.z },
    		minvel = {x = 0, y = 0, z = 0},
    		maxvel = {x = 0, y = 0, z = 0},
    		minacc = {x = 0, y = 0, z = 0},
    		maxacc = {x = 0, y = 0, z = 0},
    		minexptime = 0.1,
    		maxexptime = 0.2,
    		minsize = 10,
    		maxsize = 40,
    		collisiondetection = true,
    		vertical = true,
    		texture = "selfrep_doomsday_lightning.png",
    		glow = 14,
    	})	
		
		minetest.set_node(pos, {name = "air"})

	--sound

		minetest.sound_play("selfrep_doomsday_chaos_4", {pos = pos, gain = 1, max_hear_distance = 20,})

	--ouch
		local h = player:get_hp()
      	player:set_hp(h-0.5)

		

	end
	end	
end,
}




--SPARK SCORCH



minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_chaos_spark"},
	interval = 1,
	chance = 15,
	catch_up = true,
	action = function(pos)
		

-- find what the gas will destroy

	randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

	

--name for new node

		local newplace = minetest.get_node(randpos)


----Conditions
	
-- finds stone?

		if minetest.get_item_group(newplace.name, "stone") >= 1 then

			minetest.set_node(randpos, {name = "default:lava_source"})
end



-- finds sand?

		if minetest.get_item_group(newplace.name, "sand") == 1 then
	 	
			minetest.set_node(randpos, {name = "default:obsidian_glass"})
end


-- finds ice?
--vaporise to prevent infinite build up from oceans

		if minetest.get_node(randpos).name == "default:ice" then
	 	
			minetest.set_node(randpos, {name = "air"})
end


						
end,
}



