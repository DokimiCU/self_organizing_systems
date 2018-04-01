

----------------------------------------------------------------
---- Crafting
----------------------------------------------------------------


----------------------------------------------------------------
--MAKING BOTS... removed, spawner makes it unnecessary. they can be accessed in creative anyway


----------------------------------------------------------------
--MAKING STUFF FROM BOTS
-- all tree and shrub and trunk nodes can already be used as fuel
-- all flowers can be turned into dye (includes some biggger plants set as flowers)
-- only animals, dead, and herbs need crafts. But animals can be eaten.

--make generic plant life into sticks...easiest way of making sure all have some craft use
minetest.register_craft({
	output = 'default:stick 3',
	recipe = {
	{'group:flora','group:flora','group:flora'}, 	{'group:flora','group:flora','group:flora'},
	{'group:flora','group:flora','group:flora'},
	}
})


-- make dead into something peat like
minetest.register_craft({
	output = 'default:coal_lump',
	recipe = {
		{'ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead'}, 	{'ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead'},
	{'ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead','ecobots:ecobots_bot_dead'},
	}
})


-- make grass into paper (as a substitute for displacing papyrus)
minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'ecobots:ecobots_pioneer_bot','ecobots:ecobots_pioneer_bot','ecobots:ecobots_pioneer_bot'}, 	{'ecobots:ecobots_pioneer_bot','ecobots:ecobots_pioneer_bot','ecobots:ecobots_pioneer_bot'},
	{'ecobots:ecobots_pioneer_bot','ecobots:ecobots_pioneer_bot','ecobots:ecobots_pioneer_bot'},
	}
})


--make evine into ladders for a sturdier climbing thing
minetest.register_craft({
	output = "default:ladder_wood 5",
	recipe = {
		{"ecobots:ecobots_evine_bot", "", "ecobots:ecobots_evine_bot"},
		{"ecobots:ecobots_evine_bot", "ecobots:ecobots_evine_bot", "ecobots:ecobots_evine_bot"},
		{"ecobots:ecobots_evine_bot", "", "ecobots:ecobots_evine_bot"},
	}
})


---------------------------------------------------------------
--ANIMAL MEAT
--these are for the (currently unfinished) animals API
--This is a set of generic animal meats for various types of mob to drop.
-- cooked and raw.
-- red meat, white meat, insect goo,

--RED
--e.g. mammals

-- raw red meat
minetest.register_craftitem("ecobots:red_meat_raw", {
	description = "Raw Red Meat",
	inventory_image = "ecobots_red_meat_raw.png",
	on_use = minetest.item_eat(2),
})

-- cooked red meat
minetest.register_craftitem("ecobots:red_meat", {
	description = "Red Meat",
	inventory_image = "ecobots_red_meat.png",
	on_use = minetest.item_eat(6),
})

--cook red
minetest.register_craft({
	type = "cooking",
	output = "ecobots:red_meat",
	recipe = "ecobots:red_meat_raw",
	cooktime = 5,
})


--WHITE
--e.g. birds, fish

-- raw white meat
minetest.register_craftitem("ecobots:white_meat_raw", {
	description = "Raw White Meat",
	inventory_image = "ecobots_white_meat_raw.png",
	on_use = minetest.item_eat(2),
})

-- cooked white meat
minetest.register_craftitem("ecobots:white_meat", {
	description = "White Meat",
	inventory_image = "ecobots_white_meat.png",
	on_use = minetest.item_eat(6),
})

--cook white meat
minetest.register_craft({
	type = "cooking",
	output = "ecobots:white_meat",
	recipe = "ecobots:white_meat_raw",
	cooktime = 4,
})


--GOO
--e.g. insects, snails

-- raw white meat
minetest.register_craftitem("ecobots:bug_goo_raw", {
	description = "Raw Bug Goo",
	inventory_image = "ecobots_bug_goo_raw.png",
	on_use = minetest.item_eat(0.5),
})

-- cooked bug goo
minetest.register_craftitem("ecobots:bug_goo", {
	description = "Bug Goo",
	inventory_image = "ecobots_bug_goo.png",
	on_use = minetest.item_eat(2),
})

--cook red
minetest.register_craft({
	type = "cooking",
	output = "ecobots:bug_goo",
	recipe = "ecobots:bug_goo_raw",
	cooktime = 2,
})

