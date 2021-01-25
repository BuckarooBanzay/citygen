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

local function populate_streets(data, max_x, max_z)
	data[1][1] = {
		street = true,
		direction = "all"
	}

	for x=2, max_x do
		data[x][1] = {
			street = true,
			crossing = x % 4 == 0,
			direction = "x+x-"
		}
	end

	for z=2, max_z do
		data[1][z] = {
			street = true,
			crossing = z % 4 == 0,
			direction = "z+z-"
		}
	end
end

local function populate_buildings(data, perlin_map, start_x, start_z, _, _, direction_x, direction_z)
	-- XXX: create a single building in the corner
	local perlin_index = 1
	local building_size_x = clamp(perlin_map[perlin_index], 3, 6)
	perlin_index = perlin_index + 1
	local building_size_y = clamp(perlin_map[perlin_index], 3, 10)
	perlin_index = perlin_index + 1
	local building_size_z = clamp(perlin_map[perlin_index], 3, 6)
	perlin_index = perlin_index + 1
	local building_type = clamp(perlin_map[perlin_index], 1, 20)

	for x=start_x, building_size_x, direction_x do
		for z=start_z, building_size_z, direction_z do
			local def = {
				height = building_size_y,
				building = building_type
			}
			if x == start_x and z == start_z then
				def.type = "corner"
				def.direction = "x-z-"
			elseif x == building_size_x and z == building_size_z then
				def.type = "corner"
				def.direction = "x+z+"
			elseif x == building_size_x and z == start_z then
				def.type = "corner"
				def.direction = "x+z-"
			elseif x == start_x and z == building_size_z then
				def.type = "corner"
				def.direction = "x-z+"
			elseif x == start_x then
				def.type = "edge"
				def.direction = "x-"
			elseif z == start_x then
				def.type = "edge"
				def.direction = "z-"
			elseif x == building_size_x then
				def.type = "edge"
				def.direction = "x+"
			elseif z == building_size_z then
				def.type = "edge"
				def.direction = "z+"
			else
				def.type = "inner"
			end

			data[x][z] = def
		end
	end
end

-- returns the root-position for the cityblock
local function get_root_pos(mapblock_pos)
	return {
		x = mapblock_pos.x - (mapblock_pos.x % citygen.cityblock_size),
		z = mapblock_pos.z - (mapblock_pos.z % citygen.cityblock_size)
	}
end

-- returns the partial data for the specified mapblock
function citygen.get_cityblock_mapblock(mapblock_pos)
	local cityblock = citygen.get_cityblock(mapblock_pos)
	local root_pos = get_root_pos(mapblock_pos)

	local rel_pos_x = mapblock_pos.x - root_pos.x + 1
	local rel_pos_z = mapblock_pos.z - root_pos.z + 1

	if cityblock.data and cityblock.data[rel_pos_x] and cityblock.data[rel_pos_x][rel_pos_z] then
		return cityblock.data[rel_pos_x][rel_pos_z]
	else
		return
	end
end

-- returns the whole cityblock data
function citygen.get_cityblock(mapblock_pos)
	-- root position of that cityblock
	local root_pos = get_root_pos(mapblock_pos)

	-- consult cache first
	local cache_key = root_pos.x .. "/" .. root_pos.z
	if cache[cache_key] then
		return cache[cache_key]
	end

	local map_lengths_xyz = {x=citygen.cityblock_size, y=citygen.cityblock_size, z=citygen.cityblock_size}
	local perlin = minetest.get_perlin_map(perlin_params, map_lengths_xyz)

	local perlin_map = {}
	perlin:get_2d_map_flat({x=root_pos.x, y=root_pos.z}, perlin_map)

	local max_x = citygen.cityblock_size
	local max_z = citygen.cityblock_size

	-- initialize 2-dimensional data
	local data = {}
	for x=1, max_x do
		data[x] = {}
	end

	populate_streets(data, max_x, max_z)
	populate_buildings(data, perlin_map, 2, 2, max_x, max_z, 1, 1)

	local result = {
		root_pos = root_pos,
		data = data
	}

	-- cache computed result
	cache[cache_key] = result
	return result
end
