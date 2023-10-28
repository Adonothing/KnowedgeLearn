local function starts_with(str, start)
   return str:sub(1, #start) == start
end
function Figure(el)
  return pandoc.Div(el, pandoc.Attr(el.identifier))
end