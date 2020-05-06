//flatten a nested structure

flatten: { [alist]
   $[(count alist) ~ count raze alist; 
     :alist ;
     :flatten raze alist
     ];
 }
 
 flatten ((1; 2; 3); (`x`y; (`a`b); (`c;(`d`e)); (10;20;(30;40;(50;60;70)))))
 