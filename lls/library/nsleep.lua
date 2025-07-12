---@meta

---Represents a time value with seconds and nanoseconds.
---@class timespec
---@field tv_sec integer # Number of seconds
---@field tv_nsec integer # Number of nanoseconds (must be in range [0, 999999999])

---Sleeps for the specified amount of time.
---
---Returns:
---* `0` — if sleep completed successfully.
---* `timespec, errmsg, errno` — if sleep was interrupted or failed.
---
---Note:
---* `errmsg` and `errno` are always returned if the function does not return `0`.
---* `timespec` contains the remaining time (from `nanosleep`) if interrupted.
---
---Example:
---```lua
---local duration = { tv_sec = 1, tv_nsec = 500000000 } -- 1.5 seconds
---local ret, err, errnum = nsleep(duration)
---if ret == 0 then
---    print("Slept successfully")
---else
---    print(string.format("Interrupted or failed, remaining: %d sec %d nsec", ret.tv_sec, ret.tv_nsec))
---    print("Error:", err, errnum)
---end
---```
---
---@param ts timespec The requested sleep time.
---@return integer|timespec # 0 on success; timespec (remaining time) if interrupted or failed.
---@return string? errmsg     # Error message (always set if return is not 0).
---@return integer? errno     # Error number (always set if return is not 0).
local function nsleep(ts) end

return nsleep
