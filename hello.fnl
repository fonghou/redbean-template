(local clj (require :cljlib))
(local html (require :html))

;; (import-macros {: dbg} :macros.dbg)

(when (< 0 (DB:exec
  "
  CREATE TABLE test (
    id INTEGER PRIMARY KEY,
    content TEXT
  );
  INSERT INTO test (content) VALUES ('Hello World');
  INSERT INTO test (content) VALUES ('Hello Lua');
  INSERT INTO test (content) VALUES ('Hello Sqlite3');
  "))
  (error (.. "can't create tables: " (DB:errmsg))))

(each [row (DB:nrows "SELECT * FROM test")]
  (print (.. row.id ". " row.content "\n")))

(H.setRoute (H.GET "/status403") H.serve403)

(H.setTemplate :hello "Hello, {%& name %}")
(H.setRoute "/hello/:name"
  (fn [r]
    (dbg)
    (H.serveContent
      :hello
      {:name r.params.name})))
