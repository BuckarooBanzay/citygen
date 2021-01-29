
function citygen.generate_building(perlin_manager, options)
	options = options or {}
	local size_x = perlin_manager.get_value(options.min_x or 3, options.max_x or 6)
	local size_y = perlin_manager.get_value(options.min_y or 3, options.max_y or 10)
	local size_z = perlin_manager.get_value(options.min_z or 3, options.max_z or 6)
	local building_type = perlin_manager.get_value(1, 20)

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
