//=========== Multiple group by ===========//

N:10
// trade:([] sym:N?`ibm`msft`hsbc`samsung; price:N?(303.00*3+1); size:N?(900*5); time:N?(.z.T-365))
trade:([] exch:N?`A`B; sym:N?`ibm`msft`hsbc`samsung; price:N?(303*3+1); size:N?(900*5); time:N?(.z.T-365))
trade

//------------------
select from trade where price > 40

wherecon: enlist (>;`price;40)
?[`trade;wherecon;0b;()] / select from t where p > 40


//------------------
select max price by exch from trade where price > 40 
groupby: (enlist `exch) ! (enlist `exch)
selcols: (enlist `maxpric) ! enlist( (max; `price))
?[ `trade;wherecon; groupby;selcols] 


//------------------
res1: select max price by exch, sym from trade where price > 40 

groupby: `exch`sym!(`exch;`sym)
groupby
selcols: (enlist `price) ! enlist( (max; `price))
selcols
res2: ?[ `trade;wherecon; groupby;selcols] 

res1
res2

res1 ~ res2
