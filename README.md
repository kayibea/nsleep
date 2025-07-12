# nsleep

A Lua C module that provides direct access to the POSIX `nanosleep()` syscall

## API

### `nsleep(timespec)`

Sleeps for the duration specified by a `timespec` table.

#### Parameters

- `timespec` — a table with the following fields:
  - `tv_sec` (integer): seconds
  - `tv_nsec` (integer): nanoseconds (must be in range `[0, 999999999]`)

#### Returns

- `0` on success
- On interruption or failure:  
  - `timespec`: remaining time  
  - `errmsg`: string from `strerror(errno)`  
  - `errno`: integer error code

#### Example

```lua
local nsleep = require("nsleep")

local ret, err, errnum = nsleep({ tv_sec = 1, tv_nsec = 500000000 }) -- 1.5 seconds
if ret == 0 then
  print("slept successfully")
else
  print("sleep interrupted or failed:", err, errnum)
  print("remaining:", ret.tv_sec, ret.tv_nsec)
end
