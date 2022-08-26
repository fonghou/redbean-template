local clj = require("cljlib")
local html = require("html")
local dbg = require("debugger")
for row in DB:nrows("SELECT * FROM test") do
  print((row.id .. ". " .. row.content .. "\n"))
end
H.setTemplate("hello", "Hello, {%& name %}")
local function _1_(r)
  dbg()
  return H.serveContent("hello", {name = r.params.name})
end
return H.setRoute("/hello/:name", _1_)
