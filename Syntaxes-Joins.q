
/--------------------------------------
/ There are three high-level categories of Joins in q:
/  * Simple joins between unkeyed tables
/  * Joins based on keys between tables
/  * as-of joins, which are joins based on time column tables between tables[again 
/    highlighting the fact that KDB+ provides features as a TSDB].
/------------------------------


t: ([] c1: `a`b`c ; c2: 1 2 3);
/ c1 c2
/ -----
/ a  1 
/ b  2 
/ c  3 

t1: ([] c1: `c`d`a ; c2: 10 20 30);
t1
/ c1 c2
/ -----
/ c  10
/ d  20
/ a  30

t,t1



/---------------------------------------------------
/ Coalesce : 
/ t1^t2
/ t1 and t2 are keyed tables
/ t1 and t2 can have differences in schemas but the primary keys should be the same. (q wouldn’t throw an error if the primary keys are different but the result wouldn’t be as expected)
/ It returns a merged copy of t1 and t2
/ The values of common columns in t2 override the values from t1
/ When t2 has null column values, the column values of t1 are replaced only by the non-null values from t2.
/---------------------------------------------------



/ Equi-join (ej)
/ Syntax:
/   ej[c;t1;t2]
/       c is list of column names or a single column.
/       The result has one combined record for each row in t1 that matches t2 on column(s) c.
/       Any of the tables being joined may or may not be keyed.
/       The schema can be different.
/ THIS IS LIKE SQL "... where a.col1 = b.col1 and a.col2=b.col2




/  Inner-join (ij)
/       Syntax:
/           t1 ij t2
/  t1 and t2 are tables.
/  t2 is a keyed table and the corresponding keyed columns are a part of schema 
/  of t1(it may or may not be keyed). (the schema don’t have to be identical)
/  The result has one combined record for each row in t1 that matches a row in t2.
/  The nulls in t2 for the matching columns override the values in t1.



/ 
/ Left-join(lj)
/   t1 ij t2
/ t1 and t2 are tables.
/ t2 is keyed and the keys of t2 are a part of schema of t1.(t1 may or may not be keyed)
/ The tables are joined on the keyed columns of t2.
/ For each record in t1, the result has one record with the columns of t1 joined to columns of t2.
/ The nulls in t2 for the matching columns override the values in t1.


/ Plus-join(pj)

/ Syntax:
/ t1 pj t2
/ t1 and t2 are tables.
/ t2 is keyed and t1 should have the keys in its schema. t1 may or may not be keyed.
/ The join is performed on the key columns of t2.
/ For each record in t1, if there is a matching record in t2, it is added to the
/  t1 record. If there is no matching record, common column values are unchanged and new columns are zero.


/ Full outer join: no direct way but indirect
/-----------------------------------------------

x:([a:1 1 2 3]; b:3 4 5 6)

/  a | b
/    -----
/    1 | 3
/    1 | 4
/    2 | 5
/    3 | 6

y:([a:1 2 2 4]; c:7 8 9 10)

/ a |  c
/    ------
/    1 |  7
/    2 |  8
/    2 |  9
/    4 | 10


/To get full outer join, simply extract out the non common keys from table x and y and append them to equijoin result.
ej[`a;x;y]
r,(0!x,'y) except r:ej[`a;x;y]










