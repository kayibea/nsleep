rockspec_format ="3.0"
package = "nsleep"
version = "0.1.0-1"
source = {
  url = "git://github.com/kayibea/nsleep.git"
}
description = {
  summary = "A Lua C module that provides direct access to the POSIX `nanosleep()` syscall",
  detailed = "A Lua C module that provides direct access to the POSIX `nanosleep()` syscall",
  homepage = "https://github.com/kayibea/nsleep",
  issues_url = "https://github.com/kayibea/nsleep/issues",
  license = "MIT",
  labels = {
    "lua",
    "sleep",
    "nanosleep",
    "time",
    "timespec"
  }
}
supported_platforms = {
  "linux"
}
dependencies = {
  "lua >= 5.1"
}
test_dependencies = {
  "busted >= 2.2.0-1",
  "luaposix >= 36.3-1"
}
build = {
  type = "builtin",
  modules = {
    nsleep = {
      sources = "nsleep.c"
    }
  }
}
