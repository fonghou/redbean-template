(fn dbg []
  (if (os.getenv "DEBUG")
    `((require :debugger))
    `(do)))

{: dbg}
