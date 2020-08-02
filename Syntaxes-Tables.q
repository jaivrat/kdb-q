system "pwd"


/ In the coming chapters, we’re going to be looking at persisting the in-memory
/ tables down to disk. There are multiple structures the data can be stored in.
/ Serialized tables
/ Splayed tables
/ Partitioned tables
/ Segmented tables

/==============================================================================
/                  Serialized tables
/==============================================================================
/ Any table(keyed or unkeyed) can be persisted to disk using 
/ serialization/deserialization mechanism provided by the set and get operations
/ (discussed in File I/O section).

/ * The entire table is saved down as a single data file.
/ * set operation is used to save-down and get is used to retrieve back.
/ * Always make sure to have enough memory in RAM when loading back.

/ Let’s take a practical example of this.

/ * Create an in-memory table.
/ * Save it down to disk using set.
/ * End the q session.
/ * Check the contents of the file on disk.
/ * Start a new q session and load it back using get.

/Create a new table
t:([] name:`ash`ketchum`pika; age: 12 13 14; city:`ny`nj`la)
t
/ name    age city
/ ----------------
/ ash     12  ny  
/ ketchum 13  nj  
/ pika    14  la  

/Save to file
(hsym `$"/Users/jvsingh/a-KDB-Q/t") set t

/On file system, have a look
/ (base) jvsingh: ~/a-KDB-Q  -> file t
/ t: dasa
/ (base) jvsingh: ~/a-KDB-Q  -> 



/Loading the table back into a new q session with get
t_read: get (hsym `$"/Users/jvsingh/a-KDB-Q/t")

t_read
/ name    age city
/ ----------------
/ ash     12  ny  
/ ketchum 13  nj  
/ pika    14  la  


/We can query directly as well, using filehandle
select from (hsym `$"/Users/jvsingh/a-KDB-Q/t")
/ name    age city
/ ----------------
/ ash     12  ny  
/ ketchum 13  nj  
/ pika    14  la  



/===============================================================================
/            Splayed Tables
/===============================================================================
/There are some issues with serialized tables:

/The entire table has to be loaded into the memory even if a user needs only a 
/chunk of it. Operations may be slower if queries are run against the persisted 
/serialized table, being loaded each time of making a call.

This is where Splayed tables come in.

/ * Splayed tables are saved down to a directory with each column stored as a 
/   single file with the same name as a column.
/ * It solves the memory issue we noticed with serialized tables. This is because 
/   the column data is loaded on-demand per query and released back when no 
/   longer required.

/Restrictions:
/ * Keyed tables cannot be splayed. Unkey them with 0! and then splay.
/ * Only columns which are simple lists or compound lists(all items in the column 
/   are lists of the same type) can be splayed.
/ * All symbol columns must be enumerated (we discussed the concept here before) 
/   before the table is splayed. The reason is to store the integer indexes of 
/   the symbol values which is a much efficient way of saving space and faster 
/   retrieval.

/https://thinqkdb.wordpress.com/splayed-tables/

/They are more efficient and useful than serialized tables, especially when the 
/table sizes get large.
















