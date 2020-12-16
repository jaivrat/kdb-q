//Qstudio connected to 8888
//for IPC, we connect to remote server 


/ Syntax:
/ hopen `:[server]:port
//h:   hopen `::9999

getConn:{[]
  h:   hopen `::9999;
  : h
 };



// Remote execution
/Using a function with arguments in a list

f:{x + y}
//send function to server for execution

h: getConn[];

h (f; 3; 5)
/8

//Closing the Handle
hclose h


//============================Synchronous and Asynchronous Communication========
/To make a sync call, we make use of the naked(positive value of the handle) handle.
/To make an async call, we negate the handle using the neg function. (neg h)
/sync call
h: getConn[]   
h "7*8"
/async call
(neg h) "7*8"
hclose h



//.z namespace for IPC- Processing Messages and Callbacks
/Syntax:
/    .z.po:f
/This function is evaluated when a client makes a connection.
/     f is a unary function.

/-- On server
/ q)msg: {[] `$"Got New Connection" }
/ q).z.po: msg
/ q)

/Here on Client
h: getConn[] 
hclose h


msg: {[] 0N!`$"Got New Connection" }
msg: {[] a:: a + 1; 0 }

/===============================================================================
/.z.pg(get for Sync)
/This function is evaluated when a Synchronous call is made by a client.
/  f is a unary function assigned.
/ The default behavior is value x, where x is the call made by the client.


/===============================================================================
/.z.ps(set for Async)
/.z.ps:f


/===============================================================================
/Syntax:
/   .z.pc:f
/This function is called when a client closes a connection.
/ f is a unary function assigned.
/ .z.po – We capture the user, handle, host, handle with .z.w(returns clients 
/         handle with .z.po and server handle with .z.pc) and time in a table 
/         when a connection is opened.
/ .z.pg – We capture the user, function call by client, host, handle and time 
/         in a table when a synchronous call is made.
/ .z.ps – We capture the user, function call by client, host, handle and time 
/         in a table when an asynchronous call is made.
/ .z.pc – We capture the same details as .z.po in a different table.








/Opening client and server ports, defining .z.po and table .clientSessions.captureOpen table
/-- Server:
.clientSessions.captureOpen:([] user:(); handle:(); host:(); sessionHandle:(); time:());
/-- Define .z.po
.z.po:{.clientSessions.captureOpen ,: (.z.u; x; .z.a; .z.w; .z.T) };


/Defining .z.pg
.z.po:{.clientSessions.captureSync ,: (.z.u; x; .z.a; .z.w; .z.T); value x };
.clientSessions.captureSync:([] user:(); functionCall:(); host:(); sessionHandle:(); time:());
.z.pg:{.clientSessions.captureSync ,: (.z.u; x; .z.a; .z.w; .z.T); value x };




/Defining .z.ps 
.clientSessions.captureASync:([] user:(); functionCall:(); host:(); sessionHandle:(); time:())
.z.ps:{.clientSessions.captureASync ,: (.z.u; x; .z.a; .z.w; .z.T); value x }


/Defining .z.pc 
.clientSessions.captureClose:([] user:(); handle:(); host:(); sessionHandle:(); time:())
.z.pc:{.clientSessions.captureClose ,: (.z.u; x; .z.a; .z.w; .z.T)}




/====
/Making Client Calls and checking the tables

/Opening a connection and checking the .clientSessions.captureOpen table on server
//Client
h: getConn[] 
hclose h

/Server - we see this
/q).clientSessions.captureOpen
/ user    handle host       sessionHandle time        
/ ----------------------------------------------------
/ jvsingh 8      2130706433 8             14:38:30.352



//Run a synchronous function from client and check the .clientSessions.captureSync table

/1.
f: { x + y};


h: getConn[] 
/q).clientSessions.captureSync
/user functionCall host sessionHandle time
/-----------------------------------------

/On client make this call
h (f; 5; 10)

/On Server
/ q).clientSessions.captureSync
/ user    functionCall  host       sessionHandle time        
/ -----------------------------------------------------------
/ jvsingh { x + y} 5 10 2130706433 8             14:59:41.824



// Run an Async call from client and check .clientSessions.captureASync table
/ .clientSessions.captureASync

(neg h) (f; 5; 10)
/ On Client Side
/ user    functionCall  host       sessionHandle time        
/ -----------------------------------------------------------
/ jvsingh { x + y} 5 10 2130706433 8             15:20:20.971



/Close the connection from client and check .clientSessions.captureClose table
hclose h

//On Server side
/ user    functionCall host       sessionHandle time        
/ ----------------------------------------------------------
/ jvsingh 8            2130706433 0             18:25:32.137




//Anynchronous calls and call backs
/On REmote Server ie on 9999
cub3:{x*x*x}
cub3:{0N!x*x*x}

//on client - ie here
(neg h) (`cub3; 5)
/prints 125 on remote server console

//on server side, .z.w is the handle of the client. Server can use this to 
/ comminucate something to client
cub3:{ 0N! .z.w; x*x*x}  


//On Server
worker : { [arg; callback] r: cub3 arg; (neg .z.w) (callback; r); };

//On Client, define call back
mycb : {0N! x}

(neg h) (`worker; 5; `mycb) //THis prints 125 on client console

 




/Returns the IP address as a 32-bit integer.
.z.a
/..

/Convert to ip address
"i"$0x0 vs .z.a



//Find number of physical cores with .z.c
.z.c
/6i



//Return hostname as symbol with .z.h
.z.h
/`jais-mac-mini-2.local


/Find Process ID with .z.i
.z.i
/1811i


/.z.K   /Returns the release version
.z.K
/4f



.z.k   /Returns the release date
/2020-03-17d



.z.w
/8i



/User ID with .z.u
.z.u
/`


/Local datetime with .z.Z
.z.Z
/2020-05-23T18:33:08.840z


/UTC time with .z.t
.z.t
/10:33:39.621t


/Local date with .z.D
.z.D

/UTC
.z.d



/=======================================System commands

/List all tables with \a
\a
/ `symbol$()


/Pending views and all views with \B and \b
\b
/`symbol$()

\B 


/console size with \c


/Change directory with \cd
/ Syntax:
/ \cd [directory]


\f
/ Syntax:
/ \f [namespace]
/ -namespace is optional


/Client Execution timeout with \T
/\T [n]


/timer with \t
/   Syntax:
/        \t [param]


/time and space with \ts
/ Syntax:
/ \ts [param]


//List all variables with \v
/ 
/ Syntax:
/ \v [namespace]


/system command takes in a string with an OS level command and returns the corresponding results.






































