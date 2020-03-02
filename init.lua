
citygen = {}


local MP = minetest.get_modpath("citygen")

-- common stuff
dofile(MP.."/functions.lua")
dofile(MP.."/mapblock_checks.lua")
dofile(MP.."/street.lua")
dofile(MP.."/mapgen.lua")

if minetest.settings:get_bool("enable_citygen_integration_test") then
        dofile(MP.."/integration_test.lua")
end
