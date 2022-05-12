-- name -> fn(mapblock_pos, data)
local renderers = {}

function citygen.register_renderer(name, fn)
    renderers[name] = fn
end

function citygen.get_renderer(name)
    return renderers[name]
end