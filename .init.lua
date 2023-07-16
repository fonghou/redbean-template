-- setup fennel
local fennel = require("fennel")
local path = require("path")

local make_searcher = function(env)
  return function(module_name)
    local mod_path = module_name:gsub("%.", "/") .. ".fnl"
    if path.exists(".lua/" .. mod_path) then
      mod_path = ".lua/" .. mod_path
    else
      mod_path = "/zip/.lua/" .. mod_path
    end
    return function(...)
      return fennel.dofile(mod_path, { env = env, correlate = true }, ...)
    end, mod_path
  end
end

table.insert(package.searchers, make_searcher(_G))
table.insert(fennel["macro-searchers"], make_searcher("_COMPILER"))
debug.traceback = fennel.traceback

-- setup debugger
if os.getenv("DEBUG") then
  local dbg = require("debugger")
  _G.dbg = dbg
  _G.error = dbg.error
  _G.assert = dbg.assert
else
  _G.dbg = function() end
end

-- setup SQLite3 db
local sqlite3 = require("lsqlite3")

function ConnectDb()
  if not Db then
    Db = sqlite3.open("db/sqlite3")
    Db:busy_timeout(1000)
    Db:exec("PRAGMA journal_mode=WAL")
    Db:exec("PRAGMA synchronous=NORMAL")
  end
  return Db
end

-- TiddlyWiki
WIKI_PATH = "wiki.html"

if GetHostOs() == "WINDOWS" then
  -- Write the embeded html file to disk.
  local there = path.isfile(WIKI_PATH)
  if not there then
    assert(Barf(WIKI_PATH, Slurp("/zip/wiki.html")))
  end
  -- serve from disc rather than embeded asset. Same as -D
  ProgramDirectory(".")
end

-- Large enough to send entire wiki file
ProgramMaxPayloadSize(2 * GetAssetSize(WIKI_PATH))

ProgramCache(0)

-- fullmoon routes
local fm = require("fullmoon")

fm.setTemplate({ "/tmpl/", html = "fmt", lua = "fmg" })

fm.setRoute("/*.lua", function(req)
  local file = req.params.splat .. ".fnl"
  if path.exists(file) then
    fennel.dofile(file)
    return true
  end
  return false
end)

fm.setRoute("/*catchall", fm.servePath)

fm.run()
