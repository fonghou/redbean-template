(set package.path (.. package.path ";.lua/?.lua;.lua/?/init.lua"))

{:fennel-path "./?.fnl;.lua/?.fnl;"
 :fennel-macro-path "./?.fnl;.lua/?.fnl"
 :source-file-patterns ["*.fnl" ".lua/*.fnl"]}

(print "loaded .nfnl.fnl")
