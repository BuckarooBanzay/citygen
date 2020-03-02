
minetest.log("warning", "[TEST] integration-test enabled!")

local function shutdown_success()
	local data = minetest.write_json({ success = true }, true);
	local file = io.open(minetest.get_worldpath().."/integration_test.json", "w" );
	if file then
		file:write(data)
		file:close()
	end

	minetest.log("warning", "[TEST] integration tests done!")
	minetest.request_shutdown("success")
end

minetest.after(1, function()
	minetest.emerge_area(
		{x=-100, y=-100, z=-100},
		{x=100, y=100, z=100},
		function(_, _, calls_remaining)
		if calls_remaining == 0 then
			shutdown_success()
		end
	end)
end)
