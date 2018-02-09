-------------------------------------------------------------
--Do files
-------------------------------------------------------------
dofile(minetest.get_modpath("selfrep_doomsday").."/nodes.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/craft.lua")

--If you don't want things to spawn in the world block this line

dofile(minetest.get_modpath("selfrep_doomsday").."/spawner.lua")



--Devices
dofile(minetest.get_modpath("selfrep_doomsday").."/autoprotector.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/protector_dome.lua")


dofile(minetest.get_modpath("selfrep_doomsday").."/greygoo.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/weapon.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/blight.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/terraformer.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/flash.lua")

dofile(minetest.get_modpath("selfrep_doomsday").."/chaos.lua")



---------------------------------------------------
--Dangerous Things for accidental releases
--------------------------------------------------

---------------------------------------------------
-- Mystery Box spontaneous release


minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_mystery"},
	interval = 60,
	chance = 60,
	catch_up = false,
	action = function(pos)
				
		local q = math.random (1,11)
			if q ==1 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
			end
			
			if q ==2 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			end

			if q ==3 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon"})
			end

			if q ==4 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_blight"})
			end

			if q ==5 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_terraformer"})
			end

			if q ==6 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_flash"})
			end

			if q ==7 then
				minetest.set_node(pos, {name = "default:mese_block"})
			end

			if q ==8 then
				minetest.set_node(pos, {name = "tnt:tnt"})
			end

			if q ==9 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source"})
			end

			if q ==10 then
				minetest.set_node(pos, {name = "default:sand"})
			end
			
			if q ==11 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos"})
			end

end,
}


---------------------------------------------------------------
-- accidents happen
-- Protector chance of exploding when next to mystery box
-- to trigger mystery release from on-blast, or presence of fire
-- will break containment facility for other boxes

minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_mystery"},
	neighbors = {"selfrep_doomsday:selfrep_doomsday_protector"},
	interval = 60,
	chance = 60,
	catch_up = false,
	action = function(pos)
			
	--boom!	
		tnt.boom(pos, {damage_radius=3,radius=3,ignore_protection=false})
					
		
end,
}




-- Please keep away from liquids and hot materials!
minetest.register_abm{
     	nodenames = {"selfrep_doomsday:selfrep_doomsday_mystery"},
	neighbors = {"group:liquid", "group:igniter"},
	interval = 1,
	chance = 1,
	catch_up = true,
	action = function(pos)
			
	local q = math.random (1,11)
			if q ==1 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_protector"})
			end
			
			if q ==2 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_greygoo"})
			end

			if q ==3 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon"})
			end

			if q ==4 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_blight"})
			end

			if q ==5 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_terraformer"})
			end

			if q ==6 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_flash"})
			end

			if q ==7 then
				minetest.set_node(pos, {name = "default:mese_block"})
			end

			if q ==8 then
				minetest.set_node(pos, {name = "tnt:tnt"})
			end

			if q ==9 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_weapon_residue_source"})
			end

			if q ==10 then
				minetest.set_node(pos, {name = "default:sand"})
			end
		
			if q ==11 then
				minetest.set_node(pos, {name = "selfrep_doomsday:selfrep_doomsday_chaos"})
			end
		
end,
}






