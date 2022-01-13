
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
dofile(MP.."/mapdata.lua")
dofile(MP.."/layout_checks.lua")
dofile(MP.."/populate_layout.lua")
dofile(MP.."/render.lua")
dofile(MP.."/mapgen.lua")
dofile(MP.."/debug.lua")

dofile(MP.."/util/streetname.lua")
dofile(MP.."/util/place_orient.lua")

-- layouts
dofile(MP.."/layout/street.lua")
dofile(MP.."/layout/replace_nth.lua")

-- renderers
dofile(MP.."/renderer/simple_place_rotate.lua")

if minetest.get_modpath("default") and minetest.get_modpath("moreblocks") then
    -- enable default (demo?) buildings
    dofile(MP.."/default/default_buildings.lua")
    dofile(MP.."/default/street.lua")
    dofile(MP.."/default/sewer.lua")
end