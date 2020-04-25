/#############Example 1 – Atom and List Formation

/ Note that the comments begin with a slash “ / ” and cause the parser
/ to ignore everything up to the end of the line.

x: `mohan              / `mohan is a symbol, assigned to a variable x
type x                 / let’s check the type of x
-11h                   / -ve sign, because it’s single element.

y: (`abc;`bca;`cab)    / list of three symbols, y is the variable name.

type y
11h                    / +ve sign, as it contain list of atoms (symbol).

y1: (`abc`bca`cab)     / another way of writing y, please note NO semicolon

y2: (`$"symbols may have interior blanks")   / string to symbol conversion
y[0]                   / return `abc
y 0                    / same as y[0], also returns `abc
y 0 2                  / returns `abc`cab, same as does y[0 2]

z: (`abc; 10 20 30; (`a`b); 9.9 8.8 7.7)      / List of different types,
z 2 0                  / returns (`a`b; `abc),
z[2;0]                 / return `a. first element of z[2]

x: "Hello World!"      / list of character, a string
x 4 0                  / returns “oH” i.e. 4th and 0th(first) element






/################################################################
/       Q Language - Type Casting
/################################################################

a:9 18 27

$[`float;a]     / Specify desired data type by its symbol name, 1st way
9 18 27f

$["f";a]        / Specify desired data type by its character, 2nd way
9 18 27f

$[9h;a]         / Specify desired data type by its short value, 3rd way
9 18 27f


/Check if all the three operations are equivalent,
($[`float;a]~$["f";a]) and ($[`float;a] ~ $[9h;a])


//Casting Strings to Symbols
b: ("Hello";"World";"HelloWorld")    / define a list of strings

b
"Hello"
"World"
"HelloWorld"

c:`$b                               / this is how to cast strings to symbols

c                                    / Now c is a list of symbols
`Hello`World`HelloWorld

c[0]

b[0]


//Attempting to cast strings to symbols using the keyed words `symbol or 11h will fail with the type erro
b
"Hello"
"World"
"HelloWorld"

`symbol$b /will give error


11h$b  /will give error




//Casting strings to a data type other than symbol is accomplished as follows
b:900               / b contain single atomic integer

c:string b          / convert this integer atom to string “900”

c
"900"

`int $ c            / converting string to integer will return the
                      / ASCII equivalent of the character “9”, “0” and
                      / “0” to produce the list of integer 57, 48 and
                      / 48.
57 48 48i

6h $ c              / Same as above
57 48 48i

"i" $ c             / Same a above
57 48 48i

"I" $ c            //CORRECT
900i




/###############################################################################
/Q Language - Temporal Data
/###############################################################################
//Date
x:2015.01.22      / This is how we write 22nd Jan 2015

`int$x            / Number of days since 2000.01.01
5500i

`year$x           / Extracting year from the date
2015i

x.year            / Another way of extracting year
2015i

`mm$x             / Extracting month from the date
1i

x.mm              / Another way of extracting month
1i

`dd$x             / Extracting day from the date
22i

x.dd              / Another way of extracting day
22i



//Arithmetic and logical operations can be performed directly on dates.
x+1        / Add one day
2015.01.23

x-7        / Subtract 7 days
2015.01.15



//Times
tt1: 03:30:00.000     / tt1 store the time 03:30 AM

tt1
03:30:00.000

`int$tt1              / Number of milliseconds in 3.5 hours
12600000i

`hh$tt1               / Extract the hour component from time
3i

tt1.hh
3i

`mm$tt1               / Extract the minute component from time
30i

tt1.mm
30i

q)`ss$tt1               / Extract the second component from time
0i

q)tt1.ss
0i


//Datetimes
//combination of a date and a time, separated by ‘T’ as in the ISO standard format.
dt:2012.12.20T04:54:59:000      / 04:54.59 AM on 20thDec2012

type dt
-15h

dt
2012.12.20T04:54:59.000

`float$dt
4737.205


/##############################################################################
//Q Language - Lists
/##############################################################################
/(9;8;7)    or  ("a"; "b"; "c")   or   (-10.0; 3.1415e; `abcd; "r")

(9;8;7)      
("a"; "b"; "c")     
(-10.0; 3.1415e; `abcd; "r")

type 9 8 7
type (9;8;7) 




l1:(-10.0;3.1415e;`abcd;"r") 
count l1



//Examples of simple List
h:(1h;2h;255h)                    / Simple Integer List

h
1 2 255h

f:(123.4567;9876.543;98.7)        / Simple Floating Point List

f
123.4567 9876.543 98.7

b:(0b;1b;0b;1b;1b)                / Simple Binary Lists

b
01011b

symbols:(`Life;`Is;`Beautiful)    / Simple Symbols List

symbols
`Life`Is`Beautiful

chars:("h";"e";"l";"l";"o";" ";"w";"o";"r";"l";"d") 
                                    / Simple char lists and Strings.
chars
"hello world"

count chars

count "hello world"

//To create a single item list, we use −
singleton:enlist 42

singleton


//To distinguish between an atom and the equivalent singleton, examine the sign of their type.
signum type 42

signum type enlist 42


//Q Language - Indexing
//Given a list L, the item at index i is accessed by L[i]. Retrieving an item by its index is called item indexing. For example,
L:(99;98.7e;`b;`abc;"z")

L[0]
99

L[1]
98.7e

L[4]
"z"


//Indexed Assignment
//Items in a list can also be assigned via item indexing. Thus,
L1:9 8 7

L1[2]:66      / Indexed assignment into a simple list
                / enforces strict type matching.
                
L1


//Lists from Variables
l1:(9;8;40;200)

l2:(1 4 3; `abc`xyz)

l:(l1;l2)               / combining the two list l1 and l2

l
9 8 40 200
(1 4 3;`abc`xyz)

l[0]
l[1]
l[1][0]
l[1][1][0]
l[1][1][0][0]



/###############################################################################
/Joining Lists
/###############################################################################
1,2 3 4
1 2 3 4

1 2 3, 4.4 5.6     / If the arguments are not of uniform type,
                     / the result is a general list.

x:1 2 3, 4.0
x
y:1 2 3, 4
y

type x
type y


/###############################################################################
//Nesting
//Data complexity is built by using lists as items of lists.
/###############################################################################
l1:(9;8;(99;88))

count l1
3

/Here is a list of depth 3 having two items −
l5:(9;(90;180;900 1800 2700 3600))
l5
9
(90;180;900 1800 2700 3600)


count l5
2

count l5[1]
3

l5[1][2][3]
3600

//Notation for Indexing at Depth
l5[1; 2; 3]


///////Elided Indices
L:((1 2 3; 4 5 6 7); (`a`b`c;`d`e`f`g;`0`1`2);("good";"morning"))
L
(1 2 3;4 5 6 7)
(`a`b`c;`d`e`f`g;`0`1`2)
("good";"morning")



L[;1;] //Retrieve all items in the second position of each list at the top level.
4 5 6 7
`d`e`f`g
"morning"


L[;;2] //Retrieve the items in the third position for each list at the second level.
3 6
`c`f`2
"or"




/###############################################################################
/Q Language - Dictionaries
/domain → Range”
/or
/key -> value
/###############################################################################
d:`Name`Age`Sex`Weight!(`John;36;"M";60.3)   / Create a dictionary d

d

/Name   | `John
/Age    | 36
/Sex    | "M"
/Weight | 60.3

count d             / To get the number of rows in a dictionary.
4

key d               / The function key returns the domain
`Name`Age`Sex`Weight

value d             / The function value returns the range.
`John
36
"M"
60.3


cols d             / The function cols also returns the domain.
`Name`Age`Sex`Weight


//Lookup
d[`Name]       / Accessing the value of domain `Name
`John

d[`Name`Sex]   / extended item-wise to a simple list of keys
`John
"M"


//Lookup with Verb @
d1:`one`two`three!9 18 27

d1[`two]
18

d1@`two
18

/###############################################################################
/Operations on Dictionaries
/###############################################################################
/Amend and Upsert
d:`Name`Age`Sex`Weight! (`John;36;"M";60.3)
                                  / A dictionary d
                                  
d[`Age]:35                      / Assigning new value to key Age

d 
/ New value assigned to key Age in d
/Name   | `John
/Age    | 35
/Sex    | "M"
/Weight | 60.3


/Dictionaries can be extended via index assignment.
d[`Height]:"182 Ft"

d
/
/Name   | `John
/Age    | 35
/Sex    | "M"
/Weight | 60.3
/Height | "182 Ft"


//Reverse Lookup with Find (?)
d2:`x`y`z!99 88 77

d2

d2?77
`z
/In case the elements of a list is not unique, the find returns the first item mapping to it from the domain list.


d2?2345



/###############################################################################
/Removing Entries
/###############################################################################
/To remove an entry from a dictionary, the delete ( _ ) function is used. The left 
/operand of ( _ ) is the dictionary and the right operand is a key value.

d2 _`z

`z _d2
`x`z _d2



/###############################################################################
/Column dictionaries are the basics for creation of tables. Consider the 
/following example −
scores: `name`id!(`John`Jenny`Jonathan;9 18 27)

scores

scores[`name]
`John`Jenny`Jonathan


scores.name                 / Retrieving the values for a column in a
                              / column dictionary using dot notation.
`John`Jenny`Jonathan

scores[`name][1]

scores[`id][2]             / Values in row 2 of the id column is



/##############################################################################
/Flipping a Dictionary
scores

/The transpose of a dictionary is obtained by applying the unary flip operator. Take a look at the following example −
flip scores
/  name     id
/---------------
/  John     9
/  Jenny    18
/ Jonathan  27


/Flip of a Flipped Column Dictionary
/If you transpose a dictionary twice, you obtain the original dictionary,
scores ~ flip flip scores


flip flip scores



/##############################################################################
/Q Language - Table
/Tables are at the heart of kdb+. A table is a collection of named columns 
/implemented as a dictionary. q tables are column-oriented.

/Creating Tables: Tables are created using the following syntax −

trade:([]time:();sym:();price:();size:())

trade
/time sym price size
/-------------------


/In the above example, we have not specified the type of each column. This will
/be set by the first insert into the table.
/Another way, we can specify column type on initialization −
trade:([]time:`time$();sym:`$();price:`float$();size:`int$())

trade


//Or we can also define non-empty tables −
trade:([]sym:(`a`b);price:(1 2))

trade



/One can also define the column types by setting the values to be null lists of various types −
trade:([]time:0#0Nt; sym:0#`; price:0#0n; size:0#0N)

trade




//##########################Getting Table Information
trade: ([]sym:`ibm`msft`apple`samsung; mcap:2000 4000 9000 6000; ex:`nasdaq`nasdaq`DAX`Dow)
trade

cols trade                         / column names of a table
/`sym`mcap`ex

trade.sym                          / Retrieves the value of column sym
/`ibm`msft`apple`samsung

show meta trade                    / Get the meta data of a table trade.
//   c   | t f a
// ----- | -----
//  Sym  | s
//  Mcap | j
//  ex   | s


//Primary Keys and Keyed Tables
/Keyed Table
/A keyed table is a dictionary that maps each row in a table of unique keys 
/to a corresponding row in a table of values. Let us take an example −


val:flip `name`id!(`John`Jenny`Jonathan;9 18 27)
                          / a flip dictionary create table val
val                          
              
                                      
id:flip (enlist `eid)!enlist 99 198 297
                          / flip dictionary, having single column eid
id

/Now create a simple keyed table containing eid as key,
valid: id ! val
valid
// eid| name     id
// ---| -----------
// 99 | John     9 
// 198| Jenny    18
// 297| Jonathan 27


/###############################################################################
/ForeignKeys
sector:([sym:`SAMSUNG`HSBC`JPMC`APPLE]ex:`N`CME`DAQ`N;MC:1000 2000 3000 4000)
sector
// sym    | ex  MC  
// -------| --------
// SAMSUNG| N   1000
// HSBC   | CME 2000
// JPMC   | DAQ 3000
// APPLE  | N   4000


tab:([]sym:`sector$`HSBC`APPLE`APPLE`APPLE`HSBC`JPMC;price:6?9f)
tab
// sym   price   
// --------------
// HSBC  3.534771
// APPLE 4.65382 
// APPLE 4.643817
// APPLE 3.659978
// HSBC  1.602755
// JPMC  2.71595 

show meta tab
//   c    | t f a
// ------ | ----------
//  sym   | s sector
//  price | f


show select from tab where sym.ex=`N
// sym   price   
// --------------
// APPLE 4.65382 
// APPLE 4.643817
// APPLE 3.659978




/##############################################################################
//Manipulating Tables
/##############################################################################
// `tablename insert (values)
// Insert[`tablename; values]
/Let’s create one trade table and check the result of different table expression −

trade:([] sym:5?`ibm`msft`hsbc`samsung; price:5?(303.00*3+1); size:5?(900*5); time:5?(.z.T-365))
trade

//Select

select sym,price,size by time from trade where size > 2000


//Insert
/`tablename insert (values) Insert[`tablename; values]
`trade insert (`hsbc`apple;302.0 730.40;3020 3012;09:30:17.004 09:15:00.000)
trade



/Insert another value
insert[`trade;(`samsung;302.0; 3333;10:30:00.000)]

trade

count trade

//Let us now take an example to demonstrate how to use Delete statement −
delete price from trade
trade


delete from trade where price > 100
trade



//Update
//update column: newValue from table where ….
//update column: newValue from `table where …
trade
update size:9000 from trade where price > 600
trade



//Update the datatype of a column using the cast function
meta trade
update size:`float$size from trade

/ Above statement will not update the size column datatype permanently
meta trade

/to make changes in the trade table permanently, we have do
update size:`float$size from `trade

meta trade



/###############################################################################
/Q Language - Verb & Adverbs
/###############################################################################
/Kdb+ has nouns, verbs, and adverbs. All data objects and functions are nouns. 
/Verbs enhance the readability by reducing the number of square brackets and 
/parentheses in expressions. 
/Adverbs modify dyadic (2 arguments) functions and verbs to produce new, 
/related verbs. 
/The functions produced by adverbs are called derived functions or derived verbs.

//Each
/The adverb each, denoted by ( ` ), modifies dyadic functions and verbs to 
/apply to the items of lists instead of the lists themselves. 
/Take a look at the following example −

1, (2 3 5)  /Join
/1 2 3 5

1, '( 2 3 4)     / Join each
// 1 2
// 1 3
// 1 4


/There is a form of Each for monadic functions that uses the keyword “each”. For example,
reverse ( 1 2 3; "abc")           /Reverse
//a b c
//1 2 3

each [reverse] (1 2 3; "abc")     /Reverse-Each
/3 2 1
/c b a

'[reverse] ( 1 2 3; "abc")
3 2 1
c b a


//Each-Left and Each-Right
/There are two variants of Each for dyadic functions called Each-Left (\:) and 
/Each-Right (/:). The following example explains how to use them.
x: 9 18 27 36
y:10 20 30 40

x,y   /Join
/9 18 27 36 10 20 30 40

x,'y           / each
// 9   10
// 18  20
// 27  30
// 36  40


x,'y           / each, will return a list of pairs
// 9   10
// 18  20
// 27  30
// 36  40

x, \:y         / each left, returns a list of each element
                 / from x with all of y
// 					  
// 9   10  20  30  40
// 18  10  20  30  40
// 27  10  20  30  40
// 36  10  20  30  40

x,/:y          / each right, returns a list of all the x with
                 / each element of y
					  
// 9  18  27  36  10
// 9  18  27  36  20
// 9  18  27  36  30
// 9  18  27  36  40

1 _x           / drop the first element
/18 27 36

-2 _y           / drop the last two element
/10 20


/ Combine each left and each right to be a
/ cross-product (cartesian product)       
x,/:\:y

9   10  9   20  9   30  9   40
18  10  18  20  18  30  18  40
27  10  27  20  27  30  27  40
36  10  36  20  36  30  36  40



/################################################################################
/Q Language - Joins
/################################################################################
/Simple join
/Asof join
/Left join
/Union join

/Simple Join
/Simple join is the most basic type of join, performed with a comma ‘,’. In this
/case, the two tables have to be type conformant, i.e., both the tables have 
/the same number of columns in the same order, and same key.
/table1,:table2 / table1 is assigned the value of table2

/We can use comma-each join for tables with same length to join sideways. One of the tables can be keyed here,
/Table1, `Table2

/Asof Join (aj)
/It is the most powerful join which is used to get the value of a field in 
/one table asof the time in another table. Generally it is used to get the 
/prevailing bid and ask at the time of each trade.
//aj[joinColumns;tbl1;tbl2]
//aj[`sym`time;trade;quote]
tab1:([]a:(1 2 3 4); b:(2 3 4 5); d:(6 7 8 9))
tab1
tab2:([]a:(2 3 4 5); b:(3 4 5 6); c:(4 5 6 20))
tab2

aj[`a`b;tab1;tab2]
//  b d c
// -------
// 1 2 6  
// 2 3 7 4
// 3 4 8 5
// 4 5 9 6

//Left Join(lj)
//It’s a special case of aj where the second argument is a keyed table and the 
//first argument contains the columns of the right argument’s key.
//Left join- syntax table1 lj table2 or lj[table1;table2]

tab1:([]a:(1 2 3 4); b:(2 3 4 5);d:(6 7 8 9))
tab1

tab2:([a:(2 3 4); b:(3 4 5)]; c:( 4 5 6))
tab2

tab2:([a:(2 2 3 4); b:(3 3 4 5)]; c:( 4 5 6 7))
tab2


lj[tab1;tab2]
//  a  b  d  c
// -------------
//  1  2  6
//  2  3  7  4
//  3  4  8  5
//  4  5  9  6

//Union Join (uj)
/It allows to create a union of two tables with distinct schemas. It is 
/basically an extension to the simple join ( , )

tab1:([]a:(1 2 3 4);b:(2 3 4 5);d:(6 7 8 9))

tab2:([]a:(2 3 4);b:(3 4 5); c:( 4 5 6))

tab1
tab2

uj[tab1;tab2]

//  a  b  d  c
// ------------
//  1  2  6
//  2  3  7
//  3  4  8
//  4  5  9
//  2  3     4
//  3  4     5
//  4  5     6


//If you are using uj on keyed tables, then the primary keys must match.

tab1:([a:(1 2 3 4);b:(2 3 4 5)];d:(6 7 8 9))

tab2:([a:(2 3 4);b:(3 4 5)]; c:( 4 5 6))

tab1
tab2

uj[tab1;tab2]




/##############################################################################
/Q Language - Functions
/##############################################################################
/Atomic, Aggregate, Uniform, Other
// Atomic − Where the arguments are atomic and produce atomic results
// 
// Aggregate − atom from list
// 
// Uniform (list from list) − Extended the concept of atom as they apply to lists. The count of the argument list equals the count of the result list.
// 
// Other − if the function is not from the above category.
// 
// Binary operations in mathematics are called dyadic functions in q; for example, “+”. Similarly unary operations are called monadic functions; for example, “abs” or “floor”.

/abs
/all 
all 4 5 0 -4 / Logical AND (numeric min), returns the minimum value

//Max (&), Min (|), and Not (!)
// q) /And, Or, and Logical Negation
// 
// q) 1b & 1b        / And (Max)
// 1b
// 
// q) 1b|0b              / Or (Min)
// 1b
// 
// q) not 1b             /Logical Negate (Not)
// 0b 

asc 1 3 5 7 -2 0 4

/attr - gives the attributes of data, which describe how it's sorted.





avg 3 4 5 6 7           / Return average of a list of numeric values
5f

/Create on trade table

trade:([]time:3?(.z.Z-200);  sym:3?(`ibm`msft`apple);  price:3?99.0; size:3?100)
trade



/ by - Groups rows in a table at given sym

select sum price by sym from trade    / find total price for each sym
//   sym  |   price
// ------ | --------
//  apple | 140.2165
//   ibm  | 16.11385
  
  

cols trade / Lists columns of a table
/`time`sym`price`size



count (til 9) / Count list, count the elements in a list and
                / return a single int value 9
                



// q)\p 9999 / assign port number
// 
// q)/csv - This command allows queries in a browser to be exported to
//    excel by prefixing the query, such as http://localhost:9999/.csv?select from trade where sym =`ibm
   
                                   
/cut - Allows a table or list to be cut at a certain point
(1 3 5) cut "abcdefghijkl"
                            / the argument is split at 1st, 3rd and 5th letter.
// "bc"
// "de"
// "fghijkl"

5 cut "abcdefghijklj"      / cut the right arg. Into 5 letters part
                            / until its end.
// "abcde"
// "fghij"
// "kl"

 

 
/delete - Delete rows/columns from a table

trade
delete price from trade

          time              sym   size
---------------------------------------
  2009.06.18T06:04:42.919  apple   36
  2009.11.14T12:42:34.653   ibm    12
  2009.12.27T17:02:11.518  apple   97
  


// q)/distinct - Returns the distinct element of a list
// 
// q)distinct 1 2 3 2 3 4 5 2 1 3            / generate unique set of number
// 1 2 3 4 5


// q)/enlist - Creates one-item list.
// 
// q)enlist 37
// ,37
// 
// q)type 37           / -ve type value
// -7h
// 
// q)type enlist 37    / +ve type value
// 7h 



//FILL
/fill - used with nulls. There are three functions for processing null values.
/The dyadic function named fill replaces null values in the right argument with the atomic left argument.

100 ^ 3 4 0N 0N -5
/3 4 100 100 -5

`Hello^`jack`herry``john`
/`jack`herry`Hello`john`Hello


/fills - fills in nulls with the previous not null value.

fills 1 0N 2 0N 0N 2 3 0N -5 0N
/1 1 2 2 2 2 3 3 -5 -5



// q)/first - returns the first atom of a list
// 
// q)first 1 3 34 5 3
//1




/flip - Monadic primitive that applies to lists and associations. It interchange the top two levels of its argument.

trade
//        time                   sym      price   size
// ------------------------------------------------------
//   2009.06.18T06:04:42.919    apple   72.05742   36
//   2009.11.14T12:42:34.653    ibm     16.11385   12
//   2009.12.27T17:02:11.518    apple   68.15909   97

flip trade
// time  | 2009.06.18T06:04:42.919 2009.11.14T12:42:34.6532009.12.27T17:02:11.518
// sym   |  apple         ibm         apple
// price | 72.05742     16.11385    68.15909
// size  | 36 12 97



/iasc - Index ascending, return the indices of the ascended sorted list relative to the input list.

iasc 5 4 0 3 4 9
//2 3 1 4 0 5

5 4 0 3 4 9@iasc 5 4 0 3 4 9 //will give sorted list
//0 3 4 4 5 9


// q)/idesc - Index desceding, return the descended sorted list relative to the input list
// 
// q)idesc 0 1 3 4
// 
// 3 2 1 0


/in - In a list, dyadic function used to query list (on the right-handside) about their contents.
(2 4) in 1 2 3
/10b


/insert - Insert statement, upload new data into a table.

insert[`trade;((.z.Z);`samsung;48.35;99)]
/,3

trade
//       time                  sym       price     size
// ------------------------------------------------------
//  2009.06.18T06:04:42.919   apple    72.05742     36
//  2009.11.14T12:42:34.653    ibm     16.11385     12
//  2009.12.27T17:02:11.518   apple    68.15909     97
//  2015.04.06T10:03:36.738   samsung  48.35        99
 
 

/key - three different functions i.e. generate +ve integer number, gives content of a directory or key of a table/dictionary.
key 9
/0 1 2 3 4 5 6 7 8

key `:/Users/jvsingh
/`.CFUserTextEncoding`.DS_Store`.R`.RData`.Rapp.history`.Rhistory`.Trash`.Xaut..



// q)/lower - Convert to lower case and floor
// 
// q)lower ("JoHn";`HERRY`SYM)
// "john"
// `herry`sym


// q)/Max and Min / a|b and a&b
// 
// q)9|7
// 9
// 
// q)9&5
// 5



/null - return 1b if the atom is a null else 0b from the argument list

null 1 3 3 0N
0001b



/peach - Parallel each, allows process across slaves
foo peach list1       / function foo applied across the slaves named in list1

'list1

foo:{x+27}

list1:(0 1 2 3 4)

foo peach list1       / function foo applied across the slaves named in list1
27 28 29 30 31


//PEACH
/peach - Parallel each, allows process across slaves
/foo peach list1       / function foo applied across the slaves named in list1
foo:{x+27}

list1:(0 1 2 3 4)

foo peach list1       / function foo applied across the slaves named in list1
/27 28 29 30 31



//PREV
/prev - returns the previous element i.e. pushes list forwards
prev 0 1 3 4 5 7
//
0N 0 1 3 4 5

//random - syntax - n?list, gives random sequences of ints and floats
9?5
0 0 4 0 3 2 2 0 1

3?9.9
0.2426823 1.674133 3.901671


/raze - Flattn a list of lists, removes a layer of indexing from a list of lists. for instance:
raze (( 12 3 4; 30 0);("hello";7 8); 1 3 4)
// 12 3 4
// 30 0
// "hello"
// 7 8
// 1
// 3
// 4


//
/read0 - Read in a text file
read0 `:/Users/jvsingh/test.txt    / gives the contents of *.txt file


/read1 - Read in a q data file
//read1 `:/Users/jvsingh/someqfile
//0xff016200630b000500000073796d0074696d6500707269636…



// /reverse - Reverse a list
// 
// reverse 2 30 29 1 3 4
// 
// 4 3 1 29 30 2
// 
// reverse "HelloWorld"
// 
// "dlroWolleH"



/set - set value of a variable
x:10
x
`x set 9
x
9

get `x

`:c:/q/test12 set trade

`:c:/q/test12

get `:c:/q/test12

//        time                   sym      price     size
// ---------------------------------------------------------
//   2009.06.18T06:04:42.919    apple    72.05742    36
//   2009.11.14T12:42:34.653     ibm     16.11385    12
//   2009.12.27T17:02:11.518    apple    68.15909    97
//   2015.04.06T10:03:36.738    samsung  48.35       99
//   2015.04.06T10:03:47.540    samsung  48.35       99
//   2015.04.06T10:04:44.844    samsung  48.35       99
//   
  



/ssr - String search and replace, syntax - ssr["string";searchstring;replaced-with]
ssr["HelloWorld";"o";"O"]
"HellOWOrld"

/string - converts to string, converts all types to a string format.
string (1 2 3; `abc;"XYZ";0b)
//(,"1";,"2";,"3")
//"abc"
//(,"X";,"Y";,"Z")
//,"0"




///sv - Scalar from vector, performs different tasks dependent on its arguments.
//It evaluates the base representation of numbers, which allows us to 
//calculate the number of seconds in a month or convert a length from feet 
//and inches to centimeters.
24 60 60 sv 11 30 49
41449   / number of seconds elapsed in a day at 11:30:49



// q)/system - allows a system command to be sent,
// 
// q)system "dir *.py"
// 
// " Volume in drive C is New Volume"
// " Volume Serial Number is 8CD2-05B2"
// ""
// 
// " Directory of C:\\Users\\myaccount-raj"
// ""
// 
// "09/14/2014    06:32 PM     22 hello1.py"
// "                1 File(s)    22 bytes"
system "pwd"
/system "find ./"



/tables - list all tables
tables `
/`id`sector`tab`tab1`tab2`trade`val`valid




// q)/trim - Eliminate string spaces
// 
// q)trim " John "
// 
// "John"




/vs - Vector from scaler , produces a vector quantity from a scaler quantity

"|" vs "20150204|msft|20.45"
// 
// "20150204"
// "msft"
// "20.45"


"~" vs "20150204~msft~20.45"



/xasc - Order table ascending, allows a table (right-hand argument) to be sorted such that (left-hand argument) is in ascending order
`price xasc trade
// time                    sym     price    size
// ---------------------------------------------
// 2014.02.08T17:23:58.800 ibm     40.58565 23  
// 2020.04.12T20:27:24.545 samsung 48.35    99  
// 2001.10.14T23:02:21.303 apple   49.26727 66  
// 2003.11.04T00:17:55.185 ibm     60.47729 12  


/xcol - Renames columns of a table
`timeNew`symNew xcol trade
// timeNew                 symNew  price    size
// ---------------------------------------------
// 2014.02.08T17:23:58.800 ibm     40.58565 23  
// 2003.11.04T00:17:55.185 ibm     60.47729 12  
// 2001.10.14T23:02:21.303 apple   49.26727 66  
// 2020.04.12T20:27:24.545 samsung 48.35    99  



/xcols - Reorders the columns of a table,

`size`price xcols trade
// size price    time                    sym    
// ---------------------------------------------
// 23   40.58565 2014.02.08T17:23:58.800 ibm    
// 12   60.47729 2003.11.04T00:17:55.185 ibm    
// 66   49.26727 2001.10.14T23:02:21.303 apple  
// 99   48.35    2020.04.12T20:27:24.545 samsung



/xdesc - Order table descending, allows tables to be sorted such that the left-hand argument is in descending order.
`price xdesc trade
   
   

/xgroup - Creates nested table
/`x xgroup ([]x:9 18 9 18 27 9 9; y:10 20 10 20 30 40)
/'length

`x xgroup ([]x:9 18 9 18 27 9 9;y:10 20 10 20 30 40 10)

//   x  |    y
// ---- | -----------
//   9  | 10 10 40 10
//   18 | 20 20
//   27 | ,30



/xkey - Set key on table

`sym xkey trade
//     sym   |      time                    price     size
// --------- | -----------------------------------------------
//    apple  | 2009.06.18T06:04:42.919    72.05742     36
//     ibm   | 2009.11.14T12:42:34.653    16.11385     12
//    apple  | 2009.12.27T17:02:11.518    68.15909     97
//   samsung | 2015.04.06T10:03:36.738    48.35        99
//   samsung | 2015.04.06T10:03:47.540    48.35        99
//   samsung | 2015.04.06T10:04:44.844    48.35        99
  


/##############################################################################
/System Commands
/##############################################################################
//  \cmd [p]       where p may be optional


//\a [ namespace] – List tables in the given namespace
/Tables in default namespace

\a
/`id`sector`tab`tab1`tab2`trade`val`valid

\a .o         / table in .o namespace.
,`TI


//\b – View dependencies
/views/dependencies
a:: x+y      / global assingment

b:: x+1

\b
/`s#`a`b


//\B – Pending views / dependencies
/ Pending views/dependencies
a::x+1     / a depends on x

\B         / the dependency is pending
/' / the dependency is pending

\B
`s#`a`b

q)\b
`s#`a`b

b
29

a
29

\B
`symbol$()


/###############################################################################
/\cd – Change directory
/###############################################################################
/change directory, \cd [name]
/ \cd "/Users/jvsingh/"
/ \cd ../new-account
/ \cd



/###############################################################################
/\d – sets current namespace
/###############################################################################
/ sets current namespace \d [namespace]

// \d             /default namespace
// '
// \d .o     /change to .o
// 
// q.o)\d
// `.o
// 
// q.o)\d .         / return to default
// 
// q)key `          /lists namespaces other than .z
// `q`Q`h`j`o
// 
// q)\d .john       /change to non-existent namespace
// 
// q.john)\d
// `.john
// 
// q.john)\d .
// 
// q)\d
// `.


/###############################################################################
/\l – load file or directory from db
/###############################################################################
/ Load file or directory, \l

\l test2.q / loading test2.q which is stored in current path.


mytrade   //defined in test2.q
// sym     mcap ex    
// -------------------
// ibm     2000 nasdaq
// msft    4000 nasdaq
// apple   9000 DAX   
// samsung 6000 Dow  


/###############################################################################
/ \p – port number
/###############################################################################
/ assign port number, \p

\p
/5001i

/  \p 8888  /start server at poprt 88888

/  \p
/  8888i


/#########
/    \\ - Exit from q console



/###############################################################################
/ String Functions
/###############################################################################
/Like − pattern matching
/like is a dyadic, performs pattern matching, return 1b on success else 0b

"John" like "J??n"
1b

"John My Name" like "J*"
1b

/ltrim − removes leading blanks
/ltrim - monadic ltrim takes string argument, removes leading blanks
ltrim " Rick "
"Rick "

/rtrim − removes trailing blanks
/rtrim - takes string argument, returns the result of removing trailing blanks
rtrim " Rick "
" Rick"

/ss − string search
/ss - string search, perform pattern matching, same as "like" but return the indices of the matches of the pattern in source.

"Life is beautiful" ss "i"
1 5 13

/trim − removes leading and trailing blanks
/trim - takes string argument, returns the result of removing leading & trailing blanks

trim " John "
"John"

   
/###############################################################################
/ Mathematical Functions
/###############################################################################
/acos - inverse of cos
/cor − gives correlation
27 18 18 9 0 cor 27 36 45 54 63
-0.9707253

/cross − Cartesian product
9 18 cross `x`y`z
// 9  `x
// 9  `y
// 9  `z
// 18 `x
// 18 `y
// 18 `z
 
/var - monadic, takes a scaler or numeric list and returns a float equal to the mathematical variance of the items
var 45
0f

var 9 18 27 36
101.25
 
/wavg - dyadic, takes two numeric lists of the same count and returns the average of the second argument weighted by the first argument.

1 2 3 4 wavg 200 300 400 500
400f


/all - monadic, takes a scaler or list of numeric type and returns the result of & applied across the items.
all 0b
0b

all 9 18 27 36
1b

all 10 20 30
1b


//any - monadic, takes scaler or list of numeric type and the return the result of | applied across the items
any 20 30 40 50
1b

any 20012.02.12 2013.03.11
'20012.02.12



//prd − arithmetic product
/prd - monadic, takes scaler, list, dictionary or table of numeric type and returns the arithmetic product.

prd `x`y`z! 10 20 30
6000

prd ((1 2; 3 4);(10 20; 30 40)) //seems element wise product
10 40
90 160


//Sum − arithmetic sum
/sum - monadic, takes a scaler, list,dictionary or table of numeric type and returns the arithmetic sum.
sum 2 3 4 5 6
20

sum (1 2; 4 5)
5 7



/###############################################################################
/Uniform Functions
/###############################################################################
/Deltas − difference from its previous item.
/deltas -takes a scalar, list, dictionary or table and returns the difference of each item from its predecessor.

deltas 2 3 5 7 9
2 1 2 2 2

deltas `x`y`z!9 18 27
// x | 9
// y | 9
// z | 9




///fills - takes scalar, list, dictionary or table of numeric type and returns a c copy of the source in which non-null items are propagated forward to fill nulls
fills 1 0N 2 0N 4
1 1 2 2 4

fills `a`b`c`d! 10 0N 30 0N
// a | 10
// b | 10
// c | 30
// d | 30



/maxs - takes scalar, list, dictionary or table and returns the cumulative maximum of the source items.
maxs 1 2 4 3 9 13 2
//1 2 4 4 9 13 13

maxs `a`b`c`d!9 18 0 36
// a | 9
// b | 18
// c | 18
// d | 36


// q)/count - returns the number of entities in its argument.
// 
// q)count 10 30 30
// 3
// 
// q)count (til 9)
// 9
// 
// q)count ([]a:9 18 27;b:1.1 2.2 3.3)
// 3


// q)/distinct - monadic, returns the distinct entities in its argument
// 
// q)distinct 1 2 3 4 2 3 4 5 6 9
// 1 2 3 4 5 6 9


//Except − element not present in second arg.
/except - takes a simple list (target) as its first argument and returns a list
/ containing the items of target that are not in its second argument
1 2 3 4 3 1 except 1
2 3 4 3


/fill − fill null with first argument

42^ 9 18 0N 27 0N 36
9 18 42 27 42 36

";" ^ "Life is Beautiful"
"Life;is;Beautiful"





/##############################################################################
/Q Language - Queries
/##############################################################################
/Queries in q are shorter and simpler and extend the capabilities of sql. 
/The main query expression is the ‘select expression’, which in its simplest 
/form extracts sub-tables but it can also create new columns.

/The general form of a Select expression is as follows −

/Select columns by columns from table where conditions

// select [a] [by b] from t [where c]
// update [a] [by b] from t [where c]


/###############################################################################
/Basics Queries
sym:asc`AIG`CITI`CSCO`IBM`MSFT;
ex:"NASDAQ"
dst:`$":/Users/jvsingh/work/play_q";           /database destination

@[dst;`sym;:;sym];
n:1000000;

trade:([]sym:n?`sym; time:10:30:00.0+til n; price:n?3.3e; size:n?9; ex:n?ex);

quote:([]sym:n?`sym; time:10:30:00.0+til n; bid:n?3.3e;  ask:n?3.3e;  bsize:n?9;  asize:n?9;  ex:n?ex);

{@[;`sym;`p#]`sym xasc x}each`trade`quote;
d:2014.08.07 2014.08.08 2014.08.09 2014.08.10 2014.08.11; /Date vector can also be changed by the user

dt:{[d;t].[dst;(`$string d;t;`);:;value t]};
d dt/:\:`trade`quote;

/#Note: Once you run this query, two folders .i.e. "test" and "data" will be created under "c:/q/", and date partition data can be seen inside data folder.
//Since I am running it /Users/jvsingh/work/play_q, we see date partitions directly there
/###############################################################################

/Select all IBM trades
select from trade where sym in `IBM

/Select all IBM trades on a certain day
thisday: 2014.08.11
select from trade where date=thisday, sym=`IBM


select from trade where sym=`IBM, price > 1.0

/Select all IBM trades with a price less than or equal to 100
select from trade where sym=`IBM,not price > 100.0


/*Select all IBM trades between 10.30 and 10.40, in the morning, on a certain date
thisday: 2014.08.11
select from trade where date = thisday, sym = `IBM, time > 10:30:00.000,time < 10:40:00.000


/Select all IBM trades in ascending order of price
`price xasc select from trade where sym =`IBM

/*Select all IBM trades in descending order of price in a certain time frame
`price xdesc select from trade where date within 2014.08.07 2014.08.11, sym =`IBM

/Composite sort − sort ascending order by sym and then sort the result in descending order of price
`sym xasc `price xdesc select from trade where date = 2014.08.07,size = 5


/Select all IBM or MSFT trades
select from trade where sym in `IBM`MSFT

/*Calculate count of all symbols in ascending order within a certain time frame
`numsym xasc select numsym: count i by sym from trade where date within 2014.08.07 2014.08.11

/*Calculate count of all symbols in descending order within a certain time frame
`numsym xdesc select numsym: count i by sym from trade where date within 2014.08.07 2014.08.11


/What is the maximum price of IBM stock within a certain time frame, and when does this first happen?
select time,ask from quote where date within 2014.08.07 2014.08.11, sym =`IBM, ask = exec first ask from select max ask from quote where sym =`IBM
//(to me it seems query is wrong)

/Select the last price for each sym in hourly buckets
select last price by hour:time.hh, sym from trade




/#############################################################################
/Queries with Aggregations
/#############################################################################
//Calculate vwap (Volume Weighted Average Price) of all symbols
select vwap:size wavg price by sym from trade

//* Count the number of records (in millions) for a certain month
(select trade:1e-6*count i by date.dd from trade where date.month=2014.08m) + select quote:1e-6*count i by date.dd from quote where date.month=2014.08m

//HLOC – Daily High, Low, Open and Close for CSCO in a certain month
select high:max price, low:min price, open:first price, close:last price by date.dd from trade where date.month=2014.08m,sym =`CSCO


//Daily Vwap for CSCO in a certain month
select vwap:size wavg price by date.dd from trade where date.month = 2014.08m ,sym = `CSCO


//Calculate the hourly mean, variance and standard deviation of the price for AIG
select mean:avg price, variance:var price, stdDev:dev price by date, hour:time.hh from trade where sym = `AIG


//Select the price range in hourly buckets
select range:max[price] – min price by date,sym,hour:time.hh from trade

//Daily Spread (average bid-ask) for CSCO in a certain month
select spread:avg bid-ask by date.dd from quote where date.month = 2014.08m, sym = `CSCO

//Daily Traded Values for all syms in a certain month
select dtv:sum size by date,sym from trade where date.month = 2014.08m

//Extract a 5 minute vwap for CSCO
select size wavg price by 5 xbar time.minute from trade where sym = `CSCO

//Extract 10 minute bars for CSCO
select high:max price,low:min price,close:last price by date, 10 xbar time.minute from trade where sym = `CSCO

//* Find the times when the price exceeds 100 basis points (100e-4) over the last price for CSCO for a certain day
select time from trade where date = 2014.08.11,sym = `CSCO,price > 1.01*last price


//* Full Day Price and Volume for MSFT in 1 Minute Intervals for the last date in the database
select last price,last size by time.minute from trade where date = last date, sym = `MSFT



///////////////////////////////////////////////////////////////////////////////
/ Skipping IPC/Message handlers. 
/Have a look at section in https://www.tutorialspoint.com/kdbplus/kdbplus_quick_guide.htm
///////////////////////////////////////////////////////////////////////////////




/###############################################################################
/Q Language - Attributes
/###############################################################################
/Lists, dictionaries, or columns of a table can have attributes applied to them. 
/Attributes impose certain properties on the list. Some attributes might disappear
/ on modification.

/Types of Attributes: Sorted (`s#), Parted (`p#), Grouped (`g#),Unique (`#u)

/Sorted (`s#)
/`s# means the list is sorted in an ascending order. If a list is explicitly 
/sorted by asc (or xasc), the list will automatically have the sorted attribute set.

L1: asc 40 30 20 50 9 4
L1
// `s#4 9 20 30 40 50


/A list which is known to be sorted can also have the attribute explicitly set.
/ Q will check if the list is sorted, and if is not, an s-fail error will be thrown.
L2:30 40 24 30 2

`s#L2
// 's-fail

L2:1 24 30 30 40

`s#L2
// `s#1 24 30 30 40

L2:reverse 1 24 30 30 40
L2
`s#L2
// 's-fail




//Parted (`p#)
/ `p# means the list is parted and identical items are stored contiguously.
/ The range is an int or temporal type having an underlying int value, such as 
/ years, months, days, etc. You can also partition over a symbol provided it 
/ is enumerated.

/ Applying the parted attribute creates an index dictionary that maps each 
/ unique output value to the position of its first occurrence. When a list is 
/ parted, lookup is much faster, since linear search is replaced by hashtable 
/ lookup.
L:`p# 99 88 77 1 2 3

L
`p#99 88 77 1 2 3

L,:3

L
99 88 77 1 2 3 3


//Note −
/The parted attribute is not preserved under an operation on the list, even if 
/the operation preserves the partitioning.
/The parted attribute should be considered when the number of entities reaches 
/a billion and most of the partitions are of substantial size, i.e., there is 
/significant repetition.


/Grouped (`g#)
/`g# means the list is grouped. An internal dictionary is built and maintained 
/which maps each unique item to each of its indices, requiring considerable 
/storage space. For a list of length L containing u unique items of size s, 
/this will be (L × 4) + (u × s) bytes.

/Grouping can be applied to a list when no other assumptions about its structure
/ can be made.
/The attribute can be applied to any typed lists. It is maintained on appends, 
/but lost on deletes.

L: `g# 1 2 3 4 5 4 2 3 1 4 5 6

L
//`g#1 2 3 4 5 4 2 3 1 4 5 6

L,:9

L
//`g#1 2 3 4 5 4 2 3 1 4 5 6 9

L _:2

L
//1 2 4 5 4 2 3 1 4 5 6 9



//Unique (`#u)
//Applying the unique attribute (`u#) to a list indicates that the items of the 
//list are distinct. Knowing that the elements of a list are unique dramatically 
//speeds up distinct and allows q to execute some comparisons early.

//When a list is flagged as unique, an internal hash map is created to each 
//item in the list. Operations on the list must preserve uniqueness or the 
//attribute is lost.

LU:`u#`MSFT`SAMSUNG`APPLE

LU
//`u#`MSFT`SAMSUNG`APPLE

LU,:`IBM                        /Uniqueness preserved

LU
//`u#`MSFT`SAMSUNG`APPLE`IBM

LU,:`SAMSUNG                    / Attribute lost

LU
//`MSFT`SAMSUNG`APPLE`IBM`SAMSUNG


//Note −

/`u# is preserved on concatenations which preserve the uniqueness. It is lost 
//on deletions and non-unique concatenations.
//Searches on `u# lists are done via a hash function.


//Removing Attributes: Attributes can be removed by applying `#.



//Applying Attributes
/Three formats for applying attributes are −
/   L: `s# 14 2 3 3 9/ Specify during list creation
/   @[ `.; `L ; `s#]/ Functional apply, i.e. to the variable list L in the default namespace (i.e. `.) apply the sorted `s# attribute

/   Update `s#time from `tab            Update the table (tab) to apply the attribute.


/ set the attribute during creation
L:`s# 3 4 9 10 23 84 90


/apply the attribute to existing list data
L1: 9 18 27 36 42 54
@[`.;`L1;`s#]

L1 / check
// `s#9 18 27 36 42 54

@[`.;`L1;`#]       / clear attribute
// `.

L1


/update a table to apply the attribute
t: ([] sym:`ibm`msft`samsung; mcap:9000 18000 27000)

t:([]time:09:00 09:30 10:00t;sym:`ibm`msft`samsung; mcap:9000 18000 27000)

t

update `s#time from `t
// `t


meta t               / check it was applied



//Q Language - Functional Queries
//Functional (Dynamic) queries allow specifying column names as symbols to 
//typical q-sql select/exec/delete columns. It comes very handy when we want 
//to specify column names dynamically.

/  The functional forms are −
/   ?[t;c;b;a]    / for select
/   ![t;c;b;a]    / for update
/  where
/    t is a table;
/    a is a dictionary of aggregates;
/    b the by-phrase; and
/    c is a list of constraints.
/ Note:
/    All q entities in a, b, and c must be referenced by name, meaning as 
/    symbols containing the entity names.
/    The syntactic forms of select and update are parsed into their equivalent 
/    functional forms by the q interpreter, so there is no performance difference 
/    between the two forms.


//Functional select
//The following code block shows how to use functional select −
t:([]n:`ibm`msft`samsung`apple;p:40 38 45 54)

t
//     n       p
// -------------------
//    ibm     40
//    msft    38
//  samsung   45
//   apple    54

select m:max p,s:sum p by name:n from t where p>36, n in `ibm`msft`apple
// 
//   name |   m   s
// ------ | ---------
//  apple |  54  54
//  ibm   |  40  40
//  msft  |  38  38

//Example 1
/Let’s start with the easiest case, the functional version of “select from t” will look like −
?[t;();0b;()]     / select from t
//     n      p
// -----------------
//    ibm    40
//    msft   38
//  samsung  45
//   apple   54

/Example 2
/In the following example, we use the enlist function to create singletons to 
/ensure that appropriate entities are lists.
wherecon: enlist (>;`p;40)

?[`t;wherecon;0b;()] / select from t where p > 40
// 
//     n      p
// ----------------
//  samsung  45
//   apple   54


//Example 3
groupby: enlist[`p] ! enlist `p
selcols: enlist[`n] ! enlist `n

?[ `t;(); groupby;selcols]        / select n by p from t
//    p  |    n
// ----- | -------
//   38  |  msft
//   40  |  ibm
//   45  | samsung
//   54  | apple




//Functional Exec
//The functional form of exec is a simplified form of select.
//
//
?[t;();();`n]                / exec n from t (functional form of exec)
//`ibm`msft`samsung`apple

?[t;();`n;`p]                / exec p by n from t (functional exec)
// apple   | 54
// ibm     | 40
// msft    | 38
// samsung | 45




//Functional Update
/The functional form of update is completely analogous to that of select. In the
/ following example, the use of enlist is to create singletons, to ensure that 
/input entities are lists.
c:enlist (>;`p;0)

b: (enlist `n)!enlist `n

a: (enlist `p) ! enlist (max;`p)

![t;c;b;a]
// 
//    n      p
// -------------
//   ibm    40
//   msft   38
//  samsung 45
//  apple   54
//  
 
 
//Functional delete
/Functional delete is a simplified form of functional update. Its syntax is as 
/follows −

// ![t;c;0b;a]        / t is a table, c is a list of where constraints, a is a
                      / list of column names
//Let us now take an example to show how functional delete work −
![t; enlist (=;`p; 40); 0b;`symbol$()]
                                          / delete from t where p = 40
//    n       p
// ---------------
//   msft    38
//  samsung  45
//   apple   54




/##############################################################################
//Q Language - Table Arithmetic
/##############################################################################

d:`u`v`x`y`z! 9 18 27 36 45                  / Creating a dictionary d

/key of this dictionary (d) is given by
key d
// `u`v`x`y`z

/and the value by

value d
// 9 18 27 36 45

/a specific value
d`x
27

d[`x]
27

/values can be manipulated by using the arithmetic operator +-*% as,
45 + d[`x`y]
72 81



//If one needs to amend the dictionary values, then the amend formulation can be −
d /before
// u| 9
// v| 18
// x| 27
// y| 36
// z| 45

@[`d;`z;*;9] /update z, mulktiply original value by 9

d
// u| 9
// v| 18
// x| 27
// y| 36
// z| 405


///Example, table tab

tab:([]sym:`;time:0#0nt;price:0n;size:0N)
tab

n:10;sym:`IBM`SAMSUNG`APPLE`MSFT

insert[`tab;(n?sym;("t"$.z.Z);n?100.0;n?100)]
0 1 2 3 4 5 6 7 8 9

tab

`time xasc `tab
tab

/ to get particular column from table tab
tab[`size]
12 10 1 90 73 90 43 90 84 63

tab[`size]+9
21 19 10 99 82 99 52 99 93 72



/We can also use the @ amend too
tab
@[tab;`price;-;2]  /subtract 2 from price
// 
//    sym      time           price     size
// --------------------------------------------
//   APPLE   11:16:39.779   6.388858     12
//   MSFT    11:16:39.779   17.59907     10
//   IBM     11:16:39.779   35.5638      1
//  SAMSUNG  11:16:39.779   59.37452     90
//   APPLE   11:16:39.779   50.94808     73
//  SAMSUNG  11:16:39.779   67.16099     90
//   APPLE   11:16:39.779   20.96615     43
//  SAMSUNG  11:16:39.779   67.19531     90
//   IBM     11:16:39.779   45.07883     84
//   IBM     11:16:39.779   61.46716     63

tab



//if the table is keyed
tab1:`sym xkey tab[0 1 2 3 4]

tab1
// sym  | time         price    size
// -----| --------------------------
// APPLE| 11:23:14.895 99.68563 35  
// MSFT | 11:23:14.895 78.94779 52  
// APPLE| 11:23:14.895 64.46381 20  
// MSFT | 11:23:14.895 6.984731 26  
// IBM  | 11:23:14.895 25.92934 5   

/To work on specific column, try this
{tab1[x]`size} each sym  //for each symbol `IBM`SAMSUNG`APPLE`MSFT , get row for symbol and read column size
5 0N 35 52

(0!tab1)`size
//35 52 20 26 5

/once we got unkeyed table, manipulation is easy : I SEE HERE 0!tab1 unkeys the table
2+ (0!tab1)`size
// 37 54 22 28 7




/###############################################################################
/Q Language - Tables on Disk
/###############################################################################

/Data on your hard disk (also called historical database) can be saved in three 
/different formats − Flat Files, Splayed Tables, and Partitioned Tables. 
/Here we will learn how to use these three formats to save data.

/Flat file
/ Flat files are fully loaded into memory which is why their size (memory footprint) 
/ should be small. Tables are saved on disk entirely in one file (so size matters).

/The functions used to manipulate these tables are set/get −
/ `:path_to_file/filename set tablename

tables `.   /prints all tables in 
// `id`mytrade`quote`sector`t`tab`tab1`tab2`trade`val`valid


`:/Users/jvsingh/work/play_q/tab1_test set tab1   //this save tab1 to tab1_test file
//`:/Users/jvsingh/work/play_q/tab1_test

/Get the flat file from your disk (historical db) and use the get command as follows −

tab2: get `:/Users/jvsingh/work/play_q/tab1_test
tab2
/A new table is created tab2 with its contents stored in tab1_test file.



//Splayed Tables
//If there are too many columns in a table, then we store such tables in splayed
//format, i.e., we save them on disk in a directory. Inside the directory, each 
//column is saved in a separate file under the same name as the column name. 
//Each column is saved as a list of corresponding type in a kdb+ binary file.

//Saving a table in splayed format is very useful when we have to access only a 
//few columns frequently out of its many columns. A splayed table directory 
//contains .d binary file which contains the order of the columns.
//Note − For a table to be saved as splayed, it should be un-keyed and enumerated.


//Much like a flat file, a table can be saved as splayed by using the set 
/command. To save a table as splayed, the file path should end with a backlash
//  `:path_to_filename/filename/ set tablename

//For reading a splayed table, we can use the get function 
//   tablename: get `:path_to_file/filename


// NOT WORKING :(

//`:/Users/jvsingh/work/play_q/tab1_test_splay/ set tab1 //fail becuase keyed
// tmp:(0!tab1)
// `:/Users/jvsingh/work/play_q\/tab1_test_splay set tmp //success becuase unkeyed
// 
// tmp
// 
// //reading 
// mysplaytab: get `:/Users/jvsingh/work/play_q/tab1_test_splay
// 
// tab1


//Partitioned Tables
// Partitioned tables provide an efficient means to manage huge tables containing
// significant volumes of data. Partitioned tables are splayed tables spread 
// across more partitions (directories).
// Inside each partition, a table will have its own directory, with the structure 
// of a splayed table. The tables could be split on a day/month/year basis in 
// order to provide optimized access to its content.

//To get the content of a partitioned table, use the following code block.
get `:/Users/jvsingh/work/play_q/2014.08.07              // “get” command used, sample folder

// quote| +`sym`time`bid`ask`bsize`asize`ex!(`p#`sym!0 0 0 0 0 0 0 0 0 0 0
// trade| +`sym`time`price`size`ex!(`p#`sym!0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

/Let’s try to get the contents of a trade table −
get `:/Users/jvsingh/work/play_q/2014.08.07/trade
// sym time         price     size ex
// ----------------------------------
// IBM 10:30:00.003 1.580374  2    Q 
// IBM 10:30:00.013 0.6930636 6    A 
// IBM 10:30:00.015 2.746239  4    A 
// IBM 10:30:00.018 0.7038466 7    S 
// IBM 10:30:00.021 1.098445  8    N 
// IBM 10:30:00.024 2.499244  8    Q 
// IBM 10:30:00.031 2.190408  5    N 
// IBM 10:30:00.046 3.198092  0    N 
//Note − The partitioned mode is suitable for tables with millions of records per day (i.e. time series data)




//Sym file
/The sym file is a kdb+ binary file containing the list of symbols from all 
/splayed and partitioned tables. It can be read with,
/          get `:sym

//par.txt file (optional)
/This is a configuration file, used when partitions are spread on several 
/directories/disk drives, and contain the paths to the disk partitions.


/###############################################################################
/Q Language - Maintenance Functions
/###############################################################################
/.Q.en is a dyadic function which help in splaying a table by enumerating a symbol column. 
/It is especially useful when we are dealing with historical db (splayed, partition tables etc.). −

/  .Q.en[`:directory;table]
/  directory is the home directory of the historical database where sym file is 
/  located and table is the table to be enumerated.

/ .Q.en[`:directory_where_symbol_file_stored]table_name

//.Q.dpft
/The .Q.dpft function helps in creating partitioned and segmented tables. It is
// advanced form of .Q.en, as it not only splays the table but also creates a partition table.

//There are four arguments used in .Q.dpft −
//symbolic file handle of the database where we want to create a partition,q data 
//value with which we are going to partition the table, name of the field with 
//which parted (`p#) attribute is going to be applied (usually `sym), and the table name.

//Let’s take an example to see how it works −
tab:([]sym:5?`msft`hsbc`samsung`ibm;time:5?(09:30:30);price:5?30.25)
tab

.Q.dpft[`:/Users/jvsingh/work/play_q/;2014.08.24;`sym;`tab]
//`tab

tab

delete tab from `
//'type

delete tab from `/
//'type

delete tab from .
//'type

delete tab from `.
//`.

tab
//'tab

//We have deleted the table tab from the memory. Let us now load it from the db
filepath:`:/Users/jvsingh/work/play_q/2014.08.24/
filepath
\l filepath

\a   //we see tab here in output
//`id`mytrade`quote`sector`t`tab`tab1`tab2`tmp`trade`val`valid

tab

//.Q.chk
/?.Q.chk is a monadic function whose single parameter is the symbolic file handle 
//of the root directory. It creates empty tables in a partition, wherever necessary, 
//by examining each partition subdirectories in the root.

