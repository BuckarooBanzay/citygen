
function citygen.layout_check_neighbors(check_data, mapblock_pos, rel_pos_list)
    for _, rel_pos in ipairs(rel_pos_list) do
        local abs_pos = {
            x = mapblock_pos.x + (rel_pos.x or 0),
            y = mapblock_pos.y + (rel_pos.y or 0),
            z = mapblock_pos.z + (rel_pos.z or 0)
        }

        if check_data.name and citygen.mapdata.get_name(abs_pos) ~= check_data.name then
            return false
        end

        if check_data.group and not citygen.mapdata.has_group(abs_pos, check_data.group) then
            return false
        end
    end

    return true
end