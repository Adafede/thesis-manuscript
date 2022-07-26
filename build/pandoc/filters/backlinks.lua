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

function Div(el)
local citation_id = el.identifier:match("ref%-(.+)")
if citation_id then
local backlinks = {pandoc.Str("Cited on:"),pandoc.Space()}
for i,cite_id in ipairs(cites[citation_id]) do
local marker = pandoc.Str(i)
if FORMAT == "latex" then
marker = pandoc.RawInline("latex", "\\autopageref*{" .. cite_id .. "}")
end
if #backlinks > 2 then
table.insert(backlinks, pandoc.Str(","))
table.insert(backlinks, pandoc.Space())
end
table.insert(backlinks, pandoc.Link(marker, "#"..cite_id))
end
table.insert(el.content, pandoc.Para({pandoc.Span(backlinks,
pandoc.Attr("",{"csl-indent"}))}))
return el
end
end