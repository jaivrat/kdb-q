/Lets construct tables which have 1m rows. PLEASE ALWAYS REMEBER THERE ARE NO ROWS.
/THEY ARE ALL COLUMNS.
dates: 2018.01.01 + 10000000?31 //adding 10 mil random numbers between 0 and 31
times: 10000000?24:00:00.000    //doesnt include 24:00:00.000 
qtys:100 * 1+10000000?100
//we want to randomly appl amzon google and select random symbols
ixs:10000000?3  //10m random indices
syms:`appl`amzn`googl ixs 
//how does above work? Q considers list to be a function. List is a function that maps index to item
// at that index. Or you can say you give list a position, it retrieves item at that position


//Starting prices of appl amaxon and googl
pxs: (1+ 10000000?0.03) * 172.0 1189.0 1073.0 ixs //randomly chosen prices

//create table: Finally
t:([] date: dates; time: times; sym: syms; qty:qtys; px:pxs)

//sort the table, dates and times are in andom orders
t: `date`time xasc t   /SORT by TIME within DATE


//Select query
select date, time, qty, px from t where sym=`appl


//To measure time \t at begining
\t  select date, time, qty, px from t where sym=`appl
//55  in milli sec


//list opes, first and last we can do
first 10 20 30 40 50 
/10

last 10 20 30 40 50 
/50


select open:first px, close: last px by date, time from t where sym=`appl
// date       time        | open     close   
// -----------------------| -----------------
// 2018.01.01 00:00:00.049| 173.3187 173.3187
// 2018.01.01 00:00:02.470| 177.0491 177.0491
// 2018.01.01 00:00:02.593| 174.144  174.144 
// 2018.01.01 00:00:02.681| 174.6041 174.6041


select open:first px, close: last px , lo: min px, hi: max px by date, time from t where sym=`appl
// date       time        | open     close    lo       hi      
// -----------------------| -----------------------------------
// 2018.01.01 00:00:00.049| 173.3187 173.3187 173.3187 173.3187
// 2018.01.01 00:00:02.470| 177.0491 177.0491 177.0491 177.0491
// 2018.01.01 00:00:02.593| 174.144  174.144  174.144  174.144 


// Complex queries
//weighted average function

4 3 2 1 wavg 10 20 30 40 //using weights on left
/20f


//xbar operator: left side of bin it sits in
// or lasgest multiple of 5 that does not exceed the number
5 xbar 0  1 2 3 4 5 10 11 21
/0 0 0 0 0 5 10 10 20
//(above is very useful for grouping, many values group into interval)
//you may want to group into time interval.. trade table may have prices into few milliseconds.
//bucketed volumen weighted average price into 100milli secs.


//What is the maxm idealised profit: max ddn etc..
select px, mins px, px - mins px from t where sym=`appl
//max profit
select max px - mins px from t where sym=`appl
select max (px - (mins px)) from t where sym=`appl


/==============================================================================
/https://www.youtube.com/watch?v=lJXS9mXiL20
/==============================================================================
/* Tables are flipped column dictionaries
/* Collectons of named columns imlemented as dictionaries
/* Columnar oriented makes extrmeley fast for update delete and efficient to store.
 
//Create table from dictionary
a: `sym`price`size!(`AAPL`IBM`MSFT;100 200 300; 10 20 30)
a
// sym  | AAPL IBM MSFT
// price| 100  200 300 
// size | 10   20  30

t: flip a
t
// sym  price size
// ---------------
// AAPL 100   10  
// IBM  200   20  
// MSFT 300   30  
type t //98 : its a table

//We already know how to create a table
t:([] sym: `AAPL`IBM`MSFT; price: 100 200 300;  size :10 20 30)
t

//Gives list of all avi;able tables
\a

//also using this
tables `

//columns of table
cols t
/`sym`price`size


meta t
//I know: t f a, t is for type, f is for foregin key, a is for attributes
// c    | t f a
// -----| -----
// sym  | s    
// price| j    
// size | j    


//Let us do a new table
trd: ([] sym: `AAPL`IBM`MSFT; price: (100 200 300; 30 45 66; enlist 45);  size :10 20 30)
trd
// sym  price       size
// ---------------------
// AAPL 100 200 300 10  
// IBM  30 45 66    20  
// MSFT ,45         30  

meta trd  //Note here that type of price becomes upper case
// c    | t f a
// -----| -----
// sym  | s    
// price| J    
// size | j    



/===================== Part 2 ==========================/
trd: ([] sym: `AAPL`IBM`MSFT; price: 100 200 300;  size :10 20 30)
trd

//You get dictionary back if you do index first on eon the table
trd[0]
// sym  | `AAPL
// price| 100
// size | 10


//Further indexing
trd[0][`sym]
/`AAPL


trd.price
/100 200 300

trd.sym
/`AAPL`IBM`MSFT



//To reorder columns: LHS mentions order of columns and RHS is table.
//read as "get size price then rest of the table"
`size`price xcols trd
// size price sym 
// ---------------
// 10   100   AAPL
// 20   200   IBM 
// 30   300   MSFT



//Rename Columns: Not below we use xcol, NOT the xcols
//So we rename  first two
trd
`size_new`sym_new xcol trd
// size_new sym_new size
// ---------------------
// AAPL     100     10  
// IBM      200     20  
// MSFT     300     30  

//can we do above by variable: YES
myvar:  `size_new`sym_new

myvar xcol trd
// size_new sym_new size
// ---------------------
// AAPL     100     10  
// IBM      200     20  
// MSFT     300     30  



//== Some other things we can do with Q sql.
//select, update, insert, delete
select from trd


//
select sym, new_price: price + 30 from trd
// sym  new_price
// --------------
// AAPL 130      
// IBM  230      
// MSFT 330  


//Update: Note that it returns, (DOES NOT UPDATE TABLE IN PLACE)
update price: price+30 from trd
// sym  price size
// ---------------
// AAPL 130   10  
// IBM  230   20  
// MSFT 330   30  
trd
// sym  price size
// ---------------
// AAPL 100   10  
// IBM  200   20  
// MSFT 300   30  


select from trd where sym=`AAPL
// sym  price size
// ---------------
// AAPL 100   10  


select from trd where sym in `AAPL`MSFT
// sym  price size
// ---------------
// AAPL 100   10  
// MSFT 300   30  


//You can also use mathematical like avg, first, var for variance etc... 


//Insert records into tables: How?
// Since table are list records (disctionary sense) you can do so by assigning 
// as new record in list
trd ,: `sym`price`size!(`NVDA;250;25) 
trd
// sym  price size
// ---------------
// AAPL 100   10  
// IBM  200   20  
// MSFT 300   30  
// NVDA 250   25  

//we can also insert without providing column names
//(in came order)  - Yes makes sense
trd ,: (`AMD;19;30) 
trd
// sym  price size
// ---------------
// AAPL 100   10  
// IBM  200   20  
// MSFT 300   30  
// NVDA 250   25  
// AMD  19    30  

//(Note types of records should match - above)
//If original table has no type attached, you can insert anything then
// happens when original table 


//ANothe insertion way
`trd insert (`YEXT; 300; 50)
//,5
/(ABove is the row number where the record is inserted
trd
// sym  price size
// ---------------
// AAPL 100   10  
// IBM  200   20  
// MSFT 300   30  
// NVDA 250   25  
// AMD  19    30  
// YEXT 300   50 


//insert multiple records
`trd insert ((`IBM; 120; 40); (`AAPL; 130; 60)) //ERROR
`trd insert (`IBM`AAPL; 120 130; 40 60) //CORRECT - philosophy of being columnar
/6 7
trd
// sym  price size
// ---------------
// AAPL 100   10  
// IBM  200   20  
// MSFT 300   30  
// NVDA 250   25  
// AMD  19    30  
// YEXT 300   50  
// IBM  120   40  
// AAPL 130   60  



//Delete rows from table: NOTE that is returns (DOES NOT DO INPLACE like Oracle)
delete from trd where sym=`AAPL
// sym  price size
// ---------------
// IBM  200   20  
// MSFT 300   30  
// NVDA 250   25  
// AMD  19    30  
// YEXT 300   50  
// IBM  120   40  
trd
// sym  price size
// ---------------
// AAPL 100   10  
// IBM  200   20  
// MSFT 300   30  
// NVDA 250   25  
// AMD  19    30  
// YEXT 300   50  
// IBM  120   40  
// AAPL 130   60  



//Drop a column is also done using delete: (DOES NOT drop inplace but returns)
delete size from trd
// sym  price
// ----------
// AAPL 100  
// IBM  200  
// MSFT 300  
// NVDA 250  
// AMD  19   
// YEXT 300  
// IBM  120  
// AAPL 130  

delete  from trd where price<>300
// sym  price size
// ---------------
// MSFT 300   30  
// YEXT 300   50  






































