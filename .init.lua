local dbg = require "debugger"

if os.getenv("DEBUG") then
  _G.dbg = dbg
  _G.error = dbg.error
  _G.assert = dbg.assert
else
  _G.dbg = function() end
end

DB = require("lsqlite3").open_memory()

H = require "fullmoon"

require 'hello'

H.run()
