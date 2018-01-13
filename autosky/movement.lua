
---------------------------------------------------------------
--Movement rules
-- these control when nodes swap places
-- will do cooling from hieght changes via elevation not during moves

---------------------------------------------------------------

--settings
local speed = minetest.settings:get('autosky_speed') or 30

local slow_speed = speed + speed

--chance for rising and sinking ABMs
local move_chance = 3


--chance for turbulent
local turb_chance = move_chance + move_chance


---------------------------------------------------------------
--Warm and cold rise and fall
-- default air is ambiguous density
-- therefore assume it is in the middle (neither hot or cold)
-- not doing movement for clouds

--------------------------------------------------------------
--Warm Wet rises

minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
	interval = speed,
	chance = move_chance,
	catch_up = false,
	action = function(pos)


-- get position above

	local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

  -- swap places if default air
  if minetest.get_node(pos_above).name == "air" then
    minetest.set_node(pos_above, {name = "autosky:autosky_warm_wet"})
    minetest.set_node(pos, {name = "air"})
  end



-- swap places if cloud
	if minetest.get_node(pos_above).name == "autosky:autosky_cloud" then
      minetest.set_node(pos_above, {name = "autosky:autosky_warm_wet"})
      minetest.set_node(pos, {name = "autosky:autosky_cloud"})
    end


  -- swap places if cold wet
  if minetest.get_node(pos_above).name == "autosky:autosky_cold_wet" then
    minetest.set_node(pos_above, {name = "autosky:autosky_warm_wet"})
    minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})
  end

end,
}


--------------------------------------------------------------
--Cold wet sinks
-- only do for default, because warm already does this
-- no swapping with same density clouds

minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
	interval = speed,
	chance = move_chance,
	catch_up = false,
	action = function(pos)


-- get position

	local pos_below = {x = pos.x, y = pos.y - 1, z = pos.z}

  -- swap places if default air
  if minetest.get_node(pos_below).name == "air" then
    minetest.set_node(pos_below, {name = "autosky:autosky_cold_wet"})
    minetest.set_node(pos, {name = "air"})
  end

end,
}



--------------------------------------------------------------
--Turbulence
--random movement when encounters different temp
-- don't need another 2 ABMs for cold and cloud, redundant

--------------------------------------------------------------
--Warm Wet Turb

minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
  neighbors = {"autosky:autosky_cold_wet", "autosky:autosky_cloud"},
	interval = speed,
	chance = turb_chance,
	catch_up = false,
	action = function(pos)


-- get position

	local pos_side = {x = pos.x + math.random(-1,1), y = pos.y + math.random(-1,1), z = pos.z + math.random(-1,1)}

  -- swap places if default air
  if minetest.get_node(pos_side).name == "air" then
    minetest.set_node(pos_side, {name = "autosky:autosky_warm_wet"})
    minetest.set_node(pos, {name = "air"})
  end

  -- swap places if cloud
  if minetest.get_node(pos_side).name == "autosky:autosky_cloud" then
      minetest.set_node(pos_side, {name = "autosky:autosky_warm_wet"})
      minetest.set_node(pos, {name = "autosky:autosky_cloud"})
    end


  -- swap places if cold wet
  if minetest.get_node(pos_side).name == "autosky:autosky_cold_wet" then
    minetest.set_node(pos_side, {name = "autosky:autosky_warm_wet"})
    minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})
  end

end,
}
