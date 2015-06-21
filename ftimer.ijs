cocurrent 'form'
coinsert 'OOP'
callback =: ]
create =: 3 : 0
'fn fc' =: 2 $ boxopen y
form =: fn , > coname ''
)
NB.layouth =: (';' joinstring each (< 'bin h';'bin z') strbracket each [: ([: , onectrl &>)  each ,@('LAYOUT'&inl) { each [: <@,  'CONTROLS'&inl )@:boxopen
layouth =: ((< 'bin h';'bin z') strbracket each [: ([: , onectrl &>)  each ,@('LAYOUT'&inl) { each [: <@,  'CONTROLS'&inl )@:boxopen
layouth =: 3 : '(< ''bin h'';''bin z'') strbracket each  ([: , onectrl &>)  each LAYOUT { each  < CONTROLS' 
NB. layouth_ftimer_ <'ftimer'
onectrl =: 3 : 0 
'n t code' =. 3{. y , a:
select. t case. 'edit' do. val =. 'set ' , n ,'C' , ' text * ' , ": n~
lab =. 'cc ' , n ,'L  static center ; cn *', n
case. 'button' do. val =. 'cn *' , n 
lab =. ''end.
lab ; ('cc ' , n,'C ' ,t  ) ; val
)


restarti =: 3 : 0

( 'pshow ' ;~ 'pc ', form , ' closeok  ; pn ', (fn ORdef~ 'fc') , ';  bin v' ) strbracket , 'layouth a:' inl formlets
)

restart =: 3 : 0
try. wd 'psel ', form , '; pclose' catch. end.

wd S:0 restarti y
)
start =: restart@:formcodegen 
formcodegen =: 3 : 0
 (form '_' joinB 'close') =: 3 : 'callback a: [ wd  (''psel '', form , ''; pclose'')'
 for_f. formlets do. ks =. 0 2{"1 ] 3 $"1 &>(#~ (<'button') e.~ 1&{ &>)"1 CONTROLS__f
  for_k. ks do. 'n c'=. k
  (form '_' joinB 'button';~ n, 'C')
NB. (form '_' joinB 'button';~ n, 'C') =:  (c ql ' & ebN' locs__f) &ebN @:form2data bind end. end.
  (form '_' joinB 'button';~ n, 'C') =:  c ebNR @:form2data@:(3 : 'wdq')  end. end.
NB.('_' joinB 'button';~ n, 'C') =: c&ebN__f@:form2data end. end.
y
)
form2data =: 3 : 0 NB. y is wdq
 for_f. formlets do. ks =.  (a: (boxopen&.>@:,&<) <']' ) rplc~"1 ({. ,  {:)@:(3&{.) &>(#~ (<'edit') e.~ 1&{ &>) CONTROLS__f
   ks
   for_k. ks do. ({. k) assign__f each ( {: k) apply each ({:"1 #~ ('C' ,~ each {. k ) e.~ {."1) y end. end.
y
)


NB. ---------------------------------------------------------
cocurrent 'ftimer'
NB.coinsert 'form'
create =: 3 : 0
 NB. 'fname parent' =: y
 NB. pD form =: ,&(> coname '')^:('timer'&-:) pD fname
if. 'timer' -: y do.   parent =: 'timer' conew 'form' else. parent =: y end.

NB.form =: form__parent
  NB. form=:  'a', (o =.> 18!:5 '')
  NB. wd 'pc ' , form
  NB. COCREATOR ~.@:,~ assignwith 'formletNames' loc boxopen parent
   (coname '') ~.@:,~ assignwith 'formlets' loc boxopen parent
   NB.resume y
coinsert parent
18!:5 ''
)
NB. =========================================================

 stop =: 3 : 0
  
  wd 'psel '  , form
   wd 'ptimer 0'
)
resume =: 3 : 0
  (form , '_' ,'timer' locs) =: callback
   wd 'psel '  , form
   wd 'ptimer ', ": y
)
kill =: 3 : 0
   wd 'psel '  , form
   wd 'ptimer 0'
   wd 'pclose'
  codestroy ''
)
timerexample =: 3 : callbacks =: 'smoutput (> 18!:5 '''') ,'': '', ": (6!:0) '''''

fromy =: 3 : 0
 select. # boxopen y  case. 1 do.((*#y) {:: 'timerexample'; y) set interval 
 case. 2 do. set&>/ y
 case. 3 do. (". each {.y) schedulerx&> }. y end.
)
 
new =: 3 : 0
NB. (;: 'timer form') new y
'timer' new y
:
'callbacks interval runs' =: y dflt callbacks;interval;runs
pD y
 o =. x conew  ( 18!:5 '')
if. (L. y)*. 1=#y do. NB. use scheduler
callbacks =: < callbacks
CONTROLS =: 0 1 3 4 5 { CONTROLS 
LAYOUT =: <i.5 end.
 o
)

CONTROLS =: (9{a.) cut each cutLF 0 : 0
interval	edit	0&".
runs	edit	0&".
callbacks	edit	]
stop	button
resume	button	fromy callbacks ;] each interval [`,@.(_ > ]) runs
kill	button
)
NB. resume interval [ fromy callbacks ;] each interval [`,@.(_ > ]) runs


LAYOUT =: 0 1 3 4 5;2
interval =: 1000
runs =: _
callback =: ]
scheduler =: (' 1',~ 'run' loc [) set ]
schedulerx =: 4 : 0
 'iv times' =. y
 ('countdown' locs) =: times
 callbacks =: lr x
 iv set~ ('if. 0>: ' , 'countdown' locs , ' =: <: ' , 'countdown' locs , ' do. stop 0 end. '); ' 1' ,~ 'run' loc x
)
addscheduler =: (' 1',~ 'run' loc [) add ]

set=: 4 : 0 NB. x is explicit code to run/string.  y is miliseconds interval
if. y do.
  callbacks =: x
  callback =: 3 : (x ,&boxopen 'EMPTY')
  resume y
  
else.
  stop 0
end.
EMPTY
)
add =: 4 : 0
if. y do.
  callbacks = x
  callback =: (callback f.)`(3 : (x;'EMPTY'))
  sys_timer_z_=: callback"_ `:0
  wd 'ftimer ',":y
else.
  wd 'timer 0'
  sys_ftimer_z_=: ]
end.
EMPTY
)

NB. ---------------------------------------------------------
cocurrent 'timer'
NB.coinsert 'form'
create =: 3 : 0
 NB. 'fname parent' =: y
 NB. pD form =: ,&(> coname '')^:('timer'&-:) pD fname
if. 'timer' -: y do.   parent =: 'timer' conew 'form' else. parent =: y end.

NB.form =: form__parent
  NB. form=:  'a', (o =.> 18!:5 '')
  NB. wd 'pc ' , form
  NB. COCREATOR ~.@:,~ assignwith 'formletNames' loc boxopen parent
   (coname '') ~.@:,~ assignwith 'formlets' loc boxopen parent
   NB.resume y
coinsert parent
18!:5 ''
)
NB. =========================================================

 stop =: 3 : 0
  
  wd 'psel '  , form
   wd 'ptimer 0'
)
resume =: 3 : 0
  (form , '_' ,'timer' locs) =: callback 
   wd 'psel '  , form
   wd 'ptimer ', ": y
)
kill =: 3 : 0
   wd 'psel '  , form
   wd 'ptimer 0'
   wd 'pclose'
  codestroy ''
)
killC_button =: 3 : 'pD 33'
timerexample =: 3 : callbacks =: 'smoutput (> 18!:5 '''') ,'': '', ": (6!:0) '''''

fromy =: 3 : 0
 select. # boxopen y  case. 1 do.((*#y) {:: 'timerexample'; y) set interval 
 case. 2 do. scheduler&>/ y
 case. 3 do. ({.y) schedulerx&> }. y end.
)
 
new =: 3 : 0
NB. (;: 'timer form') new y
'timer' new y
:
'callbacks interval runs' =: y dflt callbacks;interval;runs
 o =. x conew  ( 18!:5 '')
if. (L. y)*. 1=#y do. NB. use scheduler
pD callbacks =. < callbacks
start__o ''
callbacks scheduler__o interval

NB. resume__o ''
 end.

 o
)

CONTROLS =: (9{a.) cut each cutLF 0 : 0
interval	edit	0&".
runs	edit	0&".
stop	button
resume	button	resume interval
kill	button
)
NB. resume	button	fromy  callbacks ;] each interval [`,@.(_ > ]) runs


LAYOUT =: < 0 1 2 3 4 
interval =: 1000
runs =: _
callback =: ]
scheduler =: (' 1',~ 'run' loc [) set ]
schedulerx =: 4 : 0
 'iv times' =. y
 ('countdown' locs) =: times
 
 iv set~ ('if. 0>: ' , 'countdown' locs , ' =: <: ' , 'countdown' locs , ' do. wd ''timer 0'' end. '); ' 1' ,~ 'run' loc x
)
addscheduler =: (' 1',~ 'run' loc [) add ]

set=: 4 : 0 NB. x is explicit code to run/string.  y is miliseconds interval
if. y do.
  NB. callbacks =: x
  callback =: 3 : (x ,&boxopen 'EMPTY')
  resume y
  
else.
  stop 0
end.
EMPTY
)
add =: 4 : 0
if. y do.
  NB.callbacks = x
  callback =: (callback f.)`(3 : (x;'EMPTY'))
  sys_timer_z_=: callback"_ `:0
  wd 'ftimer ',":y
else.
  wd 'timer 0'
  sys_ftimer_z_=: ]
end.
EMPTY
) 

cocurrent 'base'
t =: 0 : 0
  a =. 'smoutput (> 18!:5 '''') ,'': '', ": (6!:0)' new_ftimer_ 5000
   b =. new_ftimer_ 6000                  NB. uses locale's timerexample (overridable) as callback


 kill__a ''
 stop__b ''
 resume__b 3000
 kill__b ''
)