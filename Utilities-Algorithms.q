//flatten a nested structure

flatten: { [alist]
   $[(count alist) ~ count raze alist; 
     :alist ;
     :flatten raze alist
     ];
 }
 
 flatten ((1; 2; 3); (`x`y; (`a`b); (`c;(`d`e)); (10;20;(30;40;(50;60;70)))))
 
/Stock Returns
stock_prices: 30.0 32.0 31.0 31.5 32.5 32 31.5 32
0N -': stock_prices
rets1 : -1.0 + (stock_prices) % (0N, stock_prices[til -1  + count stock_prices])
rets1
/ 0n 0.0666667 -0.03125 0.016129 0.031746 -0.0153846 -0.015625 0.015873

//Aplying this has second argument pass first : f ': a1 a2 a3   does f[a2;a1] f[a3;a2]
{[y;x] y-x}': [ 1 2 5 8 9]

rets2: {[y;x] -1.0 + (y%x)}': [stock_prices]
rets2
/0n -0.0625 0.0322581 -0.015873 -0.0307692 0.015625 0.015873 -0.015625


rets3: {[y;x] -1.0 + y%x} prior stock_prices
rets3
/0n -0.0625 0.0322581 -0.015873 -0.0307692 0.015625 0.015873 -0.015625
