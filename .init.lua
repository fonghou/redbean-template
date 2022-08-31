if os.getenv("DEBUG") then
  local dbg = require "debugger"
  _G.dbg = dbg
  _G.error = dbg.error
  _G.assert = dbg.assert
else
  _G.dbg = function() end
end

require'batteries':export()

DB = require("lsqlite3").open_memory()

H = require "fullmoon"

require 'hello'

H.setRoute("/*catchall", H.servePath)

H.run()
