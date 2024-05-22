print("Loaded!")

-- Detects the Tabset (yay) but I can't
-- tell if it's one of my 'special' Q&A tabsets
-- or a 'normal' one.
function Tabset(el)
  print(">>>>>>>")
  print("Tabset detected")

  print("vvvvvvv")
  for k, v in pairs(el) do
    print('k: ' .. k)
  end
  print("^^^^^^^^")

  -- el.attr seems to have the class information
  -- but its a userdata type that I can't get useable
  -- information from
  print(el.attr)
  print(el.attr[1]) -- was hoping for ['qna','panel-tabset']
  print(type(el.attr)) -- but it's type userdata
  print(getmetatable(el.attr)) -- this doesn't help
  print('----')

  -- and this seems to have no obvious order that relates
  -- the source QMD file though there must be *some* link
  print(el.__quarto_custom_node.content[1]) -- this is tab content
  print(el.__quarto_custom_node.content[2]) -- this is tab title
  print("<<<<<<<<")
end

-- Detects the Div (yay) but I can't 
-- work out how to 'promote' the element
-- to a tabset if I *don't* want to manipulate it
function Div(el)
  if el.classes:includes"qna" then
    print(">>>>>>>")
    print("Q&A detected")
    if quarto.doc.is_format("html") then 
      -- need to create tabset here
      -- return quarto.Tabset(???)
      print(el.classes)
      el.classes[1] = 'panel-tabset' 
      print(el.classes)
      return el -- no effect on output

    else -- Stub for PDF/IPYNB logic later
      print("Not html")
      return nil
    end
    print("<<<<<<<<")
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
