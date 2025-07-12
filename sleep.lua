local nsleep = require "nsleep"

local NSEC_PER_SEC = 1e9
local USEC_PER_SEC = 1e6
local MSEC_PER_SEC = 1e3

---Sleeps for the given number of microseconds.
---@param usec integer Number of microseconds to sleep.
local function sleepmc(usec)
  local sec = math.floor(usec / USEC_PER_SEC)
  local nsec = (usec % USEC_PER_SEC) * 1e3
  return nsleep({ tv_sec = sec, tv_nsec = nsec })
end

---Sleeps for the given number of milliseconds.
---@param msec integer Number of milliseconds to sleep.
local function sleepms(msec)
  local sec = math.floor(msec / MSEC_PER_SEC)
  local nsec = (msec % MSEC_PER_SEC) * 1e6
  return nsleep({ tv_sec = sec, tv_nsec = nsec })
end

---Sleeps for the given number of seconds (can be fractional).
---@param sec number Number of seconds to sleep.
local function sleepsec(sec)
  local int_sec = math.floor(sec)
  local frac = sec - int_sec
  local nsec = math.floor(frac * NSEC_PER_SEC)
  return nsleep({ tv_sec = int_sec, tv_nsec = nsec })
end


return {
  sleepmc = sleepmc,
  sleepms = sleepms,
  sleepsec = sleepsec,
}
