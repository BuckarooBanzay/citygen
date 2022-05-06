
-- creates 2D partitions
function citygen.partition(size_x, size_y, min_size, perlin_mgr)
    local parts = {
        {pos={0,0}, size={size_x, size_y}}
    }

    for _=1,perlin_mgr.get_value(5, 10) do
        local part = parts[perlin_mgr.get_value(1, #parts)]

        if part.size[1] > (min_size*3) and part.size[2] > (min_size*3) then
            -- slice
            local axis = perlin_mgr.get_value(1,2)
            local third_size = math.floor(part.size[axis] / 3)
            local size1 = third_size + perlin_mgr.get_value(0, third_size)
            local size2 = part.size[axis] - size1

            -- duplicate
            local new_part = {
                pos={part.pos[1], part.pos[2]},
                size={part.size[1], part.size[2]}
            }

            -- set new sizes
            part.size[axis] = size1
            new_part.size[axis] = size2

            -- offset new part
            new_part.pos[axis] = new_part.pos[axis] + part.size[axis]
            table.insert(parts, new_part)
        end
    end

    return parts
end
