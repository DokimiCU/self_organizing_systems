

----------------------------------------------------------------
--DECOMPOSER BOT
----------------------------------------------------------------
--SETTINGS
-- similar growth rate to herbivore

local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5

local growth = animal_growth + 2

-- spread by spores ... note not migration like animals
local seed_spread = animal_growth * 2

----------------------------------------------------------------
--- REPLICATE DECOMPOSER BOT

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = growth,
	chance = 15,
	action = function(pos)
	

	---SETTINGS
	--dispersal radius up and horizontal
		local upradius_de = 1
		local horizradius_de = 7

		
	-- population limit within area	
		local decom_poplim = 5
		local decom_poprad = 2


	---POP LIMITS
	--count decomposer bots for pop limits

		local num_decom_bot = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - decom_poprad, y = pos.y - decom_poprad, z = pos.z - decom_poprad},
			{x = pos.x + decom_poprad, y = pos.y + decom_poprad, z = pos.z + decom_poprad}, {"ecobots:ecobots_decomposer_bot"})
		num_decom_bot = (cn["ecobots:ecobots_decomposer_bot"] or 0)
		
		
---LOCATIONS
-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius_de,horizradius_de), y = pos.y + math.random(-upradius_de,upradius_de), z = pos.z + math.random(-horizradius_de,horizradius_de)}


-- for check if food is above and not exposed below
	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}

local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}
	
-- for check if too damp to grow for parent 
	local pos_side = {x = pos.x + math.random (-1,1), y = pos.y, z = pos.z + math.random (-1,1)}

-- find what the parent will eat inorder to reproduce

	local pos_eat = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}



--name for new node for group check

	local newplace_create = minetest.get_node(randpos_above)

--name for eaten node for group check

	local newplace_eat = minetest.get_node(pos_eat)


----CONDITIONAL REPLICATION
		
	-- if under pop limit

	if (num_decom_bot) < decom_poplim then


	-- if parent has found food

	if minetest.get_node(pos_eat).name == "ecobots:ecobots_bot_dead" or minetest.get_item_group(newplace_eat.name, "tree") == 1 then
		
	---if parent doesn't get inhibited by water nearby
		
	if minetest.get_node(pos_side).name ~= "default:water_source" and  minetest.get_node(pos_side).name ~= "default:river_water_source" then
		

--- if child will have food

	if minetest.get_node(randpos_above).name == "ecobots:ecobots_bot_dead" or minetest.get_item_group(newplace_create.name, "tree") == 1 then

--so that doesn't float
	if minetest.get_node(randpos_below).name ~= "air" and minetest.get_node(randpos_below).name ~= "ecobots:ecobots_decomposer_bot" then


---create child below food

			minetest.set_node(randpos, {name = "ecobots:ecobots_decomposer_bot"})

			
--parent eats food
		
			minetest.dig_node(pos_eat)


			
		--decomposer sludge sound
			minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.4, max_hear_distance = 6,})
		end
		end	
		end	
		end
		end

end,
}


----------------------------------------------------------------
-- STARVE KILL DECOMPOSER BOT 

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = 30,
	chance = 5,
	action = function(pos)
 		--distance to food to sustain
		local foodradius = 1


	--count dead bots

		local num_fooda = {}
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - foodradius, y = pos.y - foodradius, z = pos.z - foodradius},
			{x = pos.x + foodradius, y = pos.y + foodradius, z = pos.z + foodradius}, {"ecobots:ecobots_bot_dead"})
		num_fooda = (cn["ecobots:ecobots_bot_dead"] or 0)

	
			

		-- do if enviro unsuitable or over lim

	if  (num_fooda) < 1 then

		-- kill bot leaving behind persistent matter
 			minetest.set_node(pos, {name = "default:dirt"})				
		end
	
end,
}



------------------------------------------------------------------SEED SPREAD
--rare long distance spread to a suitable location

-- SPREADING REPLICATION

minetest.register_abm{
     	nodenames = {"ecobots:ecobots_decomposer_bot"},
	interval = seed_spread,
	chance = 50,
	action = function(pos)
	
	--dispersal radius
		local upradius = 20
		local downradius = 30
		local horizradius = 40
		
		
		

-- get random position for new bot

	local randpos = {x = pos.x + math.random(-horizradius,horizradius), y = pos.y + math.random(-downradius,upradius), z = pos.z + math.random(-horizradius,horizradius)}


-- for check randpos is below is soil and above is air

	local randpos_below = {x = randpos.x, y = randpos.y - 1, z = randpos.z}

	local randpos_above = {x = randpos.x, y = randpos.y + 1, z = randpos.z}





-- do if below air and above dead
				
if minetest.get_node(randpos_below).name == "ecobots:ecobots_bot_dead"and  minetest.get_node(randpos_above).name == "air" then


--create bot 

		minetest.set_node(randpos, {name = "ecobots:ecobots_decomposer_bot"})
	
			
--tree growth sound
		minetest.sound_play("ecobots_sludge", {pos = pos, gain = 0.5, max_hear_distance = 5,})
		
		end
end,
}


