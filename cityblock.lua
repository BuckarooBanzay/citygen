
local cache = {}


-- returns the layout for the specified mapblock
function citygen.get_mapblock_layout(mapblock_pos)
	local cityblock = citygen.get_cityblock(mapblock_pos)
	local root_pos = citygen.get_root_pos(mapblock_pos)

	local rel_pos_x = mapblock_pos.x - root_pos.x + 1
	local rel_pos_z = mapblock_pos.z - root_pos.z + 1

	return cityblock.layout:get_entry(rel_pos_x, rel_pos_z)
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

	local result = {
		root_pos = root_pos,
		layout = citygen.populate_layout(root_pos)
	}

	-- cache computed result
	cache[cache_key] = result
	return result
end
