local MP = minetest.get_modpath("citygen")

citygen.register_building("citygen:default_sewer", {
	renderer = "simple_place_rotate",
	layout = "street",
	pos_y = -1,
	schematics = {
		all_sides = MP .. "/schematics/sewer/sewer_all_sides",
		straight = MP .. "/schematics/sewer/sewer_straight"
	}
})

