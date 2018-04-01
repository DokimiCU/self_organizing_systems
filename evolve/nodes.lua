------------------------------------------------------------------
--FORMS

--bot form
evolve.update_form = function(pos)

local meta = minetest.get_meta(pos)

local paused_value = meta:get_string("paused")

local score_list_value = meta:get_float("score")
local inv_score_list_value = meta:get_float("inv_score")
local generation_list_value =  meta:get_float("generation")


local SSS = meta:get_string("SSS")
local SST = meta:get_string("SST")
local SSO = meta:get_string("SSO")
local SSA = meta:get_string("SSA")
local STS = meta:get_string("STS")
local STT = meta:get_string("STT")
local STO = meta:get_string("STO")
local STA = meta:get_string("STA")
local SOS = meta:get_string("SOS")
local SOT = meta:get_string("SOT")
local SOO = meta:get_string("SOO")
local SOA = meta:get_string("SOA")
local SAS = meta:get_string("SAS")
local SAT = meta:get_string("SAT")
local SAO = meta:get_string("SAO")
local SAA = meta:get_string("SAA")
local TSS = meta:get_string("TSS")
local TST = meta:get_string("TST")
local TSO = meta:get_string("TSO")
local TSA = meta:get_string("TSA")
local TTS = meta:get_string("TTS")
local TTT = meta:get_string("TTT")
local TTO = meta:get_string("TTO")
local TTA = meta:get_string("TTA")
local TOS = meta:get_string("TOS")
local TOT = meta:get_string("TOT")
local TOO = meta:get_string("TOO")
local TOA = meta:get_string("TOA")
local TAS = meta:get_string("TAS")
local TAT = meta:get_string("TAT")
local TAO = meta:get_string("TAO")
local TAA = meta:get_string("TAA")
local ASS = meta:get_string("ASS")
local AST = meta:get_string("AST")
local ASO = meta:get_string("ASO")
local ASA = meta:get_string("ASA")
local ATS = meta:get_string("ATS")
local ATT = meta:get_string("ATT")
local ATO = meta:get_string("ATO")
local ATA = meta:get_string("ATA")
local AOS = meta:get_string("AOS")
local AOT = meta:get_string("AOT")
local AOO = meta:get_string("AOO")
local AOA = meta:get_string("AOA")
local AAS = meta:get_string("AAS")
local AAT = meta:get_string("AAT")
local AAO = meta:get_string("AAO")
local AAA = meta:get_string("AAA")
local OSS = meta:get_string("OSS")
local OST = meta:get_string("OST")
local OSO = meta:get_string("OSO")
local OSA = meta:get_string("OSA")
local OTS = meta:get_string("OTS")
local OTT = meta:get_string("OTT")
local OTO = meta:get_string("OTO")
local OTA = meta:get_string("OTA")
local OOS = meta:get_string("OOS")
local OOT = meta:get_string("OOT")
local OOO = meta:get_string("OOO")
local OOA = meta:get_string("OOA")
local OAS = meta:get_string("OAS")
local OAT = meta:get_string("OAT")
local OAO = meta:get_string("OAO")
local OAA = meta:get_string("OAA")

meta:set_string ("formspec",
	"size[12,12]"..

	"button[0.5,11;2.5,0.7;set_random_genome;Set Random Genome]"..
	"button[3.5,11;2.5,0.7;set_default_genome;Set Default Genome]"..
	"button[6.5,11;2.5,0.7;set_best_genome;Set Best Genome]"..
	"button[9.5,11;2.5,0.7;set_mated_genome;Mate Genome]"..
	"button[9.5,9.5;2.4,0.7;mutate_genome;Mutate Genome]"..
	"button[10,0.2;2.1,0.7;set_as_best;Set As Best]"..


	"label[5,0.5;"..paused_value.."]"..
	"button_exit[4,9.5;3.5,0.7;exit_form;Exit and Activate]"..

	"label[1.5,1;Genome Score]"..
	"label[5,1;Inventory]"..
	"label[8,1;Generation]"..
	"textlist[1.5,1.5;1.3,0.5;score_list;"..score_list_value.."]"..
	"textlist[5,1.5;1.3,0.5;inv_score_list;"..inv_score_list_value.."]"..
	"textlist[8,1.5;1.3,0.5;generation_score_list;"..generation_list_value.."]"..

	"label[1.5,8.5;Gene Codes: S=Stone, T=Target, O=Other, A=Air. In order of Below/Above/Side]"..
	"label[1.5,8.9;Allele Codes: D=Dig, M=Move, A=Above, B=Below, S=Side, NA=inactive]"..

	"textlist[1.5,2.2;2,6;genome_list;	SSS "..SSS..",	SST "..SST..",	SSO "..SSO..",	SSA "..SSA..",	STS "..STS..",	STT "..STT..",	STO "..STO..",	STA "..STA..",	SOS "..SOS..",	SOT "..SOT..",	SOO "..SOO..",	SOA "..SOA..",	SAS "..SAS..",	SAT "..SAT..",	SAO "..SAO..",	SAA "..SAA..",]"..
	"textlist[3.5,2.2;2,6;genome_list2;	TSS "..TSS..",	TST "..TST..",	TSO "..TSO..",	TSA "..TSA..",	TTS "..TTS..",	TTT "..TTT..",	TTO "..TTO..",	TTA "..TTA..",	TOS "..TOS..",	TOT "..TOT..",	TOO "..TOO..",	TOA "..TOA..",	TAS "..TAS..",	TAT "..TAT..",	TAO "..TAO..",	TAA "..TAA..",]"..
	"textlist[5.5,2.2;2,6;genome_list3;	ASS "..ASS..",	AST "..AST..",	ASO "..ASO..",	ASA "..ASA..",	ATS "..ATS..",	ATT "..ATT..",	ATO "..ATO..",	ATA "..ATA..",	AOS "..AOS..",	AOT "..AOT..",	AOO "..AOO..",	AOA "..AOA..",	AAS "..AAS..",	AAT "..AAT..",	AAO "..AAO..",	AAA "..AAA..",]"..
	"textlist[7.5,2.2;2,6;genome_list4;	OSS "..OSS..",	OST "..OST..",	OSO "..OSO..",	OSA "..OSA..",	OTS "..OTS..",	OTT "..OTT..",	OTO "..OTO..",	OTA "..OTA..",	OOS "..OOS..",	OOT "..OOT..",	OOO "..OOO..",	OOA "..OOA..",	OAS "..OAS..",	OAT "..OAT..",	OAO "..OAO..",	OAA "..OAA..",]"
)
end



--form for computer to check the best genome and it's score
evolve.computer_form = function(pos, name)

local meta = minetest.get_meta(pos)

--get best genome
local b = evolve.restore_genome_best(name)

--for display settings
local target = nil
local deposit = nil
local depot_num = nil
local medium = nil
local air = nil
local mutate = minetest.settings:get('evolve_mutate') or 4
local step_size = minetest.settings:get('evolve_step_size') or 180


if minetest.get_node(pos).name == "evolve:computer" then
	target = minetest.settings:get('evolve_target_red') or "default:stone_with_coal"
	deposit = minetest.settings:get('evolve_deposit_red') or "default:coalblock"
	depot_num = minetest.settings:get('evolve_depot_num_red') or 9
	medium = minetest.settings:get('evolve_medium_red') or "stone"
	air = minetest.settings:get('evolve_air_red') or "air"
end

if minetest.get_node(pos).name == "evolve:computer_blue" then
	target = minetest.settings:get('evolve_target_blue') or "default:stone_with_iron"
	deposit = minetest.settings:get('evolve_deposit_blue') or "default:steelblock"
	depot_num = minetest.settings:get('evolve_depot_num_blue') or 9
	medium = minetest.settings:get('evolve_medium_blue') or "stone"
	air = minetest.settings:get('evolve_air_blue') or "air"
end






--can't find a best data set
if b == nil or b == "blank" then
	--a no data form
	meta:set_string ("formspec",
		"size[12,12]"..

		"button_exit[6.5,9.5;3.5,1;exit_form;Exit ]"..
		"button[1.5,9.5;3.5,1;update_top;Update ]"..

		"label[1.5,1;Genome Score]"..
		"textlist[3.2,1;1,0.5;score_list; No Data]"..
		"label[5.5,1;Generation]"..
		"textlist[6.8,1;1,0.5;generation_list; No Data]"..

		"label[4.5,0.1;~~~ TOP GENOME ~~~]"..
		--"button[9,0.1;2.5,0.4;purge_top;Purge Best Genome!]"..

		"label[5,10.5;Global Settings]"..
		"label[4.5,11;Target: "..target.."]"..
		"label[4.5,11.3;Mutation #: "..mutate.."]"..
		"label[1,11;Digging: "..medium.."]"..
		"label[1,11.3;Moving: "..air.."]"..
		"label[1,11.6;Rate(sec): "..step_size.."]"..
		"label[8,11;Deposit: "..deposit.."]"..
		"label[8,11.3;Deposit #: "..depot_num.."]"..


		"label[1.5,8.3;Gene Codes: S=Stone, T=Target, O=Other, A=Air. In order of Below/Above/Side]"..
		"label[1.5,8.8;Allele Codes: D=Dig, M=Move, A=Above, B=Below, S=Side, NA=inactive]"..
		"textlist[1.5,2;2,6;genome_list;	No Data,...,]"..
		"textlist[3.5,2;2,6;genome_list2;	No Data,...,]"..
		"textlist[5.5,2;2,6;genome_list3;	No Data,...,]"..
		"textlist[7.5,2;2,6;genome_list4;	No Data,...,]"
	)
end

-- can find data so show complete form
if b ~= nil and b ~= "blank" then

local score_list_value = b.score
local generation_list_value =  b.generation

local SSS = b.SSS
local SST = b.SST
local SSO = b.SSO
local SSA = b.SSA
local STS = b.STS
local STT = b.STT
local STO = b.STO
local STA = b.STA
local SOS = b.SOS
local SOT = b.SOT
local SOO = b.SOO
local SOA = b.SOA
local SAS = b.SAS
local SAT = b.SAT
local SAO = b.SAO
local SAA = b.SAA
local TSS = b.TSS
local TST = b.TST
local TSO = b.TSO
local TSA = b.TSA
local TTS = b.TTS
local TTT = b.TTT
local TTO = b.TTO
local TTA = b.TTA
local TOS = b.TOS
local TOT = b.TOT
local TOO = b.TOO
local TOA = b.TOA
local TAS = b.TAS
local TAT = b.TAT
local TAO = b.TAO
local TAA = b.TAA
local ASS = b.ASS
local AST = b.AST
local ASO = b.ASO
local ASA = b.ASA
local ATS = b.ATS
local ATT = b.ATT
local ATO = b.ATO
local ATA = b.ATA
local AOS = b.AOS
local AOT = b.AOT
local AOO = b.AOO
local AOA = b.AOA
local AAS = b.AAS
local AAT = b.AAT
local AAO = b.AAO
local AAA = b.AAA
local OSS = b.OSS
local OST = b.OST
local OSO = b.OSO
local OSA = b.OSA
local OTS = b.OTS
local OTT = b.OTT
local OTO = b.OTO
local OTA = b.OTA
local OOS = b.OOS
local OOT = b.OOT
local OOO = b.OOO
local OOA = b.OOA
local OAS = b.OAS
local OAT = b.OAT
local OAO = b.OAO
local OAA = b.OAA



meta:set_string ("formspec",
	"size[12,12]"..

	"button_exit[6.5,9.5;3.5,1;exit_form;Exit ]"..
	"button[1.5,9.5;3.5,1;update_top;Update ]"..

	"label[1.5,1;Genome Score]"..
	"textlist[3.2,1;1,0.5;score_list;"..score_list_value.."]"..
	"label[5.5,1;Generation]"..
	"textlist[6.8,1;1,0.5;generation_list;"..generation_list_value.."]"..

	"label[4.5,0.1;~~~ TOP GENOME ~~~]"..
	"button[9,0.1;2.5,0.4;purge_top;Purge Best Genome!]"..

	"label[5,10.5;Global Settings]"..
	"label[4.5,11;Target: "..target.."]"..
	"label[4.5,11.3;Mutation #: "..mutate.."]"..
	"label[1,11;Digging: "..medium.."]"..
	"label[1,11.3;Moving: "..air.."]"..
	"label[1,11.6;Rate(sec): "..step_size.."]"..
	"label[8,11;Deposit: "..deposit.."]"..
	"label[8,11.3;Deposit #: "..depot_num.."]"..


	"label[1.5,8.3;Gene Codes: S=Stone, T=Target, O=Other, A=Air. In order of Below/Above/Side]"..
	"label[1.5,8.8;Allele Codes: D=Dig, M=Move, A=Above, B=Below, S=Side, NA=inactive]"..
	"textlist[1.5,2;2,6;genome_list;	SSS "..SSS..",	SST "..SST..",	SSO "..SSO..",	SSA "..SSA..",	STS "..STS..",	STT "..STT..",	STO "..STO..",	STA "..STA..",	SOS "..SOS..",	SOT "..SOT..",	SOO "..SOO..",	SOA "..SOA..",	SAS "..SAS..",	SAT "..SAT..",	SAO "..SAO..",	SAA "..SAA..",]"..
	"textlist[3.5,2;2,6;genome_list2;	TSS "..TSS..",	TST "..TST..",	TSO "..TSO..",	TSA "..TSA..",	TTS "..TTS..",	TTT "..TTT..",	TTO "..TTO..",	TTA "..TTA..",	TOS "..TOS..",	TOT "..TOT..",	TOO "..TOO..",	TOA "..TOA..",	TAS "..TAS..",	TAT "..TAT..",	TAO "..TAO..",	TAA "..TAA..",]"..
	"textlist[5.5,2;2,6;genome_list3;	ASS "..ASS..",	AST "..AST..",	ASO "..ASO..",	ASA "..ASA..",	ATS "..ATS..",	ATT "..ATT..",	ATO "..ATO..",	ATA "..ATA..",	AOS "..AOS..",	AOT "..AOT..",	AOO "..AOO..",	AOA "..AOA..",	AAS "..AAS..",	AAT "..AAT..",	AAO "..AAO..",	AAA "..AAA..",]"..
	"textlist[7.5,2;2,6;genome_list4;	OSS "..OSS..",	OST "..OST..",	OSO "..OSO..",	OSA "..OSA..",	OTS "..OTS..",	OTT "..OTT..",	OTO "..OTO..",	OTA "..OTA..",	OOS "..OOS..",	OOT "..OOT..",	OOO "..OOO..",	OOA "..OOA..",	OAS "..OAS..",	OAT "..OAT..",	OAO "..OAO..",	OAA "..OAA..",]"
)
	end

end





--------------------------------------------------------------------------
---NODES
--------------------------------------------------------------------------
--Naming
-- have to give them all nicknames to feed through the file save.
-- for diff settings has to be fed through the mining, ID, scoring too
-- so split them into color teams: Red, Blue...
-- All bots are identicle, just allows seperate pops


--EVOLUTION MINER RED

minetest.register_node('evolve:evolve_miner', {
	description = 'Evolution Bot (Red)',
	light_source = 5,
	tiles = {"evolve_miner.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
------------
	on_construct = function(pos)
		--start them out as active, prevents dud bots...such was the idea...
		local meta = minetest.get_meta(pos)
    meta:set_string("paused", "active")
		evolve.update_form(pos)

    end,

-------------
--take action for each button pushed
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
-----------
			if fields.set_default_genome then
					evolve.set_default (pos)
					minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

					evolve.update_form(pos)
		end
----------
		if fields.set_random_genome then
				evolve.set_random (pos)
				minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

				evolve.update_form(pos)
	end

	----------
			if fields.set_best_genome then
					--get the best_ever
					local g = evolve.restore_genome_best("red")
					--so can keep it's own inventory
					local inv_score = meta:get_float("inv_score")
					--only do if there is a best
						if g ~= nil and g ~= "blank" then
	        		evolve.retain_genome_2 (pos, g)
							--reset and correct
							meta:set_float("inv_score", inv_score)
							meta:set_float("score", 0)
							meta:set_string("paused", "paused")
							--bleep!
							minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
							evolve.update_form(pos)
						end
		end


	----------
			if fields.set_mated_genome then
				--mate it with the best ever
					local genome = evolve.retain_genome(pos)
						evolve.mate_genome_3_click(pos, genome, "red")
						--reset and correct... just need to keep on pause
						meta:set_string("paused", "paused")
						--bleep only, form already updates
						minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
		end

		----------
				if fields.mutate_genome then
						evolve.mutate(pos)
						minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

						evolve.update_form(pos)
			end

			----------
					if fields.set_as_best then
							local g = evolve.retain_genome(pos)
							evolve.save_genome_best(g, "red")
							minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
				end


		----------
		--activate bot on exit
				if fields.exit_form then
						meta:set_string("paused", "active")
						minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
						evolve.update_form(pos)
				end

	end,


	-----------------------------------
	--pause bot
	on_punch = function(pos, node, player, pointed_thing)
			local meta = minetest.get_meta(pos)
			meta:set_string("paused", "paused")
			minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
			evolve.update_form(pos)
end

})



--EVOLUTION BOT BLUE
--same as red, just allows diff settings and pop

minetest.register_node('evolve:evolve_blue', {
	description = 'Evolution Bot (Blue)',
	light_source = 5,
	tiles = {"evolve_blue.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
------------
	on_construct = function(pos)
		--start them out as active, prevents dud bots... such was the idea...
		local meta = minetest.get_meta(pos)
    meta:set_string("paused", "active")
		evolve.update_form(pos)

    end,

-------------
--take action for each button pushed
		on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
-----------
			if fields.set_default_genome then
					evolve.set_default (pos)
					minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

					evolve.update_form(pos)
		end
----------
		if fields.set_random_genome then
				evolve.set_random (pos)
				minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

				evolve.update_form(pos)
	end

	----------
			if fields.set_best_genome then
					--get the best_ever
					local g = evolve.restore_genome_best("blue")
					--so can keep it's own inventory
					local inv_score = meta:get_float("inv_score")
					--only do if there is a best
						if g ~= nil and g ~= "blank" then
	        		evolve.retain_genome_2 (pos, g)
							--reset and correct
							meta:set_float("inv_score", inv_score)
							meta:set_float("score", 0)
							meta:set_string("paused", "paused")
							--bleep!
							minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
							evolve.update_form(pos)
						end
		end


	----------
			if fields.set_mated_genome then
				--mate it with the best ever
					local genome = evolve.retain_genome(pos)
						evolve.mate_genome_3_click(pos, genome, "blue")
						--reset and correct... just need to keep on pause
						meta:set_string("paused", "paused")
						--bleep only, form already updates
						minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
		end

		----------
				if fields.mutate_genome then
						evolve.mutate(pos)
						minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

						evolve.update_form(pos)
			end

			----------
					if fields.set_as_best then
							local g = evolve.retain_genome(pos)
							evolve.save_genome_best(g, "blue")
							minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
				end


		----------
		--activate bot on exit
				if fields.exit_form then
						meta:set_string("paused", "active")
						minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
						evolve.update_form(pos)
				end

	end,


	-----------------------------------
	--pause bot
	on_punch = function(pos, node, player, pointed_thing)
			local meta = minetest.get_meta(pos)
			meta:set_string("paused", "paused")
			minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
			evolve.update_form(pos)
end

})



--------------------------------------------------------------------------
--COMPUTER

--laptop RED
minetest.register_node("evolve:computer", {
	drawtype = "mesh",
	mesh = "computer_laptop.obj",
	description = "Evolution Computer (Red)",
	inventory_image = "evolve_laptop_inv.png",
	tiles = {"evolve_laptop.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 4,
	groups = {snappy=3},
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.5, -0.35, 0.35, 0.05, 0.35},
	},

	on_construct = function(pos)

		evolve.computer_form(pos, "red")

		end,

	on_receive_fields = function(pos, formname, fields, sender)
		if fields.update_top then
				minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
				evolve.computer_form(pos, "red")
		end

		if fields.purge_top then
				minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

				local shit_score = "blank"
				evolve.save_genome_best(shit_score, "red")

				evolve.computer_form(pos, "red")
		end


	end,

})


--laptop BLUE
minetest.register_node("evolve:computer_blue", {
	drawtype = "mesh",
	mesh = "computer_laptop.obj",
	description = "Evolution Computer (Blue)",
	inventory_image = "evolve_laptop_inv_b.png",
	tiles = {"evolve_laptop_b.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 4,
	groups = {snappy=3},
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.5, -0.35, 0.35, 0.05, 0.35},
	},

	on_construct = function(pos)

		evolve.computer_form(pos, "blue")

		end,

	on_receive_fields = function(pos, formname, fields, sender)
		if fields.update_top then
				minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})
				evolve.computer_form(pos, "blue")
		end

		if fields.purge_top then
				minetest.sound_play("evolve_beep", {pos = pos, gain = 0.5, max_hear_distance = 10,})

				local shit_score = "blank"
				evolve.save_genome_best(shit_score, "blue")

				evolve.computer_form(pos, "blue")
		end


	end,

})


------------------------------------------------------------------
--CRAFTS

minetest.register_craft({
	output = "evolve:evolve_miner 99",
	recipe = {
		{"default:steelblock", "default:diamond", "default:copperblock"},
		{"default:diamond", "default:mese_block", "default:diamond"},
		{"default:copperblock", "default:diamond", "default:steelblock"}
	}
})

minetest.register_craft({
	output = "evolve:computer",
	recipe = {
		{"", "default:glass", ""},
		{"", "evolve:evolve_miner", ""},
		{"", "", ""}
	}
})

---------------

minetest.register_craft({
	output = "evolve:evolve_blue 99",
	recipe = {
		{"default:steelblock", "default:diamond", "default:tinblock"},
		{"default:diamond", "default:mese_block", "default:diamond"},
		{"default:tinblock", "default:diamond", "default:steelblock"}
	}
})

minetest.register_craft({
	output = "evolve:computer_blue",
	recipe = {
		{"", "default:glass", ""},
		{"", "evolve:evolve_blue", ""},
		{"", "", ""}
	}
})
