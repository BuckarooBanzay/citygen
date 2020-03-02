
citygen = {
  DIRECTION_NORTH_SOUTH = 1,
  DIRECTION_EAST_WEST = 2,
  DIRECTION_BOTH = 3
}


local MP = minetest.get_modpath("citygen")

-- common stuff
dofile(MP.."/functions.lua")
dofile(MP.."/street.lua")
dofile(MP.."/mapgen.lua")

if minetest.settings:get_bool("enable_citygen_integration_test") then
        dofile(MP.."/integration_test.lua")
end
