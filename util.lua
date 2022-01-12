-- returns the root-position for the cityblock
function citygen.get_root_pos(mapblock_pos)
	return {
		x = mapblock_pos.x - (mapblock_pos.x % citygen.cityblock_size),
		y = mapblock_pos.y - (mapblock_pos.y % citygen.cityblock_size),
		z = mapblock_pos.z - (mapblock_pos.z % citygen.cityblock_size)
	}
end
