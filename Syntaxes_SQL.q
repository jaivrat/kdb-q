/Lets construct tables which have 1m rows. PLEASE ALWAYS REMEBER THERE ARE NO ROWS.
/THEY ARE ALL COLUMNS.
N:100
dates: 2018.01.01 + N?31 //adding 10 mil random numbers between 0 and 31
times: N?24:00:00.000    //doesnt include 24:00:00.000 
qtys:100 * 1+N?100
//we want to randomly appl amzon google and select random symbols
ixs:N?3  //10m random indices
syms:`appl`amzn`googl ixs 
//how does above work? Q considers list to be a function. List is a function that maps index to item
// at that index. Or you can say you give list a position, it retrieves item at that position


//Starting prices of appl amaxon and googl
pxs: (1+ N?0.03) * 172.0 1189.0 1073.0 ixs //randomly chosen prices

//create table: Finally
t:([] date: dates; time: times; sym: syms; qty:qtys; px:pxs)

//sort the table, dates and times are in andom orders
t: `date`time xasc t   /SORT by TIME within DATE
t

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


select open:first px, close: last px by date from t where sym=`appl
/ date      | open     close   
/ ----------| -----------------
/ 2018.01.01| 172.0695 172.0695
/ 2018.01.02| 176.9233 172.9362
/ 2018.01.06| 176.5323 176.5323


select open:first px, close: last px by date from t where sym=`appl



select open:first px, close: last px , lo: min px, hi: max px by date from t where sym=`appl
/ date      | open     close    lo       hi      
/ ----------| -----------------------------------
/ 2018.01.01| 172.0695 172.0695 172.0695 172.0695
/ 2018.01.02| 176.9233 172.9362 172.9362 176.9233
/ 2018.01.06| 176.5323 176.5323 176.5323 176.5323


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

//Gives list of all available tables
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
/ sym  price size
/ ---------------
/ AAPL 100   10  
/ IBM  200   20  
/ MSFT 300   30  


//You get dictionary back if you do index first on eon the table: 
// I see reconrds, this indexig gives rows and row is nothing but a dictionary.
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


//insert multiple records in table
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



//The “i” column : q provides a virtual column i which represents the offset of each record
select i, sym, price from trd
/ x sym  price
/ ------------
/ 0 AAPL 100  
/ 1 IBM  200  
/ 2 MSFT 300  
/ 3 NVDA 250  



//select[]
/select[n] can be used to get the first n or last n records of a table.
/select[n m] can be used to get records starting from n and upto count m from n.
select [1 4] from trd
/ sym  price size
/ ---------------
/ IBM  200   20  
/ MSFT 300   30  
/ NVDA 250   25  
/ AMD  19    30  



//The where phrase: output only the ones which meet the criteria defined(boolean 1b).
//lets see on list
l: 1 2 3 4 5
where l>3  /indexes where it holds. Internally it generates booleans
/3 4
where 0N!l>3   //on server console it genrares 00011b
/3 4


/Since table is logically a list of records, we can perform an operation like below:
trd
trd[`price] > 250 
/001001001b

/return the records which satisfy this
where trd[`price] > 250  
/2 5 8
trd 2 5 8
trd where trd[`price] > 250 
/ sym  price size
/ ---------------
/ MSFT 300   30  
/ YEXT 300   50  
/ IBM  900   60  

/Let’s now use this is the select template:
select from trd where price > 250
/ sym  price size
/ ---------------
/ MSFT 300   30  
/ YEXT 300   50  
/ IBM  900   60  


//Multiple where clause - we already know, skipping here. We use "," NOT "and"
select from trd where price > 250 , size < 60
/ sym  price size
/ ---------------
/ MSFT 300   30  
/ YEXT 300   50  


//If you prefer to use "and"  in , then bracket the expression.
select from trd where (price > 250) and ( size < 60)


//Reconstuct data
N:12;
dates: 2018.01.01 + N?31; //adding 10 mil random numbers between 0 and 31
times: N?24:00:00.000;    //doesnt include 24:00:00.000 
qtys:100 * 1+N?100;
ixs:N?3 ;
syms:`appl`amzn`googl ixs ;
pxs: (1+ N?0.03) * 172.0 1189.0 1073.0 ixs; //randomly chosen prices
trade:([] date: dates; time: times; sym: syms; qty:qtys; px:pxs);

trade
/ date       time         sym   qty  px      
/ -------------------------------------------
/ 2018.01.28 21:54:47.564 amzn  400  1196.813
/ 2018.01.09 06:07:49.855 amzn  8100 1206.535
/ 2018.01.06 19:51:34.380 amzn  1600 1197.531
/ 2018.01.24 00:04:32.162 amzn  3400 1205.075
/ 2018.01.27 15:01:58.182 googl 8100 1083.574
/ 2018.01.18 17:04:33.378 appl  5800 175.5176
/ 2018.01.15 10:41:11.202 googl 7700 1087.481
/ 2018.01.22 01:53:39.465 appl  4400 173.2632
/ 2018.01.13 02:14:20.158 googl 5700 1077.666
/ 2018.01.31 17:38:59.162 appl  3800 177.0596
/ 2018.01.25 14:11:14.460 googl 2000 1082.25 
/ 2018.01.11 15:20:17.680 googl 4300 1082.314



/The by phrase : The by clause defines how common values are grouped.
/ result of grouped columns will be nested list
select px, i by sym from trade
/ sym  | px                                          x          
/ -----| -------------------------------------------------------
/ amzn | 1196.813 1206.535 1197.531 1205.075         0 1 2 3    
/ appl | 175.5176 173.2632 177.0596                  5 7 9      
/ googl| 1083.574 1087.481 1077.666 1082.25 1082.314 4 6 8 10 11




//analytics on grouped
select max px by sym from trade
/ sym  | px      
/ -----| --------
/ amzn | 1206.535
/ appl | 177.0596
/ googl| 1087.481

/Let’s see what happens if we do not select any column while using by
/This returns the last record for each symbol
select by sym from trade
/ sym  | date       time         qty  px      
/ -----| -------------------------------------
/ amzn | 2018.01.24 00:04:32.162 3400 1205.075
/ appl | 2018.01.31 17:38:59.162 3800 177.0596
/ googl| 2018.01.11 15:20:17.680 4300 1082.314


//ungroup
ungroup select px by sym from trade
/ sym   px      
/ --------------
/ amzn  1196.813
/ amzn  1206.535
/ amzn  1197.531
/ amzn  1205.075
/ appl  175.5176
/ appl  173.2632
/ appl  177.0596
/ googl 1083.574
/ googl 1087.481
/ googl 1077.666
/ googl 1082.25 
/ googl 1082.314



/Can a by subphrase be a q expression? – Yes
select max date by (px > 500) from trade
/ x| date      
/ -| ----------
/ 0| 2018.01.31
/ 1| 2018.01.28

/xbar: The xbar verb rounds its right argument down to the nearest multiple of
/      the integer left argument. The right argument can be any numeric or temporal
7 xbar 10 20 30 40 50 
/7 14 28 35 49 

/The trade table is grouped by symbol and 240 minute buckets.
select px by sym, 240 xbar time.minute from trade
/ sym   minute| px                       
/ ------------| -------------------------
/ amzn  00:00 | ,1205.075                
/ amzn  04:00 | ,1206.535                
/ amzn  16:00 | ,1197.531                
/ amzn  20:00 | ,1196.813                
/ appl  00:00 | ,173.2632                
/ appl  16:00 | 175.5176 177.0596        
/ googl 00:00 | ,1077.666                
/ googl 08:00 | ,1087.481                
/ googl 12:00 | 1083.574 1082.25 1082.314
/      
            
/The avg operation is then applied to each item of the price column.
select avg px by sym, 240 xbar time.minute from trade  
/ sym   minute| px      
/ ------------| --------
/ amzn  00:00 | 1205.075
/ amzn  04:00 | 1206.535
/ amzn  16:00 | 1197.531
/ amzn  20:00 | 1196.813
/ appl  00:00 | 173.2632
/ appl  16:00 | 176.2886
/ googl 00:00 | 1077.666
/ googl 08:00 | 1087.481
/ googl 12:00 | 1082.713


/ The exec template: exec a by b from t where c
/ The command for select is identical to exec.
/ The result depends on the number of columns specified in the exec.
/ One column results in a list.
/ More than one column results in a dictionary.
/ One difference between select and exec is that the column lists do not have to 
/ be rectangular to return a result. (Example for this below)

exec sym from trade
/`amzn`amzn`amzn`amzn`googl`appl`googl`appl`googl`appl`googl`googl

exec sym, px  from trade
/ sym| amzn     amzn     amzn     amzn     googl    appl     googl    appl     ..
/ px | 1196.813 1206.535 1197.531 1205.075 1083.574 175.5176 1087.481 173.2632 ..

exec px by sym from trade

/exec with a single column with by clause returns a dictionary
exec max px by sym from trade
/ amzn | 1206.535
/ appl | 177.0596
/ googl| 1087.481



//update a by b from t where c
/ The command for update phrase is identical to select.
/ The update phrase updates a pre-existing column in t with a value evaluated with an assignment.
/ If the column does not exist, the column is joined to the result at the end of column list.
/ The original table is not affected unless the data is persisted by using backtick.


 
