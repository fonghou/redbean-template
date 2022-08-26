
DB = require("lsqlite3").open_memory()

if DB:exec [[
  CREATE TABLE test (
    id INTEGER PRIMARY KEY,
    content TEXT
  );
  INSERT INTO test (content) VALUES ('Hello World');
  INSERT INTO test (content) VALUES ('Hello Lua');
  INSERT INTO test (content) VALUES ('Hello Sqlite3');
]] > 0 then
  error("can't create tables: "..DB:errmsg())
end

H = require "fullmoon"

require 'hello'

H.run()
