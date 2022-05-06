
citygen = {
	cityblock_size = 20
}

-- sanity checks
if minetest.get_mapgen_setting("mg_name") ~= "singlenode" then
    error("this mod only works with the 'singlenode' mapgen")
end

local MP = minetest.get_modpath("citygen")

dofile(MP.."/api.lua")
dofile(MP.."/hacks.lua")
dofile(MP.."/util.lua")
dofile(MP.."/perlin_manager.lua")
dofile(MP.."/mapgen.lua")
dofile(MP.."/chatcommands.lua")
dofile(MP.."/debug.lua")
dofile(MP.."/util/streetname.lua")
