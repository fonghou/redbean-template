(local clj (require :cljlib))
(local html (require :html))
(local dbg (require :debugger))

(each [row (DB:nrows "SELECT * FROM test")]
  (print (.. row.id ". " row.content "\n")))

(H.setTemplate :hello "Hello, {%& name %}")

(H.setRoute "/hello/:name"
  (fn [r]
    (dbg)
    (H.serveContent
      :hello 
      {:name r.params.name})))

