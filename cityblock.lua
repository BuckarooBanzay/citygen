
local cache = {}

function citygen.get_cityblock(root_pos)
    local hash = minetest.hash_node_position(root_pos)
    if cache[hash] then
        return cache[hash]
    end

    local pmgr = citygen.create_perlin_manager(root_pos)
    local cityblock = {}

    -- plot streets
    for x=0,citygen.cityblock_size-1 do
        local mapblock_pos = vector.add(root_pos, {x=x, y=0, z=0})
        local index = minetest.pos_to_string(mapblock_pos)
        cityblock[index] = {
            name = "street"
        }
    end
    for z=0,citygen.cityblock_size-1 do
        local mapblock_pos = vector.add(root_pos, {x=0, y=0, z=z})
        local index = minetest.pos_to_string(mapblock_pos)
        cityblock[index] = {
            name = "street"
        }
    end

    -- plot partitions
    local partitions = citygen.partition(citygen.cityblock_size, citygen.cityblock_size, 5, pmgr)
    for _, partition in ipairs(partitions) do
        print(dump({
            root_pos = root_pos,
            partition = partition
        }))
    end

    cache[hash] = cityblock
    return cityblock
end

function citygen.get_cityblock_mapblock(mapblock_pos)
    local root_pos = citygen.get_root_pos(mapblock_pos)

    local cityblock = citygen.get_cityblock(root_pos)
    local rel_mapblock_pos = vector.subtract(mapblock_pos, root_pos)
    local index = minetest.pos_to_string(rel_mapblock_pos)
    return cityblock[index]
end