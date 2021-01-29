local MP = minetest.get_modpath("citygen")

local default_schematics = {
	corner = {
		bottom = MP .. "/schematics/building/building_lower_corner",
		middle = MP .. "/schematics/building/building_middle_corner",
		top = MP .. "/schematics/building/building_top_corner"
	},
	edge = {
		bottom = MP .. "/schematics/building/building_lower_straight",
		middle = MP .. "/schematics/building/building_middle_straight",
		top = MP .. "/schematics/building/building_top_straight"
	},
	edge_closed = {
		bottom = MP .. "/schematics/building/building_lower_straight_closed",
		middle = MP .. "/schematics/building/building_middle_straight_closed",
		top = MP .. "/schematics/building/building_top_straight_closed"
	},
	center = {
		bottom = MP .. "/schematics/building/building_lower_center",
		middle = MP .. "/schematics/building/building_middle_center",
		top = MP .. "/schematics/building/building_top_center"
	}
}

citygen.register_building({
	name = "citygen:default_building",
	type = "12-part-template",
	schematics = default_schematics
})

citygen.register_building({
	name = "citygen:default_building_iron",
	type = "12-part-template",
	schematics = default_schematics,
	replace = {
		["moreblocks:coal_stone"] = "moreblocks:iron_stone",
		["moreblocks:coal_glass"] = "moreblocks:clean_glass",
		["moreblocks:checker_stone_tile"] = "moreblocks:iron_checker",
		["moreblocks:coal_stone_bricks"] = "moreblocks:iron_stone_bricks",
		["moreblocks:stair_coal_stone_bricks"] = "moreblocks:stair_iron_stone_bricks"
	}
})

citygen.register_building({
	name = "citygen:default_building_desert_sandstone",
	type = "12-part-template",
	schematics = default_schematics,
	replace = {
		["moreblocks:coal_stone"] = "default:desert_sandstone",
		["moreblocks:coal_glass"] = "default:glass",
		["moreblocks:coal_stone_bricks"] = "default:desert_sandstone_brick",
		["moreblocks:stair_coal_stone_bricks"] = "moreblocks:stair_desert_sandstone_brick"
	}
})

citygen.register_building({
	name = "citygen:default_building_desert_stone",
	type = "12-part-template",
	schematics = default_schematics,
	replace = {
		["moreblocks:coal_stone"] = "default:desert_stone",
		["moreblocks:coal_stone_bricks"] = "default:desert_stonebrick",
		["moreblocks:stair_coal_stone_bricks"] = "moreblocks:stair_desert_stonebrick"
	}
})
