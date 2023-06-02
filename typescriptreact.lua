local _if_arg = {
  i(1, "LHS"),
  c(2, {
    i(1, "==="),
    i(1, "=="),
    i(1, "<"),
    i(1, ">"),
    i(1, "<="),
    i(1, ">="),
    i(1, "!=="),
    i(1, "!="),
  }),
  i(3, "RHS"),
  i(4, "// TODO:"),
}

--[[ Example

if ()
if (LHS === RHS) // TODO:
if (LHS === RHS) {
  // TODO:
}

]]
local _if = s("if", {
  c(1, {
    fmt("if ({}) {}", { i(1, ""), i(2, "") }),
    fmt("if ({} {} {}) {};", vim.deepcopy(_if_arg)),
    fmt("if ({} {} {}) {{\n  {};\n}}", vim.deepcopy(_if_arg)),
  }),
})

--[[ Example

import X from Y;
import { X } from Y;
import { X as Z } from Y;

]]
local _import = s("im", {
  t "import ",
  c(1, {
    i(1, "module"),
    fmt("{{ {} }}", { i(1, "module") }),
    fmt("{{ {} as {} }}", { i(1, "module"), i(2, "alias") }),
  }),
  t ' from "',
  i(2),
  t '";',
})

--[[ Example
function Name() {
  return ();
}
]]

local _rfc = s(
  "rfc",
  fmt(
    [[
function {}({}) {{
  return ({});
}}
]],
    { i(1, "FuncName"), i(2), i(3, { "", "    <>", "", "    </>", "  " }) }
  )
)

--[[ Example
console.log(smth)
]]

local _log = s(
  "cl",
  fmt(
    [[
console.log({})
]],
    { i(1, '"Mark point"') }
  )
)

local _useState = s(
  "us",
  fmt(
    [[
const [{}, set{}] = React.useState({});
]],
    {
      i(1),
      f(function(args)
        local stateName = args[1][1]
        if stateName then
          return (stateName:gsub("^%l", string.upper))
        end
        return ""
      end, { 1 }),
      i(2),
    }
  )
)

local _useEffect = s(
  "ue",
  fmt(
    [[
React.useEffect(() => {{
  {}
}}, [{}])
]],
    { i(1), i(2) }
  )
)

local _arrowF = s(
  "af",
  fmt(
    [[
({}) => {{{}}}
]],
    { i(1), i(2) }
  )
)

local _fof = s(
  "fof",
  fmt(
    [[
for (const {} of {}) {{
  {}
}}
]],
    { i(1), i(2), i(3) }
  )
)

local _try = s("try", fmt([[
try {{
  {}
}} catch ({}) {{
  {}
}}
]], {i(1), i(2), i(3)}))

return {
  _if,
  _import,
  _rfc,
  _log,
  _fof,
  _try,
  _arrowF,
  _useState,
  _useEffect,
}
