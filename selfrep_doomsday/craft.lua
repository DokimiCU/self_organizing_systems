----------------------------------------------------------------
---CRAFT
----------------------------------------------------------------

--Crafting Protector
--from goo

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_protector 6",
	recipe = {{"selfrep_doomsday:selfrep_doomsday_greygoo", "selfrep_doomsday:selfrep_doomsday_greygoo", "selfrep_doomsday:selfrep_doomsday_greygoo"}}
})


--from weapon

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_protector 6",
	recipe = {{"selfrep_doomsday:selfrep_doomsday_weapon", "selfrep_doomsday:selfrep_doomsday_weapon", "selfrep_doomsday:selfrep_doomsday_weapon"}}
})


--from blight

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_protector 6",
	recipe = {{"selfrep_doomsday:selfrep_blight", "selfrep_doomsday:selfrep_blight", "selfrep_doomsday:selfrep_blight"}}
})

--from terra

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_protector 6",
	recipe = {{"selfrep_doomsday:selfrep_doomsday_terraformer", "selfrep_doomsday:selfrep_doomsday_terraformer", "selfrep_doomsday:selfrep_doomsday_terraformer"}}
})



--from flash

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_protector 6",
	recipe = {{"selfrep_doomsday:selfrep_doomsday_flash", "selfrep_doomsday:selfrep_doomsday_flash", "selfrep_doomsday:selfrep_doomsday_flash"}}
})

--from chaos

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_protector 6",
	recipe = {{"selfrep_doomsday:selfrep_doomsday_chaos", "selfrep_doomsday:selfrep_doomsday_chaos", "selfrep_doomsday:selfrep_doomsday_chaos"}}
})



--Crafting AutoProtector

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_autoprotector 12",
	recipe = {
		{"selfrep_doomsday:selfrep_doomsday_protector", "selfrep_doomsday:selfrep_doomsday_protector", "selfrep_doomsday:selfrep_doomsday_protector"},
		{"default:mese_block", "selfrep_doomsday:selfrep_doomsday_protector", "default:mese_block"},
		{"default:mese_block", "default:mese_block", "default:mese_block"}
	}
})


-----------------------------------------------------------

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



--Crafting flash

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_flash 10",
	recipe = {
		{"default:steel_ingot", "default:torch", "default:steel_ingot"},
		{"default:mese_block", "tnt:tnt", "default:mese_block"},
		{"default:mese_block", "default:mese_block", "default:mese_block"}
	}
})


--Crafting chaos

minetest.register_craft({
	output = "selfrep_doomsday:selfrep_doomsday_chaos 10",
	recipe = {
		{"default:steel_ingot", "default:obsidian", "default:steel_ingot"},
		{"default:mese_block", "default:obsidian", "default:mese_block"},
		{"default:mese_block", "default:obsidian", "default:mese_block"}
	}
})



--------------------------------------------------------------
--USES

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


-- Burn Flash

minetest.register_craft({
	type = "fuel",
	recipe = "selfrep_doomsday:selfrep_doomsday_flash",
	burntime = 10,
})


-- Burn Chaos

minetest.register_craft({
	type = "fuel",
	recipe = "selfrep_doomsday:selfrep_doomsday_chaos",
	burntime = 1,
})

