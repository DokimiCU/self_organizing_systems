--FUNCTIONS

neuron = {}

--balance of synapses to turn on a cell or effector
neuron.balance = function(pos)

  --do by each direction
  -- having diagonals gets too confusing, leads to crossed wires
  local ya = {x = pos.x, y = pos.y + 1, z = pos.z}
  local yb = {x = pos.x, y = pos.y - 1, z = pos.z}
  local xa = {x = pos.x + 1, y = pos.y, z = pos.z}
  local xb = {x = pos.x - 1, y = pos.y, z = pos.z}
  local za = {x = pos.x, y = pos.y, z = pos.z + 1}
  local zb = {x = pos.x, y = pos.y, z = pos.z - 1}

  --number for the position
  local nya = 0
  local nyb = 0
  local nxa = 0
  local nxb = 0
  local nza = 0
  local nzb = 0


  --excitory or inhibitory strength
  --strong
  local se = 1
  local si = -1
  --Weak
  local we = 0.5
  local wi = -0.5

--strong excitatory
  if minetest.get_node(ya).name == "neuron:neuron_esynapse_on" then
    nya = se
  end

  if minetest.get_node(yb).name == "neuron:neuron_esynapse_on" then
    nyb = se
  end


  if minetest.get_node(xa).name == "neuron:neuron_esynapse_on" then
  nxa = se
end

  if minetest.get_node(xb).name == "neuron:neuron_esynapse_on" then
  nxb = se
end

  if minetest.get_node(za).name == "neuron:neuron_esynapse_on" then
  nza = se
end

  if minetest.get_node(zb).name == "neuron:neuron_esynapse_on" then
  nzb = se
end

--weak excitatory
  if minetest.get_node(ya).name == "neuron:neuron_wesynapse_on" then
    nya = we
  end

  if minetest.get_node(yb).name == "neuron:neuron_wesynapse_on" then
    nyb = we
  end


  if minetest.get_node(xa).name == "neuron:neuron_wesynapse_on" then
  nxa = we
end

  if minetest.get_node(xb).name == "neuron:neuron_wesynapse_on" then
  nxb = we
end

  if minetest.get_node(za).name == "neuron:neuron_wesynapse_on" then
  nza = we
end

  if minetest.get_node(zb).name == "neuron:neuron_wesynapse_on" then
  nzb = we
end

-- Strong Inhibitory

  if minetest.get_node(ya).name == "neuron:neuron_isynapse_on" then
  nya = si
end

  if minetest.get_node(yb).name == "neuron:neuron_isynapse_on" then
  nyb = si
end


  if minetest.get_node(xa).name == "neuron:neuron_isynapse_on" then
nxa = si
end

  if minetest.get_node(xb).name == "neuron:neuron_isynapse_on" then
nxb = si
end

  if minetest.get_node(za).name == "neuron:neuron_isynapse_on" then
nza = si
end

  if minetest.get_node(zb).name == "neuron:neuron_isynapse_on" then
nzb = si
end

-- Weak Inhibitory

  if minetest.get_node(ya).name == "neuron:neuron_wisynapse_on" then
  nya = wi
end

  if minetest.get_node(yb).name == "neuron:neuron_wisynapse_on" then
  nyb = wi
end


  if minetest.get_node(xa).name == "neuron:neuron_wisynapse_on" then
nxa = wi
end

  if minetest.get_node(xb).name == "neuron:neuron_wisynapse_on" then
nxb = wi
end

  if minetest.get_node(za).name == "neuron:neuron_wisynapse_on" then
nza = wi
end

  if minetest.get_node(zb).name == "neuron:neuron_wisynapse_on" then
nzb = wi
end


-- does the net influence cross threshold?
--sum the strength of each position
local num = nya + nyb + nxa + nxb + nza + nzb

    return num

end



--trigger neighbors
neuron.trigger = function(pos, get, set)
  --do by each direction
  -- having diagonals gets too confusing, leads to crossed wires
  local ya = {x = pos.x, y = pos.y + 1, z = pos.z}
  local yb = {x = pos.x, y = pos.y - 1, z = pos.z}
  local xa = {x = pos.x + 1, y = pos.y, z = pos.z}
  local xb = {x = pos.x - 1, y = pos.y, z = pos.z}
  local za = {x = pos.x, y = pos.y, z = pos.z + 1}
  local zb = {x = pos.x, y = pos.y, z = pos.z - 1}

  local g = get
  local s = set

    if minetest.get_node(ya).name == g or minetest.get_node(yb).name == g then
      minetest.set_node(pos, {name = s})
    end


  if minetest.get_node(xa).name == g or minetest.get_node(xb).name == g then
    minetest.set_node(pos, {name = s})
  end

  if minetest.get_node(za).name == g or minetest.get_node(zb).name == g then
    minetest.set_node(pos, {name = s})
  end

end



-------------------------------------------------------------
--NEURON RULE SET
--controls when all parts of neurons turn off and on
-------------------------------------------------------------

---------------------------------------------------------------
---AXONS
--receptors triggering axons is in receptors file


-- Axon Turns on Axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
  --neighbors = {"neuron:neuron_axon_on"},
	interval = 0.1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_axon_on", "neuron:neuron_axon_on")

end,
}


-- Axon Turn to resting Rule


minetest.register_abm{
  nodenames = {"neuron:neuron_axon_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)


			minetest.set_node(pos, {name = "neuron:neuron_axon_rest"})

end,
}


-- Resting Axon Turn to off


minetest.register_abm{
  nodenames = {"neuron:neuron_axon_rest"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)


			minetest.set_node(pos, {name = "neuron:neuron_axon_off"})

end,
}

---------------------------------------------------------------
---SYNAPSES

-- Axon Turns on E synapse

minetest.register_abm{
  nodenames = {"neuron:neuron_esynapse_off"},
  --neighbors = {"neuron:neuron_axon_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_axon_on", "neuron:neuron_esynapse_on")


end,
}


-- Axon Turns on weak E synapse

minetest.register_abm{
  nodenames = {"neuron:neuron_wesynapse_off"},
  --neighbors = {"neuron:neuron_axon_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_axon_on", "neuron:neuron_wesynapse_on")

end,
}


-- Axon Turns on I synapse


minetest.register_abm{
  nodenames = {"neuron:neuron_isynapse_off"},
  --neighbors = {"neuron:neuron_axon_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_axon_on", "neuron:neuron_isynapse_on")


end,
}


-- Axon Turns on weak I synapse


minetest.register_abm{
  nodenames = {"neuron:neuron_wisynapse_off"},
  --neighbors = {"neuron:neuron_axon_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)


  neuron.trigger(pos, "neuron:neuron_axon_on", "neuron:neuron_wisynapse_on")


end,
}


-- E synapse Turn to off


minetest.register_abm{
  nodenames = {"neuron:neuron_esynapse_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)


			minetest.set_node(pos, {name = "neuron:neuron_esynapse_off"})

end,
}

-- weak E synapse Turn to off


minetest.register_abm{
  nodenames = {"neuron:neuron_wesynapse_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)


			minetest.set_node(pos, {name = "neuron:neuron_wesynapse_off"})

end,
}

-- I synapse Turn to off


minetest.register_abm{
  nodenames = {"neuron:neuron_isynapse_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)


			minetest.set_node(pos, {name = "neuron:neuron_isynapse_off"})

end,
}

-- weak I synapse Turn to off


minetest.register_abm{
  nodenames = {"neuron:neuron_wisynapse_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)


			minetest.set_node(pos, {name = "neuron:neuron_wisynapse_off"})

end,
}


---------------------------------------------------------------
---CELL BODY




-- Balance of synapses Turns on cell

minetest.register_abm{
  nodenames = {"neuron:neuron_soma_off"},
  --neighbors = {"neuron:neuron_esynapse_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

  local num = neuron.balance(pos)

  if (num) >= 1 then
    minetest.set_node(pos, {name = "neuron:neuron_soma_on"})
  end


end,
}



-- Soma turns on soma
minetest.register_abm{
  nodenames = {"neuron:neuron_soma_off"},
  --neighbors = {"neuron:neuron_soma_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_soma_on", "neuron:neuron_soma_on")


end,
}


-- Cell Turn to resting Rule


minetest.register_abm{
  nodenames = {"neuron:neuron_soma_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_soma_rest"})

end,
}


-- Resting cell Turn to off


minetest.register_abm{
  nodenames = {"neuron:neuron_soma_rest"},
	interval = 2,
	chance = 1,
  catch_up = false,
	action = function(pos)


			minetest.set_node(pos, {name = "neuron:neuron_soma_off"})

end,
}


--Cell Turn on axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
  --neighbors = {"neuron:neuron_soma_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_soma_on", "neuron:neuron_axon_on")



end,
}
