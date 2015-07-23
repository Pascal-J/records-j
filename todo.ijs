 MYDIR =: getpath_j_  '\/' rplc~ > (4!:4<'thisfile'){(4!:3)  thisfile=:'' NB. boilerplate to set the working directory
require MYDIR , 'records.ijs'

NB. microdatabase or freeform database
coclass__OOP 'ffdb'
coinsert 'typesys'
coinsert 'record'
create =: go
destroy =: codestroy"0@:(3 : 'co, r')

multicut =: [:>[:cut leaf/ ([: <"_1 ({&a.)^:(1 4  e.~ 3!:0)@:linearize@:maybenum@:[) (, <) ]
unmulticut =: [ (([ [^:('' -: ]) leaf joinstring (L:1)) reduce) ('&level'  ,~ ":@#@[) vV ]
unmulticut =: [ (([ [^:('' -: ]) leaf joinstring (L:1)) reduce) ": leaf@:] NB. to get string, level must be = to #@[.  Smaler #@[ can be useful.
additem=: ] , [: maybenum leaf ',|' multicut [
NB.($~ {:@$@])
deleteitem =:] ({. , >:@[ }. ])~ boxopen@:[ i.~ {."1@:]
deleteitem =: ] -. 1 take filtered
sorted =: ] {~ /:@:({"1)


filtered =: ] #~ [: *./"1 ] (('' -: ]) +. +./@:e.)&>"1 [: maybenum leaf ',|' multicut [

amdt =:2 : '(u"_ (v{ ]))`(v"_@:])`]} ]'
take =: 1&$: : ((<. #) {. ])
 filteredI =: [: I. [: *./"1 ] (('' -: ]) +. +./@:e.)&>"1 [: maybenum leaf ',|' multicut [ 
 update =: 2 : ' (, m additem i.0 0)"_ amdt  (1 take n&filteredI@:])'  NB. data only update
updateV =: 2 : ' u amdt  (n&filteredI@:])'
NB. modify purgeold to archive
uncutrecs =: ';|,' (unmulticut <"1) ]
PARAMS =: DEF_record_ 'variable str ; additem ; delete_item ; filtered ; notfiltered ; index_filter int; update1st_filtered ; verb_update ; sort_columns int ; save int 3&count 0 1&inrange '
sample =:  'field|initval|control|help|tooltip'additem i.0 0
cb =: 3 : 0 
if. a: -: y do. y return. end.
pD o =.  ] assignwithC (i.0 0) variable__PARAMS y
NB.if. 0 < # additem__PARAMS y do. o =. o additem~  '`,' unmulticut colcount ((>.#) {. ]) ',`' multicut pD additem__PARAMS y end.
if. 0 < # additem__PARAMS y do. o =.  o additem~  pD additem__PARAMS y end.
if. 0 < # delete_item__PARAMS y do. o =. o deleteitem~ '|,' unmulticut ({: $ o) ((>.#) {. ]) ',|' multicut delete_item__PARAMS y end.
o2 =.o
if. 0 < # filtered__PARAMS y do. o2 =. o2 filtered~ '|,' unmulticut ({: $ o2) ((>.#) {. ]) ',|' multicut filtered__PARAMS y end.
if. 0 < # notfiltered__PARAMS y do. o2 =. o2 (filtered -.~ ])~ '|,' unmulticut ({: $ o2)((>.#) {. ]) ',|' multicut notfiltered__PARAMS y end.
if. 0 < # index_filter__PARAMS y do. o2 =. o2 {~ ,@:index_filter__PARAMS y end.
if. 0 < # update1st_filtered__PARAMS y do. o2 =. o =. (, ('|,' unmulticut  ({: $ o2) ((>.#) {. ]) ',|' multicut update1st_filtered__PARAMS y) additem i.0 0)"_ amdt (linearize 1 take o i. 1 take o2) o 
  elseif.  0 < # verb_update__PARAMS y do.  o2 =. o =. ((verb_update__PARAMS y) eval) amdt (linearize o i.  o2) o end.
if. {. save__PARAMS y do. (variable__PARAMS y) assign (o ,&< o2) {::~ 1 { save__PARAMS y 
  if. {: save__PARAMS y do. (3!:1 o) fwrite MYDIR , (variable__PARAMS y) , '.ffdb' end. end.
((variable__PARAMS y) ;&< headerCols)  hout__co ((#~ ({: $ o2) > ]) sort_columns__PARAMS y) sorted^:(0 < # sort_columns__PARAMS y)  o2 
pD uncutrecs (variable__PARAMS y)~
(variable__PARAMS y)~
)

go =: 3 : 0 NB. x is boxed or space delimited: var columncount headersforeachcolumn list
NB.a: go y
NB. :
 NB.in =. ( cut^:(0 = L.) x) dflt 'sample';6; ;:'task time priority category client cost'
NB.'var colcount' =: 2 {. in
NB.headerCols =:  colcount take 2 }. in
headerCols =: y 'var callback' varargs 'sample';a:
NB.var =. > var
pD callback =.'cb' locs ,~ '@:',~^:(0<#@]) callback
NB.pD callback =. '(', callback , ' [ ' , 'pD@:',('uncutrecs' locs) , ')'
fp =. 'ffdb ; freeform data; Creates table saved in variable ;cb__Cffdb__OOP;' , var , '` ` ` ` ` ` ` `0`1 0 0 ; edit`clear`clear`ignore"0`ignore"0`ignore"0`clear`ignore"0`ignore"1`clear ;'
NB.fp =. fp , (>x), '`30` ` ` ` ` ` ` `24`0`2 1`1` ;'
fp =. fp , 'Variable name (locale qualified recommended) to read and update`add an item: separate fields with backtick. separate items within field with ,`deletes all identical copies of first item matching filter (set clear off to repeat deletes)`Filters OR within fields.  AND between fields.  Enter blank field as ,.  Blanks filter as any.`Same input as filtered. Returns non matches. Can pretest for delete.`index numbers (unsorted) are filter. Space separator.`uses one filter (preferred top to bottom) input to select items.  Updates first item filtered to new data (like additem format)`Uses dyadic J verb to update records selected by flitered or not filtered.right argument is filtered records.  left is full table or passed parameters.  Must return same number of items as selected by filtered` Ignore to not sort. Numbers are column indexes in sort order.`Overwrites variable name with results of add delete update if first number is 1. Saves filtered data if 2nd number is 1. Saves variable to disk if 3rd number is 1' 
start_consoleform_ co =: (callback, ';hello world') DEF_consoleform_ r =: fp DEFfromR_recordform_ PARAMS
NB. start_consoleform_ co =: '`;hello world' DEF_consoleform_ r =: ('pass ; password for life;cb__; ; passw`edit ; enter long password you will remember ` numbers are good') DEF_recordform_ 'password str `7&mthan; other int`3 5&inrange 0&gthan 22&lthan'
(var ;&< headerCols)  hout__co  ] assignwithC (i.0 0) var
var~
)
NB. version with backtick ` instead of | separator
coclass__OOP 'ffdbbt'
coinsert 'ffdb'
additem=: ] , [: maybenum leaf ',`' multicut [
filtered =: ] #~ [: *./"1 ] (('' -: ]) +. +./@:e.)&>"1 [: maybenum leaf ',`' multicut [
filteredI =: [: I. [: *./"1 ] (('' -: ]) +. +./@:e.)&>"1 [: maybenum leaf ',`' multicut [ 
uncutrecs =: ';`,' (unmulticut <"1) ]
sample =:  'field`initval`control`help`tooltip'additem i.0 0
cb =: 3 : 0 
if. a: -: y do. y return. end.
pD o =.  ] assignwithC (i.0 0) variable__PARAMS y
if. 0 < # additem__PARAMS y do. o =.  o additem~  pD additem__PARAMS y end.
if. 0 < # delete_item__PARAMS y do. o =. o deleteitem~ '`,' unmulticut ({: $ o) ((>.#) {. ]) ',`' multicut delete_item__PARAMS y end.
o2 =.o
if. 0 < # filtered__PARAMS y do. o2 =. o2 filtered~ '`,' unmulticut ({: $ o2) ((>.#) {. ]) ',`' multicut filtered__PARAMS y end.
if. 0 < # notfiltered__PARAMS y do. o2 =. o2 (filtered -.~ ])~ '`,' unmulticut ({: $ o2)((>.#) {. ]) ',`' multicut notfiltered__PARAMS y end.
if. 0 < # index_filter__PARAMS y do. o2 =. o2 {~ ,@:index_filter__PARAMS y end.
if. 0 < # update1st_filtered__PARAMS y do. o2 =. o =. (, ('`,' unmulticut  ({: $ o2) ((>.#) {. ]) ',`' multicut update1st_filtered__PARAMS y) additem i.0 0)"_ amdt (linearize 1 take o i. 1 take o2) o 
  elseif.  0 < # verb_update__PARAMS y do.  o2 =. o =. ((verb_update__PARAMS y) eval) amdt (linearize o i.  o2) o end.
if. {. save__PARAMS y do. (variable__PARAMS y) assign (o ,&< o2) {::~ 1 { save__PARAMS y 
  if. {: save__PARAMS y do. (3!:1 o) fwrite MYDIR , (variable__PARAMS y) , '.ffdb' end. end.
((variable__PARAMS y) ;&< headerCols)  hout__co ((#~ ({: $ o2) > ]) sort_columns__PARAMS y) sorted^:(0 < # sort_columns__PARAMS y)  o2 
pD uncutrecs (variable__PARAMS y)~
(variable__PARAMS y)~
)

coclass__OOP 'formbuilder'
coinsert 'record'
create =: gof
destroy =: codestroy"0@:(3 : 'co, r')
PARAMS =: DEF_record_ RPsample =:  'name_F str`2&mthan; title_F ; prompt_F ; callback_F pDlr_recordform_&d 3&evalto;okcaption OK&d; FP_var FP&d localized; RP_var RP&d localized;rec_preCoercer; rec_postFunction; recordF'
RP =: (LF,'|,') multicut <LF
pD (LF,'|,') unmulticut <"1 RP =: >(LF,~',|') multicut  ] 98 111 98 32 110 117 109 32 51 38 103 116 104 97 110 124 51 10 115 117 101 124 44{a.

buildFPsample =: 3 : 0 NB. y ignored.  used to create large sample form for testing.
RPsample =: 'name_F str,2&mthan;title_F ;prompt_F ;callback_F pDlr_recordform_&d 3&evalto;okcaption OK&d; FP_var FP&d localized; RP_var RP&d localized;rec_preCoercer; rec_postFunction; recordF'
r =. dltb leaf ';' multicut RPsample
NB.r =. (';',~LF) multicut RPsample
fp =.'`;' multicut 'fbsample;recordform builder;Use fields button to add fields using ffdb interface;', 'fcb' , ';edit`edit`edit`edit`edit`ignore"1`ignore"1`auto"0`auto"0`autom"1'

fpp =.  (' ';' ';' ';'pDlr_recordform_';' ';'' ;'';' ';' ';' ')
 pD  '1&level'&cV each |: r , fpp,: (> {: fp)
 ( (LF,'|,') unmulticut <"1 RPsample =: '1&level'&cV each  |: r , fpp,: (> {: fp)) <@:[ amdt _1 fpp
NB.( (LF,'|,') unmulticut <"1 RPsample =: |: r , fpp,: (> {: fp)) <@:[ amdt _1 fpp
)

gof =: 3 : 0
NB. pD '`'unmulticut defs =.  dflt&('FP RP';' ';' ';' ';'pDlr_recordform_';' ';' ';' '; (LF,~',|') unmulticut RP )  '96&cut 9&count  _ _ 1 _ _ _ _ _ _&copies' c y
 ] assignwithC (' ';' ';' ';'pDlr_recordform_';' ';'FP' locs ;'RP' locs;' ';' ';(LF,'|,') unmulticut <"1 RP) 'FP'
 pD '`'unmulticut defs =.  dflt&FP  '96&cut 10&count  _ 0 _ _ _ _ _ _ _ _&copies' c y
pD callback =. 'fcb' locs
fpi =. 'form name (usually just seen in error messages. but must be 2 letters+ long)`form titlebar caption`upper left text prompt`function called when OK pressed`Caption for OK button (can leave blank)`localized Variable that will save these form parameters.  If Auto set, will use default form (FP) variable. locs function usually used to automatically localize.`localized Variable that saves just the recordF parameters.  Auto will will use default form (RP) variable.`Coercer functions applied to whole record prior to individual field coercers.  Auto will add null values to any missing fields (individual fields can have defaults), force a limit on parameters, and provide a backtick delimited string interface to the record.`J function will be called after all coercers.  It should return what is intended to be valid record input.`The fields button will use ffdb interface to edit this content.  Here, one line per field.  Name [coercers],[validators] (separate coercers from validators with comma)|initial value|control type|Explanation Text|Tooltip .  If all fields have initial blank, and are edit controls, and you don''t want explanation text, then only field name needs input.  If you input some initvals/controls/explanations/tooltips, input values for all.  Auto will ignore this field, and read from variable name when fields button, and automatically update this field and variable when field editor OK is pressed.'
co =: (callback, ';OK will print form parameters in J console and below.  Fields provides an advanced database interface to editing the recordF content.  Preview will launch the generated form.') DEF_consoleform_ r =: ('fb;recordform builder;Use fields button to add fields using ffdb interface;', callback , ';', ('`'unmulticut defs),';edit`edit`edit`edit`edit`auto"0`auto"0`auto"1`auto"0`autom"0;',fpi ) DEFfromR_recordform_ PARAMS
(('gopreview' locs),';Preview;10;1') DEF_buttonadd_(('gofields' locs),';fields;10;1') DEF_buttonadd_ r
start_consoleform_ co
('Current valid Control list',&< ;: 'name core_type setcode')hout__co CNTRLLOOKUP_recordform_
)
rcb =: 3 : 0
if. a: -: y do. y return. end.
NB. pD CONTROLS__r
NB.
NB.  pD  (LF,'|,') unmulticut (',|',LF) (multicut ) (LF,'|,') unmulticut <"1 y
NB. pD lr (LF,'|,')  unmulticut <"1 y
NB. NB. wd__r S:0 setCtrl__r/ pD (recordF__PARAMS CONTROLS__r) ;  (LF,'|,') unmulticut <"1 y
NB. pD RETURN__r
wd 'psel ', form__r 
'fields updated if auto is set' hout__co  > cutLF (LF,'|,') unmulticut <"1 y
NB.wd 'psel ', form__r 
if. '__' -.@-: recordF__PARAMS RETURN__r do. wd__r  'set recordFC text *',  (LF,'|,') unmulticut <"1 y end.
NB.if. '__' -.@-: recordF__PARAMS RETURN__r do. wd S:0 setCtrl__r/ pD (recordF__PARAMS CONTROLS__r) ;  (LF,'|,') unmulticut <"1 y end.
y
)
fcb =: 3 : 0
if. a: -: y do. y return. end.
rp =. ('RP&d localized' cV  ''"_^:('__' -:] )RP_var__PARAMS  y)
y assign~ ('FP'"_^:('__' -:] )FP_var__PARAMS  y)
if. '__' -.@-: recordF__PARAMS RETURN__r do. (rp) assign pD ',|' (multicut dltb)"1 > cutLF recordF__PARAMS y end.
('recordF input',&< ;: 'name initval control explanation tooltip') hout__co rp~
 rcnt =. (": # >0 {"1 rp~),'&count'
 pc =.  (9 32 { a.),^:(0 < #@]) ('96&cut ' , rcnt"_)^:('__' -:] ) rec_preCoercer__PARAMS y
 pf =.  (9 32 { a.),^:(0 < #@]) rec_postFunction__PARAMS y
'record parameters' hout__co  R =. dltb (pD ';`' unmulticut  0 {"1 rp~) ,pc,pf
pD   (< okcaption__PARAMS y),~ 8{. (0 1 2 3 { y) ,  , each '1&level' <@cV"1  }. |: rp~
'recordform (x) parameters' hout__co  (';`' unmulticut pD '2&level'&cV every (< okcaption__PARAMS y),~ 8{. (0 1 2 3 { y) ,  , each '1&level' <@cV"1  }. |: rp~) 
pD every sfX (';`' unmulticut pD '2&level'&cV every  (< okcaption__PARAMS y),~ 8{. (0 1 2 3 { y) ,  , each '1&level' <@cV"1  }. |: rp~) ,&< dltb R
NB. ';' unmulticut '`' unmulticut "1
)
gopreview =: 3 : 0
o =.  pD fcb y
pD $ each o
NB. reassign crashes J804
NB.'rect' reassign DEF_record_ pD dltb 1 {:: o
NB.start__rt a: [ 'rt' reassign (dltb 0{:: o) DEFfromR__Crecordform__OOP rect
rect =: DEF_record_ pD dltb 1 {:: o
start__rt a: [ rt =: (dltb 0{:: o) DEFfromR__Crecordform__OOP rect

)
gofields =: 3 : 0
NB.vh =. cut 'FP RP'"_ ^:(0=#) var_holders__PARAMS y
pD rp =. ('RP&d localized' cV  ''"_^:('__' -:] )RP_var__PARAMS  y)
if. '__' -.@-: recordF__PARAMS y do.   (rp) assign ',|' (multicut dltb)"1 > cutLF recordF__PARAMS y end.
recf =: New_ffdb_ (rp); 'rcb'locs ; ;: 'name initvals controls instructions tooltips'
)
NB. formbuilderception example:
NB. f =. New_formbuilder_ buildFPsample_formbuilder_ a:
NB.reinvert proc example: ',`' (multicut_todo_ dltb)"1  '`,' unmulticut_todo_"1 sample_todo_
NB. > (',`',LF)(multicut ) (LF,'`,') unmulticut <"1 sample_todo_
coclass__OOP 'todo'
coinsert 'ffdbbt'
purgeold =: 4 : ''',`_24,_23,_22,_21,_20,_19,_18,_17,_16,_15,_14,_13,_12,_11,_10,_9,_8,_7,_6,_5,_4,_3,_2,_1`,`,`,'' (filtered -.~ ]) (-&x leaf@:]  amdt 1)"1@:]  updateV '',`,`,`,`,'' y'

NB. version with checkboxes: PARAMS =: DEF_record_ 'variable str ; viewlimit int ; additem ; delete_item ; filtered ; notfiltered ; update1st_filtered ; verb_update ; purge_old int`24&lthan ; backup_purged int; sort_columns int ; save int; writedisk int'
sortedview =: (;: 'task time priority category'), sorted

PARAMS =: DEF_record_ 'variable str ; viewlimit int ; additem ; delete_item ; filtered ; notfiltered ; index_filter int; update1st_filtered ; verb_update ; purge_old int 3&count `24&lthan 3&count ;  sort_columns int ; save int 3&count 0 1&inrange '
sample =:  'work`9,10,11,14,15,16`,`programming,todo list`jsoftware' additem 'lunch,Jane`37`4`life,routine,Jane' additem 'lunch`13,14`4`life,routine'additem'get a phone`,`8`shopping'additem i.0 0
cb =: 3 : 0 
if. a: -: y do. return. end.
pD o =.  ] assignwithC (i.0 0) variable__PARAMS y
NB.if. 0 < # additem__PARAMS y do. o =. o additem~  '`,' unmulticut colcount ((>.#) {. ]) ',`' multicut pD additem__PARAMS y end.
if. 0 < # additem__PARAMS y do. o =.  o additem~  pD additem__PARAMS y end.
if. 0 < # delete_item__PARAMS y do. o =. o deleteitem~ '`,' unmulticut ({: $ o) ((>.#) {. ]) ',`' multicut delete_item__PARAMS y end.
o2 =.o
if. 0 < # filtered__PARAMS y do. o2 =. o2 filtered~ '`,' unmulticut ({: $ o2) ((>.#) {. ]) ',`' multicut filtered__PARAMS y end.
if. 0 < # notfiltered__PARAMS y do. o2 =. o2 (filtered -.~ ])~ '`,' unmulticut ({: $ o2)((>.#) {. ]) ',`' multicut notfiltered__PARAMS y end.
if. 0 < # index_filter__PARAMS y do. o2 =. o2 {~ ,@:index_filter__PARAMS y end.
if. 0 < # update1st_filtered__PARAMS y do. o2 =. o =. (, ('`,' unmulticut  ({: $ o2) ((>.#) {. ]) ',`' multicut update1st_filtered__PARAMS y) additem i.0 0)"_ amdt (linearize 1 take o i. 1 take o2) o 
  elseif.  0 < # verb_update__PARAMS y do.  o2 =. o =. ((verb_update__PARAMS y) eval) amdt (linearize o i.  o2) o end.
if. 0 < # purge_old__PARAMS y do. ('`"' unmulticut (a: $~ {: $ o) timecol}~ <  ;/ - >: i. >:hours)  (filtered -.~ ]) (-&hours leaf@:]  amdt timecol)"1@:] amdt (linearize o i.  o2) o [ 'hours backup timecol' =.purge_old__PARAMS y   end.  NB. applies to filtered. backup not implemented
if. {. save__PARAMS y do. (variable__PARAMS y) assign (o ,&< o2) {::~ 1 { save__PARAMS y 
  if. {: save__PARAMS y do. (3!:1 o) fwrite MYDIR , (variable__PARAMS y) , '.ffdb' end. end.
(var ;&< headerCols)  hout__co (viewlimit__PARAMS y) take ((#~ ({: $ o2) > ]) sort_columns__PARAMS y) sorted^:(0 < # sort_columns__PARAMS y)  o2 
)

NB. checkbox version
NB. go =: 3 : 0 NB. x is boxed or space delimited: var columncount headersforeachcolumn list
NB. a: go y
NB. :
NB.  in =. ( cut^:(0 = L.) x) dflt 'sample';6; ;:'task time priority category client cost'
NB. 'var colcount' =: 2 {. in
NB. headerCols =:  colcount take 2 }. in
NB. fp =. 'todo ; todo list; modifies todo list. ;cb__Ctodo__OOP;' , var , '`30` ` ` ` ` ` ` 24`0`2 1`1`0 ; edit`ignore"0`clear`clear`ignore"0`ignore"0`clear`ignore"0`ignore`checkbox`ignore"0`checkbox`checkbox ;'
NB. NB.fp =. fp , (>x), '`30` ` ` ` ` ` ` `24`0`2 1`1` ;'
NB. fp =. fp , 'Variable name to read and update`limit on todo items listed`add an item: separate fields with backtick, separate items within field with "`deletes all identical copies of first item matching filter (set clear off to repeat deletes)`Filters OR within fields.  AND between fields.  Enter blank field as ".  Blanks filter as any.`Same input as filtered. Returns non matches. Can pretest for delete.`uses filtered (preferred) or not filtered input to select items.  Updates first item to field (like additem format)`Uses dyadic J verb to update records selected by flitered or not filtered.right argument is filtered records.  left is full table.  Must return same number of items as selected by filtered`reduces all "times" (field 2) by number (24 recommended).  Deletes negative "times".  Works only if all other fields ignored or blank`backs up purgedold data to disk. Filenames are meaningful if consistent period used, and purge is up to date`sorts by columns. Ignore to not sort`Overwrites variable name with results (view limit doesnt affect variable)`Saves variable to disk' 
NB. start_consoleform_ co =: 'cb__Ctodo__OOP;hello world' DEF_consoleform_ r =: fp DEFfromR_recordform_ PARAMS
NB. NB. start_consoleform_ co =: '`;hello world' DEF_consoleform_ r =: ('pass ; password for life;cb__; ; passw`edit ; enter long password you will remember ` numbers are good') DEF_recordform_ 'password str `7&mthan; other int`3 5&inrange 0&gthan 22&lthan'
NB. (var ;&< headerCols)  hout__co 30 take 2 1 sorted var~
NB. )

NB. needs small change to support new objects.  As is, call directly main class go_todo_.
go =: 3 : 0 NB. x is boxed or space delimited: var columncount headersforeachcolumn list
a: go y
:
 in =. ( cut^:(0 = L.) x) dflt 'sample';6; ;:'task time priority category client cost'
'var colcount' =: 2 {. in
headerCols =:  colcount take 2 }. in
fp =. 'todo ; todo list; modifies todo list. ;cb__Ctodo__OOP;' , var , '`30` ` ` ` ` ` ` `24 0 1`2 1`1 0 0 ; edit`edit`clear`clear`ignore"0`ignore"0`ignore"0`clear`ignore"0`ignore"1`ignore"0`clear ;'
NB.fp =. fp , (>x), '`30` ` ` ` ` ` ` `24`0`2 1`1` ;'
fp =. fp , 'Variable name to read and update`limit on items listed. _ is all`add an item: separate fields with backtick, separate items within field with "`deletes all identical copies of first item matching filter (set clear off to repeat deletes)`Filters OR within fields.  AND between fields.  Enter blank field as ".  Blanks filter as any.`Same input as filtered. Returns non matches. Can pretest for delete.`index numbers (unsorted) are filter. Space separator.`uses one filter (preferred top to bottom) input to select items.  Updates first item to field (like additem format)`Uses dyadic J verb to update records selected by flitered or not filtered.right argument is filtered records.  left is full table.  Must return same number of items as selected by filtered`reduces all "times" by number (24 recommended). Then deletes negative "times". 2nd number if 1, backsup purged records. 3rd number is column with time data.` Ignore to not sort`Overwrites variable name with results of add delete update if first number is 1. Saves filters if 2nd number is 1. Saves variable to disk if 3rd number is 1' 
start_consoleform_ co =: 'cb__Ctodo__OOP;hello world' DEF_consoleform_ r =: fp DEFfromR_recordform_ PARAMS
NB. start_consoleform_ co =: '`;hello world' DEF_consoleform_ r =: ('pass ; password for life;cb__; ; passw`edit ; enter long password you will remember ` numbers are good') DEF_recordform_ 'password str `7&mthan; other int`3 5&inrange 0&gthan 22&lthan'
(var ;&< headerCols)  hout__co 30 take 2 1 sorted ] assignwithC (i.0 0) var
)

NB. SAMPLES

NB. ((< each ;/7 3) ([  amdt 4)"0 1 ]) updateV 'lunch`"`"`"`"' sample
NB. ((< each ;/71 13) (,. L:1 amdt 4)"0 1 ])  NB. inserts into field 4 seperate leading items for 2 filtered records.
NB. ((<< 22)  amdt  2)"_ 1 updateV 'lunch`"`"`"`"' sample  NB. sets field2 to <22 for all records in filter
NB. ((<< 'ignore'  ) amdt 2)  NB. "_ not needed.  updates all field2's in filter to text ignore.
NB. ((< each ;/71 13) (+ L:0 amdt 4)"0 1 ])  NB. add 71 13 to individual fields in filter (if each record has 1 field, then add different to each record.  if each record has 2 fields, then shape still matches and will add the same to both records)
NB. (( ;/71 13) (, L:0 amdt 2)"0 1 ])  NB.append 1 value inside each of 2 records