-- lua filter to add backlinks to citations
-- run after --citeproc on the command line

-- cites is a table mapping citation item identifiers
-- to an array of cite identifiers
local cites = {}

-- counter for cite identifiers
local cite_number = 1

local function with_latex_label(s, el)
  if FORMAT == "latex" then
    return {pandoc.RawInline("latex", "\\label{" .. s .. "}"), el}
  else
    return {el}
  end
end

function Cite(el)
  local cite_id = "cite_" .. cite_number
  cite_number = cite_number + 1
  for _,citation in ipairs(el.citations) do
    if cites[citation.id] then
      table.insert(cites[citation.id], cite_id)
    else
      cites[citation.id] = {cite_id}
    end
  end
  return pandoc.Span(with_latex_label(cite_id, el), pandoc.Attr(cite_id))
end

function append_inline(blocks, inlines)
  local last = blocks[#blocks]
  if last.t == 'Para' or last.t == 'Plain' then
    -- append to last block
    last.content:extend(inlines)
  else
    -- append as additional block
    blocks[#blocks + 1] = pandoc.Plain(inlines)
  end
  return blocks
end

function Div(el)
  local citation_id = el.identifier:match("ref%-(.+)")
  if citation_id then
    local backlinks = pandoc.Inlines{pandoc.Str("(cit. on p")}
    for i,cite_id in ipairs(cites[citation_id]) do
      local marker = pandoc.Str(i)
      if FORMAT == "latex" then
        marker = pandoc.RawInline("latex", "\\pageref*{" .. cite_id .. "}")
      end
      if #backlinks > 1 then
        table.insert(backlinks, pandoc.Str(","))
        table.insert(backlinks, pandoc.Space())
      end
      table.insert(backlinks, pandoc.Link(marker, "#"..cite_id))
    end
    if #backlinks > 2 then
      table.insert(backlinks, 2, pandoc.Str("p. "))
    else
      table.insert(backlinks, 2, pandoc.Str(". "))
    end
    table.insert(backlinks, pandoc.Str(")"))
    append_inline(el.content, {pandoc.Space()} .. backlinks)
    return el
  end
end