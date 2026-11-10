-- Emit fenced code as <pre data-lang="..."> so the Markdown-look CSS can
-- print the language after the opening fence.
local function escape(s)
  return (s:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

function CodeBlock(el)
  local lang = el.classes[1] or ""
  local attr = lang ~= "" and (' data-lang="' .. lang .. '"') or ""
  return pandoc.RawBlock("html", "<pre" .. attr .. "><code>" .. escape(el.text) .. "</code></pre>")
end
