local perlin_params = {
	offset = 0,
	scale = 1,
	spread = {x=64, y=64, z=64},
	seed = 5477835,
	octaves = 2,
	persist = 0.5
}

local cache = {}

local function clamp(value, min, max)
	local diff = max - min
	return math.floor(((value * max * 2) % diff) + min + 0.5)
end

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

	-- initialize map
	local map = {}
	for x=1, citygen.road_interval do
		map[x] = {}
	end


	local index = 1
	local x = 1
	while x < citygen.road_interval do
		local z=1
		local size_x = clamp(perlin_map[index], 3, 5)
		index = index + 1
		local size_z = clamp(perlin_map[index], 3, 5)
		index = index + 1
		local type = clamp(perlin_map[index], 0, 10)
		index = index + 1


		if (x + size_x) > citygen.road_interval then
			break
		end

		for map_x=x, x+size_x do
			for map_z=z, z+size_z do
				map[map_x][map_z] = {
					type = type,
					size_x = size_x,
					size_z = size_z
				}
			end
		end

		x = x + size_x
	end

	local result = {
		root_pos = root_pos,
		map = map
	}

	-- cache computed result
	cache[cache_key] = result
	return result
end

minetest.register_chatcommand("cityblock_data", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "player not found"
		end

		local pos = player:get_pos()

		local mapblock_pos = mapblock_lib.get_mapblock(pos)
		local cityblock_data = citygen.get_cityblock_data(mapblock_pos)
		print(dump(cityblock_data))

		return true
	end
})
