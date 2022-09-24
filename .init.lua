local fennel = require("fennel")
local path = require("path")

local make_searcher = function(env)
  return function(module_name)
    local mod_path = module_name:gsub("%.", "/") .. ".fnl"
    if path.exists('src/' .. mod_path) then
      mod_path = 'src/' .. mod_path
    else
      mod_path = '/zip/.lua/' .. mod_path
    end
    return function(...)
      return fennel.dofile(mod_path, { env = env, correlate = true }, ...)
    end, mod_path
  end
end

table.insert(package.loaders or package.searchers, make_searcher(_G))
table.insert(fennel["macro-searchers"], make_searcher(_G))

if os.getenv("DEBUG") then
  local dbg = require "debugger"
  _G.dbg = dbg
  _G.error = dbg.error
  _G.assert = dbg.assert
else
  _G.dbg = function() end
end

DB = require("lsqlite3").open_memory()
H = require "fullmoon"

require 'hello'

H.setRoute("/*catchall", H.servePath)

H.run()
