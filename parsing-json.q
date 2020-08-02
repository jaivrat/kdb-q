
/-- https://www.thetopsites.net/article/53089356.shtml

system "cd /Users/jvsingh/a-KDB-Q"

system "pwd"

/-- 
read0 `:sample.json
/ ,"{"
/ "\"name\":\"John\","
/ "\"age\":\"30\","
/ "\"cars\":[\"Ford\", \"BMW\", \"Fiat\" ]"
/ ,"}"

/-- A raze should be used to flatten our list of strings:
raze read0`:sample.json


/-- Finally, using .j.k on this string yields the dictionary
.j.k raze read0`:sample.json


/-- For a particularly large JSON file, it may be more efficient to use read1 rather than raze read0 on your file, e.g.
.j.k read1`:sample.json
/ name| "John"
/ age | 30f
/ cars| ("Ford";"BMW";"Fiat")

