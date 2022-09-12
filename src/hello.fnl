(local html (require :html))

(DB:exec
  "
  CREATE TABLE test (
    id INTEGER PRIMARY KEY,
    content TEXT
  );
  INSERT INTO test (content) VALUES ('Hello World');
  INSERT INTO test (content) VALUES ('Hello Lua');
  INSERT INTO test (content) VALUES ('Hello Sqlite3');
  ")

(H.setRoute (H.GET "/status403") H.serve403)

(H.setTemplate :hello "<h3>Welcome {%& name %}!</h3>")

(H.setRoute "/hello/:name"
  (fn [r]
    (dbg)
    (H.serveContent
      :hello
      {:name r.params.name})))
