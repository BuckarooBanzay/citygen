minetest.register_chatcommand("cityblock", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "player not found"
		end

		local pos = player:get_pos()

		local mapblock_pos = mapblock_lib.get_mapblock(pos)
		local cityblock_data = citygen.get_cityblock(mapblock_pos)
		print(dump(cityblock_data))

		return true
	end
})

minetest.register_chatcommand("cityblock_mapblock", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "player not found"
		end

		local pos = player:get_pos()

		local mapblock_pos = mapblock_lib.get_mapblock(pos)
		local cityblock_data = citygen.get_cityblock_mapblock(mapblock_pos)

		return true, dump(cityblock_data)
	end
})
