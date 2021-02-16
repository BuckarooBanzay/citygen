
local rnd = tonumber(string.sub(minetest.get_mapgen_setting("seed"), 1, 7))

function citygen.plot_streets(root_pos, data, max_x, max_z)
	local x_streetname = citygen.get_street_name(rnd + root_pos.z)
	local z_streetname = citygen.get_street_name(rnd + 2048 + root_pos.x)

	data[1][1] = {
		street = true,
		direction = "all",
		x_streetname = x_streetname,
		z_streetname = z_streetname
	}

	for x=2, max_x do
		data[x][1] = {
			street = true,
			street_name = x_streetname,
			crossing = x % 4 == 0,
			sewer_access = x % 7 == 0,
			direction = "x+x-"
		}
	end

	for z=2, max_z do
		data[1][z] = {
			street = true,
			street_name = z_streetname,
			crossing = z % 4 == 0,
			sewer_access = z % 7 == 0,
			direction = "z+z-"
		}
	end
end
