

----------------------------------------------------------------
--DECOMPOSER BOT
----------------------------------------------------------------




----------------------------------------------------------------
--- REPLICATE DECOMPOSER BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = 5,
	chance = 30,
	action = function(pos)
	
	--dispersal radius up and horizontal
		local upradius_de = 7
		local horizradius_de = 7

		
	-- population limit within area	
		local decom_poplim = 5
		local decom_poprad = 2


	--count decomposer bots for pop limits

		local num_decom_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - decom_poprad, y = pos.y - decom_poprad, z = pos.z - decom_poprad},
			{x = pos.x + decom_poprad, y = pos.y + decom_poprad, z = pos.z + decom_poprad}, {"ecobots:ecobots_decomposer_bot"})
		num_decom_bot = (cn["ecobots:ecobots_decomposer_bot"] or 0)
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_de,horizradius_de), y = pos.y + math.random(-upradius_de,upradius_de), z = pos.z + math.random(-horizradius_de,horizradius_de)}


-- for check randpos is food above below is dirt currently unused
	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_side = {x = randpos.x + math.random (-1,1), y = randpos.y, z = randpos.z + math.random (-1,1)}


		
	-- create if under pop limit and new node dead are below
	if (num_decom_bot) < decom_poplim and minetest.get_node(randpos_below).name == "ecobots:ecobots_bot_dead" then


		-- Create new decom bot if location suitable
		---check for water as wet inhibits decomp		
if minetest.get_node(randpos_side).name ~= "default:water_source" and  minetest.get_node(randpos_side).name ~= "default:river_water_source" then
		
		if minetest.get_node(randpos_above).name == "ecobots:ecobots_bot_dead" or minetest.get_node(randpos_above).name == "default:tree" then

			minetest.set_node(randpos, {name = "ecobots:ecobots_decomposer_bot"})
			
			--eat above if not under tree 
			local eatpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}
			local eatpos_abovethat = {x = randpos.x, y = randpos.y + 2, z = randpos.z}
		if minetest.get_node(eatpos_abovethat).name ~= "default:tree" then
			minetest.dig_node(eatpos_above)

			
		--decomposer sludge sound
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.4, max_hear_distance = 6,})
		end	
		end	
		end
	end
end,
}


----------------------------------------------------------------
-- KILL DECOMPOSER BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = 2,
	chance = 1,
	action = function(pos)
 		--distance to food to sustain
		local foodradius = 1


	--count dead bots

		local num_fooda = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - foodradius, y = pos.y - foodradius, z = pos.z - foodradius},
			{x = pos.x + foodradius, y = pos.y + foodradius, z = pos.z + foodradius}, {"ecobots:ecobots_bot_dead"})
		num_fooda = (cn["ecobots:ecobots_bot_dead"] or 0)

	
--count tree wood

		local num_foodb = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - foodradius, y = pos.y - foodradius, z = pos.z - foodradius},
			{x = pos.x + foodradius, y = pos.y + foodradius, z = pos.z + foodradius}, {"default:tree"})
		num_foodb = (cn["default:tree"] or 0)
			

		-- do if enviro unsuitable or over lim

	if  (num_fooda) + (num_foodb) < 1 then

		-- kill bot leaving behind persistent matter
 			minetest.set_node(pos, {name = "default:dirt"})				
		end
	
end,
}


