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

citygen.register_building("citygen:default_building", {
	renderer = "12-part-template",
	layout = "building_default",
	schematics = default_schematics
})

citygen.register_layout("building_default", {
	order = 10,
	layout = function(building_def, layout, root_pos)
		-- TODO
	end
})

citygen.register_renderer("12-part-template", {
	render = function(building_def, mapblock_pos)
	end
})

--[[
citygen.register_building({
	name = "citygen:default_building_iron",
	type = "12-part-template",
	schematics = default_schematics,
	replace = {
		["moreblocks:coal_stone"] = "moreblocks:iron_stone",
		["moreblocks:coal_glass"] = "moreblocks:clean_glass",
		["moreblocks:checker_stone_tile"] = "moreblocks:iron_checker",
		["moreblocks:coal_stone_bricks"] = "moreblocks:iron_stone_bricks",
		["moreblocks:stair_coal_stone_bricks"] = "moreblocks:stair_iron_stone_bricks",
		["moreblocks:stair_coal_stone_bricks_outer"] = "moreblocks:stair_iron_stone_bricks_outer",
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
		["moreblocks:stair_coal_stone_bricks"] = "moreblocks:stair_desert_sandstone_brick",
		["moreblocks:stair_coal_stone_bricks_outer"] = "moreblocks:stair_desert_sandstone_brick_outer",
	}
})

citygen.register_building({
	name = "citygen:default_building_desert_stone",
	type = "12-part-template",
	schematics = default_schematics,
	replace = {
		["moreblocks:coal_stone"] = "default:desert_stone",
		["moreblocks:coal_stone_bricks"] = "default:desert_stonebrick",
		["moreblocks:stair_coal_stone_bricks"] = "moreblocks:stair_desert_stonebrick",
		["moreblocks:stair_coal_stone_bricks_outer"] = "moreblocks:stair_desert_stonebrick_outer",
	}
})

local default_schematics2 = {
	corner = {
		bottom = MP .. "/schematics/building2/building_lower_corner",
		middle = MP .. "/schematics/building2/building_middle_corner",
		top = MP .. "/schematics/building2/building_top_corner"
	},
	edge = {
		bottom = MP .. "/schematics/building2/building_lower_straight",
		middle = MP .. "/schematics/building2/building_middle_straight",
		top = MP .. "/schematics/building2/building_top_straight"
	},
	edge_closed = {
		bottom = MP .. "/schematics/building2/building_lower_straight_closed",
		middle = MP .. "/schematics/building2/building_middle_straight_closed",
		top = MP .. "/schematics/building2/building_top_straight_closed"
	},
	center = {
		bottom = MP .. "/schematics/building2/building_lower_center",
		middle = MP .. "/schematics/building2/building_middle_center",
		top = MP .. "/schematics/building2/building_top_center"
	}
}

citygen.register_building({
	name = "citygen:default_building2",
	type = "12-part-template",
	schematics = default_schematics2
})

citygen.register_building({
	name = "citygen:default_building2_iron",
	type = "12-part-template",
	schematics = default_schematics2,
	replace = {
		["moreblocks:coal_glass"] = "moreblocks:clean_glass",
		["moreblocks:coal_stone"] = "moreblocks:iron_stone",
		["moreblocks:slope_coal_glass"] = "moreblocks:slope_clean_glass",
		["moreblocks:checker_stone_tile"] = "moreblocks:iron_checker",
		["moreblocks:coal_stone_bricks"] = "moreblocks:iron_stone_bricks",
		["moreblocks:stair_coal_stone"] = "moreblocks:stair_iron_stone",
		["moreblocks:stair_coal_stone_bricks"] = "moreblocks:stair_iron_stone_bricks",
		["moreblocks:stair_coal_stone_bricks_outer"] = "moreblocks:stair_iron_stone_bricks_outer",
		["moreblocks:slope_coal_stone_half_raised"] = "moreblocks:slope_iron_stone_half_raised",
		["moreblocks:slope_coal_stone_inner_cut"] = "moreblocks:slope_iron_stone_inner_cut",
		["moreblocks:slope_coal_stone_inner_half_raised"] = "moreblocks:slope_iron_stone_inner_half_raised",
		["moreblocks:slope_coal_stone_outer_cut_half_raised"] = "moreblocks:slope_iron_stone_outer_cut_half_raised"
	}
})

local default_schematics3 = {
	corner = {
		bottom = MP .. "/schematics/building3/building_lower_corner",
		middle = MP .. "/schematics/building3/building_middle_corner",
		top = MP .. "/schematics/building3/building_top_corner"
	},
	edge = {
		bottom = MP .. "/schematics/building3/building_lower_straight",
		middle = MP .. "/schematics/building3/building_middle_straight",
		top = MP .. "/schematics/building3/building_top_straight"
	},
	edge_closed = {
		bottom = MP .. "/schematics/building3/building_lower_straight_closed",
		middle = MP .. "/schematics/building3/building_middle_straight_closed",
		top = MP .. "/schematics/building3/building_top_straight_closed"
	},
	center = {
		bottom = MP .. "/schematics/building2/building_lower_center",
		middle = MP .. "/schematics/building2/building_middle_center",
		top = MP .. "/schematics/building2/building_top_center"
	}
}

citygen.register_building({
	name = "citygen:default_building3",
	type = "12-part-template",
	schematics = default_schematics3
})

citygen.register_building({
	name = "citygen:default_building3_iron",
	type = "12-part-template",
	schematics = default_schematics3,
	replace = {
		["moreblocks:coal_stone"] = "moreblocks:iron_stone",
		["moreblocks:coal_glass"] = "moreblocks:clean_glass",
		["moreblocks:checker_stone_tile"] = "moreblocks:iron_checker",
		["moreblocks:slope_coal_stone"] = "moreblocks:slope_iron_stone",
		["moreblocks:slope_coal_stone_inner"] = "moreblocks:slope_iron_stone_inner",
		["moreblocks:slope_coal_stone_outer"] = "moreblocks:slope_iron_stone_outer",
	}
})
--]]