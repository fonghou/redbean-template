-- [nfnl] Compiled from .lua/views.fnl by https://github.com/Olical/nfnl, do not edit.
local fm = require("fullmoon")
require("batteries")()
fm.setRoute("/view", fm.serveContent("fmg", {{"doctype"}, {"html", {"body", {"ol", {"li", {id = 1}, "one"}, {"li", {id = 2}, "two"}}}}}))
local function _1_(r)
  return ("Hello, " .. (r.params.name or "World!"))
end
fm.setRoute({"/hello(/:name)", method = {"GET", "POST"}}, _1_)
fm.setRoute("/json", fm.serveContent("test"))
local _local_2_ = table
local _3c_2f_3e = _local_2_["append"]
local function todo_html(todos)
  local function _3_()
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for i, v in ipairs(todos) do
      local val_19_auto = {"li", {id = i}, v.task}
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    return tbl_17_auto
  end
  return {_3c_2f_3e({"ol"}, _3_())}
end
return {["todo-html"] = todo_html}
