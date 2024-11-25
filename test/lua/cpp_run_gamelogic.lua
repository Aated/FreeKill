-- Run tests with `ctest`
-- 本测试加载并运行和游戏逻辑有关的测试。
-- 测试途中应保证：
-- * 不能让房间切出，房间只能以gameOver形式结束运行。
-- * 也就是说，要屏蔽掉__handleRequest型的yield。

---@diagnostic disable: lowercase-global

__package.path = __package.path .. ";./test/lua/lib/?.lua"

fk.os = __os
fk.io = __io
lu = require('luaunit')

dofile 'test/lua/server/gameevent.lua'

fk.os.exit( lu.LuaUnit.run() )