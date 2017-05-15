





-- Node on

minetest.register_node('autocell:autocell_on', {
	description = 'Autocell On',
	light_source = 14,
	tiles = {"autocell_on.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(2)
		end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "autocell:autocell_dying"})
	end,
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"autocell:autocell_off"})
	end,

	})

-- Node dying

minetest.register_node('autocell:autocell_dying', {
	description = 'Autocell Dying',
	light_source = 5,
	tiles = {"autocell_dying.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(1)
		end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = 	"autocell:autocell_off"})
	end,

})


-- Node off

minetest.register_node('autocell:autocell_off', {
	description = 'Autocell Off',
	light_source = 0,
	tiles = {"autocell_off.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"autocell:autocell_on"})
	end,

	})



-- Turn on Rule


minetest.register_abm{
     	nodenames = {"autocell:autocell_off"},
	interval = 1,
	chance = 1,
	action = function(pos)
		local radius = 1
		local num_on = {}
		
		--count on cells
		local ps, cn = minetest.find_nodes_in_area(
			{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
			{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"autocell:autocell_on"})
		num_on = (cn["autocell:autocell_on"] or 0)
		
		
		
		--Triggered by neighbours
		if (num_on) >= 2 and (num_on) <= 4 then

			minetest.set_node(pos, {name = "autocell:autocell_on"})	
		---minetest.sound_play("autocell_on", {pos = pos, gain = 0.3, max_hear_distance = 7,})				
		end
		
end,
}




