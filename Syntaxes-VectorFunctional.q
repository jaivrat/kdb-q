
//https://www.youtube.com/watch?v=ZGIPmC6wi7E

/LIST VERBS
/-------------

/take #
2#till 10

/join ,
(til 4), til 4

/split _  . LHS is indices where to split
0 3 6 _ til 9
// 0 1 2
// 3 4 5
// 6 7 8

count each 0 3 6 _ til 9
/3 3 3


//DYADIC, combine with an adverb
//eg each-both(')   take(#) + each both(')=take-each-both(#')
// ' is quote, NOT A BACKQUOTE`
3#0
/0 0 0 

3 3 3#'0 1 2
// 0 0 0
// 1 1 1
// 2 2 2

3 4 6#'0 1 2
// 0 0 0
// 1 1 1 1
// 2 2 2 2 2 2


//======================== ADVERBS==========================/
/  noun verbADVERB noun
3 3 3#'0 1 2
// 0 0 0
// 1 1 1
// 2 2 2
//Above 3 3 3 is noun , # is verb   ' is adverb and 0 1 2 is noun


/== FOLD AND SCAN ARE ADVERBS
/Fold (/) is an adverb, we call it "over"

0 +/ til 5  / a plus reduction over 0 1 2 3 4 
//10


/ Scan(\) return the incremental values of "over: left to right
0 +\ til 5  


//=============FLEXIBLE MAPPING WITH ADVERBS ====================/
/-- Only 6 adverbs, byt the come up all the time

/======  each-right (/:)
max @/: 0 3 6 _ til 9  /Using monadic function application to pair max  with each of three rows of matrix
/2 5 8

0 3 6 _ til 9
// 0 1 2
// 3 4 5
// 6 7 8

0 3 6 _ 14 5 6 2 0 9 7 10 12
// 14 5  6 
// 2  0  9 
// 7  10 14

max @/: 0 3 6 _ 14 5 6 2 0 9 7 10 12 // this does row wise
/14 9 12

max @\: 0 3 6 _ 14 5 6 2 0 9 7 10 12  //this does colum wise
/14 10 12


/====== each-left (/:)  pair each thing on left with that on right

(floor; ceiling) @\: 5.5
/5 6


(floor; ceiling) @\: (5.5 3.2)
// 5 3
// 6 4
/something like floor (5.5, 3.2)  then ceiling (5.5, 3.2). Kind of outer for loop with things on left


floor 5.2 3.2

/====== each-prior(':)

/subtract each prior of list, for the first one subtract 0. Kind of differencing
0 -': til 5
/1 1 1 1

/subtract each prior of list, for the first one subtract 1. Kind of differencing
1 -': til 5
/-1 1 1 1 1


/subtract each prior of list, for the first one subtract 1. Kind of differencing
1 - ': 10 45 50 30
/9 35 5 -20



/====== compose: 
/====== each-left-each-right (\:/:)

(min; max) @\:/: 0 3 6 _ til 9
// 0 2
// 3 5
// 6 8

0 3 6 _ til 9
// 0 1 2
// 3 4 5
// 6 7 8



//=== PRIME NUMBER GENERATION
/- forget loops
/- Imagine a 100x100 matrix with 1..100 on x and 1..100 on y
/  each cell is x mod y ie the mreainder when x div by y



0 +/ 0 3 6 _ til 9




