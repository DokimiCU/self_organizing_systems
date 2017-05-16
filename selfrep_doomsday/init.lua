-------------------------------------------------------------
--Do files
-------------------------------------------------------------
dofile(minetest.get_modpath("selfrep_doomsday").."/nodes.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/craft.lua")





------------------------------------------------------------------ABMS
---------------------------------------------------------------



----------------------------------------------------------------
-- GREY GOO RULE SET


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_greygoo"},
	interval = 10,
	chance = 1,
	action = function(pos)
	
	--count goolim
		local num_goolim = {}
		local radius = 2
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_doomsday_greygoo"})
		num_goolim = (cn["selfrep_doomsday:selfrep_doomsday_greygoo"] or 0)

	--count air
		local num_gooair = {}
		local radius = 1
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"air"})
		num_gooair = (cn["air"] or 0)



	--Replicate
		local growthlimitgoo = 5
		local airlimit = 9

		randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}
		

	if num_goolim < growthlimitgoo then

		--spread to air
		if (num_gooair) > airlimit and minetest.get_node(randpos).name == "air" then
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
		end	
			
		--spread to ocean
		if (num_gooair) > airlimit and minetest.get_node(randpos).name == "default:water_source" then

			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
		end

		--spread to river
		if (num_gooair) > airlimit and 
minetest.get_node(randpos).name == "default:river_water_source" then
			
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
		end
	end
	
--Crowding
	--count dead
		local num_dead = {}
		local radius = 1
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"selfrep_doomsday:selfrep_road_dead"})
		num_dead = (cn["selfrep_doomsday:selfrep_road_dead"] or 0)



		--kill trapped goodies
		if (num_dead) > 10 then
			minetest.set_node(pos, {name = "default:stone_with_mese"})
		
	
		end



end,
}


----------------------------------------------------------------
-- WEAPON RULE SET


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_weapon"},
	interval = 10,
	chance = 1,
	action = function(pos)

		local growthlimitweapon = 5

	--count weapon
		local num_weapon = {}
		local radius = 1
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



	--Replicate 1
			randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}
		
		
		--spread to not air
		if num_weapon < growthlimitweapon and minetest.get_node(randpos).name ~= "air" then
			 	
			minetest.set_node(randpos, {name = "selfrep_doomsday:selfrep_doomsday_weapon"})
			
					
			minetest.sound_play("selfrep_roadbuild", {pos = pos, gain = 0.5, max_hear_distance = 15,})
		end


	

	--place tnt


	if (num_tnt) < 1 and (num_weapon) > 15 then 
			minetest.set_node(pos, {name = "tnt:tnt"})
			minetest.set_node({x = pos.x, y = pos.y + 1, z = pos.z}, {name = "fire:basic_flame"})
		end
	
	
	
end,
}

