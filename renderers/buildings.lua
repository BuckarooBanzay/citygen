citygen.register_renderer(function(mapblock_pos, data)
    if not data.groups.building or mapblock_pos.y < 0 or mapblock_pos.y > data.attributes.height then
		return
	end

	local building_def = citygen.buildings[data.attributes.building_type]
	assert(building_def)

	local is_bottom = mapblock_pos.y == 0
	local is_top = mapblock_pos.y == data.attributes.height

	local three_slice
	if data.groups.inside then
		three_slice = building_def.schematics.center
	elseif data.groups.edge and not data.groups.closed then
		three_slice = building_def.schematics.edge
	elseif data.groups.edge and data.groups.closed then
		three_slice = building_def.schematics.edge_closed
	elseif data.groups.corner then
		three_slice = building_def.schematics.corner
	end

	assert(three_slice)

	local schematic

	if is_top then
		schematic = three_slice.top
	elseif is_bottom then
		schematic = three_slice.bottom
	else
		schematic = three_slice.middle
	end

	assert(schematic)

	local angle = 0

	if data.direction == "x+" or data.direction == "x+z-" then
		angle = 0
	elseif data.direction == "x-" or data.direction == "x-z+" then
		angle = 180
	elseif data.direction == "z+" or data.direction == "x+z+" then
		angle = 270
	elseif data.direction == "z-" or data.direction == "x-z-" then
		angle = 90
	end

	if schematic then
		local options = {
			use_cache = true,
			transform = {
				rotate = {
					axis = "y",
					angle = angle
				},
				replace = building_def.replace
			}
		}

		mapblock_lib.deserialize(mapblock_pos, schematic, options)
	end
end)