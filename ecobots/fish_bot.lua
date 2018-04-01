

----------------------------------------------------------------
--FISH BOT
--First attempt at getting animals to work as entities....not anywhere near finished
--a fish that will eat shellfish

---------------------------------------------------------------
--SETTINGS


local animal_growth = minetest.settings:get('ecobots_animal_growth') or 5


local animal_move = 4

--die of old age
local animal_old = animal_growth * 170

--Maintenance eating needs to be ten times more common than eating for growth to reflect how little energy goes up the food web
---chance to eat
local animal_eat = 2
local eat_breed = animal_eat * 10


---------------------------------------------------------------

ecobots:register_animal("ecobots:ecobots_fish", {
	name = "Fish",
	textures = "ecobots_fish_bot.png",
	child_texture = "ecobots_fish_bot.png",
	visual = "mesh",
	visual_size = {x=.75, y=.75},
	mesh = "ecobots_fish.b3d",
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	armor = 100,
	hp_min = 10,
	hp_max = 50,
	energy_max = 7,
	sounds = {
		random = "ecobots_swarmer_buzz",
		damage ="ecobots_hit",
		death = "ecobots_sludge",
		war_cry = "ecobots_battle_clack",
		horny = "ecobots_swarmer_nomnom",
		birth = "ecobots_muffled_dig",
		jump = "ecobots_clicky",
		social = "ecobots_friendly_clack",
		eat = "ecobots_roadbuild",
		panic = ""
	},
	lifetimer = animal_old,
	fly = true,
	fly_in = "default:water_source",
	fall_speed = -10,
	floats = 0,
	fall_damage = 1,
	fall_limit = 5,
	fear_height = 4,
	eat_chance = 2,
	eat_what = {
		{"ecobots:ecobots_beach_shellfish_bot", "default:sand", -0.5, 5},
		{"ecobots:ecobots_estuary_shellfish_bot", "default:dirt", -0.5, 5}
	 },
	 drops = {
		 {name = "ecobots:white_meat_raw", chance = 1, min = 1, max = 1},
	 },
	 panic_hit = true,
	 panic = 15,
	 stun = 2,
	 passive = false,
	 view_range = 5,
	 group_attack = true,
	 light_damage = 0,
	 water_damage =  0,
 	 lava_damage =  1,
 	 suffocation =  0.5,
	 cold_damage = 0.01,
	 jump_height = 0,
	 jump = false,
	 turn_chance = 50,
	 walk_velocity = 1,
	 run_velocity = 2,
	 walk_chance = 100,
	 stop_chance = 100,
	 reach = 1,
	 rotate = 270,
	 animation = {
		speed_normal = 24,		speed_run = 24,
		stand_start = 1,		stand_end = 80,
		walk_start = 81,		walk_end = 155,
		run_start = 81,			run_end = 155
		},
		damage = 1,
		attack_chance = 10,
		light_pref = false,
		light_fear = true,
		lightp_max = 15,
		lightp_min = 12,
		prey = true,
		--predators = {"ecobots:ecobots_fish"},
		hunter = true,
		hunter_prey = {""},
		hunt_chance = 10,
		like = {
			"ecobots:ecobots_beach_shellfish_bot",
			"ecobots:ecobots_estuary_shellfish_bot"
		},
		go_to_chance = 2,
		dislike = {
			"group:stone",
			"default:gravel",
			"ecobots:ecobots_coral_bot"
		},
		reproductive = true,
		asexual = false,
		nest_on = {
			"group:sand",
			"default:dirt"
		},
		lay_egg = false,
		birth_num = 5,
		parent_invest = 0.1,
		social = false,
		social_chance = 250,

	})

	ecobots:register_egg("ecobots:ecobots_fish", "Fish", "ecobots_fish_bot.png")
