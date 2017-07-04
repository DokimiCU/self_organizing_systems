

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




