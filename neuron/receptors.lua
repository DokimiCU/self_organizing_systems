
-------------------------------------------------------------
--RECEPTORS RULE SET
--controls their response to stimuli and transmission to axons
-------------------------------------------------------------

---------------------------------------------------------------
---EXCITOR

--Excitor Turn on axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
  --neighbors = {"neuron:neuron_excitor_r"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    --do by each direction
    -- having diagonals gets too confusing, leads to crossed wires
    local ya = {x = pos.x, y = pos.y + 1, z = pos.z}
    local yb = {x = pos.x, y = pos.y - 1, z = pos.z}
    local xa = {x = pos.x + 1, y = pos.y, z = pos.z}
    local xb = {x = pos.x - 1, y = pos.y, z = pos.z}
    local za = {x = pos.x, y = pos.y, z = pos.z + 1}
    local zb = {x = pos.x, y = pos.y, z = pos.z - 1}

      if minetest.get_node(ya).name == "neuron:neuron_excitor_r" or minetest.get_node(yb).name == "neuron:neuron_excitor_r" then
        minetest.set_node(pos, {name = "neuron:neuron_axon_on"})
      end


    if minetest.get_node(xa).name == "neuron:neuron_excitor_r" or minetest.get_node(xb).name == "neuron:neuron_excitor_r" then
      minetest.set_node(pos, {name = "neuron:neuron_axon_on"})
    end

    if minetest.get_node(za).name == "neuron:neuron_excitor_r" or minetest.get_node(zb).name == "neuron:neuron_excitor_r" then
      minetest.set_node(pos, {name = "neuron:neuron_axon_on"})
    end

end,
}

---------------------------------------------------------------
---LIGHT RECEPTOR

--Light R Turn on
-- happens in light

minetest.register_abm{
  nodenames = {"neuron:neuron_light_r_off"},
  --neighbors = {""},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    -- for check light level above

		  local light_level = {}
		  local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

      if  light_level >= 6 then

			minetest.set_node(pos, {name = "neuron:neuron_light_r_on"})
    end


end,
}


--Light R Turn on axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
  --neighbors = {"neuron:neuron_light_r_on"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    --do by each direction
    -- having diagonals gets too confusing, leads to crossed wires
    local ya = {x = pos.x, y = pos.y + 1, z = pos.z}
    local yb = {x = pos.x, y = pos.y - 1, z = pos.z}
    local xa = {x = pos.x + 1, y = pos.y, z = pos.z}
    local xb = {x = pos.x - 1, y = pos.y, z = pos.z}
    local za = {x = pos.x, y = pos.y, z = pos.z + 1}
    local zb = {x = pos.x, y = pos.y, z = pos.z - 1}

      if minetest.get_node(ya).name == "neuron:neuron_light_r_on" or minetest.get_node(yb).name == "neuron:neuron_light_r_on" then
        minetest.set_node(pos, {name = "neuron:neuron_axon_on"})
      end


    if minetest.get_node(xa).name == "neuron:neuron_light_r_on" or minetest.get_node(xb).name == "neuron:neuron_light_r_on" then
      minetest.set_node(pos, {name = "neuron:neuron_axon_on"})
    end

    if minetest.get_node(za).name == "neuron:neuron_light_r_on" or minetest.get_node(zb).name == "neuron:neuron_light_r_on" then
      minetest.set_node(pos, {name = "neuron:neuron_axon_on"})
    end



end,
}

--Light R Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_light_r_on"},
  --neighbors = {""},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_light_r_off"})


end,
}


---------------------------------------------------------------
---CLOCK 10seconds

--Turn on cell

minetest.register_abm{
  nodenames = {"neuron:neuron_clock10_r_off"},
	interval = 10,
	chance = 1,
  catch_up = false,
	action = function(pos)

    minetest.set_node(pos, {name = "neuron:neuron_clock10_r_on"})

end,
}


--Turn on axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_clock10_r_on", "neuron:neuron_axon_on")


end,
}

-- Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_clock10_r_on"},
	interval = 2,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_clock10_r_off"})


end,
}


---------------------------------------------------------------
---TOUCH


--Turn on axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_touch_r_on", "neuron:neuron_axon_on")


end,
}

-- Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_touch_r_on"},
	interval = 2,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_touch_r_off"})


end,
}

--------------------------------------------------------------
---SWITCH


--Turn on axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_switch_r_on", "neuron:neuron_axon_on")


end,
}



---------------------------------------------------------------
---PLAYER

--Turn on cell

minetest.register_abm{
  nodenames = {"neuron:neuron_player_r_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    local objs = minetest.env:get_objects_inside_radius(pos, 4)
    		for k, player in pairs(objs) do
    			if player:get_player_name()~=nil then
    			local meta = minetest.get_meta(pos)

      minetest.set_node(pos, {name = "neuron:neuron_player_r_on"})

    	end
    	end

end,
}


--Turn on axon

minetest.register_abm{
  nodenames = {"neuron:neuron_axon_off"},
	interval = 1,
	chance = 1,
  catch_up = false,
	action = function(pos)

    neuron.trigger(pos, "neuron:neuron_player_r_on", "neuron:neuron_axon_on")


end,
}

-- Turn off

minetest.register_abm{
  nodenames = {"neuron:neuron_player_r_on"},
	interval = 5,
	chance = 1,
  catch_up = false,
	action = function(pos)

			minetest.set_node(pos, {name = "neuron:neuron_player_r_off"})


end,
}
