
The program demonstrates how to modify an ini file.

Starting with the ini file:

    > cat test.ini
    [leavemealone]
    a=1
    b=1
    c= 1
    d= 1
    #e=1
     
We update the entries `a` and `b`  from the command line, which also shows the changes made via `diff`

    > ./ini.sh test.ini a=2 b=2
    2,3c2,3
    < a=1
    < b=1
    ---
    > a=2
    > b=2
    
Afterwards, the ini file is updated

    > cat test.ini
    [leavemealone]
    a=2
    b=2
    c= 1
    d= 1
    #e=1
