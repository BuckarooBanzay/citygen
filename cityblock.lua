
local cache = {}


-- returns the partial data for the specified mapblock
function citygen.get_cityblock_mapblock(mapblock_pos)
	local cityblock = citygen.get_cityblock(mapblock_pos)
	local root_pos = citygen.get_root_pos(mapblock_pos)

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
	local root_pos = citygen.get_root_pos(mapblock_pos)

	-- consult cache first
	local cache_key = root_pos.x .. "/" .. root_pos.z
	if cache[cache_key] then
		return cache[cache_key]
	end

	local perlin_manager = citygen.create_perlin_manager(root_pos)

	local max_x = citygen.cityblock_size
	local max_z = citygen.cityblock_size

	-- initialize 2-dimensional data
	local data = {}
	for x=1, max_x do
		data[x] = {}
	end

	citygen.plot_streets(root_pos, data, max_x, max_z)
	citygen.plot_buildings(data, perlin_manager, {x=1, z=1}, {x=max_x-1, z=max_z-1})

	-- fill the rest with a platform
	for x=2, max_x do
		for z=2, max_z do
			if not data[x][z] then
				data[x][z] = {
					groups = {
						platform = true
					}
				}
			end
		end
	end

	local result = {
		root_pos = root_pos,
		data = data
	}

	-- cache computed result
	cache[cache_key] = result
	return result
end
