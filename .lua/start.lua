-- fullmoon routes
local fm = require "fullmoon"

local db = fm.makeStorage("db/api.db")
db:execute "PRAGMA journal_mode=WAL"
db:execute "PRAGMA synchronous=NORMAL"

require "routes"
require "views"

fm.setRoute("/*.lua", function(req)
  Dofile(req.params.splat)
  return true
end)

fm.setRoute("/*catchall", fm.servePath)

fm.setTemplate({ "/tmpl/", html = "fmt" })

fm.run()
