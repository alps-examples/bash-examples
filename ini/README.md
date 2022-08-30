The program demonstrates how to use the ini updater bash function.

Start with an ini file.

    > cat test.ini
    [leavemealone]
    a=1
    b=1
    c= 1
    d= 1
    #e=1
     

Import `ini()` function.

    > . ini.sh

Update the entries `a` and `b`  from the command line, which also shows the changes made via `diff`.

    > ini test.ini a=2 b=2
    2,3c2,3
    < a=1
    < b=1
    ---
    > a=2
    > b=2

Afterwards, check that the ini file is updated.

    > cat test.ini
    [leavemealone]
    a=2
    b=2
    c= 1
    d= 1
    #e=1

Optional: Execute self-tests:

    > ./ini.sh
    Self-test PASSED.
