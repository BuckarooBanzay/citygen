
local street_y_mapblock = 0
local pilot_street_modulo = 10

-- returns true if the mapblock contains a street
function citygen.is_street_mapblock(mapblock_pos)
	return mapblock_pos.y == street_y_mapblock and
		(mapblock_pos.x % pilot_street_modulo == 0 or
		mapblock_pos.z % pilot_street_modulo == 0)
end

-- returns the "magic" mapblock position for the current district (modulo-width)
-- usually the lower-left/south-west mapblock of the district
function citygen.get_magic_mapblock_pos(mapblock_pos)
	return {
		x = mapblock_pos.x - (mapblock_pos.x % pilot_street_modulo),
		y = street_y_mapblock,
		z = mapblock_pos.z - (mapblock_pos.z % pilot_street_modulo)
	}
end


local noise_params = {
	offset = 0,
	scale = 5,
	spread = {x=256, y=256, z=256},
	seed = 5477835,
	octaves = 2,
	persist = 0.5
}

local perlin

-- XXX TODO
function citygen.get_perlin(mapblock_pos)
	perlin = perlin or minetest.get_perlin_map(noise_params, {x=1,y=0,z=0})
	local perlin_map = {}
	perlin:get_2d_map_flat({x=mapblock_pos.x, y=mapblock_pos.z}, perlin_map)
	return perlin_map[1]
end
