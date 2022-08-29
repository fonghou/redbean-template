local html = require("html")
if (0 < DB:exec("\n  CREATE TABLE test (\n    id INTEGER PRIMARY KEY,\n    content TEXT\n  );\n  INSERT INTO test (content) VALUES ('Hello World');\n  INSERT INTO test (content) VALUES ('Hello Lua');\n  INSERT INTO test (content) VALUES ('Hello Sqlite3');\n  ")) then
  error(("can't create tables: " .. DB:errmsg()))
else
end
for row in DB:nrows("SELECT * FROM test") do
  print((row.id .. ". " .. row.content .. "\n"))
end
H.setRoute(H.GET("/status403"), H.serve403)
H.setTemplate("hello", "Hello, {%& name %}")
local function _2_(r)
  dbg()
  return H.serveContent("hello", {name = r.params.name})
end
return H.setRoute("/hello/:name", _2_)
