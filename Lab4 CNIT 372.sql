--PART A

-- Question 1a
CREATE OR REPLACE PROCEDURE HELLO_WORLD
AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line (v_output);
END HELLO_WORLD;


/
-- Question 1b
execute HELLO_WORLD;

/
-- Question 1c
/*
The difference is pretty simple. Anonymous blocks are not named and named blocks are named.
Anonymous are missing the CREATE OR REPLACE PROCEDURE '*****' part of named block. With
named blocks you can call the procedure later in your code, this allows you to simply
call the name of the block everytime you want to execute it instead of coding the entire
block again.
*/

/
-- Question 2
CREATE OR REPLACE PROCEDURE hello_world AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line(v_output);
END hello_world;

/
-- Question 3a
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(p_name IN varchar2)
AS
    v_output VARCHAR2(35);
BEGIN
    v_output := 'Hello ' || p_name;
    dbms_output.put_line (v_output);
END HELLO_WORLD;

/
-- Question 3b
execute HELLO_WORLD ('World');

/
-- Question 3c
execute HELLO_WORLD ('Mark.');

/
-- Question 3d
execute HELLO_WORLD ('World procedure. I have so much fun coding in SQL and PLSQL.');

/
-- Question 3e
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(p_name IN varchar2)
AS
    v_output VARCHAR2(75);
BEGIN
    v_output := 'Hello ' || p_name;
    dbms_output.put_line (v_output);
END HELLO_WORLD;

/
-- Question 3f
execute HELLO_WORLD ('World procedure. I have so much fun coding in SQL and PLSQL.');

/
-- Question 4a
CREATE OR REPLACE PROCEDURE HELLO_WORLD
(
p_greeting IN varchar2,
p_name IN varchar2
)
AS
    v_output VARCHAR2(75);
BEGIN
    v_output := p_greeting || ' ' || p_name;
    dbms_output.put_line (v_output);
END HELLO_WORLD;

/
-- Question 4b
execute HELLO_WORLD ('Hello','World');

/
-- Question 4c
execute HELLO_WORLD ('World');

/
-- Question 4d
execute HELLO_WORLD ('Goodbye', 'Hal');

/
-- Question 4e
execute HELLO_WORLD ('Hello', NULL);

/
-- Question 5a
create or replace function NUMBER_OF_EMPLOYEES
 return NUMBER
as
    v_number_of_employees NUMBER := 0;
begin
    
    select count(*)
        into v_number_of_employees
    from employee;
    
    return v_number_of_employees;
end NUMBER_OF_EMpLOYEES;

/
-- Question 5b
select NUMBER_OF_EMPLOYEES FROM DUAL;

/
-- Question 6a
create or replace function NUMBER_OF_EMPLOYEES
(p_jobtitle IN varchar2)
 return NUMBER
as
    v_number_of_employees NUMBER := 0;
begin
    
    select count(*)
        into v_number_of_employees
    from employee
    where jobtitle = p_jobtitle;
    
    return v_number_of_employees;
end NUMBER_OF_EMPLOYEES;

/
-- Question 6b
select NUMBER_OF_EMPLOYEES('Engineer') FROM dual;

/
-- Question 6c
create or replace function NUMBER_OF_EMPLOYEES
(p_jobtitle in employee.jobtitle%type)
 return NUMBER
as
    v_number_of_employees NUMBER := 0;
begin
    
    select count(*)
        into v_number_of_employees
    from employee
    where trim(lower(jobtitle)) = trim(lower(p_jobtitle));
    
    return v_number_of_employees;
end NUMBER_OF_EMPLOYEES;

/
-- Question 6d
select NUMBER_OF_EMPLOYEES('engineer') FROM dual ;

/
-- Question 6e
select NUMBER_OF_EMPLOYEES('dba') FROM dual ;

/
-- Question 6f
select NUMBER_OF_EMPLOYEES('DBA') FROM dual ;

/
-- Question 6g
select NUMBER_OF_EMPLOYEES('chief sales officer') FROM dual ;

/
-- Question 6h
select NUMBER_OF_EMPLOYEES(' chief sales officer ') FROM dual ;

/
-- Question 6i
select NUMBER_OF_EMPLOYEES('CEO') FROM dual ;

/
-- Question 7a
create or replace procedure SIMPLE_LOOP_EXAMPLE
as
    lcounter NUMBER;
    v_current_date NUMBER;
begin
    v_current_date := to_number(to_char(sysdate, 'DD'));
    
    lcounter := 1;
    loop
        dbms_output.put_line (lcounter);
        if lcounter >= v_current_date THEN
            exit;
        else
            lcounter := lcounter + 1;
        end if;
    end loop;
end SIMPLE_LOOP_EXAMPLE;

/
-- Question 7b
execute SIMPLE_LOOP_EXAMPLE;

/
-- Question 7c
/*
It loops and prints the numbers in order until it hits what day it is this month for 
your system.
For example if it was the 5th it would print 1 2 3 4 5. However since it's the first
its just 1.
*/

/
-- Question 7d
/*
It uses an if then statement with an exit command.
*/

/
-- Question 7e
create or replace procedure SIMPLE_LOOP_EXAMPLE
as
    lcounter NUMBER;
    v_current_date NUMBER;
begin
    v_current_date := to_number(to_char(sysdate, 'DD'));
    
    lcounter := 1;
    loop
        dbms_output.put_line (lcounter);
         
        exit when lcounter >= v_current_date ;   
        lcounter := lcounter + 1;
    end loop;
end SIMPLE_LOOP_EXAMPLE;

/
execute SIMPLE_LOOP_EXAMPLE;

/
-- Question 8a
create or replace procedure WHILE_LOOP_EXAMPLE
as
    lcounter NUMBER;
    v_current_date NUMBER;
begin
    v_current_date := to_number(to_char(sysdate, 'DD'));
    
    lcounter := 1;
    while (lcounter <= v_current_date)
    loop
        dbms_output.put_line (lcounter);
          
        lcounter := lcounter + 1;
    end loop;
end WHILE_LOOP_EXAMPLE;

/
-- Question 8b
execute WHILE_LOOP_EXAMPLE;

/
-- Question 9a
create or replace procedure FOR_LOOP_EXAMPLE
as
    lcounter NUMBER;
    v_current_date NUMBER;
begin
    v_current_date := to_number(to_char(sysdate, 'DD'));
    
    lcounter := 1;
    for lcounter in 1..v_current_date
    loop
        dbms_output.put_line (lcounter);
          
       
    end loop;
end FOR_LOOP_EXAMPLE;

/
-- Question 9b
execute FOR_LOOP_EXAMPLE;

/
-- Question 10a
/*
You need to use a grant execute command to give execute privelage on LDPERRY.HELLO_WORLD to
CNIT372TA.

Example:grant execute on LDPERRY.HELLO_WORLD to CNIT372TA;

Oracle, O. (2014, October 01). TimesTen In-Memory Database PL/SQL Developer's Guide. 
	Retrieved October 02, 2020, 
	from https://docs.oracle.com/database/121/TTPLS/accesscntl.htm
*/

/
-- Question 10b
grant execute on LDPERRY.NUMBER_OF_EMPLOYEES to CNIT372TA;

/
-- Question 10c
grant execute on LDPERRY.for_loop_example to CNIT372TA;

grant execute on LDPERRY.HELLO_WORLD to CNIT372TA;

grant execute on LDPERRY.simple_loop_example to CNIT372TA;

grant execute on LDPERRY.while_loop_example to CNIT372TA;

/
-- Question 11a
revoke execute on LDPERRY.number_of_employees from CNIT372TA;

/
-- Question 11b
drop procedure ldperry.simple_loop_example;

/
create or replace procedure SIMPLE_LOOP_EXAMPLE
as
    lcounter NUMBER;
    v_current_date NUMBER;
begin
    v_current_date := to_number(to_char(sysdate, 'DD'));
    
    lcounter := 1;
    loop
        dbms_output.put_line (lcounter);
         
        exit when lcounter >= v_current_date ;   
        lcounter := lcounter + 1;
    end loop;
end SIMPLE_LOOP_EXAMPLE;

/
select * from user_tab_privs;

/
-- Question 11c
/*
Yes CNIT372TA only has 3 permissions now.
*/

/
-- Question 11d
create or replace procedure WHILE_LOOP_EXAMPLE
as
    lcounter NUMBER;
    v_current_date NUMBER;
begin
    v_current_date := to_number(to_char(sysdate, 'DD'));
    
    lcounter := 1;
    while (lcounter <= v_current_date)
    loop
        dbms_output.put_line (lcounter);
          
        lcounter := lcounter + 1;
    end loop;
end WHILE_LOOP_EXAMPLE;

/
select * from user_tab_privs;

/
-- Question 11e
/*
No, recreating does not remove permissions.
*/

/
-- Question 12
drop procedure ldperry.hello_world;
drop procedure ldperry.simple_loop_example;
drop procedure ldperry.while_loop_example;
drop procedure ldperry.for_loop_example;
drop procedure ldperry.number_of_employees;

/
-- Question 13a
/*
Yes, it requires 2 parameters.
*/

/
-- Question 13b
execute CNIT372TA.hello_world('Hello','Sunshine');

/
-- Question 14a
create or replace function DAYS_AWAY
(given_date in date)
 return NUMBER
as
    number_of_days NUMBER := 0;
begin
    number_of_days:=  given_date - (TRUNC(SYSDATE)) ; 
    return number_of_days;
end DAYS_AWAY;

/
-- Question 14b
select DAYS_AWAY('15-DEC-2020') from dual;

select DAYS_AWAY('11-JAN-2019') from dual;

/
-- Question 15a
CREATE OR REPLACE PROCEDURE DAY_OF_THE_WEEK
(day_date IN date)
AS
    v_output VARCHAR2(100);
BEGIN


    v_output := 'Yesterday was: ' || TO_CHAR(day_date-1, 'Day') ||
    ' Today is: ' || TO_CHAR(day_date, 'Day') ||
    ' Tomorrow is: ' || TO_CHAR(day_date+1, 'Day');
    
    dbms_output.put_line (v_output);
    
END DAY_OF_THE_WEEK;

/
-- Question 15b
execute day_of_the_week(sysdate);

execute day_of_the_week('07-JUL-20');

/

/* Results

Question 1a
Procedure HELLO_WORLD compiled
It is printed to the Script Output.

Question 1b
Hello World


Question 1c
The difference is pretty simple. Anonymous blocks are not named and named blocks are named.
Anonymous are missing the CREATE OR REPLACE PROCEDURE '*****' part of named block. With
named blocks you can call the procedure later in your code, this allows you to simply
call the name of the block everytime you want to execute it instead of coding the entire
block again.

Question 2
CREATE OR REPLACE PROCEDURE hello_world AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line(v_output);
END hello_world;

Question 3a

Procedure HELLO_WORLD compiled

Question 3b
Hello World

Question 3c
Hello Mark.

Question 3d
Error starting at line : 15 in command -
BEGIN HELLO_WORLD ('World procedure. I have so much fun coding in SQL and PLSQL.'); END;
Error report -
ORA-06502: PL/SQL: numeric or value error: character string buffer too small
ORA-06512: at "LDPERRY.HELLO_WORLD", line 6
ORA-06512: at line 1
06502. 00000 -  "PL/SQL: numeric or value error%s"
*Cause:    An arithmetic, numeric, string, conversion, or constraint error
           occurred. For example, this error occurs if an attempt is made to
           assign the value NULL to a variable declared NOT NULL, or if an
           attempt is made to assign an integer larger than 99 to a variable
           declared NUMBER(2).
*Action:   Change the data, how it is manipulated, or how it is declared so
           that values do not violate constraints.

Question 3e
Procedure HELLO_WORLD compiled

Question 3f
Hello World procedure. I have so much fun coding in SQL and PLSQL.

Question 4a
Procedure HELLO_WORLD compiled

Question 4b
Hello World

Question 4c
Error starting at line : 20 in command -
BEGIN HELLO_WORLD ('World'); END;
Error report -
ORA-06550: line 1, column 59:
PLS-00306: wrong number or types of arguments in call to 'HELLO_WORLD'
ORA-06550: line 1, column 59:
PL/SQL: Statement ignored
06550. 00000 -  "line %s, column %s:\n%s"
*Cause:    Usually a PL/SQL compilation error.
*Action:

The error is that their isn't enough arguments input to HELLO_WORLD.

Question 4d
Goodbye Hal

Question 4e
Hello 

Question 5a
Function NUMBER_OF_EMPLOYEES compiled

Question 5b
NUMBER_OF_EMPLOYEES
-------------------
                 40

Question 6a
Function NUMBER_OF_EMPLOYEES compiled

Question 6b
NUMBER_OF_EMPLOYEES('ENGINEER')
-------------------------------
                              5

Question 6c
Function NUMBER_OF_EMPLOYEES compiled

Question 6d
NUMBER_OF_EMPLOYEES('ENGINEER')
-------------------------------
                              5

Question 6e
NUMBER_OF_EMPLOYEES('DBA')
--------------------------
                         1

Question 6f
NUMBER_OF_EMPLOYEES('DBA')
--------------------------
                         1

Question 6g
NUMBER_OF_EMPLOYEES('CHIEFSALESOFFICER')
----------------------------------------
                                       1

Question 6h
NUMBER_OF_EMPLOYEES('CHIEFSALESOFFICER')
----------------------------------------
                                       1

Question 6i
NUMBER_OF_EMPLOYEES('CEO')
--------------------------
                         0

Question 7a
Procedure SIMPLE_LOOP_EXAMPLE compiled

Question 7b
1

Question 7c
It loops and prints the numbers in order until it hits what day it is this month
for your system.
For example if it was the 5th it would print 1 2 3 4 5. However since it's the first
its just 1.

Question 7d

It uses an if then statement with an exit command.


Question 7e
(Date: 10/2 now from this point on)

Script Output:
1
2


PL/SQL procedure successfully completed.

DBMS output:
1
2


Question 8a

Procedure WHILE_LOOP_EXAMPLE compiled


Question 8b
Script output:
1
2


PL/SQL procedure successfully completed.

DBMS output:
1
2

Question 9a
Procedure FOR_LOOP_EXAMPLE compiled

Question 9b
Script Output:
1
2


PL/SQL procedure successfully completed.

DBMS output:
1
2

Question 10a
You need to use a grant execute command to give execute privelage on LDPERRY.HELLO_WORLD to
CNIT372TA.

Example:grant execute on LDPERRY.HELLO_WORLD to CNIT372TA;

Oracle, O. (2014, October 01). TimesTen In-Memory Database PL/SQL Developer's Guide. 
	Retrieved October 02, 2020, 
	from https://docs.oracle.com/database/121/TTPLS/accesscntl.htm

Question 10b
Grant succeeded.

Question 10c

Grant succeeded.


Grant succeeded.


Grant succeeded.


Grant succeeded.

Question 11a
Revoke succeeded.

Question 11b

Procedure LDPERRY.SIMPLE_LOOP_EXAMPLE dropped.


Procedure SIMPLE_LOOP_EXAMPLE compiled


GRANTEE                                                                                                                          OWNER                                                                                                                            TABLE_NAME                                                                                                                       GRANTOR                                                                                                                          PRIVILEGE                                GRA HIE COM TYPE                     INH
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------- --- --- --- ------------------------ ---
LDPERRY                                                                                                                          CNIT372TA                                                                                                                        CNIT372_FALL20_ATTENDANCE                                                                                                        CNIT372TA                                                                                                                        INSERT                                   NO  NO  NO  TABLE                    NO 
LDPERRY                                                                                                                          CNIT372TA                                                                                                                        CNIT372_FALL20                                                                                                                   CNIT372TA                                                                                                                        EXECUTE                                  NO  NO  NO  PACKAGE                  NO 
CNIT372TA                                                                                                                        LDPERRY                                                                                                                          HELLO_WORLD                                                                                                                      LDPERRY                                                                                                                          EXECUTE                                  NO  NO  NO  PROCEDURE                NO 
CNIT372TA                                                                                                                        LDPERRY                                                                                                                          FOR_LOOP_EXAMPLE                                                                                                                 LDPERRY                                                                                                                          EXECUTE                                  NO  NO  NO  PROCEDURE                NO 
CNIT372TA                                                                                                                        LDPERRY                                                                                                                          WHILE_LOOP_EXAMPLE                                                                                                               LDPERRY                                                                                                                          EXECUTE                                  NO  NO  NO  PROCEDURE                NO 
PUBLIC                                                                                                                           SYS                                                                                                                              LDPERRY                                                                                                                          LDPERRY                                                                                                                          INHERIT PRIVILEGES                       NO  NO  NO  USER                     NO 

6 rows selected. 

No CNIT372TA only has 3 permissions now.

Question 11c
Yes CNIT372TA only has 3 permissions now.

Question 11d

Procedure WHILE_LOOP_EXAMPLE compiled


GRANTEE                                                                                                                          OWNER                                                                                                                            TABLE_NAME                                                                                                                       GRANTOR                                                                                                                          PRIVILEGE                                GRA HIE COM TYPE                     INH
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ---------------------------------------- --- --- --- ------------------------ ---
LDPERRY                                                                                                                          CNIT372TA                                                                                                                        CNIT372_FALL20_ATTENDANCE                                                                                                        CNIT372TA                                                                                                                        INSERT                                   NO  NO  NO  TABLE                    NO 
CNIT372TA                                                                                                                        LDPERRY                                                                                                                          HELLO_WORLD                                                                                                                      LDPERRY                                                                                                                          EXECUTE                                  NO  NO  NO  PROCEDURE                NO 
CNIT372TA                                                                                                                        LDPERRY                                                                                                                          FOR_LOOP_EXAMPLE                                                                                                                 LDPERRY                                                                                                                          EXECUTE                                  NO  NO  NO  PROCEDURE                NO 
LDPERRY                                                                                                                          CNIT372TA                                                                                                                        CNIT372_FALL20                                                                                                                   CNIT372TA                                                                                                                        EXECUTE                                  NO  NO  NO  PACKAGE                  NO 
CNIT372TA                                                                                                                        LDPERRY                                                                                                                          WHILE_LOOP_EXAMPLE                                                                                                               LDPERRY                                                                                                                          EXECUTE                                  NO  NO  NO  PROCEDURE                NO 
PUBLIC                                                                                                                           SYS                                                                                                                              LDPERRY                                                                                                                          LDPERRY                                                                                                                          INHERIT PRIVILEGES                       NO  NO  NO  USER                     NO 

6 rows selected.

Yes CNIT372TA retains its execution permissions.

Question 11e
No, recreating does not remove permissions.

Question 12

Procedure LDPERRY.HELLO_WORLD dropped.


Procedure LDPERRY.SIMPLE_LOOP_EXAMPLE dropped.


Procedure LDPERRY.WHILE_LOOP_EXAMPLE dropped.


Procedure LDPERRY.FOR_LOOP_EXAMPLE dropped.


Procedure LDPERRY.NUMBER_OF_EMPLOYEES dropped.


Question 13a
Yes, it requires 2 parameters.

Question 13b
Script output:
Hello Sunshine


PL/SQL procedure successfully completed.

dbms output:
Hello Sunshine

Question 14a
Function DAYS_AWAY compiled

Question 14b

DAYS_AWAY('15-DEC-2020')
------------------------
                      74


DAYS_AWAY('11-JAN-2019')
------------------------
                    -630

Question 15a

Procedure DAY_OF_THE_WEEK compiled


Question 15b
Script output:
Yesterday was: Thursday  Today is: Friday    Tomorrow is: Saturday 


PL/SQL procedure successfully completed.

Yesterday was: Monday    Today is: Tuesday   Tomorrow is: Wednesday


PL/SQL procedure successfully completed.



dbms output:
Yesterday was: Thursday  Today is: Friday    Tomorrow is: Saturday 

Yesterday was: Monday    Today is: Tuesday   Tomorrow is: Wednesday


*/




