
local street_y_mapblock = 0
local pilot_street_modulo = 10

function citygen.is_street_mapblock(mapblock_pos)
	return mapblock_pos.y == street_y_mapblock and
		(mapblock_pos.x % pilot_street_modulo == 0 or
		mapblock_pos.z % pilot_street_modulo == 0)
end
