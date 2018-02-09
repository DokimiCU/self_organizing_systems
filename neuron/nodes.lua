---------------------------------------------------------------
---NODES
----------------------------------------------------------------

---------------------------------------------------------------
---RECEPTORS
--- these respond to an external stimulus
-- or generate a stimulus themselves

-----------------------------------------------------------
-- Excitor
-- Constantly triggers axons
minetest.register_node("neuron:neuron_excitor_r", {
	description = "Excitor",
	tiles = {"neuron_excitor_r.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

-----------------------------------------------------------
-- Clock (1Osec)
-- Triggers axons every ten seconds

--off
minetest.register_node("neuron:neuron_clock10_r_off", {
	description = "Clock (10sec, off)",
	tiles = {"neuron_clock10_r_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
	--[[on_construct = function(pos)
		minetest.get_node_timer(pos):start(10)
	end,
	on_timer = function(pos, elapsed)
		minetest.set_node(pos, {name = "neuron:neuron_clock10_r_on"})
	end,]]
})

--on
minetest.register_node("neuron:neuron_clock10_r_on", {
	description = "Clock (10sec, on)",
	tiles = {"neuron_clock10_r_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_clock10_r_off"
})



-----------------------------------------------------------
-- Light receptor
-- triggered by light
--transparent so light can enter

--off
minetest.register_node("neuron:neuron_light_r_off", {
	description = "Light Receptor (off)",
	tiles = {"neuron_light_r_off.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_light_r_on", {
	description = "Light Receptor (on)",
	tiles = {"neuron_light_r_on.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_light_r_off"
})


-----------------------------------------------------------
-- Touch receptor
-- triggered by punching


--off
minetest.register_node("neuron:neuron_touch_r_off", {
	description = "Touch Receptor (off)",
	tiles = {"neuron_touch_r_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"neuron:neuron_touch_r_on"})
	end,

})

--on
minetest.register_node("neuron:neuron_touch_r_on", {
	description = "Touch Receptor (on)",
	tiles = {"neuron_touch_r_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_touch_r_off"
})

-----------------------------------------------------------
-- Switch
-- triggered by punching, stays on until punched again


--off
minetest.register_node("neuron:neuron_switch_r_off", {
	description = "Switch (off)",
	tiles = {"neuron_switch_r_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"neuron:neuron_switch_r_on"})
	end,

})

--on
minetest.register_node("neuron:neuron_switch_r_on", {
	description = "Switch (on)",
	tiles = {"neuron_switch_r_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_switch_r_off",
	on_punch = function(pos, node)
		minetest.set_node(pos, {name = 	"neuron:neuron_switch_r_off"})
	end,
})



-----------------------------------------------------------
-- Player receptor
-- triggered by player presence


--off
minetest.register_node("neuron:neuron_player_r_off", {
	description = "Player Receptor (off)",
	tiles = {"neuron_player_r_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_player_r_on", {
	description = "Player Receptor (on)",
	tiles = {"neuron_player_r_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_player_r_off"
})



---------------------------------------------------------------
--- EFFECTORS
--- these produce an action


-----------------------------------------------------------
-- Glow Cell
--produces light

--off
minetest.register_node("neuron:neuron_glow_e_off", {
	description = "Glow Cell (off)",
	tiles = {"neuron_glow_e_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_glow_e_on", {
	description = "Glow Cell (on)",
	tiles = {"neuron_glow_e_on.png"},
	light_source = 13,
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_glow_e_off"
})


-----------------------------------------------------------
-- Color Cell (black/white)

--off
minetest.register_node("neuron:neuron_colbw_e_off", {
	description = "Color Cell (off/black)",
	tiles = {"neuron_colbw_e_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_colbw_e_on", {
	description = "Color Cell (on/white)",
	tiles = {"neuron_colbw_e_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_colbw_e_off"
})


-----------------------------------------------------------
-- Iris
-- turns from opaque to transparent
--controls entry of light... like the iris of the eye

--off
minetest.register_node("neuron:neuron_iris_e_off", {
	description = "Iris (off)",
	tiles = {"neuron_iris_e_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_iris_e_on", {
	description = "Iris (on)",
	tiles = {"neuron_iris_e_on.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_iris_e_off"
})


-----------------------------------------------------------
-- Ghost cell
-- turns from solid to passable air
--like a door

--off
minetest.register_node("neuron:neuron_ghost_e_off", {
	description = "Ghost (off)",
	tiles = {"neuron_ghost_e_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_ghost_e_on", {
	description = "Ghost (on)",
	tiles = {"neuron_ghost_e_off.png"},
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = false,
	sunlight_propagates = true,
	groups = {not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
})




---------------------------------------------------------------
--- NEURONS
--- these are the components of the actual neurons

-----------------------------------------------------------
-- Cell Body
--the main body of the Cell
-- combines function of dendrites and soma

--off
minetest.register_node("neuron:neuron_soma_off", {
	description = "Cell Body (off)",
	tiles = {"neuron_soma_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--resting
minetest.register_node("neuron:neuron_soma_rest", {
	description = "Cell Body (resting)",
	tiles = {"neuron_soma_rest.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_soma_off"
})


--on
minetest.register_node("neuron:neuron_soma_on", {
	description = "Cell Body (on)",
	tiles = {"neuron_soma_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_soma_off"
})


-----------------------------------------------------------
-- Axon
-- transmits signals from cells to synapses


--off
minetest.register_node("neuron:neuron_axon_off", {
	description = "Axon (off)",
	tiles = {"neuron_axon_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--resting
minetest.register_node("neuron:neuron_axon_rest", {
	description = "Axon (resting)",
	tiles = {"neuron_axon_rest.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_axon_off"
})


--on
minetest.register_node("neuron:neuron_axon_on", {
	description = "Axon (on)",
	tiles = {"neuron_axon_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_axon_off"
})



-----------------------------------------------------------
-- Excitatory Synapse
-- encourages cell body to turn on

--Strong, produces a strong signal
--off
minetest.register_node("neuron:neuron_esynapse_off", {
	description = "Strong Excitatory Synapse (off)",
	tiles = {"neuron_esynapse_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_esynapse_on", {
	description = "Strong Excitatory Synapse (on)",
	tiles = {"neuron_esynapse_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_esynapse_off"
})

--Weak, produces a weak signal
--off
minetest.register_node("neuron:neuron_wesynapse_off", {
	description = "Weak Excitatory Synapse (off)",
	tiles = {"neuron_wesynapse_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_wesynapse_on", {
	description = "Weak Excitatory Synapse (on)",
	tiles = {"neuron_wesynapse_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_wesynapse_off"
})

----------------------------------------------------------
-- Inhibitory Synapse
-- stops a cell body from turning on

--Strong, produces a strong signal
--off
minetest.register_node("neuron:neuron_isynapse_off", {
	description = "Strong Inhibitory Synapse (off)",
	tiles = {"neuron_isynapse_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_isynapse_on", {
	description = "Strong Inhibitory Synapse (on)",
	tiles = {"neuron_isynapse_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_isynapse_off"
})


--Weak, produces a weak signal

--off
minetest.register_node("neuron:neuron_wisynapse_off", {
	description = "Weak Inhibitory Synapse (off)",
	tiles = {"neuron_wisynapse_off.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

--on
minetest.register_node("neuron:neuron_wisynapse_on", {
	description = "Weak Inhibitory Synapse (on)",
	tiles = {"neuron_wisynapse_on.png"},
	groups = {choppy = 3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	drop = "neuron:neuron_wisynapse_off"
})
