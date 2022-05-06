
local cache = {}

function citygen.get_cityblock(root_pos)
    local hash = minetest.hash_node_position({ x=root_pos.x, y=0, z=root_pos.z})
    if cache[hash] then
        return cache[hash]
    end

    local pmgr = citygen.create_perlin_manager(root_pos)
    local cityblock = {}

    -- plot streets
    for x=0,citygen.cityblock_size-1 do
        local index = minetest.pos_to_string({x=x, y=0, z=0})
        cityblock[index] = {
            renderer = "street"
        }
    end
    for z=0,citygen.cityblock_size-1 do
        local index = minetest.pos_to_string({x=0, y=0, z=z})
        cityblock[index] = {
            renderer = "street"
        }
    end

    -- plot partitions
    local partitions = citygen.partition(citygen.cityblock_size, citygen.cityblock_size, 5, pmgr)
    for _ in ipairs(partitions) do
    end

    cache[hash] = cityblock
    return cityblock
end

function citygen.get_cityblock_mapblock(mapblock_pos)
    local xz_mapblock_pos = { x=mapblock_pos.x, y=0, z=mapblock_pos.z }
    local root_pos = citygen.get_root_pos(xz_mapblock_pos)

    local cityblock = citygen.get_cityblock(root_pos)
    local rel_mapblock_pos = vector.subtract(xz_mapblock_pos, root_pos)
    local index = minetest.pos_to_string(rel_mapblock_pos)
    return cityblock[index]
end