;; A *very* basic HTML generation library.
;; Basic escaping features only; never use this on user input!

(local entity-replacements {"&" "&amp;" ; must be first!
                            "<" "&lt;"
                            ">" "&gt;"
                            "\"" "&quot;"})

(local void-tags {:area    true
                  :base    true
                  :br      true
                  :col     true
                  :command true
                  :embed   true
                  :hr      true
                  :img     true
                  :input   true
                  :keygen  true
                  :link    true
                  :meta    true
                  :param   true
                  :source  true
                  :track   true
                  :wbr     true})

(fn void-tag? [tag-name]
  (. void-tags tag-name))

(local entity-search
       (.. "[" (table.concat (icollect [k (pairs entity-replacements)] k)) "]"))

(fn escape [s]
  (assert (= (type s) :string))
  (s:gsub entity-search entity-replacements))

(fn tag [tag-name attrs]
  (assert (= (type attrs) "table") (.. "Missing attrs table: " tag-name))
  (let [attr-str (table.concat (icollect [k v (pairs attrs)]
                                 (if (= v true) k
                                     (.. k "=\"" v"\""))) " ")]
    (.. "<" tag-name " " attr-str">")))

(fn html [document allow-no-escape?]
  (if (= (type document) :string)
      (escape document)
      (and allow-no-escape? (= (. document 1) :NO-ESCAPE))
      (. document 2)
      (let [[tag-name attrs & body] document]
        (if (void-tag? tag-name)
            (tag tag-name attrs)
            (.. (tag tag-name attrs)
                (table.concat (icollect [_ element (ipairs body)]
                                (html element allow-no-escape?)) " ")
                "</" tag-name ">")))))
