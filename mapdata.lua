
local mapdata = {}
citygen.mapdata = mapdata

local data = {}
local root_pos_cache = {}

function mapdata.get_entry(pos, create)
    local root_pos = citygen.get_root_pos(pos)
    local root_pos_hash = minetest.hash_node_position(root_pos)
    if not root_pos_cache[root_pos_hash] and create then
        -- create layout
        citygen.populate_layout(root_pos)
        root_pos_cache[root_pos_hash] = true
    end

    local key = minetest.hash_node_position(pos)
    local entry = data[key]
    if not entry then
        entry = {
            name = nil,
            groups = {},
            attributes = {}
        }
        data[key] = entry
    end
    return entry
end

function mapdata.set_name(pos, name)
    mapdata.get_entry(pos).name = name
end

function mapdata.get_name(pos, create)
    return mapdata.get_entry(pos, create == nil or create).name
end

function mapdata.set_group(pos, group)
    mapdata.get_entry(pos).groups[group] = true
end

function mapdata.has_group(pos, group)
    return mapdata.get_entry(pos, true).groups[group]
end

function mapdata.set_attribute(pos, key, value)
    mapdata.get_entry(pos).attributes[key] = value
end

function mapdata.get_attribute(pos, key)
    return mapdata.get_entry(pos, true).attributes[key]
end
