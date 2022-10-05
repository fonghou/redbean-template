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

local fnl_searcher = make_searcher(_G)
table.insert(package.searchers, fnl_searcher)
table.insert(fennel["macro-searchers"], fnl_searcher)
debug.traceback = fennel.traceback

if os.getenv("DEBUG") then
  local dbg = require "debugger"
  _G.dbg = dbg
  _G.error = dbg.error
  _G.assert = dbg.assert
else
  _G.dbg = function() end
end

local sqlite3 = require("lsqlite3")

function ConnectDb()
  if not Db then
    Db = sqlite3.open("db/sqlite3")
    Db:busy_timeout(1000)
    Db:exec[[PRAGMA journal_mode=WAL]]
    Db:exec[[PRAGMA synchronous=NORMAL]]
    Db:exec[[select count(*) from test]]
  end
  return Db
end

H = require "fullmoon"

require 'hello'

H.setRoute("/*catchall", H.servePath)

H.run()
