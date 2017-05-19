

----------------------------------------------------------------
--HERBIVORE BOT  aka 1st Predator bot
---------------------------------------------------------------

---------------------------------------------------------------
--REPLICATE HERBIVORE BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 4,
	chance = 10,
	action = function(pos)
	-----SETTINGS
	--dispersal radius up and horizontal
		local upradius_pr = 7
		local horizradius_pr = 7

		
	-- population limit within area	
		local pred_poplim = 5
		local pred_poprad = 2


-----POP LIMITS
--count pred bots for pop limits

		local num_pred_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - pred_poprad, y = pos.y - pred_poprad, z = pos.z - pred_poprad},
			{x = pos.x + pred_poprad, y = pos.y + pred_poprad, z = pos.z + pred_poprad}, {"ecobots:ecobots_predator_bot"})
		num_pred_bot = (cn["ecobots:ecobots_predator_bot"] or 0)
		
		

----POSITIONS
-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_pr,horizradius_pr), y = pos.y + math.random(-upradius_pr,upradius_pr), z = pos.z + math.random(-horizradius_pr,horizradius_pr)}


-- find what the parent will eat inorder to reproduce

		local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}




----CONDITIONAL REPLICATION		
	
-- create if under pop limit
	if (num_pred_bot) < pred_poplim then

	
	

	
--- if parent finds food in nearby node
		if minetest.get_node(pos_eat).name == "ecobots:ecobots_photosynth_bot" or minetest.get_node(pos_eat).name == "ecobots:ecobots_pioneer_bot" then


-- if new location has food child				
		if minetest.get_node(randpos).name == "ecobots:ecobots_photosynth_bot" or minetest.get_node(randpos).name == "ecobots:ecobots_pioneer_bot" then


-- displace food item to create child

			minetest.set_node(randpos, {name = "ecobots:ecobots_predator_bot"})


--parent eats food
		
			minetest.dig_node(pos_eat)


--herbivore cry sound
			minetest.sound_play("ecobots_chirp", {pos = pos, gain = 0.5, max_hear_distance = 40,})
		
		end	
		end
		end	
end,
}


----------------------------------------------------------------
-- KILL HERBIVORE BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_predator_bot"},
	interval = 2,
	chance = 1,
	action = function(pos)
 		--distance to prey to sustain
		local hungerradius_pr = 1


	--count photosynth prey

		local num_preyp = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_pr, y = pos.y - hungerradius_pr, z = pos.z - hungerradius_pr},
			{x = pos.x + hungerradius_pr, y = pos.y + hungerradius_pr, z = pos.z + hungerradius_pr}, {"ecobots:ecobots_photosynth_bot"})
		num_preyp = (cn["ecobots:ecobots_photosynth_bot"] or 0)
		
--count pioneer prey

		local num_preypi = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_pr, y = pos.y - hungerradius_pr, z = pos.z - hungerradius_pr},
			{x = pos.x + hungerradius_pr, y = pos.y + hungerradius_pr, z = pos.z + hungerradius_pr}, {"ecobots:ecobots_pioneer_bot"})
		num_preypi = (cn["ecobots:ecobots_pioneer_bot"] or 0)

		

		-- do if enviro unsuitable or over lim

	if  (num_preyp) + (num_preypi) < 1 then

		-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}





