#define _POSIX_C_SOURCE 199309L

#include <errno.h>
#include <lauxlib.h>
#include <lua.h>
#include <lualib.h>
#include <string.h>
#include <time.h>

#define NSEC_MIN 0L
#define NSEC_MAX 999999999L

static void push_timespec(lua_State *L, const struct timespec *ts) {
  lua_newtable(L);

  lua_pushstring(L, "tv_sec");
  lua_pushinteger(L, ts->tv_sec);
  lua_settable(L, -3);

  lua_pushstring(L, "tv_nsec");
  lua_pushinteger(L, ts->tv_nsec);
  lua_settable(L, -3);
}

static int l_nanosleep(lua_State *L) {
  luaL_checktype(L, 1, LUA_TTABLE);

  struct timespec rm;
  struct timespec ts;

  lua_getfield(L, 1, "tv_sec");
  ts.tv_sec = (time_t)luaL_checkinteger(L, -1);
  lua_pop(L, 1);

  lua_getfield(L, 1, "tv_nsec");
  ts.tv_nsec = (long)luaL_checkinteger(L, -1);
  if (ts.tv_nsec < NSEC_MIN || ts.tv_nsec >= NSEC_MAX) {
    lua_pushfstring(L, "tv_nsec must be in [%d, %d]", NSEC_MIN, NSEC_MAX);
    return lua_error(L);
  }
  lua_pop(L, 1);

  if (nanosleep(&ts, &rm) != 0) {
    push_timespec(L, &rm);
    lua_pushstring(L, strerror(errno));
    lua_pushinteger(L, errno);
    return 3;
  }

  lua_pushinteger(L, 0);
  return 1;
}

int luaopen_nsleep(lua_State *L) {
  lua_pushcfunction(L, l_nanosleep);
  return 1;
}