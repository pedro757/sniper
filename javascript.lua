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

return {
  _if,
  _import,
}
