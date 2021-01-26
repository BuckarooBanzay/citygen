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
	if diff < 1 then
		-- same values for min and max provided
		return min
	end
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
			sewer_access = x % 7 == 0,
			direction = "x+x-"
		}
	end

	for z=2, max_z do
		data[1][z] = {
			street = true,
			crossing = z % 4 == 0,
			sewer_access = z % 7 == 0,
			direction = "z+z-"
		}
	end
end

local function generate_building(perlin_fn, options)
	options = options or {}
	local size_x = clamp(perlin_fn(), options.min_x or 3, options.max_x or 6)
	local size_y = clamp(perlin_fn(), options.min_y or 3, options.max_y or 10)
	local size_z = clamp(perlin_fn(), options.min_z or 3, options.max_z or 6)
	local building_type = clamp(perlin_fn(), 1, 20)

	local data = {}

	for x=1, size_x do
		data[x] = {}

		for z=1, size_z do
			local def = {
				height = size_y,
				building = building_type
			}
			if x == 1 and z == 1 then
				def.type = "corner"
				def.direction = "x-z-"
			elseif x == size_x and z == size_z then
				def.type = "corner"
				def.direction = "x+z+"
			elseif x == size_x and z == 1 then
				def.type = "corner"
				def.direction = "x+z-"
			elseif x == 1 and z == size_z then
				def.type = "corner"
				def.direction = "x-z+"
			elseif x == 1 then
				def.type = "edge"
				def.direction = "x-"
			elseif z == 1 then
				def.type = "edge"
				def.direction = "z-"
			elseif x == size_x then
				def.type = "edge"
				def.direction = "x+"
			elseif z == size_z then
				def.type = "edge"
				def.direction = "z+"
			else
				def.type = "inner"
			end

			data[x][z] = def
		end
	end

	return data, { x=size_x, z=size_z }
end

local function copy_building(building_def, data, offset)
	for x=1, #building_def do
		for z=1, #building_def[x] do
			data[x+offset.x-1][z+offset.z-1] = building_def[x][z]
		end
	end
end

local function populate_buildings(data, perlin_map, from, to)

	local perlin_index = 0
	local function perlin_fn()
		perlin_index = perlin_index + 1
		if perlin_index > #perlin_map then
			error("ran out of perlin noise!")
		end
		return perlin_map[perlin_index]
	end


	local x = from.x
	local size_z = clamp(perlin_fn(), 3, 5)
	while x < to.x do
		local remaining_size = to.x - x + 1
		if remaining_size < 3 then
			break
		end
		local min_x_size = 3
		if remaining_size < 6 then
			-- fit last building to remaining size
			min_x_size = remaining_size
		end

		local building_def, size = generate_building(perlin_fn, {
			min_x = math.min(min_x_size, remaining_size),
			max_x = math.min(6, remaining_size),
			min_y = 3,
			max_y = 7,
			min_z = size_z,
			max_z = size_z
		})
		print("x", x, "from.z", from.z, "from.x", from.x, "remaining_size", remaining_size)
		copy_building(building_def, data, {x=x, z=from.z})

		x = x + size.x
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
		return {}
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
	populate_buildings(data, perlin_map, {x=2, z=2}, {x=max_x, z=max_z})

	local result = {
		root_pos = root_pos,
		data = data
	}

	-- cache computed result
	cache[cache_key] = result
	return result
end
