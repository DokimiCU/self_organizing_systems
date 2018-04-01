
-- SETTINGS

--number of genes mutated with reproduction
local mutate_count1 = minetest.settings:get('evolve_mutate') or 4
--weird settings bug?
--so just force the bastard back to a number?
local mutate_count = tonumber(mutate_count1)

--points for digging target and for digging, and for moving
-- high target scores allows bots to luck out too easy, swamping past failures in one big hit
local target_score = 15
local dig_score = -1
local move_score = -1

-------------------------------------------------------------
-- SETTINGS FOR RED

--the medium through which it can destructively dig
--"Stone" in codes, but could be any group
--must be a group
--(this setting is also in mining.lua)
local medium_red = minetest.settings:get('evolve_medium_red') or "stone"

--medium through which it can move
--A in codes
-- so can get it too move through water etc as well
local air_red = minetest.settings:get('evolve_air_red') or "air"


local depot_num_red = minetest.settings:get('evolve_depot_num_red') or 9
--trying to fix the depot bug
--whenever depot_num is changed it then decides that is a string, despite finctioning fine before the changed
--this includes changing directly in the code... the conflict is with the config file?
--so just force the bastard back to a number? It works
local depot_num_1_red = tonumber(depot_num_red)

-------------------------------------------------------------
-- SETTINGS FOR BLUE
local medium_blue = minetest.settings:get('evolve_medium_blue') or "stone"
local air_blue = minetest.settings:get('evolve_air_blue') or "air"
local depot_num_blue = minetest.settings:get('evolve_depot_num_blue') or 9
local depot_num_1_blue = tonumber(depot_num_blue)


------------------------------------------------------------------------
---FUNCTIONS
------------------------------------------------------------------------



--ID SITUATION

evolve.get_situation = function(target, medium, air, below, above, ranside, below_check, above_check, side_check)
  local below_type = "O"
  local above_type = "O"
  local side_type = "O"

  --ID below
  if minetest.get_item_group(below_check.name, medium) >= 1 then
    below_type = "S"
  end

  if minetest.get_node(below).name == target then
    below_type = "T"
  end

  if minetest.get_node(below).name == air then
    below_type = "A"
  end

  --ID above
  if minetest.get_item_group(above_check.name, medium) >= 1 then
    above_type = "S"
  end

  if minetest.get_node(above).name == target then
    above_type = "T"
  end

  if minetest.get_node(above).name == air then
    above_type = "A"
  end

  --ID side
  if minetest.get_item_group(side_check.name, medium) >= 1 then
    side_type = "S"
  end

  if minetest.get_node(ranside).name == target then
    side_type = "T"
  end

  if minetest.get_node(ranside).name == air then
        side_type = "A"
  end


local gene = below_type .. above_type .. side_type

return gene

end


--CONVERT SITUATION GENE CODE INTO ALLELE FROM METADATA

evolve.recall_genome = function(pos, gene)
  local meta = minetest.get_meta(pos)
  local allele = meta:get_string(string.upper(gene))
    return allele

end



--------------------------------------------------------------------
--MOVEMENT FUNCTIONS

--TRANSFER GENOME WHEN MOVING FROM THE OLD TO NEW POSITION TO RETAIN IDENTITY
evolve.retain_genome = function(pos)


  local meta = minetest.get_meta(pos)

  local g = {}
  g.SSS = meta:get_string("SSS")
  g.SST = meta:get_string("SST")
  g.SSO = meta:get_string("SSO")
  g.SSA = meta:get_string("SSA")
  g.STS = meta:get_string("STS")
  g.STT = meta:get_string("STT")
  g.STO = meta:get_string("STO")
  g.STA = meta:get_string("STA")
  g.SOS = meta:get_string("SOS")
  g.SOT = meta:get_string("SOT")
  g.SOO = meta:get_string("SOO")
  g.SOA = meta:get_string("SOA")
  g.SAS = meta:get_string("SAS")
  g.SAT = meta:get_string("SAT")
  g.SAO = meta:get_string("SAO")
  g.SAA = meta:get_string("SAA")
  g.TSS = meta:get_string("TSS")
  g.TST = meta:get_string("TST")
  g.TSO = meta:get_string("TSO")
  g.TSA = meta:get_string("TSA")
  g.TTS = meta:get_string("TTS")
  g.TTT = meta:get_string("TTT")
  g.TTO = meta:get_string("TTO")
  g.TTA = meta:get_string("TTA")
  g.TOS = meta:get_string("TOS")
  g.TOT = meta:get_string("TOT")
  g.TOO = meta:get_string("TOO")
  g.TOA = meta:get_string("TOA")
  g.TAS = meta:get_string("TAS")
  g.TAT = meta:get_string("TAT")
  g.TAO = meta:get_string("TAO")
  g.TAA = meta:get_string("TAA")
  g.ASS = meta:get_string("ASS")
  g.AST = meta:get_string("AST")
  g.ASO = meta:get_string("ASO")
  g.ASA = meta:get_string("ASA")
  g.ATS = meta:get_string("ATS")
  g.ATT = meta:get_string("ATT")
  g.ATO = meta:get_string("ATO")
  g.ATA = meta:get_string("ATA")
  g.AOS = meta:get_string("AOS")
  g.AOT = meta:get_string("AOT")
  g.AOO = meta:get_string("AOO")
  g.AOA = meta:get_string("AOA")
  g.AAS = meta:get_string("AAS")
  g.AAT = meta:get_string("AAT")
  g.AAO = meta:get_string("AAO")
  g.AAA = meta:get_string("AAA")
  g.OSS = meta:get_string("OSS")
  g.OST = meta:get_string("OST")
  g.OSO = meta:get_string("OSO")
  g.OSA = meta:get_string("OSA")
  g.OTS = meta:get_string("OTS")
  g.OTT = meta:get_string("OTT")
  g.OTO = meta:get_string("OTO")
  g.OTA = meta:get_string("OTA")
  g.OOS = meta:get_string("OOS")
  g.OOT = meta:get_string("OOT")
  g.OOO = meta:get_string("OOO")
  g.OOA = meta:get_string("OOA")
  g.OAS = meta:get_string("OAS")
  g.OAT = meta:get_string("OAT")
  g.OAO = meta:get_string("OAO")
  g.OAA = meta:get_string("OAA")
  g.score = meta:get_float("score")
  g.inv_score = meta:get_float("inv_score")
  g.paused = meta:get_string("paused")
  g.generation = meta:get_float("generation")
  return g

end

--SECOND STEP OF RETAIN GENOME... includes scoring for movement
evolve.retain_genome_2 = function(pos, genome_table)


  local g = genome_table

  local meta = minetest.get_meta(pos)

  meta:set_string("SSS", g.SSS)
  meta:set_string("SST", g.SST)
  meta:set_string("SSO", g.SSO)
  meta:set_string("SSA", g.SSA)
  meta:set_string("STS", g.STS)
  meta:set_string("STT", g.STT)
  meta:set_string("STO", g.STO)
  meta:set_string("STA", g.STA)
  meta:set_string("SOS", g.SOS)
  meta:set_string("SOT", g.SOT)
  meta:set_string("SOO", g.SOO)
  meta:set_string("SOA", g.SOA)
  meta:set_string("SAS", g.SAS)
  meta:set_string("SAT", g.SAT)
  meta:set_string("SAO", g.SAO)
  meta:set_string("SAA", g.SAA)
  meta:set_string("TSS", g.TSS)
  meta:set_string("TST", g.TST)
  meta:set_string("TSO", g.TSO)
  meta:set_string("TSA", g.TSA)
  meta:set_string("TTS", g.TTS)
  meta:set_string("TTT", g.TTT)
  meta:set_string("TTO", g.TTO)
  meta:set_string("TTA", g.TTA)
  meta:set_string("TOS", g.TOS)
  meta:set_string("TOT", g.TOT)
  meta:set_string("TOO", g.TOO)
  meta:set_string("TOA", g.TOA)
  meta:set_string("TAS", g.TAS)
  meta:set_string("TAT", g.TAT)
  meta:set_string("TAO", g.TAO)
  meta:set_string("TAA", g.TAA)
  meta:set_string("ASS", g.ASS)
  meta:set_string("AST", g.AST)
  meta:set_string("ASO", g.ASO)
  meta:set_string("ASA", g.ASA)
  meta:set_string("ATS", g.ATS)
  meta:set_string("ATT", g.ATT)
  meta:set_string("ATO", g.ATO)
  meta:set_string("ATA", g.ATA)
  meta:set_string("AOS", g.AOS)
  meta:set_string("AOT", g.AOT)
  meta:set_string("AOO", g.AOO)
  meta:set_string("AOA", g.AOA)
  meta:set_string("AAS", g.AAS)
  meta:set_string("AAT", g.AAT)
  meta:set_string("AAO", g.AAO)
  meta:set_string("AAA", g.AAA)
  meta:set_string("OSS", g.OSS)
  meta:set_string("OST", g.OST)
  meta:set_string("OSO", g.OSO)
  meta:set_string("OSA", g.OSA)
  meta:set_string("OTS", g.OTS)
  meta:set_string("OTT", g.OTT)
  meta:set_string("OTO", g.OTO)
  meta:set_string("OTA", g.OTA)
  meta:set_string("OOS", g.OOS)
  meta:set_string("OOT", g.OOT)
  meta:set_string("OOO", g.OOO)
  meta:set_string("OOA", g.OOA)
  meta:set_string("OAS", g.OAS)
  meta:set_string("OAT", g.OAT)
  meta:set_string("OAO", g.OAO)
  meta:set_string("OAA", g.OAA)

  meta:set_float("score", g.score + move_score)
  meta:set_float("inv_score", g.inv_score)
  meta:set_string("paused", g.paused)
  meta:set_float("generation", g.generation)

  evolve.update_form(pos)

end


--------------------------------------------------------------------------
-- SCORING


--SCORING FOR BOTH TYPES OF DIGGING...pos of node, pos of dug node, name of dug node pos for group check

evolve.score_digging = function(pos, dig_pos_name, name)

  local meta = minetest.get_meta(pos)
  local score = meta:get_float("score")
  local inv_score = meta:get_float("inv_score")

  local dug_check = dig_pos_name

  --match to bot
  if name == "red" then
    medium = medium_red
  end

  if name == "blue" then
    medium = medium_blue
  end


  --ID and score...should only call when digging medium or target so don't need double check
  if minetest.get_item_group(dug_check.name, medium) >= 1 then
      meta:set_float("score", score + dig_score)
      minetest.sound_play("evolve_dig", {pos = pos, gain = 0.6, max_hear_distance = 15,})
    else
    meta:set_float("score", score + target_score)
    meta:set_float("inv_score", inv_score + 1)
    minetest.sound_play("evolve_dig_t", {pos = pos, gain = 0.6, max_hear_distance = 15,})
  end

  evolve.update_form(pos)


end


---------------------------------------------------------------------
--SETTING INITIAL GENOMES


-- SET DEFAULT Genome

evolve.set_default = function(pos)

  local meta = minetest.get_meta(pos)

  meta:set_float("score", 0)
  meta:set_float("inv_score", 0.0)
  meta:set_string("paused", "paused")
  meta:set_float("generation", 0)

  meta:set_string("SSS", "DB")
  meta:set_string("SST", "DS")
  meta:set_string("SSO","DB")
  meta:set_string("SSA", "MS")
  meta:set_string("STS", "DA")
  meta:set_string("STT", "DA")
  meta:set_string("STO", "DA")
  meta:set_string("STA", "DA")
  meta:set_string("SOS", "DB")
  meta:set_string("SOT", "DS")
  meta:set_string("SOO", "DB")
  meta:set_string("SOA", "DB")
  meta:set_string("SAS", "DB")
  meta:set_string("SAT", "DS")
  meta:set_string("SAO", "DB")
  meta:set_string("SAA", "MS")
  meta:set_string("TSS", "DB")
  meta:set_string("TST", "DS")
  meta:set_string("TSO", "DB")
  meta:set_string("TSA", "DB")
  meta:set_string("TTS", "DA")
  meta:set_string("TTT", "DS")
  meta:set_string("TTO", "DA")
  meta:set_string("TTA", "DA")
  meta:set_string("TOS", "DB")
  meta:set_string("TOT", "DS")
  meta:set_string("TOO", "DB")
  meta:set_string("TOA", "DB")
  meta:set_string("TAS", "DB")
  meta:set_string("TAT", "DS")
  meta:set_string("TAO", "DB")
  meta:set_string("TAA", "DB")
  meta:set_string("ASS", "MB")
  meta:set_string("AST", "DS")
  meta:set_string("ASO", "MB")
  meta:set_string("ASA", "MB")
  meta:set_string("ATS", "DA")
  meta:set_string("ATT", "DA")
  meta:set_string("ATO", "DA")
  meta:set_string("ATA", "DA")
  meta:set_string("AOS", "MB")
  meta:set_string("AOT", "DS")
  meta:set_string("AOO", "MB")
  meta:set_string("AOA", "MS")
  meta:set_string("AAS", "MB")
  meta:set_string("AAT", "DS")
  meta:set_string("AAO", "MB")
  meta:set_string("AAA", "MB")
  meta:set_string("OSS", "DS")
  meta:set_string("OST", "DS")
  meta:set_string("OSO", "DA")
  meta:set_string("OSA", "MS")
  meta:set_string("OTS", "DA")
  meta:set_string("OTT", "DA")
  meta:set_string("OTO", "DA")
  meta:set_string("OTA", "DA")
  meta:set_string("OOS", "DS")
  meta:set_string("OOT", "DS")
  meta:set_string("OOO", "NA")
  meta:set_string("OOA", "MS")
  meta:set_string("OAS", "DS")
  meta:set_string("OAT", "DS")
  meta:set_string("OAO", "MA")
  meta:set_string("OAA", "MS")

end




-- SET RANDOM Genome

evolve.set_random = function(pos)

local meta = minetest.get_meta(pos)
local newgene = "NA"

meta:set_float("score", 0)
meta:set_float("inv_score", 0.0)
meta:set_string("paused", "paused")
meta:set_float("generation", 0)

newgene = evolve.math_random ("SSS",0,0,0,"MB", "MA", "MS")
  meta:set_string("SSS", newgene)

newgene = evolve.math_random ("SST", 0,0,0, "MB", "MA", "MS")
  meta:set_string("SST", newgene)

newgene = evolve.math_random ("SSO", 0, 0,"DS", "MB", "MA", "MS")
  meta:set_string("SSO",newgene)

newgene = evolve.math_random ("SSA", 0,0,"DS", "MB","MA",0)
  meta:set_string("SSA", newgene)

newgene = evolve.math_random ("STS", 0,0,0, "MB", "MA", "MS")
  meta:set_string("STS", newgene)

newgene = evolve.math_random ("STT", 0,0,0, "MB", "MA", "MS")
  meta:set_string("STT", newgene)

newgene = evolve.math_random ("STO", 0,0,"DS", "MB", "MA", "MS")
  meta:set_string("STO", newgene)

newgene = evolve.math_random ("STA", 0,0,"DS", "MB", "MA",0)
  meta:set_string("STA", newgene)

newgene = evolve.math_random ("SOS", 0,"DA",0, "MB", "MA", "MS")
  meta:set_string("SOS", newgene)

newgene = evolve.math_random ("SOT", 0,"DA",0, "MB", "MA", "MS")
  meta:set_string("SOT", newgene)

newgene = evolve.math_random ("SOO", 0,"DA", "DS",  "MB", "MA", "MS")
  meta:set_string("SOO", newgene)

newgene = evolve.math_random ("SOA", 0,"DA", "DS",  "MB", "MA",0)
  meta:set_string("SOA", newgene)

newgene = evolve.math_random ("SAS", 0,"DA",0, "MB",0, "MS")
  meta:set_string("SAS", newgene)

newgene = evolve.math_random ("SAT", 0,"DA",0, "MB",0, "MS")
  meta:set_string("SAT", newgene)

newgene = evolve.math_random ("SAO", 0,"DA", "DS", "MB",0, "MS")
  meta:set_string("SAO", newgene)

newgene = evolve.math_random ("SAA", 0,"DA", "DS", "MB",0,0)
  meta:set_string("SAA", newgene)

newgene = evolve.math_random ("TSS", 0,0,0,"MB", "MA", "MS")
  meta:set_string("TSS", newgene)

newgene = evolve.math_random ("TST", 0,0,0,"MB", "MA", "MS")
  meta:set_string("TST", newgene)

newgene = evolve.math_random ("TSO", 0,0,"DS", "MB", "MA", "MS")
  meta:set_string("TSO", newgene)

newgene = evolve.math_random ("TSA", 0,0,"DS", "MB", "MA",0)
  meta:set_string("TSA", newgene)

newgene = evolve.math_random ("TTS", 0,0,0,"MB", "MA", "MS")
  meta:set_string("TTS", newgene)

newgene = evolve.math_random ("TTT", 0,0,0,"MB", "MA", "MS")
  meta:set_string("TTT", newgene)

newgene = evolve.math_random ("TTO", 0,0,"DS", "MB", "MA", "MS")
  meta:set_string("TTO", newgene)

newgene = evolve.math_random ("TTA", 0,0,"DS", "MB", "MA",0)
  meta:set_string("TTA", newgene)

newgene = evolve.math_random ("TOS", 0,"DA",0, "MB", "MA", "MS")
  meta:set_string("TOS", newgene)

newgene = evolve.math_random ("TOT", 0,"DA",0, "MB", "MA", "MS")
  meta:set_string("TOT", newgene)

newgene = evolve.math_random ("TOO", 0,"DA", "DS",  "MB", "MA", "MS")
  meta:set_string("TOO", newgene)

newgene = evolve.math_random ("TOA", 0,"DA", "DS",  "MB", "MA",0)
  meta:set_string("TOA", newgene)

newgene = evolve.math_random ("TAS", 0,"DA",0, "MB",0, "MS")
  meta:set_string("TAS", newgene)

newgene = evolve.math_random ("TAT", 0,"DA",0, "MB",0, "MS")
  meta:set_string("TAT", newgene)

newgene = evolve.math_random ("TAO", 0,"DA", "DS", "MB",0, "MS")
  meta:set_string("TAO", newgene)

newgene = evolve.math_random ("TAA", 0,"DA", "DS", "MB",0,0)
  meta:set_string("TAA", newgene)

newgene = evolve.math_random ("ASS", "DB",0,0,0, "MA", "MS")
  meta:set_string("ASS", newgene)

newgene = evolve.math_random ("AST", "DB",0,0,0, "MA", "MS")
  meta:set_string("AST", newgene)

newgene = evolve.math_random ("ASO", "DB",0, "DS",0, "MA", "MS")
  meta:set_string("ASO", newgene)

newgene = evolve.math_random ("ASA", "DB",0, "DS",0, "MA",0)
  meta:set_string("ASA", newgene)

newgene = evolve.math_random ("ATS", "DB",0,0,0, "MA", "MS")
  meta:set_string("ATS", newgene)

newgene = evolve.math_random ("ATT", "DB", 0,0,0,"MA", "MS")
  meta:set_string("ATT", newgene)

newgene = evolve.math_random ("ATO", "DB",0, "DS", 0,"MA", "MS")
  meta:set_string("ATO", newgene)

newgene = evolve.math_random ("ATA", "DB",0, "DS",0, "MA",0)
  meta:set_string("ATA", newgene)

newgene = evolve.math_random ("AOS", "DB", "DA",0,0, "MA", "MS")
  meta:set_string("AOS", newgene)

newgene = evolve.math_random ("AOT", "DB", "DA",0,0,  "MA", "MS")
  meta:set_string("AOT", newgene)

newgene = evolve.math_random ("AOO", "DB", "DA", "DS", 0,"MA", "MS")
  meta:set_string("AOO", newgene)

newgene = evolve.math_random ("AOA", "DB", "DA", "DS", 0,"MA",0)
  meta:set_string("AOA", newgene)

newgene = evolve.math_random ("AAS", "DB", "DA",0,0,0, "MS")
  meta:set_string("AAS", newgene)

newgene = evolve.math_random ("AAT", "DB", "DA",0,0,0, "MS")
  meta:set_string("AAT", newgene)

newgene = evolve.math_random ("AAO", "DB", "DA", "DS",0,0, "MS")
  meta:set_string("AAO", newgene)

newgene = evolve.math_random ("AAA", "DB", "DA", "DS",0,0,0)
  meta:set_string("AAA", newgene)

newgene = evolve.math_random ("OSS", "DB",0,0, "MB", "MA", "MS")
  meta:set_string("OSS", newgene)

newgene = evolve.math_random ("OST", "DB",0,0, "MB", "MA", "MS")
  meta:set_string("OST", newgene)

newgene = evolve.math_random ("OSO", "DB",0, "DS", "MB", "MA", "MS")
  meta:set_string("OSO", newgene)

newgene = evolve.math_random ("OSA", "DB",0, "DS", "MB", "MA",0)
  meta:set_string("OSA", newgene)

newgene = evolve.math_random ("OTS", "DB",0,0, "MB", "MA", "MS")
  meta:set_string("OTS", newgene)

newgene = evolve.math_random ("OTT", "DB",0,0, "MB", "MA", "MS")
  meta:set_string("OTT", newgene)

newgene = evolve.math_random ("OTO", "DB", 0,"DS", "MB", "MA", "MS")
  meta:set_string("OTO", newgene)

newgene = evolve.math_random ("OTA", "DB", 0,"DS", "MB", "MA",0)
  meta:set_string("OTA", newgene)

newgene = evolve.math_random ("OOS", "DB", "DA",0, "MB", "MA", "MS")
  meta:set_string("OOS", newgene)

newgene = evolve.math_random ("OOT", "DB", "DA",0, "MB", "MA", "MS")
  meta:set_string("OOT", newgene)

meta:set_string("OOO", "NA")

newgene = evolve.math_random ("OOA", "DB", "DA", "DS", "MB", "MA",0)
  meta:set_string("OOA", newgene)

newgene = evolve.math_random ("OAS", "DB", "DA",0, "MB",0, "MS")
  meta:set_string("OAS", newgene)

newgene = evolve.math_random ("OAT", "DB", "DA",0, "MB", 0,"MS")
  meta:set_string("OAT", newgene)

newgene = evolve.math_random ("OAO", "DB", "DA", "DS", "MB",0, "MS")
  meta:set_string("OAO", newgene)

newgene = evolve.math_random ("OAA", "DB", "DA", "DS", "MB",0,0)
  meta:set_string("OAA", newgene)

end



-- SET RANDOM Genome part 2 math random
-- select a random gene
-- don't allow banned genes
--loops until gene is set

evolve.math_random = function(gene, ban1, ban2, ban3, ban4, ban5, ban6)
  repeat

    local newgene = "NA"
    local q = math.random (1,6)

  -- if draws the unbanned number set these allele
      if q ==1 and ban1 ~= "DB" then
      newgene = "DB"
      return newgene
      end


      if q ==2 and ban2 ~= "DA" then
      newgene = "DA"
      return newgene
      end



      if q ==3 and ban3 ~= "DS" then
      newgene = "DS"
      return newgene
      end

      if q ==4 and ban4 ~= "MB" then
      newgene = "MB"
      return newgene
      end

      if q ==5 and ban5 ~= "MA" then
      newgene = "MA"
      return newgene
      end

      if q ==6 and ban6 ~= "MS" then
      newgene = "MS"
      return newgene
      end

      --still blank? loop
    until (newgene ~= "NA")


    end





----------------------------------------------------------------------
--EVOLUTION


----------------------------------------------------------------------
--MATING
--called on mating wave
-- have to call all three in order
-- split in three because it's complicated


--STEP 1 saves the current best bot's genome for group
-- sometimes doesn't seem to fire right despite seeming like it should...
-- sometimes leaves current best a blank, despite having fired to save it...
-- yet it is able to save it
--it may be because the bot moved before it could finish?
-- making the mining ABM chance lower reduces issue? gives them a chance to finish?

evolve.mate_genome_1 = function(pos,name)

  --get the bot's genome and relevant data therein
  local meta = minetest.get_meta(pos)
  local genome = evolve.retain_genome(pos)
  local g_score = genome.score
  local g_inv_score = genome.inv_score
  local g_generation = genome.generation


  --open the current best of group to compare
  local cur_best = evolve.restore_genome(name)

--right settings for right type
  local depot_num = nil

  if minetest.get_node(pos).name == "evolve:evolve_miner" then
    depot_num = depot_num_1_red
  end

  if minetest.get_node(pos).name == "evolve:evolve_blue" then
      depot_num = depot_num_1_blue
    end

  --restrict who can get saved to prevent new randoms taking top spot
  --only save those who have dug some, or are not newbies
  if g_inv_score >= ((depot_num + 2) - depot_num) or g_generation >=1 then

    --save if no cur_best file or it has been reset previously
    if cur_best == nil or cur_best == "blank" then
      evolve.save_genome(genome,name)
      --sound to let me know...acts like a bell to signal beginning of selection
      minetest.sound_play("evolve_bell", {pos = pos, gain = 2, max_hear_distance = 50,})

    end

    -- has file and it hasn't been blanked
    if cur_best ~= nil and cur_best ~= "blank" then
        --it's not nil so now can read it's data
        local cur_score = cur_best.score

        --this bot is the best so far
        if g_score >= cur_score then

        --save bot as new current best
        evolve.save_genome(genome, name)
        end
    end
  -- move on to next stage
  -- some mate before a new true current champion emerges
  -- but they should all mate with the best in sequence so far
  -- only the last bot done will truly use the best of the bunch

      evolve.mate_genome_2(pos, name)

    end
end


--STEP 2 compares the saved current best against the saved best ever
-- if the current best is better it is saved as the new best ever
-- afterwards the current best score is reset so that a new wave can unseat it
-- this is just a check, most will fail and pass to next step
evolve.mate_genome_2 = function(pos, name)

  --open the current best of group to compare
  local cur_best = evolve.restore_genome(name)

  --open the best ever to compare
  local best_ever = evolve.restore_genome_best(name)


  --only the current file exists... it is best by default
  --make sure file exist and save current best if no best ever file
  --should only apply first time, or if file deleted or purged
  if cur_best ~=nil and (best_ever == nil or best_ever == "blank") then

    --will not save a blank file
    if cur_best ~= "blank" then
      evolve.save_genome_best(cur_best, name)
      --play sound to indicate a new top dog
      minetest.sound_play("evolve_best", {pos = pos, gain = 1, max_hear_distance = 20,})
    end
  end

  -- both files do exist... we can compare to see who is best
  if cur_best ~=nil and best_ever ~= nil then

    --will not save a blank file
    if cur_best ~= "blank" and best_ever ~= "blank" then
    --now get data from files that do actually exist
    local best_score = best_ever.score
    local cur_score = cur_best.score

      --and the current genome is the better
      if cur_score > best_score then
      --save the current as new top dog
      evolve.save_genome_best(cur_best, name)
      --play sound to indicate a new top dog
      minetest.sound_play("evolve_best", {pos = pos, gain = 1, max_hear_distance = 20,})
    end
  end
end

  -- move on to next stage
  evolve.mate_genome_3(pos, name)
end



--STEP 3 mates the best ever and current best and sets bot's new genome
evolve.mate_genome_3 = function(pos,name)

  --get the two parents
  local cur_best = evolve.restore_genome(name)
  local best_ever = evolve.restore_genome_best(name)


  --for dealing with the bot
  local meta = minetest.get_meta(pos)
  local inv_score = meta:get_float("inv_score")

  -- check files exist...
  if best_ever ~=nil and cur_best ~=nil then

    -- sometimes cur_best will be nil bc nothing was suitable this round
    if cur_best ~= "blank" then

    --now get data from files that do actually exist
    -- will count in terms of reigning champions
    local gen = best_ever.generation


      --genomes are mated and the child genome is set
      evolve.mix_genomes(pos, best_ever, cur_best)

      --can't simply ask is best=cur bc inventory etc differs despite genes being same
      -- this mainly an issue whenever a new top dog emerges bc it will be best ever and current best
      -- mutation should help create spread then


      --reset and correct the non-relevant parts of new genome
      meta:set_float("score", 0)
      meta:set_float("inv_score", inv_score)
      meta:set_string("paused", "active")
      --tick the generation up one
      meta:set_float("generation", gen + 1)
      --reset the bot's form with new data
      evolve.update_form(pos)
      --let them know you got a new genome!
      minetest.sound_play("evolve_mate", {pos = pos, gain = 1, max_hear_distance = 20,})


    end
  end

end



-- Optional mating with the best
-- called when click "mate" button
-- Basically Step 3 but lets you set which other genome gets mated
evolve.mate_genome_3_click = function(pos, genome, name)

  --get the two parents
  local cur_best = genome
  local best_ever = evolve.restore_genome_best(name)


  --for dealing with the bot
  local meta = minetest.get_meta(pos)
  local inv_score = meta:get_float("inv_score")

  -- check file exists...
  if best_ever ~=nil and best_ever ~= "blank"  then

  --now get data from files that do actually exist
  -- will count in terms of reigning champions
  local gen = best_ever.generation

    --genomes are mated and the child genome is set
    evolve.mix_genomes(pos, best_ever, cur_best)
    --reset and correct the non-relevant parts of new genome
    meta:set_float("score", 0)
    meta:set_float("inv_score", inv_score)
    meta:set_string("paused", "active")
    --tick the generation up one
    meta:set_float("generation", gen + 1)
    --reset the bot's form with new data
    evolve.update_form(pos)
    --let them know you got a new genome!
    minetest.sound_play("evolve_mate", {pos = pos, gain = 1, max_hear_distance = 20,})

  end


end




----------------------------------------------------------------------
--FILE SAVING AND READING
--name is so can save for any node

--SAVE the CURRENT best genome to file
evolve.save_genome = function(genome, name)

   local data = minetest.serialize( genome );
   local path = minetest.get_worldpath().."/mod_evolve_"..name..".data";

   local file = io.open( path, "w" );
   if( file ) then
      file:write( data );
      file:close();
   else
      print("[Mod evolve] Error: Savefile '"..tostring( path ).."' could not be written.");
   end
end



--READ CURRENT best saved genome from file
evolve.restore_genome = function(name)

   local path = minetest.get_worldpath().."/mod_evolve_"..name..".data";

   local file = io.open( path, "r" );
   if( file ) then
      local data = file:read("*all");
      local genome = minetest.deserialize( data );
      file:close();
      return genome
   else
      print("[Mod evolve] Error: Savefile '"..tostring( path ).."' not found.");
   end
end


---------------------------------------------
--SAVE BEST EVER genome to file
evolve.save_genome_best = function(genome, name)

   local data = minetest.serialize( genome );
   local path = minetest.get_worldpath().."/mod_evolve_best_"..name..".data";

   local file = io.open( path, "w" );
   if( file ) then
      file:write( data );
      file:close();
   else
      print("[Mod evolve] Error: Savefile '"..tostring( path ).."' could not be written.");
   end
end



--READ BEST EVER saved genome from file
evolve.restore_genome_best = function(name)

   local path = minetest.get_worldpath().."/mod_evolve_best_"..name..".data";

   local file = io.open( path, "r" );
   if( file ) then
      local data = file:read("*all");
      local genome = minetest.deserialize( data );
      file:close();
      return genome
   else
      print("[Mod evolve] Error: Savefile '"..tostring( path ).."' not found.");
   end
end



-------------------------------------------------------------------------
--SEXY BIZNEZZ

--COMBINE two parent genomes into a child genome
evolve.mix_genomes = function(pos,genome1, genome2)

  local meta = minetest.get_meta(pos)
  local newgene = ""


  newgene = evolve.math_random_sex (genome1.SSS, genome2.SSS)
    meta:set_string("SSS", newgene)

  newgene = evolve.math_random_sex (genome1.SST, genome2.SST)
    meta:set_string("SST", newgene)

  newgene = evolve.math_random_sex (genome1.SSO, genome2.SSO)
    meta:set_string("SSO",newgene)

  newgene = evolve.math_random_sex (genome1.SSA, genome2.SSA)
    meta:set_string("SSA", newgene)

  newgene = evolve.math_random_sex (genome1.STS, genome2.STS)
    meta:set_string("STS", newgene)

  newgene = evolve.math_random_sex (genome1.STT, genome2.STT)
    meta:set_string("STT", newgene)

  newgene = evolve.math_random_sex (genome1.STO, genome2.STO)
    meta:set_string("STO", newgene)

  newgene = evolve.math_random_sex (genome1.STA, genome2.STA)
    meta:set_string("STA", newgene)

  newgene = evolve.math_random_sex (genome1.SOS, genome2.SOS)
    meta:set_string("SOS", newgene)

  newgene = evolve.math_random_sex (genome1.SOT, genome2.SOT)
    meta:set_string("SOT", newgene)

  newgene = evolve.math_random_sex (genome1.SOO, genome2.SOO)
    meta:set_string("SOO", newgene)

  newgene = evolve.math_random_sex (genome1.SOA, genome2.SOA)
    meta:set_string("SOA", newgene)

  newgene = evolve.math_random_sex (genome1.SAS, genome2.SAS)
    meta:set_string("SAS", newgene)

  newgene = evolve.math_random_sex (genome1.SAT, genome2.SAT)
    meta:set_string("SAT", newgene)

  newgene = evolve.math_random_sex (genome1.SAO, genome2.SAO)
    meta:set_string("SAO", newgene)

  newgene = evolve.math_random_sex (genome1.SAA, genome2.SAA)
    meta:set_string("SAA", newgene)

  newgene = evolve.math_random_sex (genome1.TSS, genome2.TSS)
    meta:set_string("TSS", newgene)

  newgene = evolve.math_random_sex (genome1.TST, genome2.TST)
    meta:set_string("TST", newgene)

  newgene = evolve.math_random_sex (genome1.TSO, genome2.TSO)
    meta:set_string("TSO", newgene)

  newgene = evolve.math_random_sex (genome1.TSA, genome2.TSA)
    meta:set_string("TSA", newgene)

  newgene = evolve.math_random_sex (genome1.TTS, genome2.TTS)
    meta:set_string("TTS", newgene)

  newgene = evolve.math_random_sex (genome1.TTT, genome2.TTT)
    meta:set_string("TTT", newgene)

  newgene = evolve.math_random_sex (genome1.TTO, genome2.TTO)
    meta:set_string("TTO", newgene)

  newgene = evolve.math_random_sex (genome1.TTA, genome2.TTA)
    meta:set_string("TTA", newgene)

  newgene = evolve.math_random_sex (genome1.TOS, genome2.TOS)
    meta:set_string("TOS", newgene)

  newgene = evolve.math_random_sex (genome1.TOT, genome2.TOT)
    meta:set_string("TOT", newgene)

  newgene = evolve.math_random_sex (genome1.TOO, genome2.TOO)
    meta:set_string("TOO", newgene)

  newgene = evolve.math_random_sex (genome1.TOA, genome2.TOA)
    meta:set_string("TOA", newgene)

  newgene = evolve.math_random_sex (genome1.TAS, genome2.TAS)
    meta:set_string("TAS", newgene)

  newgene = evolve.math_random_sex (genome1.TAT, genome2.TAT)
    meta:set_string("TAT", newgene)

  newgene = evolve.math_random_sex (genome1.TAO, genome2.TAO)
    meta:set_string("TAO", newgene)

  newgene = evolve.math_random_sex (genome1.TAA, genome2.TAA)
    meta:set_string("TAA", newgene)

  newgene = evolve.math_random_sex (genome1.ASS, genome2.ASS)
    meta:set_string("ASS", newgene)

  newgene = evolve.math_random_sex (genome1.AST, genome2.AST)
    meta:set_string("AST", newgene)

  newgene = evolve.math_random_sex (genome1.ASO, genome2.ASO)
    meta:set_string("ASO", newgene)

  newgene = evolve.math_random_sex (genome1.ASA, genome2.ASA)
    meta:set_string("ASA", newgene)

  newgene = evolve.math_random_sex (genome1.ATS, genome2.ATS)
    meta:set_string("ATS", newgene)

  newgene = evolve.math_random_sex (genome1.ATT, genome2.ATT)
    meta:set_string("ATT", newgene)

  newgene = evolve.math_random_sex (genome1.ATO, genome2.ATO)
    meta:set_string("ATO", newgene)

  newgene = evolve.math_random_sex (genome1.ATA, genome2.ATA)
    meta:set_string("ATA", newgene)

  newgene = evolve.math_random_sex (genome1.AOS, genome2.AOS)
    meta:set_string("AOS", newgene)

  newgene = evolve.math_random_sex (genome1.AOT, genome2.AOT)
    meta:set_string("AOT", newgene)

  newgene = evolve.math_random_sex (genome1.AOO, genome2.AOO)
    meta:set_string("AOO", newgene)

  newgene = evolve.math_random_sex (genome1.AOA, genome2.AOA)
    meta:set_string("AOA", newgene)

  newgene = evolve.math_random_sex (genome1.AAS, genome2.AAS)
    meta:set_string("AAS", newgene)

  newgene = evolve.math_random_sex (genome1.AAT, genome2.AAT)
    meta:set_string("AAT", newgene)

  newgene = evolve.math_random_sex (genome1.AAO, genome2.AAO)
    meta:set_string("AAO", newgene)

  newgene = evolve.math_random_sex (genome1.AAA, genome2.AAA)
    meta:set_string("AAA", newgene)

  newgene = evolve.math_random_sex (genome1.OSS, genome2.OSS)
    meta:set_string("OSS", newgene)

  newgene = evolve.math_random_sex (genome1.OST, genome2.OST)
    meta:set_string("OST", newgene)

  newgene = evolve.math_random_sex (genome1.OSO, genome2.OSO)
    meta:set_string("OSO", newgene)

  newgene = evolve.math_random_sex (genome1.OSA, genome2.OSA)
    meta:set_string("OSA", newgene)

  newgene = evolve.math_random_sex (genome1.OTS, genome2.OTS)
    meta:set_string("OTS", newgene)

  newgene = evolve.math_random_sex (genome1.OTT, genome2.OTT)
    meta:set_string("OTT", newgene)

  newgene = evolve.math_random_sex (genome1.OTO, genome2.OTO)
    meta:set_string("OTO", newgene)

  newgene = evolve.math_random_sex (genome1.OTA, genome2.OTA)
    meta:set_string("OTA", newgene)

  newgene = evolve.math_random_sex (genome1.OOS, genome2.OOS)
    meta:set_string("OOS", newgene)

  newgene = evolve.math_random_sex (genome1.OOT, genome2.OOT)
    meta:set_string("OOT", newgene)

  --meta:set_string("OOO", "NA")

  newgene = evolve.math_random_sex (genome1.OOA, genome2.OOA)
    meta:set_string("OOA", newgene)

  newgene = evolve.math_random_sex (genome1.OAS, genome2.OAS)
    meta:set_string("OAS", newgene)

  newgene = evolve.math_random_sex (genome1.OAT, genome2.OAT)
    meta:set_string("OAT", newgene)

  newgene = evolve.math_random_sex (genome1.OAO, genome2.OAO)
    meta:set_string("OAO", newgene)

  newgene = evolve.math_random_sex (genome1.OAA, genome2.OAA)
    meta:set_string("OAA", newgene)

    --now MUTATE
    --keep track of number of repeats
    local mutate_run = 0
    repeat
      evolve.mutate(pos)
      mutate_run = mutate_run + 1
    --keep going until matches number of genes to mutate set in settings
    until (mutate_run >= mutate_count)

    --reset count
    mutate_run = 0

  end




  -- Mix Genomes part 2 math random
  -- select a random gene one of the two parents genes

  evolve.math_random_sex = function(gene1, gene2)

    local newgene = {}

    local q = math.random (1,2)

        if q ==1 then
        newgene = gene1
        return newgene
      end

        if q ==2 then
        newgene = gene2
        return newgene
    end

  end


  -- MUTATE Genome
  --select one gene to randomize

  evolve.mutate = function(pos)

  local meta = minetest.get_meta(pos)

  local newgene = {}

  local q = math.random (1,64)

  if q ==1 then
  newgene = evolve.math_random ("SSS",0,0,0,"MB", "MA", "MS")
    meta:set_string("SSS", newgene)
  end

  if q ==2 then
  newgene = evolve.math_random ("SST", 0,0,0, "MB", "MA", "MS")
    meta:set_string("SST", newgene)
  end

  if q ==3 then
  newgene = evolve.math_random ("SSO", 0, 0,"DS", "MB", "MA", "MS")
    meta:set_string("SSO",newgene)
  end

  if q ==4 then
  newgene = evolve.math_random ("SSA", 0,0,"DS", "MB","MA",0)
    meta:set_string("SSA", newgene)
  end

  if q ==5 then
  newgene = evolve.math_random ("STS", 0,0,0, "MB", "MA", "MS")
    meta:set_string("STS", newgene)
  end

  if q ==6 then
  newgene = evolve.math_random ("STT", 0,0,0, "MB", "MA", "MS")
    meta:set_string("STT", newgene)
  end

  if q ==7 then
  newgene = evolve.math_random ("STO", 0,0,"DS", "MB", "MA", "MS")
    meta:set_string("STO", newgene)
  end

  if q ==8 then
  newgene = evolve.math_random ("STA", 0,0,"DS", "MB", "MA",0)
    meta:set_string("STA", newgene)
  end

  if q ==9 then
  newgene = evolve.math_random ("SOS", 0,"DA",0, "MB", "MA", "MS")
    meta:set_string("SOS", newgene)
  end

  if q ==10 then
  newgene = evolve.math_random ("SOT", 0,"DA",0, "MB", "MA", "MS")
    meta:set_string("SOT", newgene)
  end

  if q ==11 then
  newgene = evolve.math_random ("SOO", 0,"DA", "DS",  "MB", "MA", "MS")
    meta:set_string("SOO", newgene)
  end

  if q ==12 then
  newgene = evolve.math_random ("SOA", 0,"DA", "DS",  "MB", "MA",0)
    meta:set_string("SOA", newgene)
  end

  if q ==13 then
  newgene = evolve.math_random ("SAS", 0,"DA",0, "MB",0, "MS")
    meta:set_string("SAS", newgene)
  end

  if q ==14 then
  newgene = evolve.math_random ("SAT", 0,"DA",0, "MB",0, "MS")
    meta:set_string("SAT", newgene)
  end

  if q ==15 then
  newgene = evolve.math_random ("SAO", 0,"DA", "DS", "MB",0, "MS")
    meta:set_string("SAO", newgene)
  end

  if q ==16 then
  newgene = evolve.math_random ("SAA", 0,"DA", "DS", "MB",0,0)
    meta:set_string("SAA", newgene)
  end

  if q ==17 then
  newgene = evolve.math_random ("TSS", 0,0,0,"MB", "MA", "MS")
    meta:set_string("TSS", newgene)
  end

  if q ==18 then
  newgene = evolve.math_random ("TST", 0,0,0,"MB", "MA", "MS")
    meta:set_string("TST", newgene)
  end

  if q ==19 then
  newgene = evolve.math_random ("TSO", 0,0,"DS", "MB", "MA", "MS")
    meta:set_string("TSO", newgene)
  end

  if q ==20 then
  newgene = evolve.math_random ("TSA", 0,0,"DS", "MB", "MA",0)
    meta:set_string("TSA", newgene)
  end

  if q ==21 then
  newgene = evolve.math_random ("TTS", 0,0,0,"MB", "MA", "MS")
    meta:set_string("TTS", newgene)
  end

  if q ==22 then
  newgene = evolve.math_random ("TTT", 0,0,0,"MB", "MA", "MS")
    meta:set_string("TTT", newgene)
  end

  if q ==23 then
  newgene = evolve.math_random ("TTO", 0,0,"DS", "MB", "MA", "MS")
    meta:set_string("TTO", newgene)
  end

  if q ==24 then
  newgene = evolve.math_random ("TTA", 0,0,"DS", "MB", "MA",0)
    meta:set_string("TTA", newgene)
  end

  if q ==25 then
  newgene = evolve.math_random ("TOS", 0,"DA",0, "MB", "MA", "MS")
    meta:set_string("TOS", newgene)
  end

  if q ==26 then
  newgene = evolve.math_random ("TOT", 0,"DA",0, "MB", "MA", "MS")
    meta:set_string("TOT", newgene)
  end

  if q ==27 then
  newgene = evolve.math_random ("TOO", 0,"DA", "DS",  "MB", "MA", "MS")
    meta:set_string("TOO", newgene)
  end

  if q ==28 then
  newgene = evolve.math_random ("TOA", 0,"DA", "DS",  "MB", "MA",0)
    meta:set_string("TOA", newgene)
  end

  if q ==29 then
  newgene = evolve.math_random ("TAS", 0,"DA",0, "MB",0, "MS")
    meta:set_string("TAS", newgene)
  end

  if q ==30 then
  newgene = evolve.math_random ("TAT", 0,"DA",0, "MB",0, "MS")
    meta:set_string("TAT", newgene)
  end

  if q ==31 then
  newgene = evolve.math_random ("TAO", 0,"DA", "DS", "MB",0, "MS")
    meta:set_string("TAO", newgene)
  end

  if q ==32 then
  newgene = evolve.math_random ("TAA", 0,"DA", "DS", "MB",0,0)
    meta:set_string("TAA", newgene)
  end

  if q ==33 then
  newgene = evolve.math_random ("ASS", "DB",0,0,0, "MA", "MS")
    meta:set_string("ASS", newgene)
  end

  if q ==34 then
  newgene = evolve.math_random ("AST", "DB",0,0,0, "MA", "MS")
    meta:set_string("AST", newgene)
  end

  if q ==35 then
  newgene = evolve.math_random ("ASO", "DB",0, "DS",0, "MA", "MS")
    meta:set_string("ASO", newgene)
  end

  if q ==36 then
  newgene = evolve.math_random ("ASA", "DB",0, "DS",0, "MA",0)
    meta:set_string("ASA", newgene)
  end

  if q ==37 then
  newgene = evolve.math_random ("ATS", "DB",0,0,0, "MA", "MS")
    meta:set_string("ATS", newgene)
  end

  if q ==38 then
  newgene = evolve.math_random ("ATT", "DB", 0,0,0,"MA", "MS")
    meta:set_string("ATT", newgene)
  end

  if q ==39 then
  newgene = evolve.math_random ("ATO", "DB",0, "DS", 0,"MA", "MS")
    meta:set_string("ATO", newgene)
  end

  if q ==40 then
  newgene = evolve.math_random ("ATA", "DB",0, "DS",0, "MA",0)
    meta:set_string("ATA", newgene)
  end

  if q ==41 then
  newgene = evolve.math_random ("AOS", "DB", "DA",0,0, "MA", "MS")
    meta:set_string("AOS", newgene)
  end

  if q ==42 then
  newgene = evolve.math_random ("AOT", "DB", "DA",0,0,  "MA", "MS")
    meta:set_string("AOT", newgene)
  end

  if q ==43 then
  newgene = evolve.math_random ("AOO", "DB", "DA", "DS", 0,"MA", "MS")
    meta:set_string("AOO", newgene)
  end

  if q ==44 then
  newgene = evolve.math_random ("AOA", "DB", "DA", "DS", 0,"MA",0)
    meta:set_string("AOA", newgene)
  end

  if q ==45 then
  newgene = evolve.math_random ("AAS", "DB", "DA",0,0,0, "MS")
    meta:set_string("AAS", newgene)
  end

  if q ==46 then
  newgene = evolve.math_random ("AAT", "DB", "DA",0,0,0, "MS")
    meta:set_string("AAT", newgene)
    end

  if q ==47 then
  newgene = evolve.math_random ("AAO", "DB", "DA", "DS",0,0, "MS")
    meta:set_string("AAO", newgene)
    end

  if q ==48 then
  newgene = evolve.math_random ("AAA", "DB", "DA", "DS",0,0,0)
    meta:set_string("AAA", newgene)
    end

  if q ==49 then
  newgene = evolve.math_random ("OSS", "DB",0,0, "MB", "MA", "MS")
    meta:set_string("OSS", newgene)
    end

  if q ==50 then
  newgene = evolve.math_random ("OST", "DB",0,0, "MB", "MA", "MS")
    meta:set_string("OST", newgene)
    end

  if q ==51 then
  newgene = evolve.math_random ("OSO", "DB",0, "DS", "MB", "MA", "MS")
    meta:set_string("OSO", newgene)
    end

  if q ==52 then
  newgene = evolve.math_random ("OSA", "DB",0, "DS", "MB", "MA",0)
    meta:set_string("OSA", newgene)
    end

  if q ==53 then
  newgene = evolve.math_random ("OTS", "DB",0,0, "MB", "MA", "MS")
    meta:set_string("OTS", newgene)
    end

  if q ==54 then
  newgene = evolve.math_random ("OTT", "DB",0,0, "MB", "MA", "MS")
    meta:set_string("OTT", newgene)
    end

  if q ==55 then
  newgene = evolve.math_random ("OTO", "DB", 0,"DS", "MB", "MA", "MS")
    meta:set_string("OTO", newgene)
    end

  if q ==56 then
  newgene = evolve.math_random ("OTA", "DB", 0,"DS", "MB", "MA",0)
    meta:set_string("OTA", newgene)
    end

  if q ==57 then
  newgene = evolve.math_random ("OOS", "DB", "DA",0, "MB", "MA", "MS")
    meta:set_string("OOS", newgene)
    end

  if q ==58 then
  newgene = evolve.math_random ("OOT", "DB", "DA",0, "MB", "MA", "MS")
    meta:set_string("OOT", newgene)
    end

  --meta:set_string("OOO", "NA")

  if q ==59 then
  newgene = evolve.math_random ("OOA", "DB", "DA", "DS", "MB", "MA",0)
    meta:set_string("OOA", newgene)
    end

  if q ==60 then
  newgene = evolve.math_random ("OAS", "DB", "DA",0, "MB",0, "MS")
    meta:set_string("OAS", newgene)
  end

  if q ==61 then
  newgene = evolve.math_random ("OAT", "DB", "DA",0, "MB", 0,"MS")
    meta:set_string("OAT", newgene)
end

  if q ==62 then
  newgene = evolve.math_random ("OAO", "DB", "DA", "DS", "MB",0, "MS")
    meta:set_string("OAO", newgene)
  end

  if q ==63 then
  newgene = evolve.math_random ("OAA", "DB", "DA", "DS", "MB",0,0)
    meta:set_string("OAA", newgene)
  end

  end
