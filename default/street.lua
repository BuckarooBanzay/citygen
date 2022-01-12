local MP = minetest.get_modpath("citygen")

citygen.register_building("citygen:default_street", {
	renderer = "simple_place_rotate",
	layout = "street",
	pos_y = 0,
	schematics = {
		all_sides = MP .. "/schematics/street/street_all_sides",
		crossing = MP .. "/schematics/street/street_straight_crossing",
		straight = MP .. "/schematics/street/street_straight",
		sewer = MP .. "/schematics/street/street_straight_sewer_access"
	}
})
