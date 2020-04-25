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