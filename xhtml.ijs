cocurrent 'z'
strbracketF =: 0&{::@:[ , ] , 1&{::@:[
strbracket =: (0&({)@:[ , ] , 1&({)@:[)
strinsert =: 1 : ' [ , u , ]'
codeinsert =: 1 : '[: u lrA strinsert/ lr every'

coclass 'xml'
coinsert 'typesys'
xs =: ({. (, <) _2 ]\ }.) '96&cut dltb'c@:[ ( ('<>' strbracket  (0 {:: [) ([`(,"1 ,"1/@:((' ' , 0&{:: , '=' , '""' strbracket leaf 1&{::)"1))@.(0 < #@:])) 1 {:: [) , ":@:] , '<>' strbracket  '/', 0 {:: [) ]
table =: ;: inv@:cut@:unshape@:([:'table'&xs &:> [: 'tr'&(,@:xs)&.:>"1 ('td'&xs@": leaf))@:((<"_1)^:(1 < #@$)^:(0=L.)) : (] (4 : 0)~ '96 59&cut 2&count'cV [)
 'cap headers' =.  x
  o =. ([: 'tr'&(,@:xs)&.:>"1 ('td'&xs@": leaf))@:((<"0)^:(0=L.)) y
  if. 0 < # headers do. o =. ('tr' xs  ,>'th'&xs@": leaf headers ) ; o end.
  if. 0 < # cap do. o =. ('caption' xs ,> cap) ; o end.
  ;: inv@:cut@:unshape 'table'&xs &:> o
)

table =: 3 : 0
NB.;: inv@:cut@:unshape@:( 'table' xs [: 'tr'&xs_xml_@;"1 ([: 'td'&xs each ([:'table`border`1'&xs_xml_ &:> ([: 'tr'&(,@:xs_xml_)S:0"1 ('td'&xs_xml_@": S:0)"1))@:((<"1)^:(0=L.)) each))  
 ;: inv a: -.~ dltb each cutLF unshape 'table' xs 'tr'&xs_xml_@;"1  'td'&xs_xml_ each (([:'table`border`1'&xs_xml_ &:> ([: 'tr'&(,@:xs_xml_)S:0"1 ('td'&xs_xml_@": S:0)"1))@:((<"1)^:(0=L.)) each) y
: 
'cap headers' =.  '96 59&cut 2&count'cV  x
  NB.o =. ([: 'tr'&(,@:xs)&.:>"1 ('td'&xs@": leaf))@:((<"0)^:(0=L.)) y
  o =. 'tr'&xs_xml_@;"1  'td'&xs_xml_ each (([:'table`border`1'&xs_xml_ &:> ([: 'tr'&(,@:xs_xml_)S:0"1 ('td'&xs_xml_@": S:0)"1))@:((<"1)^:(0=L.)) each) y
  if. 0 < # headers do. o =. ('tr' xs  ,>'th'&xs@": leaf headers ) , o end.
  if. 0 < # cap do. o =. ('caption`align`center' xs 'b' xs ,> cap) , o end.
  ;: inv a: -.~ dltb each cutLF unshape 'table' xs o
)

0 : 0
table =: ;: inv@:cut@:unshape@:([:'table`border`1px solid black`border-collapse`collapse'&xs &:> [: 'tr'&(,@:xs)&.:>"1 ('td`border`1px solid black`border-collapse`collapse'&xs@": leaf))@:(((<"_1)`(<"1)@.(2 = 3!:0))^:(0=L.)) : (] (4 : 0)~ '96 59&cut 2&count'cV [)
 'cap headers' =.  x
  o =. ([: 'tr'&(,@:xs)&.:>"1 ('td'&xs@": leaf))@:((<"0)^:(0=L.)) y
  if. 0 < # headers do. o =. ('tr' xs  ,>'th'&xs@": leaf headers ) ; o end.
  if. 0 < # cap do. o =. ('caption' xs ,> cap) ; o end.
  ;: inv@:cut@:unshape 'table'&xs &:> o
)

tables =:  table_xml_  hook ((table_xml_ L:1)^:(1 < L.)^:_"0 each)
tables =:  table_xml_  hook ((table_xml_ L:1)^:(1 < L.)^:_"0 )
unshape =: [: , ,&LF"1^:(1 < #@$)
j2h =: [: , ,&('<br>',LF)@":"1
pre =: [: , [: ,&LF"1 'pre`font`Courier New' xs ":"1
NB. 'table' xs_xml_ 'tr`dgf`45'&(,@xs_xml_)"_1 ([:'td`left`33'&xs_xml_ ":)"0 i.2 3
NB.  'table'&(xs_xml_)&:> (<'caption'&xs_xml_ 'integer list') , 'tr'&(,@:(xs_xml_))&.:>"1    'td'&xs_xml_@": leaf  <"0 i.2 3
css =: ,@:([: (0 Y every  ,"1 1  ('{}' strbracket"1 [: ,"2 ';' ,~"1 ':' joinstring("1) 1 Y_typesys_) every  ) ({. (, <) _2 ]\ }.) each@:(dltb leaf)) '96 59&cut 'c 
NB. css_xml_'table, th, td`border`1px solid black`border-collapse`collapse;th, td`padding`5px`text-align`left;caption`padding`20px'

NB. below works marginally.
x =:   ({. (, <) _2 ]\ }.) '96&cut dltb'c@:[ (, <)   <@:] 
unp =: (('<>' strbracket (0 {:: ]) ([`(,"1 ,"1/@:((' ' , 0&{:: , '=' , '""' strbracket leaf 1&{::)"1))@.(0 < #@:])) 1 {:: ] ) , ([: >@:]`( $:)@.(1 < L.@:])   (2 {:: ])) , '<>' strbracket  '/', (0 {:: ]))S:_1 
