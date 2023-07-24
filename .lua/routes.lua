local fm = require "fullmoon"

fm.setRoute("", fm.servePath("/index.lua"))

fm.setRoute("/news", fm.serveResponse(286))

fm.setRoute("/todo", fm.servePath("/todo.lua"))
