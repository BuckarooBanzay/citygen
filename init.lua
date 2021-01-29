
citygen = {
	cityblock_size = 20
}

local MP = minetest.get_modpath("citygen")

dofile(MP.."/util.lua")
dofile(MP.."/perlin_manager.lua")
dofile(MP.."/generate_building.lua")
dofile(MP.."/plot_buildings.lua")
dofile(MP.."/plot_streets.lua")
dofile(MP.."/cityblock.lua")
dofile(MP.."/render.lua")
dofile(MP.."/mapgen.lua")
dofile(MP.."/chatcommands.lua")
