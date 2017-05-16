


----------------------------------------------------------------
---DETRITIVORE BOT
----------------------------------------------------------------

----------------------------------------------------------------
--REPLICATE DETRITIVORE BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = 5,
	chance = 40,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_detrit = 7
		local horizradius_detrit = 7

		
	-- population limit within area	
		local detrit_poplim = 5
		local detrit_poprad = 2

	--count detritivore bots

		local num_detrit_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - detrit_poprad, y = pos.y - detrit_poprad, z = pos.z - detrit_poprad},
			{x = pos.x + detrit_poprad, y = pos.y + detrit_poprad, z = pos.z + detrit_poprad}, {"ecobots:ecobots_predator_bot"})
		num_detrit_bot = (cn["ecobots:ecobots_detritivore_bot"] or 0)
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_detrit,horizradius_detrit), y = pos.y + math.random(-upradius_detrit,upradius_detrit), z = pos.z + math.random(-horizradius_detrit,horizradius_detrit)}


-- for check randpos is prey below and above air
	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}
		

		
	-- create if under pop limit
	if (num_detrit_bot) < detrit_poplim then


		-- Create detrit bot if location suitable...tunnel 
				
		
		if minetest.get_node(randpos_below).name == "ecobots:ecobots_decomposer_bot" and minetest.get_node(randpos_above).name == "air" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_detritivore_bot"})

			-- for eat the creature beneath
			local eatpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

		--- dig so it collapses
			minetest.dig_node(eatpos_below)



		--predator cry sound
			minetest.sound_play("ecobots_muffled_dig", {pos = pos, gain = 0.3, max_hear_distance = 6,})
		
		end	
	end
end,
}



--  KILL DETRITIVORE bot 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_detritivore_bot"},
	interval = 2,
	chance = 1,
	action = function(pos)
 		--distance to prey to sustain
		local hungerradius_detrit = 1


	--count decomposer prey

		local num_preydec = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - hungerradius_detrit, y = pos.y - hungerradius_detrit, z = pos.z - hungerradius_detrit},
			{x = pos.x + hungerradius_detrit, y = pos.y + hungerradius_detrit, z = pos.z + hungerradius_detrit}, {"ecobots:ecobots_decomposer_bot"})
		num_preydec = (cn["ecobots:ecobots_decomposer_bot"] or 0)
		

		

		-- Kill if buried or no food
	local tunnel_above = {x = pos.x, y = pos.y + 1, z = pos.z}

	if  (num_preydec) < 1  then

		-- kill bot 			
			minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})	
						
		end
	
end,
}


