(local {: Seq : Set} (require :batteries))
(local html (require :html))
(local pp (fn [t] (print ((require :fennel.view) t))))
(import-macros {: args} :macros)

(local dbm (H.makeStorage "db/sqlite3"))

(H.setRoute (H.GET "/status403") H.serve403)

(fn hello-html [r]
  (dbg)
  (html [:html {:lang "en"}
         [:body {}
          [:h1 {} (string.format "Hello, %s!" r.name)]]]))

(H.setTemplate :hello hello-html)
;; (H.setTemplate :hello "<h3>Welcome {%& name %}!</h3>")

(H.setRoute "/hello/:name"
  (fn [r]
    (H.serveContent
      :hello
      {:name r.params.name})))

(comment

  (icollect [row (dbm:nrows "SELECT * FROM test")] row.content)

  (pp (args 10 20 30 & :a "a"))

  'comment)
