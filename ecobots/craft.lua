

----------------------------------------------------------------
---- Crafting
----------------------------------------------------------------


----------------------------------------------------------------
--MAKING BOTS

---starter to make photosynth
minetest.register_craft({
	output = 'ecobots:ecobots_photosynth_bot 99',
	recipe = {
		{'default:sapling'},{'default:tree'},{'default:mese_block'},
	}
})


---starter to make pioneer
minetest.register_craft({
	output = 'ecobots:ecobots_pioneer_bot 99',
	recipe = {
		{'default:grass'},{'default:tree'},{'default:mese_block'},
	}
})


---next to make herbivore
minetest.register_craft({
	output = 'ecobots:ecobots_predator_bot 3',
	recipe = {
		{'ecobots:ecobots_photosynth_bot'},{'ecobots:ecobots_photosynth_bot'},{'ecobots:ecobots_photosynth_bot'},
	}
})


---pioneer alternative to make herbivore
minetest.register_craft({
	output = 'ecobots:ecobots_predator_bot 3',
	recipe = {
		{'ecobots:ecobots_pioneer_bot'},{'ecobots:ecobots_pioneer_bot'},{'ecobots:ecobots_pioneer_bot'},
	}
})


---next to make apex from herbivore
minetest.register_craft({
	output = 'ecobots:ecobots_apex_bot 3',
	recipe = {
		{'ecobots:ecobots_predator_bot'},{'ecobots:ecobots_predator_bot'},{'ecobots:ecobots_predator_bot'},
	}
})


---to make decomposer out of dead

minetest.register_craft({
	output = 'ecobots:ecobots_decomposer_bot 3',
	recipe = {
		{'ecobots:ecobots_bot_dead'},{'ecobots:ecobots_bot_dead'},{'ecobots:ecobots_bot_dead'},
	}
})

---to make detritivore from decomposers 

minetest.register_craft({
	output = 'ecobots:ecobots_detritivore_bot 3',
	recipe = {
		{'ecobots:ecobots_decomposer_bot'},{'ecobots:ecobots_decomposer_bot'},{'ecobots:ecobots_decomposer_bot'},
	}
})




----------------------------------------------------------------
--MAKING STUFF FROM BOTS

-- mulch dead
minetest.register_craft({
	output = 'default:coal_lump',
	recipe = {
		{'ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead'}, 	{'ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead'},
	{'ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead'},
	}
})

--apple from photo
minetest.register_craft({
	output = 'default:apple',
	recipe = {
		{'ecobots:ecobots_photosynth_bot', 'ecobots:ecobots_photosynth_bot', 'ecobots:ecobots_photosynth_bot'},
		{'ecobots:ecobots_photosynth_bot', 'ecobots:ecobots_photosynth_bot', 'ecobots:ecobots_photosynth_bot'},
		{'ecobots:ecobots_photosynth_bot', 'ecobots:ecobots_photosynth_bot', 'ecobots:ecobots_photosynth_bot'},

	}
})

--flour from pioneer
minetest.register_craft({
	output = 'farming:flour',
	recipe = {
		{'ecobots:ecobots_pioneer_bot', 'ecobots:ecobots_pioneer_bot', 'ecobots:ecobots_pioneer_bot'},
		{'ecobots:ecobots_pioneer_bot', 'ecobots:ecobots_pioneer_bot', 'ecobots:ecobots_pioneer_bot'},
		{'ecobots:ecobots_pioneer_bot', 'ecobots:ecobots_pioneer_bot', 'ecobots:ecobots_pioneer_bot'},

	}
})


-- string from herbi
minetest.register_craft({
	output = 'farming:string',
	recipe = {
		{'ecobots:ecobots_predator_bot', 'ecobots:ecobots_predator_bot', 'ecobots:ecobots_predator_bot'},
		{'ecobots:ecobots_predator_bot', 'ecobots:ecobots_predator_bot', 'ecobots:ecobots_predator_bot'},
		{'ecobots:ecobots_predator_bot', 'ecobots:ecobots_predator_bot', 'ecobots:ecobots_predator_bot'},
	}
})


-- iron from apex
minetest.register_craft({
	output = 'default:iron_lump',
	recipe = {
		{'ecobots:ecobots_apex_bot', 'ecobots:ecobots_apex_bot', 'ecobots:ecobots_apex_bot'},
		{'ecobots:ecobots_apex_bot', 'ecobots:ecobots_apex_bot', 'ecobots:ecobots_apex_bot'},
		{'ecobots:ecobots_apex_bot', 'ecobots:ecobots_apex_bot', 'ecobots:ecobots_apex_bot'},
	}
})


-- clay from detritivore
minetest.register_craft({
	output = 'default:clay_lump',
	recipe = {
		{'ecobots:ecobots_detritivore_bot', 'ecobots:ecobots_detritivore_bot', 'ecobots:ecobots_detritivore_bot'},
		{'ecobots:ecobots_detritivore_bot', 'ecobots:ecobots_detritivore_bot', 'ecobots:ecobots_detritivore_bot'},
		{'ecobots:ecobots_detritivore_bot', 'ecobots:ecobots_detritivore_bot', 'ecobots:ecobots_detritivore_bot'},
	}
})


-- mushroom from decomposer
minetest.register_craft({
	output = 'flowers:mushroom_brown',
	recipe = {
		{'ecobots:ecobots_decomposer_bot', 'ecobots:ecobots_decomposer_bot', 'ecobots:ecobots_decomposer_bot'},
		{'ecobots:ecobots_decomposer_bot', 'ecobots:ecobots_decomposer_bot', 'ecobots:ecobots_decomposer_bot'},
		{'ecobots:ecobots_decomposer_bot', 'ecobots:ecobots_decomposer_bot', 'ecobots:ecobots_decomposer_bot'},
	}
})

