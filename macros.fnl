;; fennel-ls: macro-file
;; [nfnl-macro]

(fn *kv [...]
  (let [args [...]
        t {}]
    (var j 0)
    (each [i x (ipairs args) &until (= x '&)]
      (set j i)
      (table.insert t x))
    (var k 0)
    (for [i (+ j 2) (length args) 2]
      (set k i)
      (tset t (. args i) (. args (+ i 1))))
    (when (= k (length args))
      (table.insert t (. args k)))
    t))
  
{: *kv}
