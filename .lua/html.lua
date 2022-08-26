local entity_replacements = {["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;"}
local void_tags = {area = true, base = true, br = true, col = true, command = true, embed = true, hr = true, img = true, input = true, keygen = true, link = true, meta = true, param = true, source = true, track = true, wbr = true}
local function void_tag_3f(tag_name)
  return void_tags[tag_name]
end
local entity_search
local function _1_(...)
  local tbl_15_auto = {}
  local i_16_auto = #tbl_15_auto
  for k in pairs(entity_replacements) do
    local val_17_auto = k
    if (nil ~= val_17_auto) then
      i_16_auto = (i_16_auto + 1)
      do end (tbl_15_auto)[i_16_auto] = val_17_auto
    else
    end
  end
  return tbl_15_auto
end
entity_search = ("[" .. table.concat(_1_(...)) .. "]")
local function escape(s)
  assert((type(s) == "string"))
  return s:gsub(entity_search, entity_replacements)
end
local function tag(tag_name, attrs)
  assert((type(attrs) == "table"), ("Missing attrs table: " .. tag_name))
  local attr_str
  local _3_
  do
    local tbl_15_auto = {}
    local i_16_auto = #tbl_15_auto
    for k, v in pairs(attrs) do
      local val_17_auto
      if (v == true) then
        val_17_auto = k
      else
        val_17_auto = (k .. "=\"" .. v .. "\"")
      end
      if (nil ~= val_17_auto) then
        i_16_auto = (i_16_auto + 1)
        do end (tbl_15_auto)[i_16_auto] = val_17_auto
      else
      end
    end
    _3_ = tbl_15_auto
  end
  attr_str = table.concat(_3_, " ")
  return ("<" .. tag_name .. " " .. attr_str .. ">")
end
local function html(document, allow_no_escape_3f)
  if (type(document) == "string") then
    return escape(document)
  elseif (allow_no_escape_3f and (document[1] == "NO-ESCAPE")) then
    return document[2]
  else
    local _let_6_ = document
    local tag_name = _let_6_[1]
    local attrs = _let_6_[2]
    local body = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_let_6_, 3)
    if void_tag_3f(tag_name) then
      return tag(tag_name, attrs)
    else
      local _7_
      do
        local tbl_15_auto = {}
        local i_16_auto = #tbl_15_auto
        for _, element in ipairs(body) do
          local val_17_auto = html(element, allow_no_escape_3f)
          if (nil ~= val_17_auto) then
            i_16_auto = (i_16_auto + 1)
            do end (tbl_15_auto)[i_16_auto] = val_17_auto
          else
          end
        end
        _7_ = tbl_15_auto
      end
      return (tag(tag_name, attrs) .. table.concat(_7_, " ") .. "</" .. tag_name .. ">")
    end
  end
end
return html
