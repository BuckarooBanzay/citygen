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

citygen.register_building("citygen:default_sewer_with_access", {
	renderer = "simple_place_rotate",
	layout = "street_sewer",
	pos_y = -1,
	mod_x = 7,
	mod_z = 7,
	replace = "citygen:default_sewer",
	schematics = {
		all_sides = MP .. "/schematics/sewer/sewer_straight_access",
		straight = MP .. "/schematics/sewer/sewer_straight_access"
	}
})

