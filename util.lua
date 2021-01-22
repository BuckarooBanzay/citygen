local perlin_params = {
	offset = 0,
	scale = 1,
	spread = {x=64, y=64, z=64},
	seed = 5477835,
	octaves = 2,
	persist = 0.5
}

local cache = {}

function citygen.get_cityblock_data(mapblock_pos)
	-- root position of that cityblock
	local root_pos = {
		x = mapblock_pos.x - (mapblock_pos.x % citygen.road_interval) + 1,
		z = mapblock_pos.z - (mapblock_pos.z % citygen.road_interval) + 1
	}

	-- consult cache first
	local cache_key = root_pos.x .. "/" .. root_pos.z
	if cache[cache_key] then
		return cache[cache_key]
	end

	local map_lengths_xyz = {x=citygen.road_interval, y=citygen.road_interval, z=citygen.road_interval}
	local perlin = minetest.get_perlin_map(perlin_params, map_lengths_xyz)

	local perlin_map = {}
	perlin:get_2d_map_flat({x=root_pos.x, y=root_pos.z}, perlin_map)

	local result = {
		pos = root_pos,
		height = math.floor(perlin_map[1] * 10000),
		size = #perlin_map
	}

	-- cache computed result
	cache[cache_key] = result
	return result
end
