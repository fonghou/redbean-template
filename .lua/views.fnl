(import-macros {: *kv} :macros)
(local fm (require :fullmoon))
((require :batteries))

(fm.setRoute "/view"
  (fm.serveContent :fmg
    [[:doctype]
     [:html
       [:body [:ol [:li {:id 1} "one"]
                   [:li {:id 2} "two"]]]]]))

(fm.setRoute (*kv "/hello(/:name)" & :method [:GET :POST])
  (fn [r] (.. "Hello, " (or r.params.name "World!"))))

(fm.setRoute "/json" (fm.serveContent :test))

(local {:append </>} table)

(fn todo-html [todos]
  [(</> [:ol] (icollect [i v (ipairs todos)]
                [:li {:id i} v.task]))])

{: todo-html}
