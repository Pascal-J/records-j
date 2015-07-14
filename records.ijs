Note 'record as dataless class'
A record can have multiple implementations: 
	boxed data members
	unboxed if all have same type
	fixed fieldsize binary blob
	variable fieldsize binary blob
	records of nested records
	inverted table of records grouped by vartype and/or category.

record class provides verbs to access members from any source representation,
  so can use named member access in tacit code
  can subselect fields or filter and optionally create a temporary object that includes data and accessors

code that uses/manipulates record data is written independently of how the record is structured.
name__myRecName is a verb that returns the 'name' member from the format described by myRecName
name__Person__myRecName would access subrecords
record definitions are created in one line.  Member names and types.
types can be consistent with j type system (other addon)
variable coding/compression of records is possible in binary format
)

NB. default: boxed delimited members
NB. indirect_typesys_ =: 1 : '(loc&u)@:[ apply ]'
MYDIR =: getpath_j_  '\/' rplc~ > (4!:4<'thisfile'){(4!:3)  thisfile=:'' NB. boilerplate to set the working directory
require MYDIR , 'typesys.ijs'
coclass__OOP 'record'

coinsert 'typesys'

reduce =: 1 : '<"_1@[ ([: u boxscan ,) <@:]'
boxscan =: &.>/(>@:) NB. applies u/ to any shape x and any shape y, as long as they are joined <x,<y
applyintree =: 2 : 0
if. #n do. ((u applyintree (}.n)) L:_1 ({.n){y) ({.n)} y else. u y end.
:
NB. The rank is s,0 where s is the surplus of x-rank over y-rank. This causes
NB. the cells of y to be matched up with the largest appropriate blocks x.  This
NB. is necessary because it is impossible to change the shape of the values being modified
if. #n do. (x u applyintree (}.n) L:_ _1"(0 (,~ >.) x -&(#@$) a) (a =. ({.n){y)) ({.n)} y
else. x u y end.
)
boxdefine_typesys_ =: (0 : ) 1 : 'cutLF m'
boxtabdefine_typesys_ =: ( 0 :) 1 : ' '' 9 10&cut'' cV m '

create =: 3 : 0@:(3{. typeparser each each each@:(2&{.),2&}.)  '96 59 9&cut' c
 NB.pD y
 LXnames=: recPN 0&{:: y
 LXboxes=: recPV 0&{:: y
 preval=: ('] ' ,  ((''"_)`(' c' ,~ lr)@.('any' -.@-: ]) (recunparser (0;0)&{:: :: ('any'"_)  1&{:: y )) ,  (''"_)`(' v' ,~ lr)@.('any' -.@-: ]) (recunparser (0;1)&{:: :: ('any'"_)  1&{:: y) ) eval
 wholeval =: (']'"_^:(0 = #) linearize >> 2&{:: y) eval NB. parameter must be linear representation of verb.  will transform after invidivual fields validated.
 NB.LXboxes =. typeparser each each (9{a.) cut each ;: inv@:}.@:cut each cut^:(0= L.) y
 NB.LXnames =: {.@:cut every cut^:(0= L.) y
 NB. LXCOERCEVALS =. 2{. each  (< 2# < a:) ,~  each LXboxes
 LXCOERCEVALS =. 2{. each  (< 2#  a:) ,~  each LXboxes
 NB.  LXCOERCEVALS =. 2{. each  ( 2# < a:) ,~  L:3 LXboxes
 COERCIONS =: (a:,&< <'any')rplc~ ' '&joinstring each ('&'&joinstring) each each {. every  LXCOERCEVALS 
 VALIDATIONS =: (a:,&< <'any')rplc~ ' '&joinstring each ('&'&joinstring) each each {: every LXCOERCEVALS
NB. if. (<'any') *./@:= COERCIONS do. VALverB =: ]  else. VALverB =: (COERCIONS cV each ])  end. 
 if. (<'any') *./@:= COERCIONS do. VALverB =: ]  else. VALverB =: (COERCIONS cV leaf ])  end. 
 if. (<'any') *./@:= VALIDATIONS do. VALverB =: VALverB f. else. VALverB =: (VALIDATIONS vV each  VALverB f.) end. NB. leaf prob needed.
 
NB. VAL =: 1 : ('u hook ' , VALverB)
 VAL =: VALverB f.
 fullval =: wholeval@:VAL@:preval
 for_ind. LXnames do. (; ind) =: (ind_index {:: ]) end.
 coname ''
)
DEF =: ( coname '') conew~  ]
NB. allow 4 boxes per record for 
recparser =: ((>@:{.@:])`([: typeparser each  '`' cut ;: inv@:}.@:])@.[ each ' ' cut each^:(1= L.@:]) ';'&cut^:(0= L.@:]))"0 1  NB. x=0 for names, 1 for validations
recparser =: ([: typeparser each each^:(2=L.@:])  '`' cut each ^:(1= L.@:]) ';'&cut^:(0= L.@:])) NB. more flexible than '96 59&cut' bc expression can be partially boxed.
recunparser =: ('";` &') joinstring L:0 1^:(0 < L.@]) reduce ]
recPN =: (0;0;0)&{:: each 
recPV =: ([: ,@:> L:_1 }. L:2@:{. each , each }. each)
recPV =:  (}.applyintree(0)) (L:_1) 
wholeVal =: ]  NB. change this to a coercive or validating expression. ex. 5&{. to take 5 items from params
preval = ]
iD =: 3 : 0 NB. overrides iD_typesys_
 ('' ,&< LXnames) iD_typesys_ y
:
 ((<x) ,&< LXnames) iD_typesys_ y
)
NB. VAL =: 3 : 'VALIDATIONS vV each  COERCIONS cV each wholeVal y' 
NB. sets global variable (caller's context) to something, returns adverb which will execute its u, before resetting back global to what it was.
NB. must use lateval bindings or explicit code (in u)
lval_z_ =: 1 : 0 
3 : m @]
)
setWith_z_ =: 2 : 0
t =. m~
f1 =. 3 : ( m lrA , ' assign ' , t lrA )
f2 =. 3 : ( m lrA , ' assign ' , n lrA )
1 : (f1 f. lrA , '@:] sfX @: u :: (' , f2 f. lrA , ') hook (' , f2 f. lrA , '@:] sfX)')
)
NB. (] + 'a' lval) ('a' setWith 5) 8
ORdef_z_ =: ".@[^:(_1< 4!:0@<@[)

coclass__OOP 'recordform'
coinsert 'record'

require MYDIR_base_ , 'ftimer.ijs'
coinsert 'form'
NB.FORMPARAMS =: DEF_record_ 'name ; title ; callback pD&d 3&evalto ; initvals ; ctrllist edit&d ; instructions ; tooltips"'
NB. FORMPARAMS =: DEF_record_ 'pass ; password for life ;pD@lr ; ; passw`edit ; enter long password you will remember`numbers are good	96 59&cut 7&count	[: linearize@:(dltb"1) leaf >^:(1=#)each	'
pDlr =: pD@:(256 list lr)
FORMPARAMS =: DEF_record_ 'name ; title ; prompt ; callback pDlr_recordform_&d 3&evalto ; initvals ; ctrllist edit&d ; instructions ; tooltips ; okcaption OK&d	96 59&cut 9&count  _ 0 _ _ _ _ _ 6 _&copies	[: linearize@:(dltb"1) leaf >^:(1=#)each'
CONTROL =: DEF_record_ 'name ; type ; code'

create =: 3 : 0
 R =: y
 coname ''
)

DEF =: ( fullval__FORMPARAMS@:[) 4 : 0 ]
 formlets =: (DEF_record_ y) conew coname ''
 formparams__formlets x
 formlets
)
dontdestroyR=: 0
DEFfromR =: ( fullval__FORMPARAMS@:[) 4 : 0 ]  NB. record already made.
 formlets =: y conew coname ''
 formparams__formlets x
 dontdestroyR=: 1
 formlets
)

formparams =: 3 : 0
 pD fparams =: y
 c =. # LXnames__R
 'fn fc' =: 2 {. y
 form =: fn , > R
 PROMPT =: prompt__FORMPARAMS y
 RETURN =: c $ boxopen initvals__FORMPARAMS y
 LAYOUT =: (<"0 i.c) , < c+i.2
 NB. CONTROLS =: (boxopen ctrllist__FORMPARAMS y) (a: ,~ [ ;~ ]) each LXnames__R
 CONTROLS =: (2 {. each '"' cut each boxopen ctrllist__FORMPARAMS y) ,~ each < each LXnames__R  NB. uses " as separator to set code value of controls
 CONTROLS =: CONTROLS , <"1 (] ,. ('button';'button') ,. ])  ;: 'OK CANCEL'
 (2 {. each '"' cut each boxopen ctrllist__FORMPARAMS y) ,~ each < each LXnames__R
 callback =: (callback__FORMPARAMS y)&apply
 EXPLAINS =: instructions__FORMPARAMS y
 genValidators R 
 
)
 fntfix=:  (UNAME -: 'Linux') { '"DejaVu Mono" 12 ' ,:~ '"Courier New" 12'  

CNTRLLOOKUP =: (9{a.) cut &> cutLF 0 : 0  NB. name type code
edit	edit		text
editm	editm		text
passw	edit		text
checkbox	checkbox		value
console	edith		text
ignore	edit		text
clear	edit		text
auto	edit		text
autom	editm		text
)
indirect=: 4 : 'x i.@0:`apply__R@.(0 < #@]) y'
layouth =: 3 : '(< ''bin h'';''bin z'') strbracket each  ([: , ctrlswitch &>)  each LAYOUT { each  < CONTROLS' 
ctrlswitch =: 3 : ' ( > ''GUI'' , leaf ([: {. [: cut leaf type__CONTROL) y)~  y'

NB.GUIedit =: ('cc ' , name__CONTROL ,'L  static center ; cn *', name__CONTROL) ; ('cc ' ,  name__CONTROL ,'C ' , type__CONTROL); ('cc ' , name__CONTROL ,'INST  static left ; cn *', [: (name__CONTROL loc R) eval instructions__FORMPARAMS@:'fparams' lval) ;'set ' , name__CONTROL ,'C' , ' text *' , [: ":@:name__CONTROL 'RETURN' lval
NB.GUIedit =: ('cc ' , name__CONTROL ,'L  static  ; cn *', name__CONTROL) ; (' cc ' ,  name__CONTROL ,'C ' , type__CONTROL); ('cc ' , name__CONTROL ,'INST  static left ; cn *',  name__CONTROL indirect  'EXPLAINS' lval) ; 'set ' , name__CONTROL ,'C' , ' text *' , [: ":  ( name__CONTROL) indirect 'RETURN' lval
GUIeditm =: GUIedit =: ('cc ' , name__CONTROL ,'L static right; cn *', (1 + [: >./ [: # every 'LXnames' inl 'R' lval) {. name__CONTROL ) ; ( ' set ', name__CONTROL ,'L font ', fntfix , '; cc ' ,  name__CONTROL ,'C ' , type__CONTROL); ('bin s ; cc ' , name__CONTROL ,'INST  static panel left; cn *',  name__CONTROL indirect  'EXPLAINS' lval) 
GUIcheckbox =: ('cc ' , name__CONTROL ,'L static right; cn *', (1 + [: >./ [: # every 'LXnames' inl 'R' lval) {. name__CONTROL ) ; ( ' set ', name__CONTROL ,'L font ', fntfix , '; cc ' ,  name__CONTROL ,'C ' , type__CONTROL); ('bin s ; cc ' , name__CONTROL ,'INST  static panel left; cn *',  name__CONTROL indirect  'EXPLAINS' lval) 
NB. GUIedit =: ('cc ' , name__CONTROL ,'L  static center ; cn *', name__CONTROL) ; ('cc ' ,  name__CONTROL ,'C ' , type__CONTROL); ('bin s ; cc ' , name__CONTROL ,'INST  static left panel ; cn *                                                             '"_) 
GUIpassw =: 3 : 0
   (a=. 'SELVAL' ,~ name__CONTROL y) ORassign code__CONTROL y
   o =. GUIedit (name__CONTROL ; 'edit' ; code__CONTROL) y
   lr 'a'~~
  if. ] 'int' c 'a'~~ do. o =. ' password' ,~ leaf amdt 1 o end.
  NB.(form , '_', 'SEL_button' ,~ name__CONTROL y) =: 3 : ('chkformvalid ', a , ' =: ' , 'SEL' ,~ name__CONTROL y)
(form , '_', 'SEL_button' ,~ name__CONTROL y) =: 3 : ('reset a: [ restart ''''[ chkformvalid ', a , ' =: ' , 'SEL' ,~ name__CONTROL y)
   ((0 1&{ ,&< 2&{) o) strbracketF (('cc ' ,  'SEL  checkbox  ; cn *mask?',~ name__CONTROL) ;  ('set ' ,  'SEL tooltip switch between dots and not dots' ,~ name__CONTROL) ; 'set ' , (": 'a'~~) ,~ 'SEL value ' ,~ name__CONTROL) y
)

GUIclear =: 3 : 0  NB. clear (set to initval) text after ok if option
 (a=. 'SELVAL' ,~ name__CONTROL y) ORassign code__CONTROL y
 o =. GUIedit (name__CONTROL ; 'edit' ; code__CONTROL) y
 ((0 1&{ ,&< 2&{) o) strbracketF (('cc ' ,  'SEL  checkbox  ; cn *clear?',~ name__CONTROL) ;  ('set ' ,  'SEL tooltip set will clear editbox after OK pressed' ,~ name__CONTROL) ; 'set ' , (": 'a'~~) ,~ 'SEL value ' ,~ name__CONTROL) y
)

GUIignore =: 3 : 0 NB. if set ignores text value prior to OK.
 (a=. 'SELVAL' ,~ name__CONTROL y) ORassign code__CONTROL y
 o =. GUIedit (name__CONTROL ; 'edit' ; code__CONTROL) y
 ((0 1&{ ,&< 2&{) o) strbracketF (('cc ' ,  'SEL  checkbox  ; cn *ignore?',~ name__CONTROL) ;  ('set ' ,  'SEL tooltip set will ignore value in editbox' ,~ name__CONTROL) ; 'set ' , (": 'a'~~) ,~ 'SEL value ' ,~ name__CONTROL) y

)
GUIauto =: 3 : 0 NB. if set ignores text value prior to OK, and will fill it as result of OK or other code.
 (a=. 'SELVAL' ,~ name__CONTROL y) ORassign code__CONTROL y
 o =. GUIedit (name__CONTROL ; 'edit' ; code__CONTROL) y
 ((0 1&{ ,&< 2&{) o) strbracketF (('cc ' ,  'SEL  checkbox  ; cn *auto?',~ name__CONTROL) ;  ('set ' ,  'SEL tooltip set will have code automatically use generated value and update the control' ,~ name__CONTROL) ; 'set ' , (": 'a'~~) ,~ 'SEL value ' ,~ name__CONTROL) y

)
GUIautom =: 3 : 0 NB. if set ignores text value prior to OK, and will fill it as result of OK or other code.
 (a=. 'SELVAL' ,~ name__CONTROL y) ORassign code__CONTROL y
 o =. GUIedit (name__CONTROL ; 'editm' ; code__CONTROL) y
 ((0 1&{ ,&< 2&{) o) strbracketF (('cc ' ,  'SEL  checkbox  ; cn *auto?',~ name__CONTROL) ;  ('set ' ,  'SEL tooltip set will have code automatically use generated value and update the control' ,~ name__CONTROL) ; 'set ' , (": 'a'~~) ,~ 'SEL value ' ,~ name__CONTROL) y

)
GUIconsole =:  ( ('cc ' ,  name__CONTROL ,'C ' , 'edith flush; set ', name__CONTROL , 'C text *' , [: ". 'TEXT' ,~ name__CONTROL) ;  ' set ', name__CONTROL , 'C stylesheet *' , 'QTextEdit {color:#00007f;background-color:#ffffee;} ', STYLESHEET_consoleform_"_)  NB. , 'style' xs_xml_ STYLESHEET_consoleform_"_
GUIconsole =:  ([: < ('cc ' ,  name__CONTROL ,'C ' , 'edith flush; set ', name__CONTROL , 'C text *' , [: ". 'TEXT' ,~ name__CONTROL) )  NB. , 'style' xs_xml_ STYLESHEET_consoleform_"_
GUIbutton =: ('cc ' ,  name__CONTROL ,'C ' , ';',~ type__CONTROL); 'cn *' , name__CONTROL

genValidators =: 3 : 0 NB. y is usually R, but can be any record
 NB. pD 'VAlidators run';form;formSHOWexplSELVAL
 'formSHOWexplSELVAL' ORassign 1
 
 if. (<'any') *./@:= COERCIONS__y do. VALverB =. ]  else. VALverB =. (COERCIONS__y cV each ])  end. 
 if. (<'any') *./@:= VALIDATIONS__y do. VALverB =. VALverB f. 
 EXPLverb =: ]
 else. EXPLverb =:  [: ([: LF strinsert/ [: ,:^:(2 > #@$) [: ;"1 [: ": each }."1)^:isErr each  ((a: ,: instructions__FORMPARAMS fparams) {~ 'formSHOWexplSELVAL' lval) [ M each VALIDATIONS__y vmV each VALverB f.
  VALverB =. ([: ([: *./  -.@isErr every) VALIDATIONS__y vmV each  VALverB f.) end.
  NB.VALverB =. (VALIDATIONS__y ([: *./@:; *./@:vbV each)  VALverB f.) end.
  setEXPL =: ('set ', leaf (LXnames__R    , leaf 'INST caption '), leaf ])  NB. y usually EXPLAINS but can set to anything.
  (isformvalid =: VALverB f.) lrA
)

getCtrlvals =: (([ {~ [ 0:^:(#@:[ = ]) ]  i.~ {."1@:[) ([: {. cut leaf))  NB. x is CNTRLLOOKUP y is 'checkbox' or other first colum from table.  bad elements are set to first.
getCtrlvals2 =: (] ({:@] {~ (i.~ {.)) [: |:@:~. (0 2&{)"1@:[  )  NB. x CNTRLLOOKUP, y is CONTROLS
setCtrl =: ((#@] {. [) (] ,~ leaf  'set ' , leaf  ('C ' ,~ leaf  (0 {:: L:1 [ ))  , leaf ' *' ,~ leaf CNTRLLOOKUP (2&{::)@:getCtrlvals (1 {:: L:1 [ ) ) ": leaf@:])
setCtrl =: ((#@] {. [) (] ,~ leaf  'set ' , leaf  ('C ' ,~ leaf  (0 {:: L:1 [ ))  , leaf ' *' ,~ leaf CNTRLLOOKUP getCtrlvals2 (1 {:: L:1 [ ) ) ": leaf@:])
NB.CONTROLS__r  setCtrl RETURN__r
NB. can aslo use to set 1 control:
NB. wd__r S:0 setCtrl__r/ name__PARAMS__Ckeygenform__OOP  (<"1 |: CONTROLS__r ,: RETURN__r)
recdata =: 3 : '{:"1 (#~ (LXnames__R , each ''C'') e.~ {."1) wdq'

formcodegen2 =: 3 : 0
wd 'set OKC caption *', okcaption__FORMPARAMS fparams
wd 'msgs'
NB.". S:0 pD ((form , '_OKC_button') ,~ '''' , form , '_' , ] , 'C_button'''' assign '"_)   pD
(form , '_', 'formSHOWexplSEL_button') =: showexplbutton 
for_i. LXnames__R #~ (<'edit') -: every  CNTRLLOOKUP (1 {:: getCtrlvals) L:_ 0  {. every ;: each boxopen ctrllist__FORMPARAMS fparams do.

  ( form , '_' , (>i) , 'C_button')  =:  OK NB.(form , '_OKC_button')  
wd  'set ', (>i) , 'C tooltip *' , > i_index { :: (''"_) tooltips__FORMPARAMS fparams
end.
)


showexplbutton =:  3 : 'chkformvalid RETURN [  formSHOWexplSELVAL =: 0 ". formSHOWexplSEL '
start =:  reset@:formcodegen2@:restart@:formcodegen NB.(start f.)
					NB.start =: ('reset@:formcodegen2@:restart@:formcodegen' inl ] dflt [: coname''"_)
restarti =: 3 : 0
 NB.pD 'restarti';formSHOWexplSELVAL
( 'pshow ' ;~ 'pc ', form , ' escclose  ; pn ', (fn ORdef~ 'fc') , ';  bin v' ) strbracket , (( 'bin h ;' , ' cc formPROMPT static center; cn *', PROMPT) ; 'bin s; cc formSHOWexplSEL checkbox; cn "Show explanations";  bin z ' ) , layouth a: ,  (CONTROLS  setCtrl RETURN), setEXPL EXPLAINS
)
reset =: 3 : 'wd S:0 (<''set formSHOWexplSEL value '' ,  ": formSHOWexplSELVAL), (CONTROLS  setCtrl RETURN), setEXPL EXPLAINS '
chkformvalid =: 3 : 0
 NB. if. isformvalid RETURN =: recdata a: do. 1 [ reset EXPLAINS =: (# LXnames__R) # <'OK' [RETURN =: VAL__R RETURN else. 
  		NB. could filter out autos too.
 if. isformvalid RETURN =: recdata a: do. t =.  ((  ((# LXnames__R) {. ((<'ignore') = type__CONTROL each) CONTROLS)) } (0 ,: +/@:(0&".) every  ". each ('SEL' ,~ leaf LXnames__R)) ) } a: ,:~ RETURN
  1 [ reset EXPLAINS =: (# LXnames__R) # <'OK' [RETURN =: VAL__R  RETURN else. 
  EXPLAINS =: EXPLverb RETURN 
  0 [ reset '' end.
)
OK =: 3 : 0
0 OK y
:
 if. chkformvalid RETURN do. pD t =.  ((  ((# LXnames__R) {. ((<'ignore') = type__CONTROL each) CONTROLS)) } (0 ,: +/@:(0&".) every  ". each ('SEL' ,~ leaf LXnames__R)) ) } a: ,:~ RETURN 
  x (4 : 'x~ y')`(callback@:])@.(0-:[) t=. ((  ((# LXnames__R) {. ((;:'auto autom') e.~ type__CONTROL each) CONTROLS)) } (0 ,: +/@:(0&".) every  ". each ('SEL' ,~ leaf LXnames__R)) ) }  (<'__') ,:~ t
 NB.callback RETURN
   a=. ((  ((# LXnames__R) {. ((<'clear') = type__CONTROL each) CONTROLS)) } (0 ,: +/@:(0&".) every  ". each ('SEL' ,~ leaf LXnames__R)) )
  if. +./ a do. RETURN =:  a }  (initvals__FORMPARAMS fparams) ,:~ RETURN 
    reset '' end.
   
 NB. wd 'pclose'
 NB. codestroy ''
else.
 a: return.
end.
 RETURN
)
CANCEL =: 3 : 0
wd 'pclose'
callback  a:
codestroy ''
a:
)
destroy =: 3 : 'if. -. dontdestroyR do. codestroy__R a: end.'
NB. r =: ('pass';'password for life';'pD@lr';'';('passw';'edit' ); <'enter long password you will remember';'numbers are good') DEF_recordform_ 'password str `7&mthan; other int`3 5&inrange 0&gthan 22&lthan'
NB. r =: ('pass ; password for life;pD@lr; ; passw`edit ; enter long password you will remember ` numbers are good') DEF_recordform_ 'password str `7&mthan; other int`3 5&inrange 0&gthan 22&lthan'
NB. start__r
NB.    start__r a: [ r =: ('pass ; password for life;type random stuff, and output will be shown on console;pD@lr; ` `2`fff ; passw"0`edit password`ignore`clear ; enter long password you will remember ` numbers are good`something`clear after cmd') DEF_recordform_ 'password str `7&mthan; otherP int`0&mthan 3 5&inrange 0&gthan 22&lthan;special int `1&gthan ; command '


NB. attaches a console (edith) at bottom of record form and takes as parameters:
NB. recordform, RF y
NB. function that overwrites callback__RF
NB. initial help text to fill console,
NB. callback function is overridden to use pD_z_ to output to console
coclass__OOP 'consoleform'

coinsert 'record'
coinsert 'typesys'
require MYDIR_base_ , 'xhtml.ijs'
coinsert 'xml'
DIVID =: 0
getID =: 3 : 'DIVID =: >: DIVID'
PARAMS =: DEF_record_ 'func hout&d 3&evalto; htext ; style		96 59&cut 3&count	[: linearize@:(dltb"1) leaf >^:(1=#)each '
create =: 3 : 0
 RF =: y
 coname ''
)


DEF =:   4 : 0 

o =. y conew coname ''
formparams__o  fullval__PARAMS__o x
o
)

formparams =: 3 : 0
LAYOUT__RF =: LAYOUT__RF , < >: >./ ; LAYOUT__RF
CONTROLS__RF =: CONTROLS__RF , <'con' ; 'console' ; ''
conTEXT__RF =: 'html'xs  ('head' xs 'style' xs STYLESHEET) , 'body' xs htext__PARAMS y
callback__RF =: (func__PARAMS y) inlA NB. ((func__PARAMS y) loc coname '')&apply
1
)
STYLESHEET =:   css_xml_'table, th, td`border`1px solid`border-style`solid;th, td`padding`5px`text-align`left;caption`padding`20px'
STYLESHEET =:   css_xml_'table, th, td`border`1 solid`border-style`solid;th, td`padding`3;caption`padding`20'
start =: 3 : 'Preset@:start__RF y'
start =: ('Preset@:start__RF a:' inl ] dflt [: coname''"_)
Preset =: 3 : 0
wd 'set conC text *', conTEXT__RF
wd 'set conC scroll max'
wd 'msgs'
)

ipD =: hout =: 3 : 0
o =. y
if. 0 < L. o do. o =. tables_xml_ o else. o =. pre_xml_ o end.
NB.Preset conTEXT__RF =: (_14 }. conTEXT__RF) , (('div`class`hout`id`',": getID a:) xs_xml_  o)  , '</body></html>'
Preset conTEXT__RF =: (_14 }. conTEXT__RF) , '<hr>' , (  o)  , '</body></html>'
y
:
o =. y
if. 0 < L. o do. o =. x tables_xml_ o else. 
 x=. '96 59&cut 2&count' cV x
 if. 1 < #@$ y do. o =. ('caption`align`center' xs_xml_ 'b' xs_xml_ unshape_xml_  ;: inv  ;: inv L:1  a: -.~ x) , pre_xml_ o 
  else. o=. unshape_xml_ j2h_xml_ ('b' xs_xml_ > 0 {:: x) ,  ": o end. end.
NB.Preset conTEXT__RF =: (_14 }. conTEXT__RF) , (('div`class`hout`id`',": getID a:) xs_xml_  o) , '</body></html>'
Preset conTEXT__RF =: (_14 }. conTEXT__RF) , '<hr>' , ( o) , '</body></html>'
y
)
ipD =: 3 : 0 
Preset conTEXT__RF =: (_14 }. conTEXT__RF) , '<hr>' , (unshape_xml_  pre_xml_  ": y) , '</body></html>'
y
:
Preset conTEXT__RF =: (_14 }. conTEXT__RF) , '<hr>' , (x , '<br>') , (unshape_xml_  pre_xml_  ": y) , '</body></html>'
y

)
NB. co =: '`;hello world' DEF_consoleform_ r =: ('pass ; password for life;`;pD@lr; ; passw`edit ; enter long password you will remember ` numbers are good') DEF_recordform_ 'password str `7&mthan; other int`3 5&inrange 0&gthan 22&lthan'

coclass__OOP 'buttonadd'

coinsert 'typesys'
PARAMS =: DEF_record_ 'func 3&evalto ; caption; position _1&d num; checkvalid 0&d num 0 1&inrange	96 59&cut 4&count 	[: linearize@:(dltb"1) leaf >^:(1=#)each'
create =: 3 : 0
 RF =: y
 coname ''
)


DEF =:   4 : 0 

o =. y conew coname ''
formparams__o  fullval__PARAMS__o x
RF__o NB. return form instead of self.
)

formparams =: 3 : 0
pD np =. >: >./ ; LAYOUT__RF
if. _1 = position__PARAMS y do. p =.  <: np else. p =. pD position__PARAMS y end.
LAYOUT__RF =: np ,~ each  amdt ([: I. p&e. every) LAYOUT__RF

NB.LAYOUT__RF =: LAYOUT__RF , < >: >./ ; LAYOUT__RF
CONTROLS__RF =: CONTROLS__RF , <"1 (] ; ('button') ; ])   caption__PARAMS y

NB. callback__RF =: (func__PARAMS y) inlA NB. ((func__PARAMS y) loc coname '')&apply
NB.(pD form__RF , '_' , (caption__PARAMS y) , 'C_button__RF') =: [: (func__PARAMS y) inlA 'RETURN' lval
if. checkvalid__PARAMS y do. ( (caption__PARAMS y) , '__RF') =: (func__PARAMS y) 'OK' inlA__RF 'RETURN' lval
   else.( (caption__PARAMS y) , '__RF') =: [: (func__PARAMS y) inlA 'RETURN' lval end.
1
)