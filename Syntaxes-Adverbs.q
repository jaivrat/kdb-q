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




















