--SETTINGS

--interval for  mating
-- fitness is a race to get the highest score in this time
-- need to give them enough time to go through all their motions before getting overwritten
-- longer peiods reduce effect of short term luck... but make change slower
local mate_rate = minetest.settings:get('evolve_step_size') or 180

---------------------------------------------------------------------
-- SETTINGS FOR RED

-- Target node
--this could be made into a setting to set it for any block type...or as a gene
local target_red = minetest.settings:get('evolve_target_red') or "default:stone_with_coal"

local deposit_red = minetest.settings:get('evolve_deposit_red') or "default:coalblock"


--how much of the target must it mine until it can deposit and mate?
-- condensed Coal blocks are 9 lots of ore

local depot_num_red = minetest.settings:get('evolve_depot_num_red') or 9
--trying to fix the depot bug
--whenever depot_num is changed it then decides that is a string, despite finctioning fine before the changed
--this includes changing directly in the code... the conflict is with the config file?
--so just force the bastard back to a number? It works
local depot_num_1_red = tonumber(depot_num_red)


--the medium through which it can destructively dig
--"Stone" in codes, but could be any group
--must be a group
local medium_red = minetest.settings:get('evolve_medium_red') or "stone"

--medium through which it can move
--A in codes
-- so can get it too move through water etc as well
local air_red = minetest.settings:get('evolve_air_red') or "air"


-------------------------------------------------------------
-- SETTINGS FOR BLUE
local target_blue = minetest.settings:get('evolve_target_blue') or "default:stone_with_iron"
local deposit_blue = minetest.settings:get('evolve_deposit_blue') or "default:steelblock"

local depot_num_blue = minetest.settings:get('evolve_depot_num_blue') or 9
local depot_num_1_blue = tonumber(depot_num_blue)

local medium_blue = minetest.settings:get('evolve_medium_blue') or "stone"
local air_blue = minetest.settings:get('evolve_air_blue') or "air"




------------------------------------------------------------
--[[
--Abandoned this idea. Tends to be far too restrictive
--hardly nothing ever moves... works, but doesn't work!
-- the idea was to add an extra constraint to their movement
-- e.g. making them clump, or stick to ground.

--Neighbors
local glue = minetest.settings:get('evolve_glue') or "none"
local repel = minetest.settings:get('evolve_repel') or "none"

--ID position of neighbour for new pos
-- go into a math.random(min,max)
-- glue
local gx_max = minetest.settings:get('evolve_gx_max') or 1
local gx_min = minetest.settings:get('evolve_gx_min') or -1
local gy_max = minetest.settings:get('evolve_gy_max') or 1
local gy_min = minetest.settings:get('evolve_gy_min') or -1
local gz_max = minetest.settings:get('evolve_gz_max') or 1
local gz_min = minetest.settings:get('evolve_gz_min') or -1

-- repel
local rx_max = minetest.settings:get('evolve_rx_max') or 1
local rx_min = minetest.settings:get('evolve_rx_min') or -1
local ry_max = minetest.settings:get('evolve_ry_max') or 1
local ry_min = minetest.settings:get('evolve_ry_min') or -1
local rz_max = minetest.settings:get('evolve_rz_max') or 1
local rz_min = minetest.settings:get('evolve_rz_min') or -1

--this stuff goes in settings... should anyone wish to resurrect this stuff
# Neighbors
# Attraction, stick to 'em like glue.
# Bot can only move to spaces bordered by this block
# Must be a specific node
# position of the relevant neighbor set by gx_max etc
# to disable set as none (the default value)
evolve_glue (Glue) string none

# Neighbors
# Avoidance, repel 'em.
# Bot can only move to spaces not bordered by this block
# Must be a specific node
# position of the relevant neighbor set by rx_max etc
# to disable set as none (the default value)
evolve_repel (Repel) string none

# Neighbors attraction
evolve_gx_max (glue x max) int 1

# Neighbors attraction
evolve_gx_min (glue x min) int -1

# Neighbors attraction
evolve_gy_max (glue y max) int 1

# Neighbors attraction
evolve_gy_min (glue y min) int -1

# Neighbors attraction
evolve_gz_max (glue z max) int 1

# Neighbors attraction
evolve_gz_min (glue z min) int -1


# Neighbors avoidance
evolve_rx_max (repel x max) int 1

# Neighbors avoidance
evolve_rx_min (repel x min) int -1

# Neighbors avoidance
evolve_ry_max (repel y max) int 1

# Neighbors avoidance
evolve_ry_min (repel y min) int -1

# Neighbors avoidance
evolve_rz_max (repel z max) int 1

# Neighbors avoidance
evolve_rz_min (repel z min) int -1


]]


--------------------------------------------------------------------
--MINING
--------------------------------------------------------------------
-- interval and chance shouldn't be too low.. probably interferes with evo functions
minetest.register_abm{
  nodenames = {"evolve:evolve_miner", "evolve:evolve_blue"},
  interval = 1.5,
  chance = 3,
  action = function(pos)

    local meta = minetest.get_meta(pos)
    local pause = meta:get_string("paused")
    --don't allow digging if at max inventory otherwise it goes above 9
    local inv_score = meta:get_float("inv_score")

    if pause == "active" then

      --name to feed through for all the save files etc
      --make sure consistent with all the buttons pushed in the register_node
      local name = nil
      local node_name = nil
      local target =nil
      local medium = nil
      local air = nil
      local depot_num = nil

      if minetest.get_node(pos).name == "evolve:evolve_miner" then
        name = "red"
        node_name = "evolve:evolve_miner"
        target = target_red
        medium = medium_red
        air = air_red
        depot_num = depot_num_1_red
      end

      if minetest.get_node(pos).name == "evolve:evolve_blue" then
        name = "blue"
        node_name = "evolve:evolve_blue"
        target = target_blue
        medium = medium_blue
        air = air_blue
        depot_num = depot_num_1_blue
      end

    --Get Positions... BAS
    --Below
    local below = {x = pos.x, y = pos.y - 1, z = pos.z}

    --Above
    local above = {x = pos.x, y = pos.y + 1, z = pos.z}

    --Random Side
    local side_1 = {x = pos.x + 1, y = pos.y, z = pos.z}
    local side_2 = {x = pos.x - 1, y = pos.y, z = pos.z}
    local side_3 = {x = pos.x, y = pos.y, z = pos.z + 1}
    local side_4 = {x = pos.x, y = pos.y, z = pos.z - 1}


     --get random side
     local random_number = math.random(1,5)
     local ranside = {}
     if random_number > 1 then ranside = side_1
       if random_number > 2 then ranside = side_2
         if random_number > 3 then ranside = side_3
           if random_number > 4 then ranside = side_4
           end
         end
       end
     end

     --names for substrate check

      local below_check = minetest.get_node(below)
      local above_check = minetest.get_node(above)
      local side_check = minetest.get_node(ranside)



      --ID situation returns gene code BAS e.g. SSS
      local gene = evolve.get_situation (target, medium, air, below, above, ranside, below_check, above_check, side_check)


      -- recall genome from meta to get the allele
      local allele  = evolve.recall_genome (pos, gene)



      -- act on the strategy of the allele
      if string.find(allele, "DB") and inv_score < depot_num then
        minetest.dig_node(below)

        evolve.score_digging (pos, below_check, name)
      end

      if string.find(allele, "DA") and inv_score < depot_num then
        minetest.dig_node(above)

        evolve.score_digging (pos, above_check, name)
      end

      if string.find(allele, "DS") and inv_score < depot_num then
        minetest.dig_node(ranside)

        evolve.score_digging (pos, side_check, name)
      end

      if string.find(allele, "MB") then

        --[[
        --get neighbors location for below
        local gneighbor = {x = below.x + math.random(-gx_min, gx_max), y = below.y + math.random(-gy_min, gy_max), z = below.z + math.random(-gz_min, gz_max)}
        local rneighbor = {x = below.x + math.random(-gx_min, gx_max), y = below.y + math.random(-gy_min, gy_max), z = below.z + math.random(-gz_min, gz_max)}
        --neighbors condition
        -- we are either not using it, or it is a go, and true for both glue and repel
        if (glue == "none" or minetest.get_node(gneighbor).name == glue ) and (repel == "none" or minetest.get_node(rneighbor).name ~= repel) then
        ]]

          --do it!
          minetest.sound_play("evolve_move", {pos = pos, gain = 0.6, max_hear_distance = 15,})
          local g = evolve.retain_genome (pos)
          minetest.set_node(below, {name = node_name})
          evolve.retain_genome_2 (below, g)
          minetest.set_node(pos, {name = air})
        --end
      end

      if string.find(allele, "MA") then
        --[[
        --get neighbors location for below
        local gneighbor = {x = above.x + math.random(-gx_min, gx_max), y = above.y + math.random(-gy_min, gy_max), z = above.z + math.random(-gz_min, gz_max)}
        local rneighbor = {x = above.x + math.random(-gx_min, gx_max), y = above.y + math.random(-gy_min, gy_max), z = above.z + math.random(-gz_min, gz_max)}
        --neighbors condition
        -- we are either not using it, or it is a go, and true for both glue and repel
        if (glue == "none" or minetest.get_node(gneighbor).name == glue ) and (repel == "none" or minetest.get_node(rneighbor).name ~= repel) then
        ]]
          --do it!
          minetest.sound_play("evolve_move", {pos = pos, gain = 0.6, max_hear_distance = 15,})
          local g = evolve.retain_genome (pos)
          minetest.set_node(above, {name = node_name})
          evolve.retain_genome_2 (above, g)
          minetest.set_node(pos, {name = air})
        --end
      end

      if string.find(allele, "MS") then
        --[[
        --get neighbors location for below
        local gneighbor = {x = ranside.x + math.random(-gx_min, gx_max), y = ranside.y + math.random(-gy_min, gy_max), z = ranside.z + math.random(-gz_min, gz_max)}
        local rneighbor = {x = ranside.x + math.random(-gx_min, gx_max), y = ranside.y + math.random(-gy_min, gy_max), z = ranside.z + math.random(-gz_min, gz_max)}
        --neighbors condition
        -- we are either not using it, or it is a go, and true for both glue and repel
        if (glue == "none" or minetest.get_node(gneighbor).name == glue ) and (repel == "none" or minetest.get_node(rneighbor).name ~= repel) then
        ]]
          --do it!
          minetest.sound_play("evolve_move", {pos = pos, gain = 0.6, max_hear_distance = 15,})
          local g = evolve.retain_genome (pos)
          minetest.set_node(ranside, {name = node_name})
          evolve.retain_genome_2 (ranside, g)
          minetest.set_node(pos, {name = air})
        --end
      end


end

end,
}


--------------------------------------------------------------------
--CREATE DEPOTS..
--------------------------------------------------------------------

minetest.register_abm{
  nodenames = {"evolve:evolve_miner", "evolve:evolve_blue"},
  interval = 1,
  chance = 1,
  action = function(pos)


    local meta = minetest.get_meta(pos)
    local pause = meta:get_string("paused")
    --only active bots take action, also needs this to pull the get name for each bot part in
    if pause == "active" then

      --Positions
      local randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1, 1), z = pos.z + math.random(-1,1)}

      --names for substrate check
      local randpos_check = minetest.get_node(randpos)

      local inv_score = meta:get_float("inv_score")
      local score = meta:get_float("score")

      --name to feed through for all the save files etc
      --make sure consistent with all the buttons pushed in the register_node
      local name = nil
      local node_name = nil
      local depot_num = nil
      local deposit =nil
      local medium = nil
      local air = nil

      if minetest.get_node(pos).name == "evolve:evolve_miner" then
        name = "red"
        node_name = "evolve:evolve_miner"
        depot_num = depot_num_1_red
        deposit = deposit_red
        medium = medium_red
        air = air_red
      end

      if minetest.get_node(pos).name == "evolve:evolve_blue" then
        name = "blue"
        node_name = "evolve:evolve_blue"
        depot_num = depot_num_1_blue
        deposit = deposit_blue
        medium = medium_blue
        air = air_blue
      end

        --- conditions
        --has enough
        if inv_score >= depot_num then


          --dump site is empty or destroyable
          -- both actual air and what ever is set as move medium e.g. water count as empty
          if (minetest.get_node(randpos).name == air or minetest.get_node(randpos).name == "air")  or minetest.get_item_group(randpos_check.name, medium) >= 1 then

              --empty inventory
              meta:set_float("inv_score", (inv_score - depot_num))
              -- plonk it down
              minetest.set_node(randpos, {name = deposit})
              -- let it sound
              minetest.sound_play("evolve_deposit", {pos = pos, gain = 5, max_hear_distance = 25,})
              --get form up to date
              evolve.update_form(pos)

              --additional step if it is self replicating
              --set new bot's genome from parent
              if deposit == node_name then

                local g = evolve.retain_genome (pos,name)
                evolve.retain_genome_2 (randpos, g)
                local meta2 = minetest.get_meta(randpos)
                meta2:set_float("inv_score", 0)
                meta2:set_float("score", 0)
              end
          end
      end
    end
  end,
  }


  --------------------------------------------------------------------
  --MATING WAVE
  --------------------------------------------------------------------
--everybody mates


  minetest.register_abm{
    nodenames = {"evolve:evolve_miner", "evolve:evolve_blue"},
    interval = mate_rate,
    chance = 1,
    catch_up = false,
    action = function(pos)

        local meta = minetest.get_meta(pos)
        local pause = meta:get_string("paused")

        --name to feed through for all the save files
        --make sure consistent with all the buttons pushed in the register_node
        local name = nil

        if minetest.get_node(pos).name == "evolve:evolve_miner" then
          name = "red"
        end

        if minetest.get_node(pos).name == "evolve:evolve_blue" then
          name = "blue"
        end

        -- don't allow unset and ones that you are fiddling with go into this
        if pause == "active" then

          --mating
            evolve.mate_genome_1(pos, name)



          --shitty score to overwrite used current file
          -- replaces all data with a blank
          -- needs to be called after everyone has been through,
          -- otherwise each one just wipes it and allows it to be replaced by whoever is next
          -- add a time delay which is less than the mate_rate so it only gets wiped after they're all done, but before the next round
          -- because everyone is calling it it will be done more than the once needed...but oh well
              local timer = 0
              local go_time = mate_rate/2
              local shit_score = "blank"
              minetest.register_globalstep(function(dtime)
              timer = timer + dtime;
                if timer >= go_time then
                  --reset current score to allow for next round!
                  evolve.save_genome(shit_score, name)
                  timer = 0
                end
              end)

        end
    end,
    }
