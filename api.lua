
citygen.buildings = {}

function citygen.register_building(def)
	assert(def.name)
	citygen.buildings[def.name] = def
end
