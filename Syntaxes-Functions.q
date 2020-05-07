/ Simple : f:{[x] x:x+2;x*x}
/
/ The sequence is evaluated left to right. However, the individual expressions 
/ are always evaluated from right to left.

//Note: A function is a first class value in q. That means a function is data 
/ just like symbols, int. A function is assigned to a variable to name it. 
/ The example below will give a clearer picture.



f:{[x] x:x+2;x*x}
type f
//100h

type {[x] x:x+2;x*x}
//100 h



/====Functions Valence/Rank
/    {[p1;...;pn] e1; ...; em}
/      p1, p2….pn -> Formal parameters passed(Optional)
/      e1, e2…..en -> Expressions sequence      
/      “;” -> Expression separators
/Valence/Rank: The valence or rank of a function is the number of formal 
/              parameters passed to it.
/              Monadic – A function with valence 1.
/              Dyadic  – A function with a valence 2.
/              Niladic – A function with valence 0.
/
/Note: The maximum allowed valence for a function in kdb is 8. One can use 
/dictionaries or lists to pass longer arguments.


/Monadic
mf :  {[x] x*x}
/Diadic
df :  {[x;y] x+y}
/niladic
nf:{[] 33} 


//Use:
mf 1 2 3 
/1 4 9

mf (1 2 3;4 5 6)
/ 1  4  9 
/ 16 25 36


df[3;4]


//Note that if you pass list, whole list becomes an argument
//DONT BE CONFUSED THAT function operates on individual element.
//REMEBER as far as possibly Q gobbles vectors
nf 1 2 3 4
nf til 10
{[] 33} til 10
{[x] 33} til 10
mf til 10
mf each til 12

/Function application in q is strict, meaning that expressions in arguments are
/ evaluated before substitution to the function. (Example below)
{[x;y] y%x + x}[10; 20*30]
//30f
/600%10 + 10 => 600%20=>30
20+30%10  + 10
/21.5
(20+30)%10  + 10
/2.5


//Implicit Parameter – ‘Let x, y and z be arguments’
f:{x * y * z}
f[2;5;10] /100




//=======Local and Global Variables
/Local variables are defined with a single colon : inside a function.
/A local variable is not visible outside its immediate scope of the definition.
/A local variable is not visible within the body of a local function defined in the same scope.

/Local variable inside function
f:{[x] a:5; x+a}
f[4]
a //No visible

//A local variable is not visible outside its immediate scope of the definition.
f:{[arg1] 
    a:1; 
    g:{[arg2] a*arg2}; 
    g arg1 
}
f[5] //SHOULD BE ERROR because loal a to f is not even avilable to enclosed function g


/One needs to pass the argument to the function separately and define 
/the local function to read it.
f:{ [arg1] 
       a:2; 
       g:{[somearg; arg2] somearg*arg2}[a;]; g arg1 }

f[5]
/Note abobe that g:{[somearg; arg2] somearg*arg2}[a;] is like partial function as 
/its first argument "somearg" is binded with a, and in the last statement you make
/a call with arg1 only.


//I wonder how g:{[somearg; arg2] somearg*arg2}[a;] this works, unpassed arguments
myfun:{[a;b] a+b}
type myfun
/100h

part1: myfun[10;] //10 binds to first arg
type part1
/104h
type {[x] x*x}
/100

part1[12] 
/22

part2: myfun[;30] //30 binds to second
type part2
/104

part2[4]
/34



//=======Assigning Global Variables within a Function
/ The double-colon :: operator can be used to amend or assign global 
/ variables inside of a function.
a:8
f:{a::9;b::25; x*a}
f[7]
/63
a
/9
b
/25



/ If there’s an existing local variable with the same name as the global 
/ variable one’s trying to amend, double-colon has an effect only on the
/ local variable.
a:8
f:{[x] a:6; a::x; a+x}
f[9]
/18
a
/8



/========= Function Projection
/ Projection means specifying only some of the parameters in function 
/ application, resulting in a function of the remaining parameters.

SI: {[p;r;t] p*r*t}
SI[1000; 0.05; 10]
/500f

easySI:SI[;0.05;]  //0.05 binds to r
easySI[20;10]
//10f


/======Some Important Terminology
/==Some important terms for functions:
/ Ambivalent Functions: A function that may be applied to either one or two arguments; i.e. has both unary and binary applications. Example: deltas
/ Binary Function: A function with valence 2.
/ Infix Notation: Writing an operator between its arguments
/ Prefix Notation: Applying a function to its argument/s by writing it to the left of them
/ Postfix Notation: Will be looked at in the Adverbs section.
/ Unary Function: A function with valence 1.

/infix
2+3  /5


/prefix
+[2;3]
/5

f:{[x;y] x+y}

/Function call is like prefix
f[2;3]
/5

2 f 3 //infix call to function does not work.
/ERROR


(+/) 1 2 3 4
/10
(f/) 1 2 3 4
/10

(f\) 1 2 3 4
/1 3 6 10



