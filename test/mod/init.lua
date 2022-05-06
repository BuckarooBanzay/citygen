local pos1 = vector.new(0,0,0)
local pos2 = vector.new(90,30,90)

local jobs = {}

local MP = minetest.get_modpath("citygen_test")
table.insert(jobs, loadfile(MP .. "/perlin_manager.lua")())
table.insert(jobs, loadfile(MP .. "/util.lua")())
table.insert(jobs, loadfile(MP .. "/prepare_world.lua")(pos1, pos2))

local job_index = 1

local function worker()
  local job = jobs[job_index]
  if not job then
    -- exit gracefully
    minetest.request_shutdown("success")
    return
  end

  job(function()
    job_index = job_index + 1
    minetest.after(0, worker)
  end)
end

minetest.log("warning", "[TEST] integration-test enabled!")
minetest.register_on_mods_loaded(function()
  -- defer emerging until stuff is settled
  minetest.after(1, worker)
end)
