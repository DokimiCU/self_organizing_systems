---------------------------------------------------------------
--Autosky
---------------------------------------------------------------
--to see all nodes unblock color_nodes.lua and block nodes.lua


--Dofiles
dofile(minetest.get_modpath("autosky").."/nodes.lua")

--dofile(minetest.get_modpath("autosky").."/color_nodes.lua")

dofile(minetest.get_modpath("autosky").."/movement.lua")

dofile(minetest.get_modpath("autosky").."/transformations.lua")

dofile(minetest.get_modpath("autosky").."/spawner.lua")



----------------------------------------------------------------
-- AMBIENCE...
--wind wind different temps colide
--when cold hits warm

minetest.register_abm{
  nodenames = {
    "autosky:autosky_cloud",
    "autosky:autosky_cold_wet",
  },
  neighbors = {"autosky:autosky_warm_wet"},
	interval = 20,
	chance = 20,
	catch_up = false,
	action = function(pos)

		-- windy

			minetest.sound_play("autosky_wind", {pos = pos, gain = 0.9, max_hear_distance = 25,})


end,
}


--lightning
--when clouds and warm air collide
--rare
-- possibly not working as intended... but good enough
minetest.register_abm{
  nodenames = {
    "autosky:autosky_cloud",
  },
  neighbors = {"autosky:autosky_warm_wet"},
	interval = 30,
	chance = 10000,
	catch_up = false,
	action = function(pos)

--check has space to zap
    local function get_pos(pos)
    local line, pos2 = minetest.line_of_sight(pos, {x = pos.x, y = pos.y - 100, z = pos.z}, 1)
    if line then
      return nil
    end
  end

    local pos2 = get_pos(pos)

if pos2 == nil then


    minetest.add_particlespawner({
    		amount = 1,
    		time = 0.2,
    		minpos = {x = pos.x, y = pos.y, z = pos.z },
    		maxpos = {x = pos.x, y = pos.y, z = pos.z },
    		minvel = {x = 0, y = 0, z = 0},
    		maxvel = {x = 0, y = 0, z = 0},
    		minacc = {x = 0, y = 0, z = 0},
    		maxacc = {x = 0, y = 0, z = 0},
    		minexptime = 0.1,
    		maxexptime = 0.2,
    		minsize = 50,
    		maxsize = 300,
    		collisiondetection = true,
    		vertical = true,
    		texture = "autosky_lightning.png",
    		glow = 14,
    	})

    	minetest.sound_play({ pos = pos, name = "autosky_thunder", gain = 10, max_hear_distance = 100 })
end

end,
}
