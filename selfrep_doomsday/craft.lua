



----------------------------------------------------------------
---CRAFT
----------------------------------------------------------------

--Crafting Goo

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_greygoo 5",
	recipe = {
		{"default:steel_ingot", "group:stone", "default:steel_ingot"},
		{"default:mese_block", "default:mese_block", "default:mese_block"},
		{"default:mese_block", "default:mese_block", "default:mese_block"}
	}
})


--Crafting weapon

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_weapon 5",
	recipe = {
		{"default:steel_ingot", "tnt:tnt", "default:steel_ingot"},
		{"default:mese_block", "default:mese_block", "default:mese_block"},
		{"default:mese_block", "default:mese_block", "default:mese_block"}
	}
})


--Crafting blight

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_blight 5",
	recipe = {
		{"default:steel_ingot", "group:sand", "default:steel_ingot"},
		{"default:mese_block", "default:mese_block", "default:mese_block"},
		{"default:mese_block", "default:mese_block", "default:mese_block"}
	}
})



--Crafting terra

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_terraformer 5",
	recipe = {
		{"default:steel_ingot", "group:flora", "default:steel_ingot"},
		{"default:mese_block", "default:mese_block", "default:mese_block"},
		{"default:mese_block", "default:mese_block", "default:mese_block"}
	}
})



--Cook Goo

minetest.register_craft({
	type = "cooking",
	output = "default:iron_lump",
	recipe = "selfrep_doomsday:selfrep_doomsday_greygoo",
})


--Cook Weapon

minetest.register_craft({
	type = "cooking",
	output = "default:copper_lump",
	recipe = "selfrep_doomsday:selfrep_doomsday_weapon",
})


--Cook Blight

minetest.register_craft({
	type = "cooking",
	output = "default:coal_lump",
	recipe = "selfrep_doomsday:selfrep_blight",
})


--Cook Terra

minetest.register_craft({
	type = "cooking",
	output = "default:clay_lump",
	recipe = "selfrep_doomsday:selfrep_doomsday_terraformer",
})



-- Burn Goo

minetest.register_craft({
	type = "fuel",
	recipe = "selfrep_doomsday:selfrep_doomsday_greygoo",
	burntime = 1,
})

-- Burn Weapon

minetest.register_craft({
	type = "fuel",
	recipe = "selfrep_doomsday:selfrep_doomsday_weapon",
	burntime = 4,
})


-- Burn Blight

minetest.register_craft({
	type = "fuel",
	recipe = "selfrep_doomsday:selfrep_blight",
	burntime = 1,
})


-- Burn Terra

minetest.register_craft({
	type = "fuel",
	recipe = "selfrep_doomsday:selfrep_doomsday_terraformer",
	burntime = 1,
})



