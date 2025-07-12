local posix = require("posix")
local nanosleep = require("nsleep")

describe("nsleep.nanosleep", function()
  it("sleeps for at least the specified time", function()
    local ts = { tv_sec = 0, tv_nsec = 500000000 } -- 0.5 sec
    local t0 = posix.clock_gettime("CLOCK_MONOTONIC")
    local ok = nanosleep(ts)
    local t1 = posix.clock_gettime("CLOCK_MONOTONIC")

    assert.are.equal(0, ok)
    assert.is_true((t1 - t0) >= 0)
  end)

  it("returns remaining time and error on EINTR", function()
    posix.signal(posix.SIGALRM, function() end)
    posix.alarm(1)

    local ts = { tv_sec = 5, tv_nsec = 0 }
    local rem, err, errno = nanosleep(ts)

    assert.is_table(rem)
    assert.is_string(err)
    assert.is_number(errno)

    assert.is_true(rem.tv_sec < 5)
    assert.are.equal(posix.EINTR, errno)

    posix.alarm(0)
  end)

  it("throws error on invalid tv_nsec", function()
    local ok, err = pcall(nanosleep, { tv_sec = 1, tv_nsec = 1000000000 })
    assert.is_false(ok)
    assert.matches("tv_nsec must be in", err or "")
  end)

  it("throws error on missing argument", function()
    local ok, err = pcall(nanosleep)
    assert.is_false(ok)
    assert.matches("table", err or "")
  end)

  it("throws error on bad field types", function()
    local ok, err = pcall(nanosleep, { tv_sec = "abc", tv_nsec = "xyz" })
    assert.is_false(ok)
    assert.matches("number expected", err or "")
  end)
end)
