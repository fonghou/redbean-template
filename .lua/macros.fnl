;; fennel-ls: macro-file
;; [nfnl-macro]

(fn *args [...]
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


(comment

  (macro while-let [bindings ...]
    (assert-compile (sequence? bindings)
      "expected binding sequence" bindings)
    (assert-compile (= 0 (% (length bindings) 2))
      "expected even number of name/value bindings" bindings)
    (let [[binding expr] bindings
          body (fcollect [i 3 (length bindings) 2 :into '(do (var ,binding ,expr))]
                `(var ,(. bindings i)
                      (and ,(. bindings (- i 2)) ,(. bindings (+ i 1)))))
          sets (fcollect [i 3 (length bindings) 2 :into '(do (set ,binding ,expr))]
                `(set ,(. bindings i)
                      (and ,(. bindings (- i 2)) ,(. bindings (+ i 1)))))]
      (doto body
        (table.insert
          `(while ,(. bindings (- (length bindings) 1))
              (do ,...)
              ,sets)))))

  (macrodebug
    (while-let [x (> (math.random 100) 50)
                y (> (math.random 100) 50)]
      ;; x AND y are true
      (print :x x)
      (print :y y)))

  'comment)

(fn while-let [bindings ...]
  (assert-compile (sequence? bindings)
   "expected binding sequence" bindings)
  (assert-compile (= 0 (% (length bindings) 2))
   "expected even number of name/value bindings" bindings)
  (let [[binding expr] bindings
        body (fcollect [i 3 (length bindings) 2 :into '(do (var ,binding ,expr))]
               `(var ,(. bindings i)
                     (and ,(. bindings (- i 2)) ,(. bindings (+ i 1)))))
        sets (fcollect [i 3 (length bindings) 2 :into '(do (set ,binding ,expr))]
               `(set ,(. bindings i)
                     (and ,(. bindings (- i 2)) ,(. bindings (+ i 1)))))
        protect (fcollect [i 1 (length bindings)]
                  (. bindings (if (= 0 (% i 2)) (- i 1) i)))]
    (doto body
      (table.insert
       `(while ,(. bindings (- (length bindings) 1))
          (let ,protect ,...)
          ,sets)))))

{: *args
 : while-let}
