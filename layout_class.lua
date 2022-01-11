local Layout = {}
Layout.__index = Layout

function citygen.new_layout(size_x, size_z)
    local o = {
        data = {},
        size_x = size_x,
        size_z = size_z
    }
    setmetatable(o, Layout)

    return o
end

local function get_key(x, z)
    return x .. "/" .. z
end

function Layout:get_size()
    return self.size_x, self.size_z
end

function Layout:get_entry(x, z)
    local key = get_key(x, z)
    local entry = self.data[key]
    if not entry then
        entry = {
            groups = {},
            names = {},
            attributes = {}
        }
        self.data[key] = entry
    end
    return entry
end

function Layout:set_name(x, z, name)
    self:get_entry(x, z).names[name] = true
end

function Layout:set_group(x, z, group)
    self:get_entry(x, z).groups[group] = true
end

function Layout:set_attribute(x, z, key, value)
    self:get_entry(x, z).attributes[key] = value
end
