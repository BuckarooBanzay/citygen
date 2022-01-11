
function citygen.layout_check_neighbors(check_data, mapblock_pos, rel_pos_list)
    for _, rel_pos in ipairs(rel_pos_list) do
        local abs_pos = {
            x = mapblock_pos.x + rel_pos.x,
            z = mapblock_pos.z + rel_pos.z
        }
        local layout_data = citygen.get_mapblock_layout(abs_pos)

        if check_data.name and not layout_data.names[check_data.name] then
            return false
        end

        if check_data.group and not layout_data.groups[check_data.group] then
            return false
        end
    end

    return true
end