
-------------------------------------------------------------
--EFFECTORS RULE SET
--controls when all parts turn off and on
-------------------------------------------------------------


---------------------------------------------------------------
---GLOW CELL

--Turn glow on
-- Balance of synapses Turns on cell

minetest.register_abm{
  nodenames = {"neuron:neuron_glow_e_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

  local num = neuron.balance(pos)

  if (num) >= 1 then
    minetest.set_node(pos, {name = "neuron:neuron_glow_e_on"})
  end


end,
}




--Glow Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_glow_e_on"},
  --neighbors = {""},
	interval = 30,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_glow_e_off"})


end,
}


---------------------------------------------------------------
---COLOR CELL (black/white)

--Turn on
-- Balance of synapses Turns on cell

minetest.register_abm{
  nodenames = {"neuron:neuron_colbw_e_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

  local num = neuron.balance(pos)

  if (num) >= 1 then
    minetest.set_node(pos, {name = "neuron:neuron_colbw_e_on"})
  end


end,
}

-- Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_colbw_e_on"},
  --neighbors = {""},
	interval = 5,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_colbw_e_off"})


end,
}


---------------------------------------------------------------
--IRIS

--Turn on
-- Balance of synapses Turns on cell

minetest.register_abm{
  nodenames = {"neuron:neuron_iris_e_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

  local num = neuron.balance(pos)

  if (num) >= 1 then
    minetest.set_node(pos, {name = "neuron:neuron_iris_e_on"})
  end


end,
}

-- Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_iris_e_on"},
  --neighbors = {""},
	interval = 7,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_iris_e_off"})


end,
}

---------------------------------------------------------------
--GHOST

--Turn on
-- Balance of synapses Turns on cell

minetest.register_abm{
  nodenames = {"neuron:neuron_ghost_e_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

  local num = neuron.balance(pos)

  if (num) >= 1 then
    minetest.set_node(pos, {name = "neuron:neuron_ghost_e_on"})
  end


end,
}

-- Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_ghost_e_on"},
  --neighbors = {""},
	interval = 10,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_ghost_e_off"})


end,
}
