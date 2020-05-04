//From https://thinqkdb.wordpress.com/adverbs-part-1/

/==========================================================/
/==================== Adverbs – Part 1 ====================/
/==========================================================/

/q Grammar
/Noun – The variables storing data.
/Verb – The operators between nouns.
/Adverb – Higher-order functions that modify the behavior of verbs on lists.
/ It is similar to any spoken language. Adverbs in q give one the power to avoid 
/ n-order loops and perform a highly complex operation in a single line of code.

/Let’s go over each of the Adverbs in q one by one with examples:


/=== Monadic each

/Let's say we have a list with depth 1
l:1 2 3

/To get the count of list l, we can simply use the count function
count l
/3

/Let's now take another list, this time with depth 2
l1:(1 2 3;4 5 6)

/The count of the list is 2 since the individual items are themselves lists.
count l1
/2

/ How does one get the length of each individual list forming the above list. 
/ This is where the adverb each comes in.
count each l1
/3 3 

/------------------------------------------------------------------------------/
/ The function each takes one item at a time from the list l1 and then applies 
/ the count function to each one.
/------------------------------------------------------------------------------/

/Let’s make this problem a tad bit more complex by taking a list of depth 3.
l2: ((1 2 3; 3 4); (100 200; 300 400 500))
l2
/ 1 2 3   3 4        
/ 100 200 300 400 500

/How does one get the length of each list inside l2.
/The idea here is to chain one more each to reach another level down.
(count each) each l2
/ 3 2
/ 2 3
/   Why do we have parenthesis here -> (count each)
/   How do we visualize this operation?
/    The first question is answered by the right to left evaluation in q. If we
/    don’t use the parenthesis we have two each side by side and that is a 
/    nonsensical operation. The parenthesis combines the operation count each 
/    to one logical function call.


/------------------------------------------------------------------------------/
/=====Each-Both
/------------------------------------------------------------------------------/
/Let’s start with an example. We know we can perform an element-wise addition 
/between lists using the below
1 2 3 + 4 5 6
/5 7 9
/+ is an atmoic operator and applies to correspoding pairs.


/But let’s say we have the dyadic join operator (,) . It does not perform an 
/element-wise operation between lists, rather it takes in both left and right 
/arguments in their entirety to join.
"abc", "cfg"
/"abccfg"


/The challenge here is to perform the join element-wise. This is where we use 
/the each-both adverb (‘)
"abc",'"cfg"
/ "ac"
/ "bf"
/ "cg"


("will"; "tom") ,' ("smith"; "hanks")
/ "willsmith"
/ "tomhanks"


// Remember that the lists on either side of each-both should be of the same 
/ length else one will encounter a length error.
"abc" ,' "cg" //ERROR

//The operation works with atoms:
"a" ,' "cgd" 
/ "ac"
/ "ag"
/ "ad"

"cgd" ,' "a"



/------------------------------------------------------------------------------/
/======= Each-left
/------------------------------------------------------------------------------/
/ An atomic operator like + is able to operate the right atom with all elements 
/ on left. Example:

1 2 3 + 10
//11 12 13

/ The each-left adverb (\:) modifies a dyadic function so that it applies the 
/ second argument with each item of the first argument.
/ Let's take an example where we want to join a last name to multiple first 
/ names, where the last name is common.

("Mick"; "Miley"; "Sophie") ,\: " Higgins" //we use join(,) with adver for-each (\:)
/ "Mick Higgins"
/ "Miley Higgins"
/ "Sophie Higgins"

"Mick" , " Higgins" /so check join operator.
/ "Mick Higgins"


/Another eample
1 2 3 +\: (4;5;6;7)  /for loop on each of 1 2 3 and added to (4;5;6;7) 
/ 5 6 7 8 
/ 6 7 8 9 
/ 7 8 9 10

1 2 3 +\: 4 5 6 7 /gives same as they are same as above
/ EQVIVALENT loop in other languages
/ for( i in 1 2 3)
/ {
/    i + (4;5;6;7)
/ }



/------------------------------------------------------------------------------/
/======= Each-right
/------------------------------------------------------------------------------/

/ Each-right works in the exact opposite way to Each-left.
/ The each-right adverb /: modifies a dyadic function so that it applies the first 
/ argument to each item of the second argument. 

1 2 3 +/: (4;5;6;7)
/ 5 6 7 
/ 6 7 8 
/ 7 8 9 
/ 8 9 10

/ EQVIVALENT loop in other languages
/ for( i in 4;5;6;7)
/ {
/    i + (1 2 3)
/ }



/------------------------------------------------------------------------------/
/======= Each-previous
/------------------------------------------------------------------------------/
/ The adverb each-previous (':) provides a declarative way to perform a dyadic 
/ operation on each item of a list with its predecessor.

/ Since the initial item of the list does not have a predecessor, we must 
/ provide one in the left operand of the modified operator. One choice is the 
/ initial item of the source list. For example, to calculate the deltas of a 
/ list of prices.

20 -': 100 99 101 102 101
/80 -1 2 1 -1


//EQUIVALENT other languages
/ /l <- 100 99 101 102 101
/ prev = 20
/ for (i in 1:length(l))
/ {
/     print(l[i] - prev)
/     prev = l[i]
/ }




/==========================================================/
/==================== Adverbs – Part 2 ====================/
/==========================================================/

/Over(/) for Accumulation

/0: initial value
0 +/ 1 2 3 4 5 6
/21

/The left operand “0” is the initial value passed to the accumulator.
/The right operand is the list to be accumulated over.
/The operation starts with (0+1), then this result is added to 2 and so on and so forth.

/ Let’s take an example where we create our own dyadic function to add over a 
/ list and simultaneously use the 0N to print out each step
x: 1 2

y: 0N!x
/With a 0N on the left hand side, returns the right hand side after printing its 
/unformatted text representation to console.

y
/1 2


/Monadic over for Accumulation
/One can get rid of the initial accumulator value by using the monadic form of 
/over. Let’s take an example:
(+/) 1 2 3 4 5 6
/21
/The parenthesis to enclose the function with over are mandatory.


/------Prefix forms of above operations
+/[1 2 3 4 5 6]
/21

/0: initial value
+/[0; 1 2 3 4 5 6]



/------Use cases:
/-- min from list
(&/) 10 2 3 40 5 60 4
/2

/-- max from list
(|/) 10 2 3 40 5 60 4
/60




/===== Over for iteration
/When over(/) follows a monadic function, one can specify the number of times to
/iterate the same operation. Example:
f:{x+2}

f/[5;4]
/14

/The first argument passed is the number of iterations we want. It is 5 in this case.
/The second argument passed is the initial value passed to the list. It is 4 in this case.

f:{0N!x; x+2}
f/[5;4]
/14

/The 0N function shows/prints the value of x passed to function f in each iteration.
/In this case the console prints
/4
/6
/8
/10
/12



/===Over for iteration until convergence
/ Over can behave as a converge when following a monadic function. It keeps 
/ iterating until the last seen is produced. Example:

{x*x}/[0.1]
/0f

/Lets run this with each step printed

{0N!x; x*x}/[0.1]
/0f

/But console prints :
//The function keeps getting called until the last value 0 is produced.
/ 0.1
/ 0.01
/ 0.0001
/ 1e-08
/ 1e-16
/ 1e-32
/ 1e-64
/ 1e-128
/ 1e-256
/ 0f


/=====Over with condition check
/ Over can be limited in the number of its iterations by specifying another 
/ function which condition checks the input passed. Note this applies when 
/ over is following a monadic function. Example:

{0N!x;x+100}/[{1200>x};200]
/The over function is modifying the first function.
/The function:{1200>x} condition checks each iteration by comparing the value 
/of the second argument which is the input to the first function.

{x+100}/[{1200>x};1201]
{x+100}/[{1200>x};1199]





/====Fold using over

/This use-case is for functions with more than two arguments.
/   f/[x;y;z]
/   Applies as:
/   f[f[… f[f[x;y0;z0];y1;z1]; … yn-2;zn-2];yn-1;zn-1] 

{x + y + z}/[ 1 5 6; 2 22; 3 33]
//61 65 66

//Like x = 1  5  6; f( 1 5 6; 2; 3) => 1 5 6 + 2 + 3 => 6 10 11
//     x = 6 10 11; f(6 10 1; 22; 33) => 6 10 11 + 22 + 33 => 61 65 66





/=========== Scan(\)
/ The scan adverb \ is a higher-order function that behaves just like / except 
/ that it returns all the intermediate accumulations instead of just the final 
/ one. Whereas over produces an aggregate function that collapses a list, scan 
/ produces a function whose output has the same number of items as its input.

/ Let’s look at the same examples we used for over:

//Infix scan with dyadic function
0+\ 1 2 3 4 5 6 7 8 9 10
/1 3 6 10 15 21 28 36 45 55

//Prefix scan with dyadic function
+\[0; 1 2 3 4 5 6 7 8 9 10]
/1 3 6 10 15 21 28 36 45 55


//Infix scan with monadic function
(+\) 1 2 3 4 5 6 7 8 9 10
/1 3 6 10 15 21 28 36 45 55

(+\)[ 1 2 3 4 5 6 7 8 9 10]
/1 3 6 10 15 21 28 36 45 55

//We will see how important above become when we need iterations with Tables and Joins.

