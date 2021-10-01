
-- get all lines from a file, returns an empty
-- list/table if the file does not exist
-- https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
local function lines_from(file)
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

function citygen.parse_layout(path, mapping)
    local lines = lines_from(path)
    assert(#lines == 20, "invalid line count: " .. #lines)

    local layout = {}

    for _, line in ipairs(lines) do
        local x_stride = {}
        table.insert(layout, x_stride)
        for key in line:gmatch("([^,]+)") do
            local entry = mapping[key]
            assert(entry, "mapping for '" .. key .. "' not found")
            table.insert(x_stride, entry)
        end
    end

    return layout
end