# kdb-q
KDB-Q

## Jupyter Notebook with Q
1. Get kdb-q installed. KDB is underlying database, q is like sql to interact with kdb.
2. Assuming you have Python installed, you now install pyq, the kernel for q support from within python.
   Have a look at this:
   https://code.kx.com/q/interfaces/pyq/install/#installing-on-windows
   
   Using MacOS, go to "Installing with 32-bit kdb+ on macOS" on above link.
3. To start jupyter notebook with pyq kernel, first you need to have pyq installed as in step 2. Then run this
    source ${HOME}/pyq2/bin/activate
    
4. Next on the command prompt, start the notebook

(pyq2) jvsingh: ~  -> jupyter-notebook
