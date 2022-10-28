(local html (require :html))

(fn index []
  (html [:html {:lang "en"}
         [:body {}
          [:h1 {} "Welcome!"]]]))

(Write (index))
