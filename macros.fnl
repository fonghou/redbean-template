(fn *kv* [...]
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
      (let [last (. args k)]
        (if (sequence? last)
          (each [_ x (ipairs last)] (table.insert t x))
          (table.insert t last))))
    t))
  
{: *kv*}
