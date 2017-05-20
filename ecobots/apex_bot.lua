


----------------------------------------------------------------
--APEX PREDATOR BOT
----------------------------------------------------------------




----------------------------------------------------------------
-- REPLICATE APEX BOT



minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = 6,
	chance = 22,
	action = function(pos)
	----SETTINGS
	--dispersal radius up and horizontal
		local upradius_ap = 7
		local horizradius_ap = 7

		
	-- population limit within area	
		local apex_poplim = 5
		local apex_poprad = 2


----POP LIMITS
	--count apex bots

		local num_apex_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_poprad, y = pos.y - apex_poprad, z = pos.z - apex_poprad},
			{x = pos.x + apex_poprad, y = pos.y + apex_poprad, z = pos.z + apex_poprad}, {"ecobots:ecobots_predator_bot"})
		num_apex_bot = (cn["ecobots:ecobots_apex_bot"] or 0)
		
		
----POSITIONS
-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_ap,horizradius_ap), y = pos.y + math.random(-upradius_ap,upradius_ap), z = pos.z + math.random(-horizradius_ap,horizradius_ap)}


-- for check randpos is prey below 	

	local	randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}


-- find what the parent will eat inorder to reproduce

		local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}



----CONDITIONAL REPLICATION
		
	-- create if under pop limit
		if (num_apex_bot) < apex_poplim then


--- if selected nearby node is edible
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_predator_bot" or minetest.get_node(pos_eat).name == "ecobots:ecobots_detritivore_bot" then


		-- if new location has prey available under
				

		if minetest.get_node(randpos_below).name == "ecobots:ecobots_predator_bot" or minetest.get_node(randpos_below).name == "ecobots:ecobots_detritivore_bot" then


--- Create Child on top of prey

			minetest.set_node(randpos, {name = "ecobots:ecobots_apex_bot"})


			--parent eats food
		
			minetest.dig_node(pos_eat)


		-- apex cry sound
			minetest.sound_play("ecobots_chirp_dark", {pos = pos, gain = 2, max_hear_distance = 50,})
			
	end	
	end
	end
end,
}


----------------------------------------------------------------
-- KILL APEX BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_apex_bot"},
	interval = 2,
	chance = 1,
	action = function(pos)
 		--distance to prey to sustain
		local apex_hungerradius = 1


	--count prey herbivore

		local num_predprey = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_predator_bot"})
		num_predprey = (cn["ecobots:ecobots_predator_bot"] or 0)
	
--count prey detritivore

		local num_detritprey = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - apex_hungerradius, y = pos.y - apex_hungerradius, z = pos.z - apex_hungerradius},
			{x = pos.x + apex_hungerradius, y = pos.y + apex_hungerradius, z = pos.z + apex_hungerradius}, {"ecobots:ecobots_detritivore_bot"})
		num_detritprey = (cn["ecobots:ecobots_detritivore_bot"] or 0)	


		-- do if enviro unsuitable

	if  (num_predprey) + (num_detritprey)  < 1 then

		-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}


