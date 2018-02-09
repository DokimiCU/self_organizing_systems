--A cellular automata that plays music... yeah... "music" 
--block playsound lines if you just want colours


--these are the notes it plays
--we have alternate notes!
--unblock the set you want.. just don't double up

--piano
local note_1 = "automusic_c"
local note_2 = "automusic_e"
local note_3 = "automusic_g"

--drums
--local note_1 = "automusic_tom1"
--local note_2 = "automusic_tom2"
--local note_3 = "automusic_tom3"

--creepy long notes
--local note_1 = "automusic_creepy_bflat"
--local note_2 = "automusic_creepy_d"
--local note_3 = "automusic_creepy_f"



-- how fast it plays

local tempo_all = 0.7
local chance_all = 1



-- give generic names for block because any three notes (that harmonize) could be used


-- Node off


minetest.register_node('autocell:automusic_off', {
	description = 'Automusic Off',
	--light_source = 14,
	tiles = {"autocell_music_off.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"autocell:automusic_first"})
	end,

	})



-- Node first

minetest.register_node('autocell:automusic_first', {
	description = 'Automusic First',
	--light_source = 5,
	tiles = {"autocell_music_1.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"autocell:automusic_second"})
	end,
	
})


-- Node second

minetest.register_node('autocell:automusic_second', {
	description = 'Automusic Second',
	--light_source = 0,
	tiles = {"autocell_music_2.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"autocell:automusic_third"})
	end,

	})

-- Node third

minetest.register_node('autocell:automusic_third', {
	description = 'Automusic Third',
	--light_source = 0,
	tiles = {"autocell_music_3.png"},
	groups = {cracky = 3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_glass_defaults(),
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"autocell:automusic_off"})
	end,
	})




-- Die Rule
-- turns them off

minetest.register_abm{
     	nodenames = {"autocell:automusic_first", "autocell:automusic_second", "autocell:automusic_third"},
	interval = tempo_all *2,
	chance = 1,
	action = function(pos)

	minetest.set_node(pos, {name = "autocell:automusic_off"})

end,
}


-- Turn on Rule off to 1
-- anything on turns off on at beginning of cycle

minetest.register_abm{
     	nodenames = {"autocell:automusic_off"},
	neighbors = {"autocell:automusic_first", "autocell:automusic_second", "autocell:automusic_third"},
	interval = tempo_all,
	chance = chance_all,
	action = function(pos)

	minetest.set_node(pos, {name = "autocell:automusic_first"})

	minetest.sound_play(note_1, {pos = pos, gain = 0.5, max_hear_distance = 20,})
		
end,
}




-- Turn on Rule 1 to 2


minetest.register_abm{
     	nodenames = {"autocell:automusic_first"},
	neighbors = {"autocell:automusic_first"},
	interval = tempo_all,
	chance = chance_all,
	action = function(pos)

	minetest.set_node(pos, {name = "autocell:automusic_second"})

	minetest.sound_play(note_2, {pos = pos, gain = 0.5, max_hear_distance = 20,})
		
end,
}

-- Turn on Rule 2 to 3


minetest.register_abm{
     	nodenames = {"autocell:automusic_second"},
	neighbors = {"autocell:automusic_second"},
	interval = tempo_all,
	chance = chance_all,
	action = function(pos)

	minetest.set_node(pos, {name = "autocell:automusic_third"})

	minetest.sound_play(note_3, {pos = pos, gain = 0.5, max_hear_distance = 20,})
				
end,
}

-- Turn on Rule 3 to off


minetest.register_abm{
     	nodenames = {"autocell:automusic_third"},
	neighbors = {"autocell:automusic_third"},
	interval = tempo_all,
	chance = chance_all,
	action = function(pos)
		
	
		minetest.set_node(pos, {name = "autocell:automusic_off"})	
					
		
end,
}







