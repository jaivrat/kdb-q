
/========@ and . – General Application


/Indexed retieval from lists
l:(1 2 3; 4 5; 6 7 8)

l[1]
/4 5 

l[ 0 2]
/ 1 2 3
/ 6 7 8

/Indexing at depth
l[1;0]
/4


/Indexed retieval from dictionary
d: `a`b`c!(1 2 3; 4 5; 6 7 8)
d

d[`b]
/4 5


/Indexing at depth
d[`b;0]
/4


/Multiple lookups
d[`b`c]
// 4 5
// 6 7 8


//Function application
f:{x*x}
f[4]
f 5
f[2 3]




// Square brackets and juxtaposition are syntactic forms for performing the above
/  applications, lookup, and indexed retrievals.
/  These syntactic forms are nothing but Application.
/  Application in q is actually a higher-order function that takes a function
/  and value(s) and evaluates the function at the value(s).


/================= Verb @
/@ is used for basic application

/Retrieving a list item by index
/Looking up a dictionary value by key
/Evaluating a monadic function

/Note: @ is not used for indexing at depth.

/Indexed retieval from lists
l:(1 2 3; 4 5; 6 7 8)

l@1
/4 5 


/Prefix
@[l;1]
/4 5


count @ l
/3

/Infix
@[count;l]
/3



/More than one
/l[ 0 2]
l@0 2
/ 1 2 3
/ 6 7 8



/Indexed retieval from dictionary
d: `a`b`c!(1 2 3; 4 5; 6 7 8)
d

/d[`b]
d@`b
/4 5

/Multiple lookups
d[`b`c]
d@ `b`c
// 4 5
// 6 7 8


/Monadic function application
f:{x*x}
l:1 2 3 4

f@l 
/1 4 9 16

/Infix form
@[f; l]
//1 4 9 16



/======= Verb Dot .
// Verb . can be used for in-depth application in q
// 
// Indexing a list at depth
// Retrieving a nested value from a dictionary
// Evaluating a function with multiple parameters 


l:(1 2 3; 4 5; 9 8 7 10)

/ Indexing a list at depth
l . 2 3 /10

l[2;3]
l[2][3]
/10
//both above give same 


d
// a| 1 2 3
// b| 4 5
// c| 6 7 8


//Nested lookup in dictionary
d . (`a;1)
/2

/Function application with multiple arguments
fAdd:{x + y}

fAdd . 9 10  /seems . is very much like square brackets
/19

fAdd[9;10]
/19


//Infix forms
/l . 2 3     //apve see , this is indexing at depth
.[l; 2 3]
/10

/d . (`a;1)
.[d;(`a;1)]
/2

/fAdd . 9 10
.[fAdd; 9 10]



//====================General Apply(@) with Monadic functions
/The syntax for this use-case is as follows:
/  @[L;I;f] 
/  L is a data structure.
/  I is the sub-domain of L.
/  f is the monadic function to be applied.

l:(1 2 4; 5 6 7; 9 10)

@[l; 0 2; neg]
//applys neg function to 0 and 2th index of l. 1th elem si returns as it is
// -1 -2 -4
// 5 6 7
// -9 -10

// The output is a not made permanent to the original list. To store the results 
// back to the original list, a backtick is used before the data structure name in
//  the syntax.






//=====================General Apply (@) with Dyadic Functions
/The syntax for this use-case is as follows:
/  @[L;I;f;v] 
/  L is a data structure.
/  I is the sub-domain of L.
/  f is the dyadic function to be applied.
/  v is the operand to be applied. This can be an atom or a value which conforms 
/  to the items in data structure.

l:(1 2 4; 5 6 7; 9 10)
l
/ 1 2 4
/ 5 6 7
/ 9 10

@[l; 0 1; +; 100] 
/ 101 102 104
/ 105 106 107
/ 9 10

//persisting the result back
@[`l; 0 1; +; 100]   //puting quotes or in symbol form persists change 
l
/ 101 102 104
/ 105 106 107
/ 9 10






d: `a`b`c!10 20 30
d

@[d; `b`c; +; 20 22]
/ a| 10
/ b| 40
/ c| 52




/============General Apply (.) for Monadic Functions
/   @ works on the top level of a data structure. The dot verb allows us to index 
/   at depth and apply functions to the nested items. The syntax is as follows:
/     .[L;I;f] 
//     L is a data structure.
//     I is an in-depth sub-domain of L.
//     f is the monadic function to be applied.

l:(1 2 3;4 5 6;7 8 9)

.[l; 1 1 ; neg]
// 1 2  3
// 4 -5 6
// 7 8  9

//You can persis it by passingh first as `l



/===========General Apply (.) for Dyadic Functions
//@ works on the top level of a data structure. The dot verb allows us to index 
//at depth and apply functions to the nested items. The syntax is as follows:
//     
//      .[L;I;f;v] 
//     L is a data structure.
//     I is an in-depth sub-domain of L.
//     f is the dyadic function to be applied.
//     v is the operand to be used as the second argument for function f. It can 
//     be an atom or any other value that conforms to the items in the list being
//     operated.

l:(1 2 3;4 5 6;7 8 9)

/subtract the va;ue 3 from item 6 - index 1;2 in the list

.[l; 1 2; -; 3]
// 1 2 3
// 4 5 3
// 7 8 9

//These are powerful and provide a way to apply functions to n-dimensional data structures with a simple syntax.

