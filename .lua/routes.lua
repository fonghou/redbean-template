local fm = require "fullmoon"

fm.setRoute("/", fm.servePath("/index.lua"))

fm.setRoute("/todos", fm.servePath("/todo.lua"))

fm.setRoute("/contacts", fm.serveContent("contacts"))
