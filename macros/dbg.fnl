(fn dbg []
  (if (os.getenv "DEBUG")
    `(let [dbg# (require :debugger)]
       (dbg#))
    `(do)))

{: dbg}
