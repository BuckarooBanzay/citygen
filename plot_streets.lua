
function citygen.plot_streets(data, max_x, max_z)
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
