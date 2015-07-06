# records-j
records system (builds on type-system-j)

this project uses typesystem-j https://github.com/Pascal-J/type-system-j

It enhances J, with record data structures that can be used to provide multiple parameter functions with type validated and coerced paramters, as well as pre and post function call validation.

It is powerful enough to create single line GUI calls, and is one of the main benefits provided by a dynamic type system.  Also provided is a GUI builder to create records and forms

The form generator/system is provided for Jqt, but any backend including the web can be provided with the same creation interface.

New technologies include:

#type system

A type is a named classification function (returns boolean) on data.  Validators return errors when the classification result is false.  Coercers transform the data when the classifier is false such that the classifier would return true.  A simple type is num.  It is false when evaluated on a string, but can be attempted to be converted.  Maybenum is a more powerful type in that as a coercer '123' and 123 becomes a number, while 'abc' does not.  Maybenum coerced type, can be followed up with a num validated type such that both the inputs '123' and 234 are valid, and accepted by a function that operates on numbers.

types are easily created with a single line entry in a datadriven interface including documentation and error reporting.  Additional useful type manipulation functions are described in the typesys page linked above.  typesys-J is more powerful and flexible than any other programming language type system.  It works without modifying the raw data, and so is a completely optional modifier to functions that operate on any data.

#record system

records are not only useful for database applications, but they also model traditional language function signatures.  Records are made up of fields that can each have a type interaction (default values are part of the type system coercers).  An optional pre-coercer function (often to fill input with nulls if too few parameters are passed) operates before each field is typechecked, and an optional post validator can evaluate whether the entire record is valid after coercion steps.   Each field has a an optional coercer that runs before an optional validator.

records are objects that contain no data.  Instancing a record simply creates accessor verbs, and coercion and validation functions, and so provides 0 overhead/cost to the data, when not used.  Furthermore, literal accessor functions get "compiled away" into tacit J code.

#record builder
record definitions including all of the individual field and whole record processors can be built from a single string thank to a "multicut" function that is also one of the system defined type system coercers.  multicut is similar to csv parsing, except that multiple user defined nested delimiters are used to produce nested boxes.  ',`'&multicut boxes first by  `  separator, then inside those boxes again by ','.  Using a multicut coercer allows a function that expects boxed input to receive a single string.  The record builder is an example of such a flexible function.  There is an accompanying unmulticut to create delimited strings from boxes.

#recordform builder
also built from single line, that is either a record building string or record instance as right parameter, and some form specific parameters (boxed or in multicut format) as left parameter.  A recordform will callback a provided function, once all of the recordfield inputs are valid.   A recordform "control" is a vertical grid space (Jqt term that could easily be replaced by a html table row) that renders a record field, including space for help regarding the field (also defaults as tooltip content), that serves double duty for reporting field validation errors.  the form building parameters primarily provide this info, and also provide optional starting values for the fields.

#recordform controls
edit - default standard input box.  can pass edit password to have input masked.
passw - input box with password mask, with additional mask checkbox that makes the mask optional.
ignore"[0|1] - standard input box with checkbox labeled ignore.  when ignore is checked, callback function will be passed null for this parameter.  This is useful for using internal default parameters, while letting the user have a default alternate value, and letting the user save his input but have it ignored.  The 0|1 modifier is the initial setting for the checkbox.
clear"[0|1] - standard input box with additional checkbox labeled clear.  When clear is checked, the field will revert to starting value upon valid submission (OK)
checkbox["0|1] - used for 0/1 numeric input.

#freeform (micro) database
Partly a toy application, but remarkably useful.  
functional database.  right parameter to all functions is table stored in a noun.  All functions return new data.
functional approach allows console input of every data operation
empty database is i.0 0  
No field definitions.  Number of fields is number in longest record.  
All data is Maybenum: number or string automatically determined.  
All fields are lists or null.  Lists can be mixed type.  
Simple query mode is any field contains any query item (OR within field), and AND between fields.  Unspecified fields are ANY.  
A not version of simple query is also convenient.  
Selection may also be done by indexes.
Edits are done through update_first function.  The first item in filter is updated as if adding a new item.  
Delete first matched filter item is convenient.  
Mass updates are done through update_verb.  Each filtered item is passed to a dyadic J verb which can modify any field based on record. The default left verb parameter is the full table, but can be replaced with a provided one. See SAMPLES at bottom of todo.ijs for example update functions.
Mass deletes are done by saving filters.  

A recordform GUI allows all database operations from the same form.  Possible due to functional structure.  The GUI adds the ability to switch to any variable, save filters as data, or just use them as views, save to disk, viewlimits, and use custom functions based on a domain.
