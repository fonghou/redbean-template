H = require "fullmoon"

H.setTemplate("welcome", "Welcome Hou {%& name %}!")

H.setRoute("/welcome/:name", function(r)
    return H.serveContent("welcome", {name = r.params.name})
  end)

H.run()
