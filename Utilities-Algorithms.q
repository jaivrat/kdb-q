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


//Matrix in q. 
//https://code.kx.com/q/ref/mmu/
/Matrix multiply, dot product
/Syntax: x mmu y, mmu[x;y]
/Syntax: x$y, $[x;y]
/Create a matrix 2x4 from list
a:2 4#2 4 8 3 5 6 0 7f
a
/ 2 4 8 3
/ 5 6 0 7

/4 x 3 matrix
b:4 3#"f"$til 12
b
/ 0 1  2 
/ 3 4  5 
/ 6 7  8 
/ 9 10 11

/a.b => 2 x 3
a mmu b
/ 87 104 121
/ 81 99  117


c:3 3#2 4 8 3 5 6 0 7 1f
c
/ 2 4 8
/ 3 5 6
/ 0 7 1

//inverse of matrix
inv c
/ -0.4512195  0.6341463  -0.195122  
/ -0.03658537 0.02439024 0.1463415  
/ 0.2560976   -0.1707317 -0.02439024

//matix into inverse gives back identity
c mmu inv c
/ 1 2.220446e-16 -2.775558e-17
/ 0 1            5.551115e-17 
/ 0 0            1            


1=c mmu inv c
/ 100b
/ 010b
/ 001b


//Also matrix product can be done as
(1 2 3f;4 5 6f)$(7 8f;9 10f;11 12f)
/ 58  64 
/ 139 154

1 2 3f$4 5 6f  /dot product of two vectors
/32f


a mmu b
/ 87 104 121
/ 81 99  117


/Working in parallel : i think better for big matrices
mmu[;b]peach a
/ 87 104 121
/ 81 99  117



/===============================================================================
/ Marginal Risk Contribution 
/ https://faculty.washington.edu/ezivot/econ424/riskbudgetingslides.pdf
/1. Input will be (A) covariance matrix and (b) Weights 
/2. Output will be Risk Contribution
/===============================================================================

/ Covariance matrix
cov_in: (3 3)#2.0 1.3 -1.96 1.3 1.0 0.8 -1.96 0.8 1.5;
cov_in

/-- Wts
wts_in: 0.5 0.2 0.3;
wts_in

/-- just to check conformance
wts_in mmu cov_in
cov_in mmu wts_in

/-- Variance of portfolio
var_: (wts_in mmu cov_in) mmu wts_in

/-- vol
sig : var_ xexp 0.5;

/-- Marginal Risk Contribution
mcr : (1.0%sig)*(cov_in mmu wts_in)
mcr

/-- Risk contribution
mcr * wts_in

/-- Verify that Risk Controbutions add up to vol
sig =sum mcr * wts_in




/GIVEN A VALUE, HOW DO I GET THE NULL OF THAT VALUE’S TYPE?
/We take advantage of a property of q’s indexing: If you request an item from a list (or a dictionary, for that matter)
/using an index that is out of range, q returns the null item for the list’s type.

x: 1 2 3
x 3
/0N

/Thus, we can take the item whose corresponding null we want, make a list from it, and then access that list with an out-of-range index:
NullOf: {[item] enlist[item] 1}
NullOf 1
/0N




