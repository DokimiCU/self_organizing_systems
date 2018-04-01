----------------------------------------------------------------
--A first attempt at getting animals as entities rather than blocks.
-- Nowhere near finished!
------
--ECOBOTS ANIMALS Api

ecobots = {}

-- localize math functions
local random = math.random
local pi = math.pi
local floor = math.floor
local square = math.sqrt
local min = math.min
local atann = math.atan
local sin = math.sin
local cos = math.cos
local atan = function(x)
	if not x or x ~= x then
		--error("atan bassed NaN")
		return 0
	else
		return atann(x)
	end
end



-----------------------------------------------------------------------
--BASIC
--ORIENTATION ETC

-- set YAW
local set_yaw = function(self, yaw)

	if not yaw or yaw ~= yaw then
		yaw = 0
	end

	self:setyaw(yaw)

	return yaw
end


-- CHECK.. if within physical map limits (-30911 to 30927)
local within_limits = function(pos, radius)

	if  (pos.x - radius) > -30913
	and (pos.x + radius) <  30928
	and (pos.y - radius) > -30913
	and (pos.y + radius) <  30928
	and (pos.z - radius) > -30913
	and (pos.z + radius) <  30928 then
		return true -- within limits
	end

	return false -- beyond limits
end



-- FIND... out what a node is (use fallback for nil or unknown)
local node_ok = function(pos, fallback)

	fallback = fallback or "default:dirt"

	local node = minetest.get_node_or_nil(pos)

	if node and minetest.registered_nodes[node.name] then
		return node
	end

	return {name = fallback}
end





-- VELOCITY...move bot in facing direction
local set_velocity = function(self, v)

	local yaw = (self.object:getyaw() or 0) + self.rotate
		--go forward
		self.object:setvelocity({
			x = sin(yaw) * -v,
			y = self.object:getvelocity().y,
			z = cos(yaw) * v
			})

end




-- Calculate DISTANCE
local get_distance = function(a, b)

	local x, y, z = a.x - b.x, a.y - b.y, a.z - b.z

	return square(x * x + y * y + z * z)
end


-- SPEED of bot
local get_velocity = function(self)

	local v = self.object:getvelocity()

	return (v.x * v.x + v.z * v.z) ^ 0.5
end





-----------------------------------------------------------------------
--SOUND ETC

-- PLAY sound
local bot_sound = function(self, sound)

	if sound then
		minetest.sound_play(sound, {
			object = self.object,
			gain = 1.0,
			max_hear_distance = self.sounds.distance or 10
		})
	end
end


--SET ANIM
local set_animation = function(self, anim)

	if not self.animation then return end

	self.animation.current = self.animation.current or ""

	if anim == self.animation.current
	or not self.animation[anim .. "_start"]
	or not self.animation[anim .. "_end"] then
		return
	end

	self.animation.current = anim

	self.object:set_animation({
		x = self.animation[anim .. "_start"],
		y = self.animation[anim .. "_end"]},
		self.animation[anim .. "_speed"] or self.animation.speed_normal or 15,
		0, self.animation[anim .. "_loop"] ~= false)
end




------------------------------------------------------------------------
--DEATH

-- check if bot is dead or only hurt
local check_for_death = function(self)

	-- has health actually changed?
	if self.health == self.old_health and self.health > 0 then
		return
	end

	self.old_health = self.health

	-- still got some health? play hurt sound
	if self.health > 0 then

		bot_sound(self, self.sounds.damage)

		-- make sure health isn't higher than max
		if self.health > self.hp_max then
			self.health = self.hp_max
		end

		return false
	end

	--if those didn't fire, then you dead!
	--play death sound
	bot_sound(self, self.sounds.death)

	local pos = self.object:getpos()

	self.object:remove()
	--minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})

	return true

end

-----------------------------------------------------------------------
--CLIFFS, WALLS, JUMPING ETC


-- CLIFF... is bot facing a cliff?
local is_at_cliff = function(self)

	-- no fear! We don't believe in cliffs!
	if self.fear_height == 0 then
		return false
	end

	local yaw = self.object:getyaw()
	local dir_x = -sin(yaw) * (self.collisionbox[4] + 0.5)
	local dir_z = cos(yaw) * (self.collisionbox[4] + 0.5)
	local pos = self.object:getpos()
	local ypos = pos.y + self.collisionbox[2] -- just above floor

	if minetest.line_of_sight(
		{x = pos.x + dir_x, y = ypos, z = pos.z + dir_z},
		{x = pos.x + dir_x, y = ypos - self.fear_height, z = pos.z + dir_z}
	, 1) then

		return true
	end

	return false
end


-- FLIGHT ...are we in the right stuff?
local flight_check = function(self, pos_w)

	local nod = self.standing_in

	if type(self.fly_in) == "string"
	and (nod == self.fly_in or nod == self.fly_in:gsub("_source", "_flowing")) then

		return true

	elseif type(self.fly_in) == "table" then

		for _,fly_in in pairs(self.fly_in) do

			if nod == fly_in or nod == fly_in:gsub("_source", "_flowing") then

				return true
			end
		end
	end

	return false
end




--JUMPING
local do_jump = function(self)

	--reasons not to jump
	if not self.jump
	or self.jump_height == 0
	or self.fly
	or self.child then
		return false
	end

	-- something stopping us while moving?
	if self.state ~= "stand"
	and get_velocity(self) > 0.5
	and self.object:getvelocity().y ~= 0 then
		return false
	end

	local pos = self.object:getpos()
	local yaw = self.object:getyaw()

	-- what is bot standing on?
	pos.y = pos.y + self.collisionbox[2] - 0.2

	local nod = node_ok(pos)

	--you can't jump off that!
	if minetest.registered_nodes[nod.name].walkable == false then
		return false
	end

	-- where is front
	local dir_x = -sin(yaw) * (self.collisionbox[4] + 0.5)
	local dir_z = cos(yaw) * (self.collisionbox[4] + 0.5)

	-- what is in front of bot?
	local nod = node_ok({
		x = pos.x + dir_x,
		y = pos.y + 0.5,
		z = pos.z + dir_z
	})

	-- thin blocks that do not need to be jumped
	if nod.name == "default:snow" then
		return false
	end

--print ("in front:", nod.name, pos.y + 0.5)

	if (minetest.registered_items[nod.name].walkable
	and not nod.name:find("fence")
	and not nod.name:find("gate")) then

		local v = self.object:getvelocity()

		v.y = self.jump_height -- + 1

		set_animation(self, "jump") -- only when defined

		self.object:setvelocity(v)

		bot_sound(self, self.sounds.jump)

		return true
	end

	return false
end



--Called by hitting a wall in is_wall
--triggers, jumping,climbing, turning to escape
local is_stuck = function(self)

	local sv = get_velocity(self)
	local av = self.object:getvelocity()

	--flier? go up! or down? sometimes turn
	if self.fly then
		--check above and below to see which way to move
		local pos = self.object:getpos()
		--Above?
		pos.y = pos.y + self.collisionbox[2] + 0.2
		local nod = node_ok(pos)
		--way is clear above?
		if nod.name == self.fly_in then
			--move up at the speed supposed to move
			av.y = sv
			self.object:setvelocity(av)
		else
			--below?
			pos.y = pos.y + self.collisionbox[2] - 0.2
			nod = node_ok(pos)
			if nod.name == self.fly_in then
				--move down at the speed supposed to move
				av.y = -sv
				self.object:setvelocity(av)
			--both up and down were blocked, random turns
			else
				yaw = (random(0, 360) - 180) / 180 * pi
				set_yaw(self.object, yaw)
			end
		end

	--jumper? jump! sometimes turn
	elseif self.jump and self.jump_height > 0 then
		do_jump(self)

	--climber? Climb...HAVEN"T DONE YET
	elseif self.climb then
		yaw = (random(0, 360) - 180) / 180 * pi
		set_yaw(self.object, yaw)

	--useless prick? Turn around
	else
		yaw = (random(0, 360) - 180) / 180 * pi
		set_yaw(self.object, yaw)
	end

	return
end




--check if a wall is in front
local is_wall = function(self)
	local pos = self.object:getpos()
	local yaw = self.object:getyaw()

	-- where is front
	local dir_x = -sin(yaw) * (self.collisionbox[4] + 0.5)
	local dir_z = cos(yaw) * (self.collisionbox[4] + 0.5)

	-- what is in front of bot?
	local nod = node_ok({
		x = pos.x + dir_x,
		y = pos.y + 0.5,
		z = pos.z + dir_z
	})

	--I'm flying in this buddy!
	if self.fly and nod.name == self.fly_in then
		return false
	end

	-- thin blocks
	if nod.name == "default:snow" then
		return false
	end

	--it is actually hit a wall
	if (minetest.registered_items[nod.name].walkable) then
		return true
	else
		return false
	end
end







-- FLOP! swimmers flop when out of their element, and swim again when back in
local swim_flop = function(self)

	--if it's a flier, that is out of it's element but not stuck in a wall
	if self.fly then
		local s = self.object:getpos()
		local nodef = minetest.registered_nodes[self.standing_in]
		if not flight_check(self, s)
		and not nodef.walkable then

			self.object:setvelocity({x = 0, y = -3, z = 0})
			--jump if hits land
			do_jump(self)
			set_animation(self, "stand")


			return
		end
	end
end


--STOP AT CLIFFS
local cliff_stop = function(self)
	-- if at a cliff then stand
	local is_cliff = is_at_cliff(self)
	if is_cliff then

		set_velocity(self, 0)
		set_animation(self, "stand")

		--fly
		if flight_check(self)
		and self.animation
		and self.animation.fly_start
		and self.animation.fly_end then
			set_animation(self, "fly")
		else
			set_animation(self, "walk")
		end
	end
end

------------------------------------------------------------
--PURSUIT

--called by attack and mating routines that need one bot to follow another
--can also be used to make it flee (dir, 0 = pursue, 1 = flee)
local pursue = function(self, target, move_type, dir)
	minetest.chat_send_all("pursue!")
	--abort, somethings wrong
	if target == nil then
		return
	end

	--set speed
	local speed = 0
	if move_type == "walk" then
		speed = self.walk_velocity
	elseif move_type == "run" then
		speed = self.run_velocity
	end

	--check if it's hit a wall
	--will do the get out of stuck procedure
	--don't let it continue and overwite that behaviour
	--!!!!!!!!!!!!!!!!!!!!They still get stuck when fleeing
	--...fleeing
	local wall = is_wall(self)
	if wall then
		is_stuck(self)
		return
	end

	--random turns if fleeing
	if dir == 1
	and random(1, self.turn_chance * 5) <= 1 then
		yaw = ((random(0, 360) - 180) / 180 * pi) - self.rotate
		yaw = set_yaw(self.object, yaw)
		--end here or turn gets overlaid
		return
	end

	local p
	local s = self.object:getpos()

	--if mob or player
	if target.object ~= nil then
		p = target.object:getpos()
	else
	--target:is_player()then
		p = target:getpos()
	end

	--don't follow yourself or if youre already there
	if p ~= s then
		local dist = get_distance(p, s)

		-- dont follow if out of range
		if dist > self.view_range then
			return
		end

		local vec = {
			x = p.x - s.x,
			y = p.y - s.y,
			z = p.z - s.z
		}
		--for fleeing
		if dir == 1 then
			local vec = {
				x = p.x + s.x,
				y = p.y + s.y,
				z = p.z + s.z
			}
		end


		local yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

		if p.x > s.x then yaw = yaw + pi
		end

		set_yaw(self.object, yaw)

		-- hasn't reached it
		if dist > self.reach then
			--non-fliers go ahead, fliers need to do check
			if not self.fly then
				set_velocity(self, speed)
				set_animation(self, move_type)
			elseif flight_check(self, s) then
				set_velocity(self, speed)
				set_animation(self, move_type)
			end


		--has already reached it
		else
			set_velocity(self, 0)
			set_animation(self, "stand")
		end

		--for flying follow up/down when out of reach
		if self.fly then
			local v = self.object:getvelocity()
			--in flight medium
			if flight_check(self, s) then
				--below target
				if s.y < p.y then
					--run upwards
					self.object:setvelocity({
					x = v.x,
					y = speed,
					z = v.z
				})
				--above target
			elseif s.y > p.y then
					--move down
					self.object:setvelocity({
						x = v.x,
						y = - speed,
						z = v.z
					})
				end
			end
		end
	end



	return
end



--GO TO A LOCATION... called by liked blocks etc
-- or go away (dir, 0 for to, 1 for away)
local go_to = function(self, target_pos, move_type, dir)
	--abort, somethings wrong
	if target == nil then
		return
	end

	local speed = 0

	if move_type == "walk" then
		speed = self.walk_velocity
	elseif move_type == "run" then
		speed = self.run_velocity
	end

	local s = self.object:getpos()

	--don't follow yourself or if youre already there
	if target_pos ~= s then
		local dist = get_distance(target_pos, s)

		-- dont go if out of range...don't know where it is
		if dist > self.view_range then
			return
		end

		local vec = {
			x = p.x - s.x,
			y = p.y - s.y,
			z = p.z - s.z
		}
		-- or away
		if dir == 1 then
			local vec = {
				x = p.x + s.x,
				y = p.y + s.y,
				z = p.z + s.z
			}
		end

		local yaw = (atan(vec.z / vec.x) + pi / 2) - self.rotate

		if p.x > s.x then yaw = yaw + pi
		end

		set_yaw(self.object, yaw)

		-- hasn't reached it
		if dist > self.reach then
			--non-fliers go ahead, fliers need to do check
			if not self.fly then
				set_velocity(self, speed)
				set_animation(self, move_type)
			elseif flight_check(self, s) then
				set_velocity(self, speed)
				set_animation(self, move_type)
			end


		--has already reached it
		else
			set_velocity(self, 0)
			set_animation(self, "stand")
		end

		--for flying follow up/down when out of reach
		if self.fly then
			local v = self.object:getvelocity()
			--in flight medium
			if flight_check(self, s) then
				--below target
				if s.y < p.y then
					--run upwards
					self.object:setvelocity({
					x = v.x,
					y = speed,
					z = v.z
				})
				--above target
			elseif s.y > p.y then
					--move down
					self.object:setvelocity({
						x = v.x,
						y = - speed,
						z = v.z
					})
				end
			end
		end
	end

	return
end




----------------------------------------------------------------
--GROUP ATTACK

-- BRING in reinforcements when ever in attack mode.
--called in do_attack for group defenders
local group_attack = function(self)

	local pos = self.object:getpos()
	local objs = minetest.get_objects_inside_radius(pos, self.view_range)
	local ally = nil

		for n = 1, #objs do
			ally = objs[n]:get_luaentity()

			if ally then
				-- only alert members of same mob who aren't in the fight
				if ally.name == self.name
				and ally.state ~= "attack" then
					-- go to attack mode, set the target
					ally.state = "attack"
					ally.attack = self.attack
					bot_sound(self, self.sounds.war_cry)
				end
			end
		end
end




-----------------------------------------------------------------------
--WAYS TO DIE



--GET OLD or STARVE
-- Die of old age when lifetimer expires, but not if busy
-- die if has no energy left
local old_age = function(self, pos, dtime)

	--count down age
	self.lifetimer = self.lifetimer - dtime

	--count down metabolic energy use from keeping alive
	--more intense activity use more energy...
	--stand,
	-- walk, short_walk, long_walk,
	-- panic, attack, horny, pregnant

	--doing nothing uses little energy
	local basal = 0.001
	local met = basal
	--low intensity
	if self.state == "walk"
	or self.state == "short_walk"
	or self.state == "long_walk" then
		met = basal * 5

	--high intensity
	elseif self.state == "panic"
	or self.state == "attack"
	or self.state == "horny"
	or self.state == "pregnant" then
		met = basal * 10
	end

	--factor in body size (energy_max)... each unit of mass must be maintained
	--should give 16min or so, of resting till starves
	---a child is half size
	if self.child then
		self.lifetimer = self.energy - (dtime * (met * (self.energy_max/2)))
	else
		self.lifetimer = self.energy - (dtime * (met * self.energy_max))
	end

	if self.lifetimer <= 0
	or self.energy <= 0 then
		--cause damage, check if died
		self.health = self.health - 1

		if check_for_death(self) then return end
	end
end





-- DAMAGE FROM FALLING, FLOATING
local falling = function(self, pos)

	--cant fall if you can fly
	if self.fly then
		return
	end

	-- fall at the the bots falling speed
	local v = self.object:getvelocity()
	if v.y > self.fall_speed then
		-- fall downwards
		self.object:setacceleration({
			x = 0,
			y = self.fall_speed,
			z = 0
		})
	else
		-- stop accelerating once max fall speed hit
		self.object:setacceleration({x = 0, y = 0, z = 0})
	end


	-- Splash! Float in water
	if minetest.registered_nodes[node_ok(pos).name].groups.water then

		if self.floats == 1 then

			self.object:setacceleration({
				x = 0,
				y = - random (0, self.fall_speed),
				z = 0
			})
		end
	else

		-- Splat! fall damage onto solid ground
		if self.fall_damage >= 1
		and self.object:getvelocity().y == 0 then

			local d = (self.old_y or 0) - self.object:getpos().y

			--did it go down too far?
			if d > self.fall_limit then

				--how big a splat?
				local splat = d - self.fall_limit

				self.health = self.health - floor(splat* self.fall_damage)

				if check_for_death(self) then
					return
				end
			end

			self.old_y = self.object:getpos().y
		end
	end
end


--DROP... to give the player stuff when they kill the critter.
-- not called on death at other times otherwise the world will be littered with crap
local item_drop = function(self)

	-- no drops for child mobs
	if self.child then
		return
	end

	local obj, item, num
	local pos = self.object:getpos()

	self.drops = self.drops or {} -- nil check

	for n = 1, #self.drops do

		if random(1, self.drops[n].chance) == 1 then

			num = random(self.drops[n].min, self.drops[n].max)
			item = self.drops[n].name


			-- add item if it exists
			obj = minetest.add_item(pos, ItemStack(item .. " " .. num))

			if obj and obj:get_luaentity() then

				obj:setvelocity({
					x = random(-10, 10) / 9,
					y = 6,
					z = random(-10, 10) / 9,
				})
			elseif obj then
				obj:remove() -- item does not exist
			end
		end
	end

	self.drops = {}
end




--HIT IT!
-- deal damage when bot punched
local bot_punch = function(self, hitter, tflp, tool_capabilities, dir)

	-- bot health check...it's dead
	if self.health <= 0 then
		return
	end


	-- weapon wear
	local weapon = hitter:get_wielded_item()
	local punch_interval = 1.4

	-- calculate bot damage
	local damage = 0
	local armor = self.object:get_armor_groups() or {}
	local tmp

	-- quick error check incase it ends up 0 (serialize.h check test)
	if tflp == 0 then
		tflp = 0.2
	end


	for group,_ in pairs( (tool_capabilities.damage_groups or {}) ) do

		tmp = tflp / (tool_capabilities.full_punch_interval or 1.4)

		if tmp < 0 then
			tmp = 0.0
		elseif tmp > 1 then
			tmp = 1.0
		end

		damage = damage + (tool_capabilities.damage_groups[group] or 0)
			* tmp * ((armor[group] or 0) / 100.0)
	end

	-- healing
	if damage <= -1 then
		self.health = self.health - floor(damage)
		return
	end

	-- add weapon wear
	if tool_capabilities then
		punch_interval = tool_capabilities.full_punch_interval or 1.4
	end

	if weapon:get_definition()
	and weapon:get_definition().tool_capabilities then

		weapon:add_wear(floor((punch_interval / 75) * 9000))
		hitter:set_wielded_item(weapon)
	end

	-- only play hit sound if damage is 1 or over
	if damage >= 1 then

		-- weapon sounds
		if weapon:get_definition().sounds ~= nil then

			local s = random(0, #weapon:get_definition().sounds)

			minetest.sound_play(weapon:get_definition().sounds[s], {
				object = hitter,
				max_hear_distance = 8
			})
		else
			minetest.sound_play("ecobots_hit", {
				object = hitter,
				max_hear_distance = 5
			})
		end


		-- do damage
		self.health = self.health - floor(damage)

		-- exit here if dead,

		if check_for_death(self) then
			--drop stuff for the player
			if hitter:is_player() then
				item_drop(self)
			end
			return
		end

			-- Panic effect (only on full punch)
			if self.panic_hit
			and self.panic > 0
			and tflp >= punch_interval then
				--flee
				pursue(self, hitter, "run", 1)
				--panic
				self.state = "panic"
				self.panic_timer = self.panic
			end


		-- Stun effect (only on full punch)
		if self.stun > 0
		and tflp >= punch_interval then

			local v = self.object:getvelocity()
			local up = 1
			-- if already in air then dont go up anymore when hit
				if self.fly or v.y > 0 then
					up = 0
				end

			self.object:setvelocity({
				x = 0,
				y = up,
				z = 0
			})

			self.stun_timer = self.stun
		end


		--is aggressive, and not already attacking, allow hit panic to attack ...
		--does mobbing behaviour
		if not self.passive
		and self.state ~= "attack" then
			minetest.chat_send_all("aggression!")
			-- go to attack mode, set the hostile as target
			self.state = "attack"
			self.attack = hitter
			bot_sound(self, self.sounds.war_cry)
		end
	end
end




--ENVIROMENTAL DAMAGE
--bright light, drowning, fire,
-- hurting nodes, suffocation,
--... cold
local do_env_damage = function(self)
	--applies in all states, these are lethal dangers, so takes priority
	-- will even cause a pregnant to "abort" the pregnancy

	local pos = self.object:getpos()

	-- remove bot if beyond map limits
	if not within_limits(pos, 0) then
		self.object:remove()
		return
	end

	-- Bright light
	if self.light_damage ~= 0
	and (minetest.get_node_light(pos) or 0) > 14 then
		--cause damage, send into a panic, check if died
		self.health = self.health - self.light_damage
		self.state = "panic"
		self.panic_timer = self.panic

		if check_for_death(self) then return end
	end

	--Drowning
	local y_level = self.collisionbox[2]

	if self.child then
		y_level = self.collisionbox[2] * 0.5
	end

	-- what is bot standing in?
	pos.y = pos.y + y_level + 0.25 -- foot level
	self.standing_in = node_ok(pos, "air").name

	-- don't fall when on ignore, just stand still
	if self.standing_in == "ignore" then
		self.object:setvelocity({x = 0, y = 0, z = 0})
	end

	local nodef = minetest.registered_nodes[self.standing_in]

	-- water
	if self.water_damage
	and nodef.groups.water then

		if self.water_damage ~= 0 then
			--cause damage, send into a panic, check if died
			self.health = self.health - self.water_damage
			self.state = "panic"
			self.panic_timer = self.panic

			if check_for_death(self) then return end
		end


	-- lava or fire
	elseif self.lava_damage
	and (nodef.groups.lava
	or self.standing_in == "fire:basic_flame"
	or self.standing_in == "fire:permanent_flame") then

		if self.lava_damage ~= 0 then

			self.health = self.health - self.lava_damage

			if check_for_death(self) then return end
		end

	-- damage_per_second node check
	elseif nodef.damage_per_second ~= 0 then
		--cause damage, send into a panic, check if died
		self.health = self.health - nodef.damage_per_second
		self.state = "panic"
		self.panic_timer = self.panic

		if check_for_death(self) then return end
	end

	--- suffocation inside solid node
	if self.suffocation ~= 0
	and nodef.walkable == true
	and nodef.groups.disable_suffocation ~= 1
	and nodef.drawtype == "normal" then
		--cause damage, send into a panic, check if died
		self.health = self.health - self.suffocation
		self.state = "panic"
		self.panic_timer = self.panic

		if check_for_death(self) then return end
	end


	---damage by things it is nearby... i.e. bad enviro conditions
	--- i.e. too hot, too cold, just snow and ice at the moment

	--cold
	if self.cold_damage > 0 then
		lc = minetest.find_node_near(pos, 1, {"group:snowy", "default:ice"})
		if lc then
			--cause damage, send into a panic, check if died
			self.health = self.health - self.cold_damage
			self.state = "panic"
			self.panic_timer = self.panic

			if check_for_death(self) then return end
		end
	end

	check_for_death(self)
end

--BLOW THEM UP!
local do_tnt = function(obj, damage)

	--print ("----- Damage", damage)

	obj.object:punch(obj.object, 1.0, {
		full_punch_interval = 1.0,
		damage_groups = {fleshy = damage},
	}, nil)

	check_for_death(self)
	return false, true, {}
end




-----------------------------------------------------------------
-- HEALING
--use energy to repair health
--how much does it cost to repair one hp?
--ratio of hp to energy max e.g. it has 10e for 20hp, 0.5e per hp
-- e.g. spend 0.5e to heal 1 hp
local heal = function(self)
	--not continuous so doesn't act as a defense

	--bring it up to min in all situations
	if self.health < self.hp_min
	and random(1, 60) <= 1 then
		local r = self.energy/self.hp_max
		self.energy = self.energy - r
		self.health = self.health + 1
	end

	--resting, not child, etc then bring all way
	if self.health < self.hp_max
	and not self.child
	and (self.state == "stand" or self.state == "slow_walk")
	and self.energy > (self.energy_max/4)
	and random(1, 300) <= 1
	 then
		local r = self.energy/self.hp_max
		self.energy = self.energy - r
		self.health = self.health + 1
	end

end




--------------------------------------------------------------------
-- FEEDING

-- find and replace the prey, and add to bots energy
local eat = function(self)

	--self.energy

	--reasons not to eat.. to fast, eating chance, overfed, state
	if self.object:getvelocity().x > 0.1
	or self.object:getvelocity().y > 0.1
	or self.object:getvelocity().z > 0.1
	or random(1, self.eat_chance) <= 1
	or self.state == "horny"
	or self.state == "attack"
	or self.state == "panic"
	or self.energy >= self.energy_max then
		return
	end

	local pos = self.object:getpos()

	--get the stuff from the table
	local what, debris, y_offset, e_density
	local num = random(#self.eat_what)

	what = self.eat_what[num][1] or ""
	debris = self.eat_what[num][2] or ""
	y_offset = self.eat_what[num][3] or 0
	e_density = self.eat_what[num][4] or 1

	pos.y = pos.y + y_offset

	--look to see if it is prey
	if #minetest.find_nodes_in_area(pos, pos, what) > 0 then

		--found prey so eat, leave debris and gain energy
		minetest.set_node(pos, {name = debris})
		--different foods have diff energy
		-- e.g. 1 block wood = 0.1, 1 leaves = 1, 1 meat = 10.
		--can only extract 10%
		self.energy = self.energy + (e_density * 0.1)
		bot_sound(self, self.sounds.eat)
	end
end

------------------------------------------------------------------------
--GROWING UP

local mature = function(self)
	-- child must eat to half max capacity
	--then it has enough energy to mature

	if self.child == true
	and self.energy >= (self.energy_max/2) then

		--no longer a child, loses half of energy in maturing
		self.child = false
		self.energy = self.energy/2

		self.object:set_properties({
			textures = self.base_texture,
			mesh = self.base_mesh,
			visual_size = self.base_size,
			collisionbox = self.base_colbox,
		})

		-- jump when fully grown so not to fall into ground
		self.object:setvelocity({
			x = 0,
			y = 0.5,
			z = 0
		})
	end
	return
end


------------------------------------------------------------------
--REPRODUCTION

--behaviour for when ready to reproduce
local do_horny = function(self)

	-- do if is a horny reproducer
	if self.reproductive
	and not self.child
	and self.state == "horny" then

		--asexual can just get itself pregnant
		if self.asexual then
			self.state = "pregnant"
			return
		end

		--stand there and call for a mate
		--calm down a bit with those calls buddy
		if random(1, 60) <= 1 then
			bot_sound(self, self.sounds.horny)
		end

		--a wide scan for mates.. as far as it can see
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius(pos, self.view_range)
		local num = 0
		local ent = nil

		--loop through looking for a mate
		for n = 1, #objs do
			ent = objs[n]:get_luaentity()

			--find someone of same species...to go check them out
			--rule out a few states, including horny -- so doesn't f#$% itself
			--technically this makes it rape... but it's better than self abuse!
			if ent
			and ent.name == self.name
			and ent.state ~= "short_walk"
			and not ent.child then
				num = num + 1
			end
			-- found a candidate
			if num > 1 then
				--move in their direction
					pursue(self, ent, "walk", 0)
					--if close enough then mate
					local p = ent.object:getpos()
					local dist = get_distance(p, pos)
					if dist < self.reach then
						--pow! you got 'em!
						self.state = "pregnant"
						set_velocity(self, 0)
						--set gestation time, less for egg layers...makes up with egg brooding
						if self.lay_egg then
							self.preg_timer = (self.energy_max * 2) * (self.parent_invest * self.birth_num)
						else
							self.preg_timer = (self.energy_max * 20) * (self.parent_invest * self.birth_num)
						end
					end
				break
			end
			--you died... stop being such zombie horndog!
			if self.health <=0 then
				break
			end
		end

		--give up... move around again, will quickly be back
		if random(1, 500) <= 1 then
			self.state = "walk"
		end

		--no longer in peak condition, stop being horny
		if self.energy < (self.energy_max - (self.energy_max*0.05)) then
			self.state = "walk"
		end
	end
end



--BIRTH NEW BOTS
--from live birth and eggs
local birth = function(self,pos)
	--shouldn't have been called, abort
	--seems sometimes children were used to calculate the new collision box..
	--despite blocks to stop children from mating...hmmm...
	--multiple births give occassional micro-babies...seems to be getting from siblings
	--a persistent issue, but not major -- means they have a runt of the litter
	if self.child then
		return
	end

	--scatter so multiple young don't get clogged up
	local sc = 0.5
	local pos1 = {x = pos.x + random(-sc,sc), y = pos.y + random(0,sc), z = pos.z + random(-sc,sc)}

	--delay to avoid clogging
	--[[local bot = minetest.after(1, function()
		 minetest.add_entity(pos1, self.name)
	 end)]]
	local bot = minetest.add_entity(pos1, self.name)
	local b = bot:get_luaentity()
	local textures = self.base_texture

	if self.child_texture then
		textures = self.child_texture[1]
	end

	bot:set_properties({
		textures = textures,
		visual_size = {
			x = self.base_size.x * .5,
			y = self.base_size.y * .5,
		},
		collisionbox = {
			self.base_colbox[1] * .5,
			self.base_colbox[2] * .5,
			self.base_colbox[3] * .5,
			self.base_colbox[4] * .5,
			self.base_colbox[5] * .5,
			self.base_colbox[6] * .5,
		},
	})

	b.child = true
	b.energy = (self.energy_max * self.parent_invest)
	b.state = "slow_walk"
	b.health = self.hp_min
	bot_sound(self, self.sounds.birth)
end




--PREGNANT!
local do_pregnant = function(self,dtime)
	if self.state == "pregnant"
	and not self.child then
		--gestate... must produce the child/eggs
		--based on body size... bigger takes longer
		-- 10 ticks per 1 unit of energy? i.e. a small fish takes 1 min.
		self.preg_timer = self.preg_timer - dtime

		-- finished gestating... so must check if can give birth
		if self.preg_timer <= 0 then
			self.preg_timer = 0
			--asses  location
			local s = self.object:getpos()
			local n = minetest.find_node_near(s, 2, self.nest_on)
			--nest node not on the parent
			if n
			and n.y ~= s.y
			and (n.x ~= s.x or n.z ~= s.z)
			then
				--get the position for laying/birth

				local pos = {x = n.x, y = n.y + 1, z = n.z}
				--does it lay eggs?
				if self.lay_egg then
					--!!!!!CHNGE TO EGG
					--lay the egg, then stand
					minetest.set_node(pos, {name = "ecobots:ecobots_bot_dead"})
					--stop being pregnant, lose energy each child
					set_velocity(self,0)
					self.state = "stand"
					self.energy = self.energy - ((self.energy_max * self.parent_invest) * self.birth_num)

				--Alternatively give live birth
				else
					--call birth until number of offspring delivered.
					local bnum = 0
					while bnum < self.birth_num do
						birth(self, pos)
						bnum = bnum + 1
					end
					--stop being pregnant lose energy each child
					set_velocity(self,0)
					self.state = "stand"
					self.energy = self.energy - ((self.energy_max * self.parent_invest) * self.birth_num)
				end
			end
		end


		--Either still ticking.. or unsuitable site
		--meanwhile minimize effort... an adapted version of short_walk

		--randomly turns and walks.. many turns
		if random(1, self.walk_chance) <= 1 then
			--start walking
			set_velocity(self, (self.walk_velocity/2))
			set_animation(self, "walk")


			if random(1, (self.turn_chance/3)) <= 1 then
				yaw = ((random(0, 360) - 180) / 180 * pi) - self.rotate
				yaw = set_yaw(self.object, yaw)
				set_velocity(self, (self.walk_velocity/2))
				--fliers can also move up or down
				if self.fly then
					local v = self.object:getvelocity()
					--harder to rise than fall
					v.y = random(-(self.walk_velocity/2), (self.walk_velocity/4))
					self.object:setvelocity(v)
				end
			end
		end

		-- stay put... very likely
		if random(1, (self.stop_chance/4)) <= 1 then
			set_velocity(self, 0)
			set_animation(self, "stand")
		end


		--stop if next to food..
		--get the stuff from the table
		local what, y_offset
		local num = random(#self.eat_what)
		local pos = self.object:getpos()
		what = self.eat_what[num][1] or ""
		y_offset = self.eat_what[num][3] or 0
		pos.y = pos.y + y_offset
		--look to see if it is prey
		if #minetest.find_nodes_in_area(pos, pos, what) > 0 then
			--in feeding position so stop
			set_velocity(self, 0)
		end

	end
end



---------------------------------------------------------------
--ATTRACT AND AVOID

--AVOIDANCE CHECK
--finds dangerous and unliked things, switches to long walk to leave area
--doesn't run, panic on touch takes care of that.
--walking is energy saving, precautionary avoidance
local check_avoid = function(self)
	--these are non-critical dangers, so other states take priority
	--don't switch mode if in these states
	if self.state == "pregnant"
	or self.state == "panic"
	or self.state == "attack"
	or self.state == "horny" then
		return
	end

	--find if bad stuff is near
	local s = self.object:getpos()
	local dist = (self.view_range * 0.5)
	local lpw = nil
	local lpf = nil
	local lpc = nil
	local ldl = nil
	local lpl = nil
	local lpp = nil
	local lps = nil

	-- is there something I need to avoid?
	--water
	if self.water_damage > 0 then
		lpw = minetest.find_node_near(s, dist, {"group:water"})
		if random(1, self.go_to_chance) <= 1 then
			go_to(self, lpw, "walk", 1)
		end
	end
	--fire
	if self.lava_damage > 0 then
		lpf = minetest.find_node_near(s, dist, {"group:lava", "fire:basic_flame", "fire:permanent_flame"})
		if random(1, self.go_to_chance) <= 1 then
			go_to(self, lpf, "walk", 1)
		end
	end
	--cold
	if self.cold_damage > 0 then
		lpc = minetest.find_node_near(s, dist, {"group:snowy", "default:ice"})
		if random(1, self.go_to_chance) <= 1 then
			go_to(self, lpc, "walk", 1)
		end
	end

	--find disliked blocks
	local ldl = minetest.find_node_near(s, dist, self.dislike)
	if ldl then
		if random(1, self.go_to_chance) <= 1 then
			go_to(self, ldl, "walk", 1)
		end
	end

	--look out for predators... only do it occassionally so it can be unlucky
	if random(1, 20) <= 1
	and self.prey
	and self.predators ~= nil then
		local objs = minetest.get_objects_inside_radius(s, self.view_range)
		local num = 0
		local ent = nil
		for n = 1, #objs do
			ent = objs[n]:get_luaentity()

			--found a predator
			if ent then
				for _, v in pairs(self.predators) do
					if v == ent.name then
					lh = true

						if random(1, self.go_to_chance) <= 1 then
							--move away from predator
							--could do a more nuanced thing here based on distance.
							-- ..stop and stare, then walk back, then run..
							p = ent.object:getpos()
							--flee
							pursue(self, ent, "run", 1)
							self.state = "panic"
							minetest.chat_send_all("Ah predator!")
							bot_sound(self, self.sounds.panic)
							--end here, bc in panic mode
							return
						end
					break
					end
				end
			end
		end
	end

	--has a fear of being outside light range
	if self.light_fear then
		---get time, only do during day
		local tod = minetest.get_timeofday()
		if tod > 0.3 and tod < 0.7 then
			local light = minetest.get_node_light(s) or 0
			--outside prefered range
			if light > self.lightp_max or light < self.lightp_min then
				lpl = true
			end
		end
	end

	--getting hungry might have run out of food here
	if self.energy < (self.energy_max/10) then
		lps = true
	end

	--if one of the dangerous is present...
	if lpw
	or lpf
	or lpc
	or ldl
	or lpp
	or lpl
	or lps then

		self.state = "long_walk"
		return
	end
end



--ATTRACT CHECK
--finds desired things, switches to short walk to stay in area
local check_attract = function(self)

	--don't settle down if in these states

	if self.state == "horny"
	or self.state == "pregnant"
	or self.state == "panic"
	or self.state == "attack" then
		return
	end

	--find if good stuff is near
	local s = self.object:getpos()
	local dist = (self.view_range * 0.2)
	local ll = nil
	local lp = nil
	local lh = nil

	--find liked blocks
	local ll = minetest.find_node_near(s, dist, self.like)
	if ll then
		if random(1, self.go_to_chance) <= 1 then
			go_to(self, ll, "walk", 0)
		end
	end

	--has a light preference
	if self.light_pref then
		---get time, only do during day
		local tod = minetest.get_timeofday()
		if tod > 0.3 and tod < 0.7 then
			local light = minetest.get_node_light(s) or 0
			--inside prefered range
			if light < self.lightp_max or light > self.lightp_min then
				lp = true
			end
		end
	end

	--predators look for prey... scanning frequency based on hunt chance..
	--i.e. how much is it on the look out
	--don't scan if already engaged in fight
	if random(1, self.hunt_chance) <= 1
	and self.state ~= "attack"
	and self.hunter
	and self.hunter_prey ~= nil then
		local objs = minetest.get_objects_inside_radius(s, self.view_range)
		local num = 0
		local ent = nil
		for n = 1, #objs do
			ent = objs[n]:get_luaentity()

			--found a prey
			if ent then
				for _, v in pairs(self.hunter_prey) do
					if v == ent.name then
						lh = true

						--i.e. does it instantly lunge all the time, or circle around
						if random(1, self.hunt_chance) <= 1 then
							--move towards prey
							p = ent.object:getpos()
							--Desperate attempts to allows cannabilism,
							--otherwise it tries to eat itself...and just fucks around
							--although it still freaks out if you list self as it's predator...
							--i.e. "cannabils eat me... I'm a cannibal... Ah!"
							self.state = ""
							if ent.state ~= "" then
								--go_to(self, p, "run", 0)
								self.attack = ent
								self.state = "attack"
								minetest.chat_send_all("hunting prey!")
								bot_sound(self, self.sounds.war_cry)
								--end here, bc in attack mode
								return
							end
							break
						end
					end
				end
			end
		end
	end

	--if one of the good is present...
	if ll
	or lp
	or lh then
		self.state = "short_walk"
		return
	end
end


-------------------------------------------------------------------
--DO STATES

--DO THINGS WHEN STANDING
local do_stand = function(self)
	--Standing...
	if self.state == "stand" then
		--stand there!
		set_velocity(self, 0)
		set_animation(self, "stand")

		--look around...sometimes, not whirling like a maniac
		if random(1, 30) <= 1 then
			yaw = (random(0, 360) - 180) / 180 * pi
			set_yaw(self.object, yaw)
		end

		-- start moving again
		if random(1, self.walk_chance) <= 1 then
			self.state = "walk"
		end
	end

end


--DO THINGS WHEN WALKING
local do_walk = function(self)

	if self.state == "walk" then
		--walk!
		set_velocity(self, self.walk_velocity)
		set_animation(self, "walk")

		--random turns
		if random(1, self.turn_chance) <= 1 then
			yaw = ((random(0, 360) - 180) / 180 * pi) - self.rotate
			yaw = set_yaw(self.object, yaw)
			set_velocity(self, self.walk_velocity)
			--fliers can also move up or down
			if self.fly then
				local v = self.object:getvelocity()
				--harder to rise than fall
				v.y = random(-self.walk_velocity, (self.walk_velocity/2))
				self.object:setvelocity(v)
			end
		end

		-- stop moving again
		if random(1, self.stop_chance) <= 1 then
			self.state = "stand"
		end
	end
end


--DO THINGS WHEN WALKING... LONG
--- same as walking but with lower turn frequency... an avoidance behaviour
local do_long_walk = function(self)

	if self.state == "long_walk" then
		--walk!
		set_velocity(self, self.walk_velocity)
		set_animation(self, "walk")

		--random turns
		if random(1, (self.turn_chance * 2)) <= 1 then
			yaw = ((random(0, 360) - 180) / 180 * pi) - self.rotate
			yaw = set_yaw(self.object, yaw)
			set_velocity(self, self.walk_velocity)
		end

		-- stop going long
		if random(1, self.stop_chance) <= 1 then
			self.state = "walk"
		end
	end
end



--DO THINGS WHEN WALKING... SHORT
--- same as walking but with higher turn frequency... an attract behaviour
local do_short_walk = function(self)

	if self.state == "short_walk" then
		--walk!
		set_velocity(self, self.walk_velocity)
		set_animation(self, "walk")

		--random turns
		if random(1, (self.turn_chance/2)) <= 1 then
			yaw = ((random(0, 360) - 180) / 180 * pi) - self.rotate
			yaw = set_yaw(self.object, yaw)
			set_velocity(self, self.walk_velocity)
			--fliers can also move up or down
			if self.fly then
				local v = self.object:getvelocity()
				--harder to rise than fall
				v.y = random(-self.walk_velocity, (self.walk_velocity/2))
				self.object:setvelocity(v)
			end
		end



		-- stop going short... and walk to leave
		if random(1, self.walk_chance) <= 1 then
			self.state = "walk"
		end


		-- stop going short... and stay put...highly likely... it's a good place
		if random(1, (self.stop_chance/2)) <= 1 then
			self.state = "stand"
		end


		--stop if next to food..only in short walk bc it feels safe here
		--get the stuff from the table
		local what, y_offset
		local num = random(#self.eat_what)
		local pos = self.object:getpos()
		what = self.eat_what[num][1] or ""
		y_offset = self.eat_what[num][3] or 0
		pos.y = pos.y + y_offset
		--look to see if it is prey
		if #minetest.find_nodes_in_area(pos, pos, what) > 0 then
			--in feeding position so stop
			set_velocity(self, 0)
			self.state = "stand"
		end

		--Get horny
		--do if fully fed, only in short walk bc it is feeling safe
		--not always, so has a chance to move between mating calls
		if self.energy >= self.energy_max
		and not self.child
		and random(1, 300) <= 1 then
			self.state = "horny"
			set_velocity(self, 0)
			set_animation(self, "stand")
			minetest.chat_send_all("I was set to horn!")

		end
	end
end





--ATTACK...CURRENTLY HAS ISSUES.... make suitable for player too (remove object from self.attack to make work for player)
--was working... until it wasnt
local do_attack_state = function(self)

	--need to send player to different set
	--if self.attack.object:is_player()
	--in attack mode and has target
	if self.state == "attack" then

		--has no target... abort
		if self.attack == nil or self.attack.object == nil then
			minetest.chat_send_all("I had no target")
			self.state = "stand"
			set_velocity(self, 0)
			set_animation(self, "stand")
			return
		end

--nil values are getting past here...?!?maybe

		minetest.chat_send_all("Doing attack state!")

		--is the target dead?
		if check_for_death(self.attack) then
			--Maybe you want to eat it?
			if self.hunter
			and self.hunter_prey ~= nil then
				--see if it was prey
				for _, v in pairs(self.hunter_prey) do
					if v == self.attack then
						--absorb it's energy
						self.energy = self.energy + (t.energy * 0.1)
						--!!!!!!!!!!!!!!IS THIS ACTUALLY WORKING... NEVER HEAR IT
						bot_sound(self, self.sounds.eat)
						break
					end
				end
			end
			--target is dead... stop attack
			self.state = "stand"
			set_velocity(self, 0)
			set_animation(self, "stand")
			self.attack = nil
			return
		end
		



		-- calculate distance from bot and enemy
		local t = self.attack.object:get_luaentity()
		local s = self.object:getpos()
		--some'n wrong here...object
		local p = t.object:getpos() or s
		local dist = get_distance(p, s)


		--if the target is within reach, and lands a hit
		--damage the target
		if dist < self.reach
		and random(1, self.attack_chance) <= 1 then
			local dam = self.damage
			--less damage from children
			if self.child then
				dam = dam * 0.5
			end

			t.object:punch(t.object, dam, {
			full_punch_interval = 1,
			damage_groups = {fleshy = dam},
			}, nil)
			return
		end



		--decide if it should stop attacking
		-- stop attacking if too far, nothing there, no energy
		if dist > self.view_range
		or not t
		or not p
		or self.energy < (self.energy_max/10) then
			self.state = "stand"
			set_velocity(self, 0)
			set_animation(self, "stand")
			self.attack = nil
			--attack over ...stop here
			return
		end

		--follow the target...only sometimes, unpredictable chase
		if random(1, 4) <= 1 then
			pursue(self, t.object, "run", 0)
		end

		--if a group fighter bring in friends
		if self.group_attack then
			group_attack(self)
		end

		--occassional war cry
		if random(1, 60) <= 1 then
			bot_sound(self, self.sounds.war_cry)
		end


	end
end



--DO panic
--run, jumping etc, all to get away fast
local do_panic = function(self, dtime)
	-- it has been panicked
	if self.panic_timer > 0 then

		set_velocity(self, self.run_velocity)
		set_animation(self, "run")

		--low likelyhood of turning
		if random(1, (self.turn_chance * 4)) <= 1 then
			yaw = (random(0, 360) - 180) / 180 * pi
			set_yaw(self.object, yaw)
			--fliers can also move up or down
			if self.fly then
				local v = self.object:getvelocity()
				--harder to rise than fall
				v.y = random(-self.run_velocity, self.walk_velocity)
				self.object:setvelocity(v)
			end
		end


		--tick down
		self.panic_timer = self.panic_timer - dtime

		--timer has run out
		if self.panic_timer < 1 then
			self.panic_timer = 0
			set_velocity(self, 0)
			self.state = "stand"
		end
		return
	end
end


--DO STUN
--just dazed
local do_stun = function(self, dtime)
	-- it has been stunned
	if self.stun_timer > 0 then

		--tick down
		self.stun_timer = self.stun_timer - dtime

		--timer has run out
		if self.stun_timer < 1 then
			self.stun_timer = 0
		end
		return
	end
end


--SOCIAL... seek out same species, and huddle
local do_social = function(self)
--do if has social trait, and chanced
	if self.social
	and random(1,self.social_chance) <= 1 then
		--find a friend
		--a wide scan.. as far as it can see
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius(pos, self.view_range)
		local num = 0
		local fr = nil

		--loop through looking for a friend
		for n = 1, #objs do
			fr = objs[n]:get_luaentity()

			--find someone of same species
			if fr
			and fr.name == self.name then
				num = num + 1
			end
			-- found a friend
			if num > 1 then
				--move in their direction, if they aren't on top
				local posfr = fr.object:getpos()
				if pos ~= posfr then
					pursue(self, fr, "walk", 0)
					bot_sound(self, self.sounds.social)
					break
				end

			end
		end
	end
end




----------------------------------------------------------------------
--STATIC DATA

-- get entity staticdata
local bot_staticdata = function(self)

	self.remove_ok = true
	self.attack = nil
	--self.state = "stand"

	local tmp = {}

	for _,stat in pairs(self) do

		local t = type(stat)

		if  t ~= "function"
		and t ~= "nil"
		and t ~= "userdata" then
			tmp[_] = self[_]
		end
	end

	--print('===== '..self.name..'\n'.. dump(tmp)..'\n=====\n')
	return minetest.serialize(tmp)
end


-------------------------------------------------------------------------
-- ACTIVATE

-- activate bot and reload settings
local bot_activate = function(self, staticdata, def, dtime)

	-- load entity variables
	local tmp = minetest.deserialize(staticdata)

	if tmp then
		for _,stat in pairs(tmp) do
			self[_] = stat
		end
	end

	-- select random texture, set model and size
		if not self.base_texture then

			self.base_texture = def.textures[random(1, #def.textures)]
			self.base_mesh = def.mesh
			self.base_size = self.visual_size
			self.base_colbox = self.collisionbox
		end


	-- set texture, model and size
	local textures = self.base_texture
	local mesh = self.base_mesh
	local vis_size = self.base_size
	local colbox = self.base_colbox


	-- set child objects to half size
	if self.child == true then

		vis_size = {
			x = self.base_size.x * .5,
			y = self.base_size.y * .5,
		}

		colbox = {
			self.base_colbox[1] * .5,
			self.base_colbox[2] * .5,
			self.base_colbox[3] * .5,
			self.base_colbox[4] * .5,
			self.base_colbox[5] * .5,
			self.base_colbox[6] * .5
		}
	end

	--set health
	if self.health == 0 then
		self.health = random (self.hp_min, self.hp_max)
	end

	--set energy from food for reproduction
	if self.energy == 0 then
		self.energy = random ((self.energy_max/10), self.energy_max)
	end


	self.object:set_armor_groups({immortal = 1, fleshy = self.armor})
	self.old_y = self.object:getpos().y
	self.old_health = self.health
	self.sounds.distance = self.sounds.distance or 10
	self.textures = textures
	self.mesh = mesh
	self.collisionbox = colbox
	self.visual_size = vis_size
	self.standing_in = ""



	-- set anything changed above
	self.object:set_properties(self)
	set_yaw(self.object, (random(0, 360) - 180) / 180 * pi)

end


---------------------------------------------------------------------
--MAIN

-- main bot function
local bot_step = function(self, dtime)
	--a random chance for functions that benefit from not always overlapping
	--i.e. they can conflict if called at same time
	-- or they are intensive, and can free up juice by not always running
	--makes it a bit more natural but should be low
	local c = 2
	local c2 = 4
	local c3 = 6
	local c4 = 100
	local pos = self.object:getpos()


	heal(self)

	--die of old age
	old_age(self, pos, dtime)

	--get hurt falling
	falling(self, pos)

	-- node replace (eat prey etc.)
	if c <= 1 then
		eat(self)
	end

	-- plays random sound
	if random(1, c4) <= 1 then
		bot_sound(self, self.sounds.random)
	end


	do_env_damage(self)

	do_horny(self)

	do_pregnant(self, dtime)

	if random(1, c4) <= 1 then
		mature(self)
	end

	if random(1, c2) <= 1 then
		do_jump(self)
	end

	swim_flop(self)

	if random(1, c3) <= 1 then
		check_avoid(self)
	end

	if random(1, c3) <= 1 then
		check_attract(self)
	end

	if random(1, c2) <= 1 then
		do_stand(self)
	end

	if random(1, c2) <= 1 then
		do_walk(self)
	end

	if random(1, c2) <= 1 then
		do_long_walk(self)
	end

	if random(1, c2) <= 1 then
		do_short_walk(self)
	end

	if random(1, c) <= 1 then
		cliff_stop(self)
	end

	if random(1, c) <= 1 then
		local w = is_wall(self)
		if w then
			--get unstuck
			is_stuck(self)
		end
	end

	if random(1, c2) <= 1 then
		do_attack_state(self)
	end

	if random(1, c2) <= 1 then
		do_panic(self, dtime)
	end

	if random(1, c) <= 1 then
		do_stun(self, dtime)
	end

	if random(1, c2) <= 1 then
		do_social(self)
	end


end



----------------------------------------------------------------------
--REGISTER

-- register bot entity
function ecobots:register_animal(name, def)
	minetest.register_entity(name, {
		name = name,
		physical = true,
		texture_list = def.textures,
		child_texture = def.child_texture,
		visual = def.visual,
		visual_size = def.visual_size or {x = 1, y = 1},
		mesh = def.mesh,
		collisionbox = def.collisionbox,
		armor = def.armor or 100,
		hp_min = def.hp_min or 10,
		hp_max = def.hp_max or 50,
		--body size, --how energy it can contain, 1 block =10e
		energy_max = def.energy_max or 10,
		energy = 0,
		health = 0,
		child = false,
		sounds = def.sounds or {},
		lifetimer = def.lifetimer or 900,		--lifespan, 900 = 15min
		fly = def.fly or false,
		fly_in = def.fly_in or "air",
		fall_speed = def.fall_speed or -10,	--max speed which falls at
		floats = def.floats or 1,						-- 1 = floats in water
		fall_damage = def.fall_damage or 1,	--damage it takes from a fall
		fall_limit = def.fall_limit or 5,		--height from which it can safetly fall
		fear_height = def.fear_height or 5,		--height that makes it afraid
		eat_chance = def.eat_chance or 2,				--1/X chance of eating,
		--a table {{prey, debris, y offset, e_density},...}, can have multiple
		-- e_density: 1 block wood = 0.1, 1 leaves = 1, 1 meat = 10.
		eat_what = def.eat_what,
		drops = def.drops or {},			--drops this if player kills it
		panic_hit = def.panic_hit,			--panic if hit
		panic = def.panic or 15,						--panics when hit
		panic_timer = 0,											--timer for panic
		stun = def.stun or 1,								--pauses when hit
		stun_timer = 0,											--pause from stun
		passive = def.passive,				--will it attack?
		view_range = def.view_range or 10,  	--how far it can see to attack etc
		group_attack = def.group_attack,
		env_damage_timer = 0,								-- controls enviro damage
		light_damage = def.light_damage or 0,			--hurt by bright light
		water_damage = def.water_damage or 0.1,
		lava_damage = def.lava_damage or 1,
		suffocation = def.suffocation or 0.5,
		cold_damage = def.cold_damage or 0.01,				--hurt by snow and ice below
		jump_height = def.jump_height or 4,
		jump = def.jump or true,										--can it jump?
		turn_chance = def.turn_chance or 50,				-- 1/X random turning when moving
		walk_velocity = def.walk_velocity or 1,
		run_velocity = def.run_velocity or 2,
		walk_chance = def.walk_chance or 100,				--1/X chance to start walking
		stop_chance = def.stop_chance or 100,				--1/X chance to stop moving
		reach = def.reach or 2,
		rotate = math.rad(def.rotate or 0), --  0=front, 90=side, 180=back, 270=side2
		animation = def.animation,
		damage = def.damage or 1,						--how much hurt it can inflict
		attack_chance = def.attack_chance or 5, -- its 1/X chance of landing a hit
		light_pref = def.light_pref or false, 		--does it have a light preference?
		light_fear = def.light_fear or false,	--does it get spooked outside light range?
		--best a narrow range?
		lightp_max = def.lightp_max or 14,				--max daytime desired light
		lightp_min = def.lightp_min	or 10,			--min daytime desired light
		prey = def.prey or true, 				--is it a prey with predators to fear?
		predators = def.predators, 		--predators
		hunter = def.hunter, 		--is it itself a predator (or mobs)
		hunter_prey = def.hunter_prey,		--what mobs does it hunt?
		hunt_chance = def.hunt_chance,		--1/X chance of attacking prey
		like = def.like,							--blocks it likes, e.g. food
		go_to_chance = def.go_to_chance,  --1/X chance to go to/away from to liked/disliked
		dislike = def.dislike,							--non-harmful blocks it dislikes
		reproductive = def.reproductive or true,	--able to breed, allows for hives etc
		asexual = def.asexual or false, --can breed without mating
		preg_timer = 0,					--controls gestation time for pregnancy
		nest_on = def.nest_on or {
			"group:sand",
			"group:soil"
		},					--what lays/births on,
		lay_egg = def.lay_egg or false, --eggs or live birth?
		--high birth num of high invest can kill parent from exhaustion
		--energy_max/(energy_max * parent_invest) is max logical value for birth_num
		--i.e. uses all the parents energy
		birth_num = def.birth_num or 1, --how many offspring per egg/birth.
		parent_invest = def.parent_invest or 0.2, --portion of energy given to child
		social = def.social or false,						--does it follow members of own kind
		social_chance = def.social_chance or 100,  --1/X chance of following a friend


		get_staticdata = function(self)
			return bot_staticdata(self)
		end,

		on_activate = function(self, staticdata, dtime)
			return bot_activate(self, staticdata, def, dtime)
		end,


		on_step = bot_step,

		on_punch = bot_punch,

		on_blast = do_tnt,



		})

		end










-------------------------------------------------------------------------
-- SPAWN EGG
--these are just for testing,

function ecobots:register_egg(bot, desc, background)

	local invimg = background

	-- register egg
	minetest.register_craftitem(bot, {

		description = desc,
		inventory_image = invimg,

		on_place = function(itemstack, placer, pointed_thing)

			local pos = pointed_thing.above

			-- am I clicking on something with existing on_rightclick function?
			local under = minetest.get_node(pointed_thing.under)
			local def = minetest.registered_nodes[under.name]
			if def and def.on_rightclick then
				return def.on_rightclick(pointed_thing.under, under, placer, itemstack)
			end

			if pos
			and within_limits(pos, 0)
			and not minetest.is_protected(pos, placer:get_player_name()) then

				pos.y = pos.y + 1

				local bot = minetest.add_entity(pos, bot)
				local ent = bot:get_luaentity()

				if not ent then
					bot:remove()
					return
				end

			end

			return itemstack
		end,
	})

end
