local _for = s("for", {
  t "for ",
  i(1, "k, v"),
  t " in ",
  i(2, "ipairs()"),
  t { "do", "  " },
  i(0),
  t { "", "" },
  t "end",
})

return {
  _for,
}
