# self_organizing_systems
# by Dokimi

Adds a number of self organizing systems to Minetest. These use self replicating blocks and the scientific principles underlying complex systems in the real world to create unpredictable and often astonishing results. The blocks spontenously create their own strutures, and adapt and change in response to their own actions and those of the player. They mimic the behaviour of living things. They are the closest a Minetest block will ever come to being alive.

These mods can be fun to use in a general game, or they can used as a hands on way to explore some of the most fundamental laws of nature.



  - Autocell: a cellular automation made from light blocks. Creates interactive self sustaining light shows. One of the simplest possible demonstrations of how self organisation occurs.

  - Selfrep: adds a number a highly constrained self replicating "tools" that build useful controlled structures. A self replicating road, a self replicating tower, and a self replicating "sponge" which builds walls around the player when they walk through water, forming a water proof tunnel.
  
  - Selfrep_doomsday: explores the power of exponential growth. Self replication is entirely unconstrained. These structures take over the world, hence "doomsday". Grey Goo - grows an organic looking structure that covers the world. The Weapon - tries to destroy the world by turning it into flaming sludge.
  
  - Ecobots: creates a functional forest ecosystem of selfreplicating blocks. Self replication exists in the sweet spot between the limits of Selfrep and the mayhem of Selfrep Doomsday. Once established the ecobots simulate the behaviour of real ecosystems. They are alive!

See the instructions in each mod folder for more details on how these work and how to use them.

License:

Code is licensed under GNU LGPLv2+.

Textures and sound are licensed under CC BY-SA 3.0 Unported.



Current Version: 0.1.1


Change log:

Version 0.1.1

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
