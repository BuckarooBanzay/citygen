
citygen.buildings = {}

function citygen.register_building(def)
	assert(def.name)
	citygen.buildings[def.name] = def
end

local renderers = {}

function citygen.register_renderer(callback)
	table.insert(renderers, callback)
end

function citygen.fire_renderers(mapblock_pos, data)
	for _, callback in ipairs(renderers) do
		callback(mapblock_pos, data)
	end
end