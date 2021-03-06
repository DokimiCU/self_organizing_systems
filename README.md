# self_organizing_systems
# by Dokimi

Current Version: 0.3.1

Adds a number of self organizing systems to Minetest. These use the scientific principles underlying real world complex systems to create unpredictable and often astonishing results. These blocks spontenously create their own strutures. Some can adapt and change in response to their own actions and those of the player, mimicking the behaviour of living things. Some even possess rudimentary intelligence... and that's not a joke. 

This is the closest a Minetest block will ever come to being alive.

These mods can be fun to use in a general game, or they can used as a hands on way to explore some of the most fundamental laws of nature.



  - Autocell: build your own cellular automata from blocks. Creates interactive self sustaining patterns. One of the simplest possible demonstrations of how self organisation occurs.

  - Selfrep: adds a number a highly constrained self replicating "tools" that build useful controlled structures. e.g. A self replicating road, a self replicating tower, a self replicating tunnel, and more.
  
  - Selfrep_doomsday: explores the power of exponential growth. Self replication is entirely unconstrained. These structures take over the world, hence "doomsday". Grey Goo - grows an organic looking structure that covers the world. The Weapon - tries to destroy the world by turning it into flaming sludge. Blight - consumes organic matter. Terraformer - fixes all the damage you just done!
  
  - Ecobots: replaces the default vegetation with a biodiverse functional ecosystem of selfreplicating blocks. Self replication exists in the sweet spot between the limits of Selfrep and the mayhem of Selfrep Doomsday. Once established the ecobots simulate the behaviour of real ecosystems. Also incudes examples of network and swarm intelligence, and evolution. They are alive!
  
  - Autosky: mimics some of the basic process that give rise to local scale weather systems. Clouds and rain form spontaneously due to the availability of water, local topography, etc.
  
  - Neuron: allows the player to build neurons, and basic neural networks.
  
  - Evolve: a mining bot that uses an evolutionary algorithm to find the best mining strategy.
  
# Be Advised

These mods can display complex and unpredictable behaviour. See the instructions in each mod folder for more details on how these work and how to use them.

Whilst these mods are all variations on a theme, they will not necessarily all work well together, or be desirable to have on the same map. 

e.g. Ecobots and Autosky are both indepedently demanding on computing power.

e.g. Doomsday is the ultimate griefer's tool... it will destroy the world. 

If in doubt try each mod independantly first.




# License:

Code is licensed under GNU LGPLv2+.

Textures and sound are licensed under CC BY-SA 3.0 Unported.





# Change log:

# Version 0.1.1

Ecobots:
 -  added "The Theory Behind Ecobots" pdf
- added settings for plant growth rates
- changed pioneer to a grass that can be walked through (compatibility -  causes a slight bug with old maps, making them display as black, but corrects itself over time)
- Tidied up the way animals reproduce, parents must now eat food to produce offspring.
- added rare random plant death to simulate leaf fall and aging, creating dynamism in the plants independent of the need for animals
- made plants intolerant to seawater (compatibility - any existing swamp plants will die, but they will re-grow once the soil is above water level)
- many other minor improvements

Autocells:
- improved performance (I think!)

# Version 0.2

Selfrep_doomsday:
- added Blight device.
- added Terraformer device.
- changed from automatic timeouts to a kill-switch in settings.
- made weapon more effective.
- gave the weapon a weakness to ice.
- gave the Grey Goo additional growth forms controlled by light levels and height to add variety.
- added diamond ore, gold ore, and mese lamps to Grey Goo.
- many minor improvements.

Selfrep:
- changed appearance of sponge
- road and tower fill out more
- other minor improvements

Ecobots:
- A total overhaul...
- Added multiple new species.
- An improved map spawner now does a total replacement of default vegetation.
- Allowed for "simple" and "fancy" leaf textures.
- Gave plants (and other species) long distance seed-like replication abilities.
- Created two examples of self organizing intelligence.
- Expanded theory document to explain self organizing intelligence and to give a crash course in ecology.
- Many, many, many other improvements.
- (Compatibility: On previously grown forests some textures may need refreshing, and new growth will clash with older growth - the previous main tree has morphed into a new species.)


# Verion 0.2.1

Ecobots:
- an evolving vine species.
- a flying swarming species.
- a cave slime species.
- tweaks and new adaptations for the animals to help with longterm survival and balance.
- many other tweaks mostly aimed at longterm balance.


# Verion 0.3.0

Autocells:
- added Automusic cellular automata

Selfrep:
- added tunnel, sinkhole, dome, platform, and ladder


Selfrep_doomsday:
- brought the mod into gameplay by adding a map spawner which adds risky labs that can accidently release doomsday devices
- added protector block, and selfreplicating autoprotector, and protector dome which defend against doomsday devices
- added "Flash" and "Chaos" doomsday devices
- simplifications to the weapon, and smaller textures for devices to help with performance.

New mods:
- "Autosky" weather simulator
- "Neuron" brain cell simulator
- "Evolve" evolving autonomous mining bot

# Verion 0.3.1
Evolve:
- generalized code, and added a second bot
Ecobots:
- an unfinished attempt at transitioning the animals from blocks to entities (only adds a fish, accessible in creative mode)
