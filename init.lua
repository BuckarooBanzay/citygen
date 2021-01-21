
citygen = {}

local MP = minetest.get_modpath("citygen")

-- common stuff
dofile(MP.."/mapgen.lua")

if minetest.settings:get_bool("enable_citygen_integration_test") then
        dofile(MP.."/integration_test.lua")
end
