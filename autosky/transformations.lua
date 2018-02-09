
---------------------------------------------------------------
--Transformation rules
-- these control when nodes change type


---------------------------------------------------------------

--settings
local speed = minetest.settings:get('autosky_speed') or 90

local slow_speed = speed + speed + 3
local slowest_speed = speed + speed + speed + 3



--chance of cooling or warming with altitude
--second is for rapid change
local alt_chance = 20
local alt_chance_2 = 5

--maximum height for weather to occur i.e. space
--altitude at which rain and snow are forced are fractions of this
local max_height = 2000

--number of particles to be spawned from rain and snowing
-- large numbers severly impact performance
local ppte_amount = 1


--the following settings are subject to random fluctuations
-- this is to mimic macro changes that can't be included
--reset the value every few minutes

--macro heat
--for large changes in temperature
-- higher values push things in favour of warm process
local macro_heat = math.random(1,10)
--wind speed
-- for the prevailing wind and sea spray
-- higher is faster
local macro_wind = math.random(1,10)
--Air pressure
-- raises and lowers threshold for pressure cooling and heating
-- higher is high pressure
local macro_pres = math.random(1,10)
--time till change
local macro_go = speed * 10

--randomly change macro conditions
    local macro_timer = 0
    minetest.register_globalstep(function(dtime)
    macro_timer = macro_timer + dtime;
      if macro_timer > macro_go then
        macro_heat = math.random(1,10)
        macro_wind = math.random(1,10)
        macro_pres = math.random(1,10)
        macro_timer = 0
      end
    end)



--in high pressure we want the cooling threshold to be high
  --height above which pressure related cooling occurs
  local alt_height_cool = 12*macro_pres
  --height above which pressure related cooling is rapid
  local alt_height_cool_2 = 20*macro_pres

  -- in high pressure we want the heating threshold to be high
  --height below which pressure related heating occurs
  local alt_height_heat = 16*macro_pres
  --height below which pressure related heating is rapid
  local alt_height_heat_2 = 6*macro_pres



--wind Speed and chance to move
local wind_speed = 13 - macro_wind
local move_chance_side = 11 - macro_wind
--cold sea spray
local sea_chance = 100 - macro_wind

--condensation and disappation chance from temperature
-- should lead to positive feedback for cloud forming/loss
-- hot makes it less likely
local cond_chance = 1 + macro_heat
local diss_chance = 11 - macro_heat

--Evaporation chance
-- heat increases it
local evap_chance = 70 - macro_heat

-- Transpiration by plants
-- reduced in hot weather as plants conserve
local trans_chance = 80 + macro_heat


--light heating and cooling chance
local sun_chance = 50 - macro_heat
local sun_chance_cool = 50 + macro_heat

--surface heating and cooling chance
-- heat increases sun heated surfaces power
local sun_sur_chance = 11 - macro_heat
local sur_chance = 8


--chance of a cloud raining or snowing
-- have threshold for dry weather
-- have threshold for snow
local ppt_chance = {}
local ppt_chance_snow = {}
--hottest
if macro_heat >= 9 then
  ppt_chance = 1000
  ppt_chance_snow = 1000
end
--hot
if macro_heat <= 8 and macro_heat >=7 then
  ppt_chance = 100
  ppt_chance_snow = 1000
end
--medium
if macro_heat <= 6 and macro_heat >=5 then
  ppt_chance = 25
  ppt_chance_snow = 1000
end
--cold
--dump rain
if macro_heat <= 4 and macro_heat >=3 then
  ppt_chance = 1
  ppt_chance_snow = 100
end
--coldest
-- dump snow
if macro_heat <=2 then
  ppt_chance = 1000
  ppt_chance_snow = 1
end

--something to get rid of massive build ups
--extreme dry strong winds will remove all Moisture
--should achieve a sort of occassional reset
local hot_blast = {}
if macro_heat >= 10 and macro_wind >=10 then
  hot_blast = 10
end

----------------------------------------------------------
--Weather monitor
-- so can display the macro weather variables
-- mainly for troubleshooting
-- also may prove a weather forecaster
--not with other nodes bc needs weather values



minetest.register_node("autosky:autosky_monitor", {
	description = "Weather Monitor",
	tiles = {
		"autosky_monitor.png",
		"autosky_monitor.png",
		"autosky_monitor.png",
		"autosky_monitor.png",
		"autosky_monitor.png",
		"autosky_monitor.png"
	},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = false,
	groups = {oddly_breakable_by_hand=1},
  --set form when build
  on_construct = function(pos)
  		local meta = minetest.get_meta(pos)
  		meta:set_string("formspec",
      "size[10,10]"..
      "label[1,0.5;This device monitors global weather changes that may impact your local weather]"..
      "button[1,9;2,1;update;Update Data]"..
      "button_exit[7,9;2,1;exit_form;Exit]"..
      "label[1,1.5;Macro Heat Temperature Index]"..
      "textlist[1,2;0.5,0.5;heading_list;"..macro_heat.."]"..
      "label[1,3;1 is cold 10 is hot]"..
      "label[1,4;Macro Air Pressure Index]"..
      "textlist[1,4.5;0.5,0.5;heading_list;"..macro_pres.."]"..
      "label[1,5.5;1 is low pressure 10 is high]"..
      "label[6,1.5;Macro Wind Speed Index]"..
      "textlist[6,2;0.5,0.5;heading_list;"..macro_wind.."]"..
      "label[6,3;1 is calm 10 is windy]"
    )
      end,
  --display values
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
    minetest.show_formspec(player:get_player_name(), "monitor", formspec)
end,
--update data
  on_receive_fields = function(pos, formname, fields, sender)
			local meta = minetest.get_meta(pos)
			if fields.update then
        minetest.sound_play("autosky_beep", {pos = pos, gain = 0.4, max_hear_distance = 5,})
        meta:set_string("formspec",
        "size[10,10]"..
        "label[1,0.5;This device monitors global weather changes that may impact your local weather]"..
        "button[1,9;2,1;update;Update Data]"..
        "button_exit[7,9;2,1;exit_form;Exit]"..
        "label[1,1.5;Macro Heat Temperature Index]"..
        "textlist[1,2;0.5,0.5;heading_list;"..macro_heat.."]"..
        "label[1,3;1 is cold 10 is hot]"..
        "label[1,4;Macro Air Pressure Index]"..
        "textlist[1,4.5;0.5,0.5;heading_list;"..macro_pres.."]"..
        "label[1,5.5;1 is low pressure 10 is high]"..
        "label[6,1.5;Macro Wind Speed Index]"..
        "textlist[6,2;0.5,0.5;heading_list;"..macro_wind.."]"..
        "label[6,3;1 is calm 10 is windy]"
      )
    end
  end
})




---------------------------------------------------------------
--Housekeeping
--keep non-default air nodes away from stuff that needs default
-- changes them back to air
-- mainly so it doesn't screw with...
-- Ecobots
-- flowing liquids
---------------------------------------------------------------
minetest.register_abm{
  nodenames = {
    "autosky:autosky_cloud",
    "autosky:autosky_warm_wet",
    "autosky:autosky_cold_wet",
  },
  neighbors = {"group:flora", "group:liquid"},
	interval = 1,
	chance = 1,
	catch_up = false,
	action = function(pos)

--set back to default

    minetest.set_node(pos, {name = "air"})

end,
}


--hot blast, to occassionally clear out excessive amounts of moisture
minetest.register_abm{
  nodenames = {
    "autosky:autosky_cloud",
    "autosky:autosky_warm_wet",
    "autosky:autosky_cold_wet",
  },
  neighbors = {"air"},
	interval = 3,
	chance = hot_blast,
	catch_up = false,
	action = function(pos)

--set back to default

    minetest.set_node(pos, {name = "air"})

end,
}

---------------------------------------------------------------
--Prevailing Wind movement
--moved this here from movement file bc needs macro variables for wind
-- areas of same density can mix
--allow all to mix with default air
-- pushes everything east with a bit of wiggle
-- mimics macro scale stuff that this can't do
---------------------------------------------------------------

--------------------------------------------------------------
--Warm Wet Sideways

minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
	interval = wind_speed,
	chance = move_chance_side,
	catch_up = false,
	action = function(pos)


-- get position

	local pos_side = {x = pos.x + 1, y = pos.y, z = pos.z + math.random(-1,1)}

  -- swap places if default air
  if minetest.get_node(pos_side).name == "air" then
    minetest.set_node(pos_side, {name = "autosky:autosky_warm_wet"})
    minetest.set_node(pos, {name = "air"})
  end


end,
}


--------------------------------------------------------------
--Cold Wet Sideways

minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
	interval = wind_speed,
	chance = move_chance_side,
	catch_up = false,
	action = function(pos)


-- get position

	local pos_side = {x = pos.x + 1, y = pos.y, z = pos.z + math.random(-1,1)}

  -- swap places if default air
  if minetest.get_node(pos_side).name == "air" then
    minetest.set_node(pos_side, {name = "autosky:autosky_cold_wet"})
    minetest.set_node(pos, {name = "air"})
  end

-- swap places if cloud
  if minetest.get_node(pos_side).name == "autosky:autosky_cloud" then
      minetest.set_node(pos_side, {name = "autosky:autosky_cold_wet"})
      minetest.set_node(pos, {name = "autosky:autosky_cloud"})
    end

end,
}

--------------------------------------------------------------
--Cloud Sideways

minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
	interval = wind_speed + 2,
	chance = move_chance_side,
	catch_up = false,
	action = function(pos)


-- get position

	local pos_side = {x = pos.x + 1, y = pos.y, z = pos.z + math.random(-1,1)}


  -- swap places if cold wet
  	if minetest.get_node(pos_side).name == "autosky:autosky_cold_wet" then
        minetest.set_node(pos_side, {name = "autosky:autosky_cloud"})
        minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})
      end

  -- swap places if default air
  if minetest.get_node(pos_side).name == "air" then
    minetest.set_node(pos_side, {name = "autosky:autosky_cloud"})
    minetest.set_node(pos, {name = "air"})
  end

end,
}







---------------------------------------------------------------
--Cooling with high altitude
---------------------------------------------------------------

---------------------------------------------------------------
--low altitude
--low chance of cooling


--cool warm wet
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
	interval = slowest_speed,
	chance = alt_chance,
	catch_up = false,
	action = function(pos)

--cool down

  if pos.y >= alt_height_cool then
    minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})
  end

end,
}


---------------------------------------------------------------
--High altitude
--high chance of cooling


--cool warm wet
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
	interval = speed,
	chance = alt_chance_2,
	catch_up = false,
	action = function(pos)

--cool down

  if pos.y >= alt_height_cool_2 then
    minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})
  end

end,
}


---------------------------------------------------------------
--heating with lower altitude
---------------------------------------------------------------

---------------------------------------------------------------
--High altitude
--low chance of heating


--Heat cool wet
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
	interval = slowest_speed,
	chance = alt_chance,
	catch_up = false,
	action = function(pos)

--heat up

  if pos.y <= alt_height_heat then
    minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
  end

end,
}

--Heat i.e. dry warm wet
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
	interval = slowest_speed,
	chance = alt_chance,
	catch_up = false,
	action = function(pos)

--heat up

  if pos.y <= alt_height_heat then
    minetest.set_node(pos, {name = "air"})
  end

end,
}


--Heat clouds
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
	interval = slowest_speed,
	chance = alt_chance,
	catch_up = false,
	action = function(pos)

--heat up

  if pos.y <= alt_height_heat then
    minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
  end

end,
}

---------------------------------------------------------------
--low altitude
--high chance of heating


--Heat cool wet
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
	interval = speed,
	chance = alt_chance_2,
	catch_up = false,
	action = function(pos)

--heat up

  if pos.y <= alt_height_heat_2 then
    minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
  end

end,
}

--Heat i.e. dry warm wet
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
	interval = slowest_speed,
	chance = alt_chance_2,
	catch_up = false,
	action = function(pos)

--heat up

  if pos.y <= alt_height_heat_2 then
    minetest.set_node(pos, {name = "air"})
  end

end,
}


--Heat Clouds
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
	interval = slow_speed,
	chance = alt_chance_2,
	catch_up = false,
	action = function(pos)

--heat up

  if pos.y <= alt_height_heat_2 then
    minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
  end

end,
}

---------------------------------------------------------------
--Form clouds when cold
-- surrounding cold air causes wet air to form condensation
--do warm wet when it gets cold i.e. can't hold water anymore
-- do cold when it is near other clouds i.e. condensation surfaces
-- i.e. cold can't condense bc can't get colder than cold
---------------------------------------------------------------

--cold air cools down warm
--should trigger positve feedback flipping warm to cold
-- then trigger another feedback with following ABMs
-- hopefully the result is to trigger saturated air to do big rain
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
  neighbors = {"autosky:autosky_cold_wet", "autosky:autosky_cloud"},
	interval = slow_speed,
	chance = cond_chance,
	catch_up = false,
	action = function(pos)

--condense

    minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})

end,
}


--a threshold of cold forces cold to form clouds
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
	interval = slowest_speed,
	chance = cond_chance,
	catch_up = false,
	action = function(pos)

    -- radius for scan
      local radius = 1

    --how much needs to be nearby to trigger
      local tolerance = 6

      --count cold wet
        local num_a = {}
        local ps, cn = minetest.find_nodes_in_area(
          {x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
          {x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, {"autosky:autosky_cold_wet"})
        num_a = (cn["autosky:autosky_cold_wet"] or 0)


    --only do if near cold air
    --should trigger a positive feedback with next ABM
    if (num_a) > tolerance  then

--condensation

    minetest.set_node(pos, {name = "autosky:autosky_cloud"})
  end

end,
}


--clouds force cold to condense
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
  neighbors = {"autosky:autosky_cloud"},
	interval = speed,
	chance = cond_chance,
	catch_up = false,
	action = function(pos)

--condensation

    minetest.set_node(pos, {name = "autosky:autosky_cloud"})

end,
}


---------------------------------------------------------------
--Heat transfers
-- the opposite of the cloud cooling above
-- will create conflict in air mass between hot and cold
-- hopefully one side will win out
---------------------------------------------------------------

--uncondense cloud
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
  neighbors = {"autosky:autosky_warm_wet"},
	interval = slowest_speed,
	chance = diss_chance,
	catch_up = false,
	action = function(pos)

--no more cloud

    minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})

end,
}



--warm cold
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
  neighbors = {"autosky:autosky_warm_wet"},
	interval = slow_speed,
	chance = diss_chance,
	catch_up = false,
	action = function(pos)

--no more cloud

    minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})

end,
}

---------------------------------------------------------------
--Evaporation
---------------------------------------------------------------

-- sunny water forms warm wet air in air

minetest.register_abm{
  nodenames = {"air"},
  neighbors = {"group:water"},
	interval = slow_speed,
	chance = evap_chance,
	catch_up = false,
	action = function(pos)

    -- do it above so it doesn't conflict with keeping liquids clear
    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

    -- do if it is in air
    if minetest.get_node(pos_above).name == "air" then

    -- for check light level

    		local light_level = {}
    		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

--need high light to get the energy
        if  light_level >= 13 then
          --wet it
          minetest.set_node(pos_above, {name = "autosky:autosky_warm_wet"})
        end
      end

end,
}



-- water forms cold wet air
-- i.e. sea spray etc
minetest.register_abm{
  nodenames = {"air"},
  neighbors = {"group:water"},
	interval = slowest_speed,
	chance = sea_chance,
	catch_up = false,
	action = function(pos)


    -- do it above so it doesn't conflict with keeping liquids clear
    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

    -- do if it is in air
    if minetest.get_node(pos_above).name == "air" then

          --wet it
          minetest.set_node(pos_above, {name = "autosky:autosky_cold_wet"})
        end

end,
}


---------------------------------------------------------------
--Transpiration
-- water from plants
---------------------------------------------------------------

-- During dark
-- more than day as plants avoid heat
minetest.register_abm{
  nodenames = {"air"},
  neighbors = {
    "default:dirt_with_grass",
    "default:dirt_with_rainforest_litter",
    "group:flora",
    "group:leaves",
    "group:sapling"
  },
	interval = slow_speed,
	chance = trans_chance,
	catch_up = false,
	action = function(pos)

    -- do it above so it doesn't conflict with keeping flora clear
    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

    -- do if it is in air
    if minetest.get_node(pos_above).name == "air" then

    local light_level = {}
    local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

--do during twilight bc plants would limit water loss during midday heat
    if  light_level <= 10 and light_level >= 0 then

          --wet it
          --cold bc cools temp
          minetest.set_node(pos_above, {name = "autosky:autosky_cold_wet"})
        end
      end

end,
}

-- During day
-- less than night as plants avoid heat
minetest.register_abm{
  nodenames = {"air"},
  neighbors = {
    "default:dirt_with_grass",
    "default:dirt_with_rainforest_litter",
    "group:flora",
    "group:leaves",
    "group:sapling"
  },
	interval = slowest_speed + 3,
	chance = trans_chance + 3,
	catch_up = false,
	action = function(pos)

    -- do it above so it doesn't conflict with keeping flora clear
    local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}

    -- do if it is in air
    if minetest.get_node(pos_above).name == "air" then

    local light_level = {}
    local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

-- avoid water loss during midday heat
    if  light_level >= 11 and light_level <= 14 then

          --wet it
          --lowers temp
          minetest.set_node(pos_above, {name = "autosky:autosky_cold_wet"})
        end
      end

end,
}


---------------------------------------------------------------
--Sunny heating
---------------------------------------------------------------

-- sunny heats cold wet
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
	interval = slow_speed,
	chance = sun_chance,
	catch_up = false,
	action = function(pos)

    -- for check light level

    		local light_level = {}
    		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

        if  light_level >= 14 then
          --heat it
          minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
        end

end,
}

-- sunny heats cloud
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
	interval = slowest_speed,
	chance = sun_chance,
	catch_up = false,
	action = function(pos)

    -- for check light level

    		local light_level = {}
    		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

        if  light_level >= 14 then
          --heat it
          minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
        end

end,
}



---------------------------------------------------------------
--Dark cooling
---------------------------------------------------------------

-- dark cools warm Wet
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
	interval = slow_speed,
	chance = sun_chance_cool,
	catch_up = false,
	action = function(pos)

    -- for check light level

    		local light_level = {}
    		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

        if  light_level <= 4 then
          --cool it
          minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})
        end

end,
}



---------------------------------------------------------------
--Hot surfaces
---------------------------------------------------------------

-- sunny heated surfaces warm cold wet
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
  neighbors = {"group:stone", "group:sand", "default:gravel", "default:dirt_with_dry_grass"},
	interval = speed,
	chance = sun_sur_chance,
	catch_up = false,
	action = function(pos)

    -- for check light level

    		local light_level = {}
    		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

        if  light_level >= 13 then
          --heat it
          minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
        end

end,
}

-- sunny surfaces dry warm wet
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
  neighbors = {"group:stone", "group:sand", "default:gravel", "default:dirt_with_dry_grass"},
	interval = slow_speed,
	chance = sun_sur_chance,
	catch_up = false,
	action = function(pos)

    -- for check light level

    		local light_level = {}
    		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

        if  light_level >= 13 then
          --heat it
          minetest.set_node(pos, {name = "air"})
        end

end,
}

-- sunny heated surfaces warm clouds
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
  neighbors = {"group:stone", "group:sand", "default:gravel", "default:dirt_with_dry_grass"},
	interval = slow_speed,
	chance = sun_sur_chance,
	catch_up = false,
	action = function(pos)

    -- for check light level

    		local light_level = {}
    		local light_level = ((minetest.get_node_light({x = pos.x, y = pos.y, z = pos.z})) or 0)

        if  light_level >= 13 then
          --heat it
          minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})
        end

end,
}




-- inherently hot stuff heats cold wet
minetest.register_abm{
  nodenames = {"autosky:autosky_cold_wet"},
  neighbors = {"group:lava", "fire:basic_flame", "default:furnace", "default:torch"},
	interval = speed,
	chance = sur_chance,
	catch_up = false,
	action = function(pos)


          --heat it
          minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})


end,
}

-- inherently hot stuff dry warm wet
minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
  neighbors = {"group:lava", "fire:basic_flame", "default:furnace", "default:torch"},
	interval = slow_speed,
	chance = sur_chance,
	catch_up = false,
	action = function(pos)


          --heat it
          minetest.set_node(pos, {name = "air"})


end,
}

-- inherently hot stuff heats cloud
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
  neighbors = {"group:lava", "fire:basic_flame", "default:furnace", "default:torch"},
	interval = slow_speed,
	chance = sur_chance,
	catch_up = false,
	action = function(pos)


          --heat it
          minetest.set_node(pos, {name = "autosky:autosky_warm_wet"})

end,
}


---------------------------------------------------------------
--Cold surfaces
---------------------------------------------------------------

--inherently cold stuff cools warm wet

minetest.register_abm{
  nodenames = {"autosky:autosky_warm_wet"},
  neighbors = {
    "group:water",
    "default:dirt_with_snow",
    "default:snow",
    "default:snowblock",
    "default:ice"
  },
	interval = speed,
	chance = sur_chance,
	catch_up = false,
	action = function(pos)

          --cool it
          minetest.set_node(pos, {name = "autosky:autosky_cold_wet"})
end,
}


---------------------------------------------------------------
--Dissappate all
-- turn them back into default
-- clears them out above a certain layer
-- stops filling out to space and forever
-- i.e. have left the trophosphere
---------------------------------------------------------------
minetest.register_abm{
  nodenames = {
    "autosky:autosky_cloud",
    "autosky:autosky_warm_wet",
    "autosky:autosky_cold_wet",
  },
	interval = 3,
	chance = 3,
	catch_up = false,
	action = function(pos)

if pos.y >= max_height then
--set back to default
    minetest.set_node(pos, {name = "air"})
  end

end,
}


---------------------------------------------------------------
--Rain
--only do when other clouds about
---------------------------------------------------------------
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
  neighbors = {"autosky:autosky_cloud"},
	interval = speed,
	chance = ppt_chance,
	catch_up = false,
	action = function(pos)

    --make it rain
    minetest.add_particlespawner({
      amount = ppte_amount,
      time = 0.1,
    	minpos = {x = pos.x - 0.5, y = pos.y, z = pos.z - 0.5},
    	maxpos = {x = pos.x + 0.5, y = pos.y, z = pos.z + 0.5},
    	minvel = {x=-0, y=-1, z=-0},
    	maxvel = {x=0, y=-2, z=0},
    	minacc = {x=0, y=-1, z=0},
    	maxacc = {x=0, y=-2, z=0},
    	minexptime = 3,
    	maxexptime = 10,
    	minsize = 1,
    	maxsize = 6,
    	collisiondetection = true,
    	vertical = true,
    	texture = "autosky_raindrop.png",
    	--playername = "singleplayer"
    })


    -- remove cloud
        minetest.set_node(pos, {name = "air"})

  --make it sound like rain
  minetest.sound_play("autosky_rain", {
    	pos = {x = pos.x, y = pos.y - 1, z = pos.z},
      --make it long distance as it is near the cloud, not impact
    	max_hear_distance = 50,
    	gain = 1,
    })


end,
}



---------------------------------------------------------------
--Snow

---------------------------------------------------------------
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
  neighbors = {
    "autosky:autosky_cloud",
    "default:dirt_with_snow",
    "default:snow",
    "default:snowblock",
    "default:ice"
  },
	interval = speed,
	chance = ppt_chance_snow,
	catch_up = false,
	action = function(pos)


    --make it snow
    minetest.add_particlespawner({
      amount = ppte_amount,
      time = 0.1,
    	minpos = {x = pos.x - 0.5, y = pos.y, z = pos.z - 0.5},
    	maxpos = {x = pos.x + 0.5, y = pos.y, z = pos.z + 0.5},
    	minvel = {x= -0.05, y= -0.1, z= -0.05},
    	maxvel = {x= 0.05, y=-0.5, z=0.05},
    	minacc = {x= -0.05, y= -0.1, z= -0.05},
    	maxacc = {x=0.05, y=-0.5, z=0.05},
    	minexptime = 5,
    	maxexptime = 15,
    	minsize = 1,
    	maxsize = 7,
    	collisiondetection = true,
    	vertical = false,
    	texture = "autosky_snowflake.png",
    	--playername = "singleplayer"
    })


    -- remove cloud
        minetest.set_node(pos, {name = "air"})

end,
}

---------------------------------------------------------------
--Snow by altitude
---------------------------------------------------------------
minetest.register_abm{
  nodenames = {"autosky:autosky_cloud"},
  neighbors = {
    "autosky:autosky_cloud",
    "default:dirt_with_snow",
    "default:snow",
    "default:snowblock",
    "default:ice"
  },
	interval = speed,
  --force snow, don't use normal chance
	chance = 2,
	catch_up = false,
	action = function(pos)


  --only do if too high
    if pos.y >= max_height/9 then


      --make it snow
          minetest.add_particlespawner({
          	amount = ppte_amount,
          	time = 0.1,
          	minpos = {x = pos.x - 0.5, y = pos.y, z = pos.z - 0.5},
          	maxpos = {x = pos.x + 0.5, y = pos.y, z = pos.z + 0.5},
          	minvel = {x= -0.05, y= -0.1, z= -0.05},
          	maxvel = {x= 0.05, y=-0.5, z=0.05},
          	minacc = {x= -0.05, y= -0.1, z= -0.05},
          	maxacc = {x=0.05, y=-0.5, z=0.05},
          	minexptime = 5,
          	maxexptime = 10,
          	minsize = 1,
          	maxsize = 7,
          	collisiondetection = true,
          	vertical = false,
          	texture = "autosky_snowflake.png",
          	--playername = "singleplayer"
          })


-- remove cloud
    minetest.set_node(pos, {name = "air"})

      end

end,
}
