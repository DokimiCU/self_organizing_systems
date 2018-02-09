

----------------------------------------------------------------
--NODES
----------------------------------------------------------------

----------------------------------------------------------------
--Cloud

minetest.register_node("autosky:autosky_cloud", {
	description = "Autosky Cloud",
	tiles = {"autosky_cloud.png"},
	drawtype = "allfaces",
	paramtype = "light",
	sunlight_propagates = false,
	walkable = false,
	pointable = true,
	diggable = true,
	buildable_to = false,
	protected = true,
	on_blast = function(pos)
	end,
	use_texture_alpha = true,
	post_effect_color = {a = 51, r = 255, g = 255, b = 255},
})


----------------------------------------------------------------
--Warm Wet

minetest.register_node("autosky:autosky_warm_wet", {
	description = "Autosky Warm Wet",
	tiles = {"autosky_warm_wet_c.png"},
	drawtype = "allfaces",
	--drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = true,
	diggable = false,
	buildable_to = true,
	protected = true,
	use_texture_alpha = true,
	on_blast = function(pos)
	end,
})




----------------------------------------------------------------
--Cold Wet

minetest.register_node("autosky:autosky_cold_wet", {
	description = "Autosky Cold Wet",
	tiles = {"autosky_cold_wet_c.png"},
	drawtype = "allfaces",
	--drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	pointable = true,
	diggable = false,
	buildable_to = true,
	protected = true,
	use_texture_alpha = true,
	on_blast = function(pos)
	end,
})
