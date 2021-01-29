local perlin_params = {
	offset = 0,
	scale = 1,
	spread = {x=64, y=64, z=64},
	seed = 5477835,
	octaves = 2,
	persist = 0.5
}

local function clamp(value, min, max)
	local diff = max - min
	if diff < 1 then
		-- same values for min and max provided
		return min
	end
	return math.floor(((value * max * 2) % diff) + min + 0.5)
end

function citygen.create_perlin_manager(root_pos)
	local map_lengths_xyz = {x=citygen.cityblock_size, y=citygen.cityblock_size, z=citygen.cityblock_size}
	local perlin = minetest.get_perlin_map(perlin_params, map_lengths_xyz)

	local perlin_map = {}
	perlin:get_2d_map_flat({x=root_pos.x, y=root_pos.z}, perlin_map)

	local perlin_index = 0

	local manager = {}

	function manager.get_value(min, max)
		perlin_index = perlin_index + 1
		if perlin_index > #perlin_map then
			error("ran out of perlin noise!")
		end
		return clamp(perlin_map[perlin_index], min, max)
	end

	return manager
end
