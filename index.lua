local fennel = require "fennel"
local html = Write

html [[
  <!doctype html>
  <html lang='en-us'>
  <head>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <script src='https://unpkg.com/htmx.org@1.9.3'></script>
    <script src='https://unpkg.com/hyperscript.org@0.9.9'></script>
    <script src='https://cdn.jsdelivr.net/npm/scittle@0.6.15/dist/scittle.js' type='application/javascript'></script>
    <script src='asset/script.cljs' type='application/x-scittle'></script>
  </head>
  <body>
]]

fennel.dofile "todo.fnl"

html "</body></html>"
