print("Loaded!")

local function tabset(node)
  print("Tabset")
  return quarto.Callout({
              type    = "info",
              title   = "Foo",
              content = "^^^^",
              -- icon    = icon,
          })
end

function Div(el)
  if el.classes:includes"qna" then
    print(el.classes)
    if quarto.doc.is_format("html") then
      el.classes[1] = 'panel-tabset'
      return quarto.Tab(pandoc.Div('Test'), pandoc.Span('Title'))
      -- return pandoc.SmallCaps(el.content)
    else 
      return nil
    end
  end
end

-- function Div(div)
--   -- Set defaults
--   local title = nil
--   local ctype = nil

--   -- Set callout type
--   if div.classes[1] ~= nil and string.find(div.classes[1], "casa-") then
--       ctype = string.sub(div.classes[1], 6)
--   else 
--       ctype = ""
--   end

--   -- Look for a header
--   if div.content[1].tag == 'Header' then
--       title = div.content[1].content
--       table.remove(div.content,1)
--   end

--   -- Is the output for iPynb or something else?
--   if _G._quarto.format.isIpynbOutput() then
--       return calloutIpynb(div, ctype, title, div.content)
--   else
--       if ctype == "connection" then 
--           ctype = "note"
--       end

--       return quarto.Callout({
--           type    = ctype,
--           title   = title,
--           content = div.content,
--           -- icon    = icon,
--       })
--   end
-- end
