



----------------------------------------------------------------
---CRAFT
----------------------------------------------------------------



--Crafting grey goo

minetest.register_craft({
	output = "selfrep:selfrep_greygoo",
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:mese_block", "default:mese_block", "default:mese_block"},
		{"default:coalblock", "default:coalblock", "default:coalblock"}
	}
})


--Crafting weapon

minetest.register_craft({
	output = "selfrep:selfrep_weapon",
	recipe = {
		{"default:sword_mese", "tnt:tnt", "default:sword_mese"},
		{"default:torch", "default:mese_block", "default:torch"},
		{"default:coalblock", "default:mese_block", "default:coalblock"}
	}
})

