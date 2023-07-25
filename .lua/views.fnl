(local fm (require :fullmoon))
(import-macros {: *kv} :macros)

(fm.setRoute
  "/view"
  (fm.serveContent :fmg
    [(*kv :h1 "Welcome!")
     (*kv :div & :a 1 
          (*kv :p & :checked true "text"))])) 
