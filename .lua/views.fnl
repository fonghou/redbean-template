(local fm (require :fullmoon))
(import-macros {: *kv*} :macros)

(fm.setRoute "/view"
  (fn [r]
    (fm.serveContent :fmg
      [(*kv* :h2 "Welome")
       (*kv* :div & :a 42
         (*kv* :p & :checked true
           ["Hello," r.headers.HX-Prompt "!"]))])))
