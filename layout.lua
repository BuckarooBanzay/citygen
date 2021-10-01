local MP = minetest.get_modpath("citygen")

local function create_street(x_streetname, z_streetname, direction)
    return {
        groups = {
            street = true
        },
        attributes = {
            x_streetname = x_streetname,
            z_streetname = z_streetname
        },
        direction = direction
    }
end

local function create_platform()
    return {
        groups = {
            platform = true
        }
    }
end

local building_index = {}

-- random building
local function create_building(perlin_manager)
	if #building_index == 0 then
		-- index buildings by number
		for _, def in pairs(citygen.buildings) do
			table.insert(building_index, def)
		end
	end

    local selected_building_index = perlin_manager.get_value(1, #building_index)
	local building_def = building_index[selected_building_index]
    assert(building_def)

    local height = perlin_manager.get_value(3, 10)

    return {
        groups = {
            building = true
        },
        attributes = {
            building_type = building_def.name,
            building_id = math.random(1000),
            height = height
        }
    }
end

local function same_building_type(e1, e2)
    return e1 and e2 and e1.attributes and e2.attributes and
        e1.attributes.building_id == e2.attributes.building_id
end

local function copy(entry)
    local c = {
        direction = entry.direction,
        attributes = {},
        groups = {}
    }

    for k, v in pairs(entry.attributes or {}) do
        c.attributes[k] = v
    end
    for k, v in pairs(entry.groups or {}) do
        c.groups[k] = v
    end

    return c
end

-- "links" the independent segments to each other (determines edges,corner,etc)
local function link(map)
    for x=1,20 do
        for z=1,20 do
            local entry = copy(map[x][z])
            map[x][z] = entry

            if entry.groups.street then
                if entry.direction == "x+x-" then
                    entry.groups.crossing = x % 4 == 0
                    entry.groups.sewer_access = x % 7 == 0
                elseif entry.direction == "z+z-" then
                    entry.groups.crossing = z % 4 == 0
                    entry.groups.sewer_access = z % 7 == 0
                end
            end

            if entry.groups.building then
                local empty = { groups={}, attributes={} }
                local xplus = x < 20 and map[x+1][z] or empty
                local xminus = x > 1 and map[x-1][z] or empty
                local zplus = z < 20 and map[x][z+1] or empty
                local zminus = z > 1 and map[x][z-1] or empty

                local xplus_match = same_building_type(xplus, entry)
                local xminus_match = same_building_type(xminus, entry)
                local zplus_match = same_building_type(zplus, entry)
                local zminus_match = same_building_type(zminus, entry)

                if not xplus_match and xminus_match and zplus_match and not zminus_match then
                    entry.groups.corner = true
                    entry.direction = "x+z-"
                elseif not xplus_match and xminus_match and not zplus_match and zminus_match then
                    entry.groups.corner = true
                    entry.direction = "x+z+"
                elseif xplus_match and not xminus_match and not zplus_match and zminus_match then
                    entry.groups.corner = true
                    entry.direction = "x-z+"
                elseif xplus_match and not xminus_match and zplus_match and not zminus_match then
                    entry.groups.corner = true
                    entry.direction = "x-z-"
                elseif not xplus_match and xminus_match and zplus_match and zminus_match then
                    entry.groups.edge = true
                    entry.direction = "x+"
                elseif xplus_match and not xminus_match and zplus_match and zminus_match then
                    entry.groups.edge = true
                    entry.direction = "x-"
                elseif xplus_match and xminus_match and not zplus_match and zminus_match then
                    entry.groups.edge = true
                    entry.direction = "z+"
                elseif xplus_match and xminus_match and zplus_match and not zminus_match then
                    entry.groups.edge = true
                    entry.direction = "z-"
                else
                    -- in the center
                    entry.groups.inside = true
                end
            end
        end
    end
end



local rnd = tonumber(string.sub(minetest.get_mapgen_setting("seed"), 1, 7))

function citygen.create_layout(root_pos)
    local perlin_manager = citygen.create_perlin_manager(root_pos)

    local x_streetname = citygen.get_street_name(rnd + root_pos.z)
	local z_streetname = citygen.get_street_name(rnd + 2048 + root_pos.x)

    local mapping = {
        sc = create_street(x_streetname, z_streetname, "all"),
        sx = create_street(x_streetname, z_streetname, "x+x-"),
        sz = create_street(x_streetname, z_streetname, "z+z-"),
        b1 = create_building(perlin_manager),
        b2 = create_building(perlin_manager),
        b3 = create_building(perlin_manager),
        b4 = create_building(perlin_manager),
        b5 = create_building(perlin_manager),
        b6 = create_building(perlin_manager),
        b7 = create_building(perlin_manager),
        b8 = create_building(perlin_manager),
        b9 = create_building(perlin_manager),
        pl = create_platform()
    }

    local layouts = {}

    local filenames = {
        "basic.txt",
        "green_spaces.txt",
        "big_complex.txt"
    }

    for _, filename in ipairs(filenames) do
        local layout = citygen.parse_layout(MP .. "/layouts/" .. filename, mapping)
        table.insert(layouts, layout)
    end


    local layout_number = perlin_manager.get_value(1, #layouts)
    local map = layouts[layout_number]

    -- final processing
    link(map)

    return map
end