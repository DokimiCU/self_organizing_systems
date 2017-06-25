





-- Node on


minetest.register_node('autocell:autocell_on', {
	description = 'Autocell On',
	light_source = 14,
	tiles = {"autocell_on.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
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
		if (num_on) >= 2 and (num_on) <= 5 
then

---a number of different rules could be set for this...but it works
--
			minetest.set_node(pos, {name = "autocell:autocell_on"})	
					
		end
		
end,
}


-- Turn to resting Rule


minetest.register_abm{
     	nodenames = {"autocell:autocell_on"},
	interval = 2,
	chance = 1,
	action = function(pos)
		

			minetest.set_node(pos, {name = "autocell:autocell_dying"})	
				
end,
}


--Turn to off Rule

minetest.register_abm{
     	nodenames = {"autocell:autocell_dying"},
	interval = 2,
	chance = 1,
	action = function(pos)
		

			minetest.set_node(pos, {name = "autocell:autocell_off"})	
end,
}




