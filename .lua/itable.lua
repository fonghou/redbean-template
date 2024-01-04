-- [nfnl] Compiled from .lua/itable.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = table
local t_2fsort = _local_1_["sort"]
local t_2fconcat = _local_1_["concat"]
local t_2fremove = _local_1_["remove"]
local t_2fmove = _local_1_["move"]
local t_2finsert = _local_1_["insert"]
local t_2funpack = (table.unpack or _G.unpack)
local t_2fpack
local function _2_(...)
  local _3_ = {...}
  _3_["n"] = select("#", ...)
  return _3_
end
t_2fpack = _2_
local function pairs_2a(t)
  local _5_
  do
    local _4_ = getmetatable(t)
    if ((_G.type(_4_) == "table") and (nil ~= (_4_).__pairs)) then
      local p = (_4_).__pairs
      _5_ = p
    elseif true then
      local _ = _4_
      _5_ = pairs
    else
      _5_ = nil
    end
  end
  return _5_(t)
end
local function ipairs_2a(t)
  local _10_
  do
    local _9_ = getmetatable(t)
    if ((_G.type(_9_) == "table") and (nil ~= (_9_).__ipairs)) then
      local i = (_9_).__ipairs
      _10_ = i
    elseif true then
      local _ = _9_
      _10_ = ipairs
    else
      _10_ = nil
    end
  end
  return _10_(t)
end
local function length_2a(t)
  local _15_
  do
    local _14_ = getmetatable(t)
    if ((_G.type(_14_) == "table") and (nil ~= (_14_).__len)) then
      local l = (_14_).__len
      _15_ = l
    elseif true then
      local _ = _14_
      local function _18_(...)
        return #...
      end
      _15_ = _18_
    else
      _15_ = nil
    end
  end
  return _15_(t)
end
local function copy(t)
  if t then
    local tbl_14_auto = {}
    for k, v in pairs_2a(t) do
      local k_15_auto, v_16_auto = k, v
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    return tbl_14_auto
  else
    return nil
  end
end
local function eq(...)
  local _22_, _23_, _24_ = select("#", ...), ...
  if ((_22_ == 0) or (_22_ == 1)) then
    return true
  elseif ((_22_ == 2) and true and true) then
    local _3fa = _23_
    local _3fb = _24_
    if (_3fa == _3fb) then
      return true
    elseif (function(_25_,_26_,_27_) return (_25_ == _26_) and (_26_ == _27_) end)(type(_3fa),type(_3fb),"table") then
      local res, count_a, count_b = true, 0, 0
      for k, v in pairs_2a(_3fa) do
        if not res then break end
        local function _28_(...)
          local res0 = nil
          for k_2a, v0 in pairs_2a(_3fb) do
            if res0 then break end
            if eq(k_2a, k) then
              res0 = v0
            else
            end
          end
          return res0
        end
        res = eq(v, _28_(...))
        count_a = (count_a + 1)
      end
      if res then
        for _, _0 in pairs_2a(_3fb) do
          count_b = (count_b + 1)
        end
        res = (count_a == count_b)
      else
      end
      return res
    else
      return false
    end
  elseif (true and true and true) then
    local _ = _22_
    local _3fa = _23_
    local _3fb = _24_
    return (eq(_3fa, _3fb) and eq(select(2, ...)))
  else
    return nil
  end
end
local function deep_index(tbl, key)
  local res = nil
  for k, v in pairs_2a(tbl) do
    if res then break end
    if eq(k, key) then
      res = v
    else
      res = nil
    end
  end
  return res
end
local function deep_newindex(tbl, key, val)
  local done = false
  if ("table" == type(key)) then
    for k, _ in pairs_2a(tbl) do
      if done then break end
      if eq(k, key) then
        rawset(tbl, k, val)
        done = true
      else
      end
    end
  else
  end
  if not done then
    return rawset(tbl, key, val)
  else
    return nil
  end
end
local function immutable(t, opts)
  local t0
  if (opts and opts["fast-index?"]) then
    t0 = t
  else
    t0 = setmetatable(t, {__index = deep_index, __newindex = deep_newindex})
  end
  local len = length_2a(t0)
  local proxy = {}
  local __len
  local function _38_()
    return len
  end
  __len = _38_
  local __index
  local function _39_(_241, _242)
    return (t0)[_242]
  end
  __index = _39_
  local __newindex
  local function _40_()
    return error((tostring(proxy) .. " is immutable"), 2)
  end
  __newindex = _40_
  local __pairs
  local function _41_()
    local function _42_(_, k)
      return next(t0, k)
    end
    return _42_, nil, nil
  end
  __pairs = _41_
  local __ipairs
  local function _43_()
    local function _44_(_, k)
      return next(t0, k)
    end
    return _44_
  end
  __ipairs = _43_
  local __call
  local function _45_(_241, _242)
    return (t0)[_242]
  end
  __call = _45_
  local __fennelview
  local function _46_(_241, _242, _243, _244)
    return _242(t0, _243, _244)
  end
  __fennelview = _46_
  local __fennelrest
  local function _47_(_241, _242)
    return immutable({t_2funpack(t0, _242)})
  end
  __fennelrest = _47_
  return setmetatable(proxy, {__index = __index, __newindex = __newindex, __len = __len, __pairs = __pairs, __ipairs = __ipairs, __call = __call, __metatable = {__len = __len, __pairs = __pairs, __ipairs = __ipairs, __call = __call, __fennelrest = __fennelrest, __fennelview = __fennelview, ["itable/type"] = "immutable"}})
end
local function insert(t, ...)
  local t0 = copy(t)
  do
    local _48_, _49_, _50_ = select("#", ...), ...
    if (_48_ == 0) then
      error("wrong number of arguments to 'insert'")
    elseif ((_48_ == 1) and true) then
      local _3fv = _49_
      t_2finsert(t0, _3fv)
    elseif (true and true and true) then
      local _ = _48_
      local _3fk = _49_
      local _3fv = _50_
      t_2finsert(t0, _3fk, _3fv)
    else
    end
  end
  return immutable(t0)
end
local move
if t_2fmove then
  local function _52_(src, start, _end, tgt, dest)
    local src0 = copy(src)
    local dest0 = copy(dest)
    return immutable(t_2fmove(src0, start, _end, tgt, dest0))
  end
  move = _52_
else
  move = nil
end
local function pack(...)
  local function _55_(...)
    local _54_ = {...}
    _54_["n"] = select("#", ...)
    return _54_
  end
  return immutable(_55_(...))
end
local function remove(t, key)
  local t0 = copy(t)
  local v = t_2fremove(t0, key)
  return immutable(t0), v
end
local function concat(t, sep, start, _end, serializer, opts)
  local serializer0 = (serializer or tostring)
  local _56_
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for _, v in ipairs_2a(t) do
      local val_19_auto = serializer0(v, opts)
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    _56_ = tbl_17_auto
  end
  return t_2fconcat(_56_, sep, start, _end)
end
local function unpack(t, ...)
  return t_2funpack(copy(t), ...)
end
local function assoc(t, key, val, ...)
  local len = select("#", ...)
  if (0 ~= (len % 2)) then
    error(("no value supplied for key " .. tostring(select(len, ...))), 2)
  else
  end
  local t0
  do
    local _59_ = copy(t)
    do end (_59_)[key] = val
    t0 = _59_
  end
  for i = 1, len, 2 do
    local k, v = select(i, ...)
    do end (t0)[k] = v
  end
  return immutable(t0)
end
local function assoc_in(t, _60_, val)
  local _arg_61_ = _60_
  local k = _arg_61_[1]
  local ks = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_arg_61_, 2)
  local t0 = (t or {})
  if next(ks) then
    return assoc(t0, k, assoc_in(((t0)[k] or {}), ks, val))
  else
    return assoc(t0, k, val)
  end
end
local function update(t, key, f)
  local function _64_()
    local _63_ = copy(t)
    do end (_63_)[key] = f(t[key])
    return _63_
  end
  return immutable(_64_())
end
local function update_in(t, _65_, f)
  local _arg_66_ = _65_
  local k = _arg_66_[1]
  local ks = (function (t, k, e) local mt = getmetatable(t) if 'table' == type(mt) and mt.__fennelrest then return mt.__fennelrest(t, k) elseif e then local rest = {} for k, v in pairs(t) do if not e[k] then rest[k] = v end end return rest else return {(table.unpack or unpack)(t, k)} end end)(_arg_66_, 2)
  local t0 = (t or {})
  if next(ks) then
    return assoc(t0, k, update_in((t0)[k], ks, f))
  else
    return update(t0, k, f)
  end
end
local function deepcopy(x)
  local function deepcopy_2a(x0, seen)
    local _68_ = type(x0)
    if (_68_ == "table") then
      local _69_ = seen[x0]
      if (_69_ == true) then
        return error("immutable tables can't contain self reference", 2)
      elseif true then
        local _ = _69_
        seen[x0] = true
        local function _70_()
          local tbl_14_auto = {}
          for k, v in pairs_2a(x0) do
            local k_15_auto, v_16_auto = deepcopy_2a(k, seen), deepcopy_2a(v, seen)
            if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
              tbl_14_auto[k_15_auto] = v_16_auto
            else
            end
          end
          return tbl_14_auto
        end
        return immutable(_70_())
      else
        return nil
      end
    elseif true then
      local _ = _68_
      return x0
    else
      return nil
    end
  end
  return deepcopy_2a(x, {})
end
local function first(_74_)
  local _arg_75_ = _74_
  local x = _arg_75_[1]
  return x
end
local function rest(t)
  local _76_ = remove(t, 1)
  return _76_
end
local function nthrest(t, n)
  local t_2a = {}
  for i = (n + 1), length_2a(t) do
    t_2finsert(t_2a, t[i])
  end
  return immutable(t_2a)
end
local function last(t)
  return t[length_2a(t)]
end
local function butlast(t)
  local _77_ = remove(t, length_2a(t))
  return _77_
end
local function join(...)
  local _78_, _79_, _80_ = select("#", ...), ...
  if (_78_ == 0) then
    return nil
  elseif ((_78_ == 1) and true) then
    local _3ft = _79_
    return immutable(copy(_3ft))
  elseif ((_78_ == 2) and true and true) then
    local _3ft1 = _79_
    local _3ft2 = _80_
    local to = copy(_3ft1)
    local from = (_3ft2 or {})
    for _, v in ipairs_2a(from) do
      t_2finsert(to, v)
    end
    return immutable(to)
  elseif (true and true and true) then
    local _ = _78_
    local _3ft1 = _79_
    local _3ft2 = _80_
    return join(join(_3ft1, _3ft2), select(3, ...))
  else
    return nil
  end
end
local function take(n, t)
  local t_2a = {}
  for i = 1, n do
    t_2finsert(t_2a, t[i])
  end
  return immutable(t_2a)
end
local function drop(n, t)
  return nthrest(t, n)
end
local function partition(...)
  local res = {}
  local function partition_2a(...)
    local _82_, _83_, _84_, _85_, _86_ = select("#", ...), ...
    if ((_82_ == 0) or (_82_ == 1)) then
      return error("wrong amount arguments to 'partition'")
    elseif ((_82_ == 2) and true and true) then
      local _3fn = _83_
      local _3ft = _84_
      return partition_2a(_3fn, _3fn, _3ft)
    elseif ((_82_ == 3) and true and true and true) then
      local _3fn = _83_
      local _3fstep = _84_
      local _3ft = _85_
      local p = take(_3fn, _3ft)
      if (_3fn == length_2a(p)) then
        t_2finsert(res, p)
        return partition_2a(_3fn, _3fstep, {t_2funpack(_3ft, (_3fstep + 1))})
      else
        return nil
      end
    elseif (true and true and true and true and true) then
      local _ = _82_
      local _3fn = _83_
      local _3fstep = _84_
      local _3fpad = _85_
      local _3ft = _86_
      local p = take(_3fn, _3ft)
      if (_3fn == length_2a(p)) then
        t_2finsert(res, p)
        return partition_2a(_3fn, _3fstep, _3fpad, {t_2funpack(_3ft, (_3fstep + 1))})
      else
        return t_2finsert(res, take(_3fn, join(p, _3fpad)))
      end
    else
      return nil
    end
  end
  partition_2a(...)
  return immutable(res)
end
local function keys(t)
  local function _90_()
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for k, _ in pairs_2a(t) do
      local val_19_auto = k
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    return tbl_17_auto
  end
  return immutable(_90_())
end
local function vals(t)
  local function _92_()
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for _, v in pairs_2a(t) do
      local val_19_auto = v
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    return tbl_17_auto
  end
  return immutable(_92_())
end
local function group_by(f, t)
  local res = {}
  local ungroupped = {}
  for _, v in pairs_2a(t) do
    local k = f(v)
    if (nil ~= k) then
      local _94_ = res[k]
      if (nil ~= _94_) then
        local t_2a = _94_
        t_2finsert(t_2a, v)
      elseif true then
        local _0 = _94_
        res[k] = {v}
      else
      end
    else
      t_2finsert(ungroupped, v)
    end
  end
  local function _97_()
    local tbl_14_auto = {}
    for k, t0 in pairs_2a(res) do
      local k_15_auto, v_16_auto = k, immutable(t0)
      if ((k_15_auto ~= nil) and (v_16_auto ~= nil)) then
        tbl_14_auto[k_15_auto] = v_16_auto
      else
      end
    end
    return tbl_14_auto
  end
  return immutable(_97_()), immutable(ungroupped)
end
local function frequencies(t)
  local res = setmetatable({}, {__index = deep_index, __newindex = deep_newindex})
  for _, v in pairs_2a(t) do
    local _99_ = res[v]
    if (nil ~= _99_) then
      local a = _99_
      res[v] = (a + 1)
    elseif true then
      local _0 = _99_
      res[v] = 1
    else
    end
  end
  return immutable(res)
end
local itable
local function _101_(t, f)
  local function _103_()
    local _102_ = copy(t)
    t_2fsort(_102_, f)
    return _102_
  end
  return immutable(_103_())
end
itable = {sort = _101_, pack = pack, unpack = unpack, concat = concat, insert = insert, move = move, remove = remove, pairs = pairs_2a, ipairs = ipairs_2a, length = length_2a, eq = eq, deepcopy = deepcopy, assoc = assoc, ["assoc-in"] = assoc_in, update = update, ["update-in"] = update_in, keys = keys, vals = vals, ["group-by"] = group_by, frequencies = frequencies, first = first, rest = rest, nthrest = nthrest, last = last, butlast = butlast, join = join, partition = partition, take = take, drop = drop}
local function _104_(_, t, opts)
  local _105_ = getmetatable(t)
  if ((_G.type(_105_) == "table") and ((_105_)["itable/type"] == "immutable")) then
    return t
  elseif true then
    local _0 = _105_
    return immutable(copy(t), opts)
  else
    return nil
  end
end
return setmetatable(itable, {__call = _104_})
