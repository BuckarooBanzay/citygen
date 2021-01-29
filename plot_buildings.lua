
local function copy_building(building_def, data, offset)
	for x=1, #building_def do
		for z=1, #building_def[x] do
			data[x+offset.x][z+offset.z] = building_def[x][z]
		end
	end
end

local function is_edge(entry)
	return entry and entry.type == "edge"
end


local function detect_closed_edges(data)
	for x=1, citygen.cityblock_size do
		for z=1, citygen.cityblock_size do
			local entry = data[x][z]

			if is_edge(entry) then
				if entry.direction == "x+" and x < citygen.cityblock_size then
					entry.closed = is_edge(data[x+1][z])
				elseif entry.direction == "x-" and x > 1 then
					entry.closed = is_edge(data[x-1][z])
				elseif entry.direction == "z+" and z < citygen.cityblock_size then
					entry.closed = is_edge(data[x][z+1])
				elseif entry.direction == "z-" and z > 1 then
					entry.closed = is_edge(data[x][z-1])
				end

			end
		end
	end
end


function citygen.plot_buildings(data, perlin_manager, offset, size)
	-- along lower x axis (bottom)
	local x = 0
	local size_z = perlin_manager.get_value(3, 5)
	local lower_x_size_z = size_z
	while x <= size.x do
		local remaining_size = size.x - x
		local min_x_size = 3
		local last_building = false
		if remaining_size < 10 then
			-- fit last building to remaining size
			min_x_size = remaining_size
			last_building = true
		end

		local building_def, building_size = citygen.generate_building(perlin_manager, {
			min_x = math.min(min_x_size, remaining_size),
			max_x = math.min(8, remaining_size),
			min_y = 2,
			max_y = 10,
			min_z = size_z,
			max_z = size_z
		})
		copy_building(building_def, data, {x=offset.x+x, z=offset.z})

		x = x + building_size.x
		if last_building then
			break
		end
	end

	-- along lower z axis (left)
	local z = size_z
	local size_x = perlin_manager.get_value(3, 5)
	while z <= size.z do
		local remaining_size = size.z - z
		local min_z_size = 3
		local last_building = false
		if remaining_size < 10 then
			-- fit last building to remaining size
			min_z_size = remaining_size
			last_building = true
		end

		local building_def, building_size = citygen.generate_building(perlin_manager, {
			min_z = math.min(min_z_size, remaining_size),
			max_z = math.min(8, remaining_size),
			min_y = 2,
			max_y = 10,
			min_x = size_x,
			max_x = size_x
		})
		copy_building(building_def, data, {x=offset.x, z=offset.z+z})

		z = z + building_size.z
		if last_building then
			break
		end
	end

	-- along upper x axis (top)
	x = size_x
	size_z = perlin_manager.get_value(3, 5)
	while x <= size.x do
		local remaining_size = size.x - x
		local min_x_size = 3
		local last_building = false
		if remaining_size < 10 then
			-- fit last building to remaining size
			min_x_size = remaining_size
			last_building = true
		end

		local building_def, building_size = citygen.generate_building(perlin_manager, {
			min_x = math.min(min_x_size, remaining_size),
			max_x = math.min(8, remaining_size),
			min_y = 2,
			max_y = 10,
			min_z = size_z,
			max_z = size_z
		})
		copy_building(building_def, data, {x=offset.x+x, z=offset.z+size.z-size_z})

		x = x + building_size.x
		if last_building then
			break
		end
	end

	-- along upper z axis (right)
	z = lower_x_size_z
	size_x = perlin_manager.get_value(3, 5)
	local max_z = size.z - size_z
	while z <= max_z do
		local remaining_size = max_z - z
		local min_z_size = 3
		local last_building = false
		if remaining_size < 10 then
			-- fit last building to remaining size
			min_z_size = remaining_size
			last_building = true
		end

		local building_def, building_size = citygen.generate_building(perlin_manager, {
			min_z = math.min(min_z_size, remaining_size),
			max_z = math.min(8, remaining_size),
			min_y = 2,
			max_y = 10,
			min_x = size_x,
			max_x = size_x
		})
		copy_building(building_def, data, {x=offset.x+size.x-size_x, z=offset.z+z})

		z = z + building_size.z
		if last_building then
			break
		end
	end

	detect_closed_edges(data)
end
