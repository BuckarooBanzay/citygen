
-- buildings

local buildings = {}

function citygen.register_building(name, def)
	def.name = name
	buildings[name] = def
end

function citygen.get_building(name)
	return buildings[name]
end

function citygen.get_buildings()
	return buildings
end

-- renderers

local renderers = {}

function citygen.register_renderer(name, def)
	assert(type(def.render) == "function", "renderer_def.render must be a function")

	def.name = name
	renderers[name] = def
end

function citygen.get_renderer(name)
	return renderers[name]
end

-- layouts

local layouts = {}

function citygen.register_layout(name, def)
	assert(type(def.type) == "string", "layout_def.type must be a string")
	assert(type(def.order) == "number", "layout_def.order must be a number")
	assert(type(def.layout) == "function", "layout_def.layout must be a function")

	def.name = name
	layouts[name] = def
end

function citygen.get_layout(name)
	return layouts[name]
end

function citygen.get_layouts()
	return layouts
end