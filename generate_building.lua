
local building_index = {}

function citygen.generate_building(perlin_manager, options)

	if #building_index == 0 then
		-- index buildings by number
		for _, def in pairs(citygen.buildings) do
			table.insert(building_index, def)
		end
	end

	options = options or {}
	local size_x = perlin_manager.get_value(options.min_x or 3, options.max_x or 6)
	local size_y = perlin_manager.get_value(options.min_y or 3, options.max_y or 10)
	local size_z = perlin_manager.get_value(options.min_z or 3, options.max_z or 6)

	-- select building by number
	local selected_building_index = perlin_manager.get_value(1, #building_index)
	local building_def = building_index[selected_building_index]
	assert(building_def)
	local building_type = building_def.name

	local data = {}

	for x=1, size_x do
		data[x] = {}

		for z=1, size_z do
			local def = {
				groups = {
					building = true
				},
				attributes = {
					height = size_y,
					building_type = building_type
				}
			}
			if x == 1 and z == 1 then
				def.groups.corner = true
				def.direction = "x-z-"
			elseif x == size_x and z == size_z then
				def.groups.corner = true
				def.direction = "x+z+"
			elseif x == size_x and z == 1 then
				def.groups.corner = true
				def.direction = "x+z-"
			elseif x == 1 and z == size_z then
				def.groups.corner = true
				def.direction = "x-z+"
			elseif x == 1 then
				def.groups.edge = true
				def.direction = "x-"
			elseif z == 1 then
				def.groups.edge = true
				def.direction = "z-"
			elseif x == size_x then
				def.groups.edge = true
				def.direction = "x+"
			elseif z == size_z then
				def.groups.edge = true
				def.direction = "z+"
			else
				def.groups.inside = true
			end

			data[x][z] = def
		end
	end

	return data, { x=size_x, z=size_z }
end
