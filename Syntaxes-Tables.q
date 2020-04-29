/======Foreign Keys
/  A foreign key is a column in one table whose values are members of a primary
/  key column in another table. Foreign keys are the mechanism for establishing 
/  relations between tables.

/  Foreign keys are important to maintain referential integrity between tables 
/  in databases. It means:
/  Values in the foreign key column should exist in the primary key column.
/  Operations such as deletion of a linked value need to be handled to maintain this relationship.
/  Foreign keys in q is achieved by a concept called Enumeration.


/==Enumeration
/ For a long list containing a few distinct values, an enumeration can reduce 
/ storage requirements.  Let’s see how it works under the cover(The below is 
/ just for an explanatory purpose)

y: `a`b`c`b`a`b`c`c`c`c`c`c`c`c
x: `a`b`c

show e: "i"$x?y;
/0 1 2 1 0 1 2 2 2 2 2 2 2 2i
//These are index values stored instead of symbols

//getting back the values: Note list is a function, and we pass indices as args to give vals
x e
/`a`b`c`b`a`b`c`c`c`c`c`c`c`c

`x$y
/Enumeration stores just the indexes of distinct symbols, references that is. 
/This is how foreign keys are implemented.


/=================================================================================
/The table friends has the primary key eid
/The column eid in table bill is enumerated based on the primary key in the first table.
/This relation lets us run the select query to get the data from the first 
/table while running it on the table bill. (More on queries in the coming sections)

friends :( [eid: 100 101 102] name:`joey`chandler`ross)
friends
/ eid| name    
/ ---| --------
/ 100| joey    
/ 101| chandler
/ 102| ross    

bill:([]eid:`friends$100 101 102 101 100; money: 3 4 5 6 7) //foreign key
bill
/ eid money
/ ---------
/ 100 3    
/ 101 4    
/ 102 5    
/ 101 6    
/ 100 7    

//If we try to add some eif in bill which is not in friends then it is ERROR


//Complex Column Data
/     There are cases when one needs to store lists inside cells which means having 
/     nested column lists. Simple column lists are more efficient in storing and 
/     analyzing data though.
/     
/     But it’s completely fine to have nested lists. Let’s take an example where we 
/     have a case of getting some Market data for a symbol from different venues. 
/     There might be a case where one venue is closed. So one might end up getting 
/     scattered data.

//See in https://thinqkdb.wordpress.com/tables-part-2/



/====================Operations on tables and keyed tables
/Let’s take the below two tables and then run operations on them

t:([] name:`aa`bb`cc; age:21 22 23) /simple
kt:([name:`aa`bb`cc]; age:21 22 23) /keyed table
t
/ name age
/ --------
/ aa   21 
/ bb   22 
/ cc   23 
kt
/ name| age
/ ----| ---
/ aa  | 21 
/ bb  | 22 
/ cc  | 23 


//==List opf operations
/ count -> Get the number of records in table
/ first and last -> first and last records of table respectively
/ keys -> Lists Keys of a table
/ cols -> Lists Columns of a table
/ xkey -> Set primary key of a table
/ xcol -> Renaming a column
/ xcols -> Arranging columns
/ _ -> Cut operation to remove records
/ # -> Take n number of records
/ Insert -> Insert records into a table
/ Upsert -> Upsert records into a table




/keys -> Lists Keys of a table
keys t
/ `symbol$()

keys kt
/ ,`name

/ cols -> Lists Columns of a table
cols t
/`name`age


/ xkey -> Set primary key of a table
t
/ name age
/ --------
/ aa   21 
/ bb   22 
/ cc   23 

`name xkey t
/ name| age
/ ----| ---
/ aa  | 21 
/ bb  | 22 
/ cc  | 23 

/ xcol -> Renaming a column
`age`name xcols t
/ age name
/ --------
/ 21  aa  
/ 22  bb  
/ 23  cc  

// xcols -> Arranging columns
//.(Note xcols wouldn’t work for keyed tables.)


/ _ -> Cut operation to remove records
1_t //Rem first rec

-1_t //rem last rec


/ # -> Take n number of records
//we know this


/ Insert -> Insert records into a table
/ Upsert -> Upsert records into a table

/upsert simply inserts to an unkeyed table
t
/ name age
/ --------
/ aa   21 
/ bb   22 
/ cc   23 

`t upsert (`ee;26)

t
/ name age
/ --------
/ aa   21 
/ bb   22 
/ cc   23 
/ ee   26 


/===============================================================================
/==========================Tables – Part 3
/===============================================================================
/This section is about Attributes in q. Let’s see what attributes are and how 
/they’re useful with some important points below:

/ * Attributes are metadata which are attached to lists of special types.
/ * Attributes are applied on a dictionary domain or table column to speed up 
/   certain operations.
/ * The q interpreter makes certain optimizations based on the attribute applied. 
/ * In simple words, a certain attribute tells the interpreter that this is a 
/   specific kind of a list and the interpreter follows a different route than 
/   usual to speed up operations.
/ * The application of an attribute does not make any changes to the list or convert 
/   it in any manner.
/ * It is the responsibility of the user to keep the list in that special form. An 
/   attribute is just a mediator between the user and the interpreter.
/ * If you perform an operation that defies the original special form that the 
/   attribute was indicating, the attribute is lost.
/ * Attributes speed up operations only when you’re dealing in order of millions
/   of records.
/ * The syntax is an overload of # function. The first operand is the attribute 
/   symbol and the second operand is the list/domain it is being applied on.
/ * This is a lot to take in. Let’s jump into each of the attributes that q 
/   supports and see examples for each of them.



//-------  Sorted `s#
/Applying the sorted attribute indicates that the list is sorted in ascending order.
/When this attribute is applied, linear search is replaced by binary search.
/This helps with functions such as in, within, find, relational operation.
/Applying this to a non-sorted list results in a failure. (s-fail)
/Appends that preserve the sorted order maintain this attribute else the attribute is lost.
/It is helpful with time-series data if you apply this to the time column.


l: 1 2 3 4
l: `s#l

...to be done...



