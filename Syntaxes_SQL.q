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































