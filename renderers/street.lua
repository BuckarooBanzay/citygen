local MP = minetest.get_modpath("citygen")

local has_street_signs_mod = minetest.get_modpath("street_signs")

local content_street_sign = -1
if has_street_signs_mod then
	content_street_sign = minetest.get_content_id("street_signs:sign_basic")
end

citygen.register_renderer(function(mapblock_pos, data)
	if not data.groups.street or mapblock_pos.y ~= 0 then
		return
	end

	local angle = 0
	local schematic

	if data.direction == "all" then
		schematic = MP .. "/schematics/street/street_all_sides"
	elseif data.groups.sewer_access then
		schematic = MP .. "/schematics/street/street_straight_sewer_access"
	elseif data.groups.crossing then
		schematic = MP .. "/schematics/street/street_straight_crossing"
	else
		schematic = MP .. "/schematics/street/street_straight"
	end

	if data.direction == "z+z-" then
		angle = 90
	end

	mapblock_lib.deserialize(mapblock_pos, schematic, {
		use_cache = true,
		transform = {
			rotate = {
				axis = "y",
				angle = angle,
				disable_orientation = {
					["default:stonebrick"] = true,
					["street_signs:sign_basic"] = true
				}
			}
		},
		on_metadata = function(_, content_id, meta)
			if content_id == content_street_sign then
				-- write street name
				local txt = data.attributes.z_streetname .. "\n" .. data.attributes.x_streetname
				meta:set_string("infotext", txt)
				meta:set_string("text", txt)
			end
		end
	})
end)