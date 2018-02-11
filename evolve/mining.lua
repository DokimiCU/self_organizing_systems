--interval for  mating
-- fitness is a race to get the highest score in this time
-- need to give them enough time to go through all their motions before getting overwritten
-- longer peiods reduce effect of short term luck... but make change slower
local mate_rate = 180

-- Target node
--this could be made into a setting to set it for any block type...or as a gene
local target = minetest.settings:get('evolve_target') or "default:stone_with_coal"

local deposit = minetest.settings:get('evolve_deposit') or "default:coalblock"


--how much of the target must it mine until it can deposit and mate?
-- condensed Coal blocks are 9 lots of ore


local depot_num = minetest.settings:get('evolve_depot_num') or 9
--trying to fix the depot bug
--whenever depot_num is changed it then decides that is a string, despite finctioning fine before the changed
--this includes changing directly in the code... the conflict is with the config file?
--so just force the bastard back to a number? It works
local depot_num_1 = tonumber(depot_num)


--the medium through which it can destructively dig
--"Stone" in codes, but could be any group
--must be a group
local medium = minetest.settings:get('evolve_medium') or "stone"

--medium through which it can move
--A in codes
-- so can get it too move through water etc as well
local air = minetest.settings:get('evolve_air') or "air"


--------------------------------------------------------------------
--MINING
--------------------------------------------------------------------
-- interval and chance shouldn't be too low.. probably interferes with evo functions
minetest.register_abm{
  nodenames = {"evolve:evolve_miner"},
  interval = 1.5,
  chance = 3,
  action = function(pos)

    local meta = minetest.get_meta(pos)
    local pause = meta:get_string("paused")
    --don't allow digging if at max inventory otherwise it goes above 9
    local inv_score = meta:get_float("inv_score")

    if pause == "active" then




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
      local gene = evolve.get_situation (target, medium, below, above, ranside, below_check, above_check, side_check)


      -- recall genome from meta to get the allele
      local allele  = evolve.recall_genome (pos, gene)



      -- act on the strategy of the allele
      if string.find(allele, "DB") and inv_score < depot_num_1 then
        minetest.dig_node(below)

        evolve.score_digging (pos, below_check)
      end

      if string.find(allele, "DA") and inv_score < depot_num_1 then
        minetest.dig_node(above)

        evolve.score_digging (pos, above_check)
      end

      if string.find(allele, "DS") and inv_score < depot_num_1 then
        minetest.dig_node(ranside)

        evolve.score_digging (pos, side_check)
      end

      if string.find(allele, "MB") then
        minetest.sound_play("evolve_move", {pos = pos, gain = 0.6, max_hear_distance = 15,})
        local g = evolve.retain_genome (pos)
        minetest.set_node(below, {name = "evolve:evolve_miner"})
        evolve.retain_genome_2 (below, g)
        minetest.set_node(pos, {name = air})
      end

      if string.find(allele, "MA") then
        minetest.sound_play("evolve_move", {pos = pos, gain = 0.6, max_hear_distance = 15,})
        local g = evolve.retain_genome (pos)
        minetest.set_node(above, {name = "evolve:evolve_miner"})
        evolve.retain_genome_2 (above, g)
          minetest.set_node(pos, {name = air})
      end

      if string.find(allele, "MS") then
        minetest.sound_play("evolve_move", {pos = pos, gain = 0.6, max_hear_distance = 15,})
        local g = evolve.retain_genome (pos)
        minetest.set_node(ranside, {name = "evolve:evolve_miner"})
        evolve.retain_genome_2 (ranside, g)
        minetest.set_node(pos, {name = air})
      end


end

end,
}


--------------------------------------------------------------------
--CREATE DEPOTS..
--------------------------------------------------------------------

minetest.register_abm{
  nodenames = {"evolve:evolve_miner"},
  interval = 1,
  chance = 1,
  action = function(pos)


    --Positions
    local randpos = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1, 1), z = pos.z + math.random(-1,1)}

    --names for substrate check
    local randpos_check = minetest.get_node(randpos)

    local meta = minetest.get_meta(pos)
    local inv_score = meta:get_float("inv_score")
    local score = meta:get_float("score")


    --- conditions
    --has enough
    if inv_score >= (depot_num_1) then

      --dump site is empty or destroyable
      -- both actual air and what ever is set as move medium e.g. water count as empty
      if (minetest.get_node(randpos).name == air or minetest.get_node(randpos).name == "air")  or minetest.get_item_group(randpos_check.name, medium) >= 1 then

          --empty inventory
          meta:set_float("inv_score", (inv_score - depot_num_1))
          -- plonk it down
          minetest.set_node(randpos, {name = deposit})
          -- let it sound
          minetest.sound_play("evolve_deposit", {pos = pos, gain = 5, max_hear_distance = 25,})
          --get form up to date
          evolve.update_form(pos)
      end
    end
  end,
  }


  --------------------------------------------------------------------
  --MATING WAVE
  --------------------------------------------------------------------
--everybody mates


  minetest.register_abm{
    nodenames = {"evolve:evolve_miner"},
    interval = mate_rate,
    chance = 1,
    catch_up = false,
    action = function(pos)

        local meta = minetest.get_meta(pos)
        local pause = meta:get_string("paused")

        -- don't allow unset and ones that you are fiddling with go into this
        if pause == "active" then

          --mating
            evolve.mate_genome_1(pos, mate_rate)



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
                  evolve.save_genome(shit_score)
                  timer = 0
                end
              end)

        end
    end,
    }
