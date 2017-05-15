



----------------------------------------------------------------
---CRAFT
----------------------------------------------------------------

--Crafting road

minetest.register_craft({
	output = "selfrep:selfrep_road",
	recipe = {
		{"default:steel_ingot", "group:stone", "default:steel_ingot"},
		{"default:diamond", "default:mese_block", "default:diamond"},
		{"default:steel_ingot", "group:stone", "default:steel_ingot"}
	}
})


--Crafting tower

minetest.register_craft({
	output = "selfrep:selfrep_tower",
	recipe = {
		{"default:steel_ingot", "default:mese_block", "default:steel_ingot"},
		{"default:diamond", "group:stone", "default:diamond"},
		{"default:steel_ingot", "group:stone", "default:steel_ingot"}
	}
})


--Crafting sponge

minetest.register_craft({
	output = "selfrep:selfrep_sponge",
	recipe = {
		{"default:steel_ingot", "default:mese_block", "default:steel_ingot"},
		{"default:diamond", "default:sand", "default:diamond"},
		{"default:steel_ingot", "default:gravel", "default:steel_ingot"}
	}
})



