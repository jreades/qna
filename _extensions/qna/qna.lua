function Div(div)
  if not div.classes:includes("qna") then 
    return
  end

  raw = {}
  local div_num = 0
  local header_level = 0

  div:walk({
      Block = function(block)
        print('vvvv')
        print("Unknown block of type " .. block.t)
        if next(block.classes) ~= nil then
          print("Has classes: ")
          print(block.classes)
        end 
        print("Has attributes: ")
        for k,v in pairs(block.attributes) do
          print(k)
          print(v)
        end
        print('^^^^')
      end,
      Div = function(div)
        if next(div.classes) ~= nil and (div.classes:includes('cell') or div.classes:includes('cell-output')) then
          return {}
        else
          table.insert(raw[div_num].content, div)
        end
      end,
      CodeBlock = function(code)
        table.insert(raw[div_num].content, code)
      end,
      Para = function(para)
        table.insert(raw[div_num].content, para)
      end,
      BulletList = function(bl)
        table.insert(raw[div_num].content, bl)
      end,
      OrderedList = function(ol)
        table.insert(raw[div_num].content, ol)
      end,
      Plain = function(pl)
        return pl -- table.insert(raw[div_num].content, pl)
      end,
      Header = function(header)
        if header_level == 0 then
          header_level = header.level
        end
        if header.level == header_level then
          div_num = div_num + 1
          raw[div_num] = {}
          raw[div_num]['title'] = header.content
          raw[div_num]['content'] = {}
        else
          table.insert(raw[div_num].content, header)
        end
      end
    })

  tabs = {}
  for i, t in pairs(raw) do
    table.insert(tabs, quarto.Tab({title=t.title, content=t.content}) )
  end

  return quarto.Tabset({
    level = 3,
    tabs = pandoc.List( tabs ),
    attr = pandoc.Attr("", {"panel-tabset"}) -- this shouldn't be necessary but it's the bug I mentioned.
  })
end
