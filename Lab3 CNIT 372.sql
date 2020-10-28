-- Question 1a
begin
    dbms_output.put_line ('Hello World');
end;

/
-- Question 1b
set SERVEROUTPUT on;

/
-- Question 1c
begin
    dbms_output.put_line ('Hello World');
end;

-- restart

begin
    dbms_output.put_line ('Hello World');
end;

set SERVEROUTPUT on;

/
-- Question 1d
/*
serveroutput attribute - Controls whether to display the output (that is, DBMS_OUTPUT PUT_LINE)
of stored procedures or PL/SQL blocks in SQL*Plus.

Oracle, O. (2005, June 22). SQL*Plus® User's Guide and Reference. 
	Retrieved September 25, 2020, from 
	https://docs.oracle.com/cd/B19306_01/server.102/b14357/ch12040.htm
*/

/
-- Question 2a
begin
    DBMS_OUTPUT.PUT_LINE('The ubiquitous Hello world');
end;

/
-- Question 2b
begin
    DBMS_OUTPUT.PUT('The');
    DBMS_OUTPUT.PUT(' ');
    DBMS_OUTPUT.PUT('Ubiquitous');
    DBMS_OUTPUT.PUT(' ');
    DBMS_OUTPUT.PUT('Hello');
    DBMS_OUTPUT.PUT(' ');
    DBMS_OUTPUT.PUT_LINE('World');
end;

/
-- Question 2c
/*
DBMS_OUTPUT.PUT builds the line of information but doesn't display it or enter it into the
buffer while DBMS_OUTPUT.PUT_LINE actually enters it into buffer and displays it.
*/

/
-- Question 2d
/*
DBMS_OUTPUT.PUT - builds a line of information piece by piece for DBMS_OUTPUT.

Oracle, O. (2016, September 02). Database PL/SQL Packages and Types Reference. Retrieved
	September 25, 2020, from https://docs.oracle.com/database/121/ARPLS/d_output.htm
*/

/
-- Question 2e
/*
DBMS_OUTPUT.PUT_LINE - places an entire line of information into the buffer for DBMS_OUTPUT.

Oracle, O. (2016, September 02). Database PL/SQL Packages and Types Reference. Retrieved 
	September 25, 2020, from https://docs.oracle.com/database/121/ARPLS/d_output.htm
*/

/
-- Question 2f
/*
DBMS_OUTPUT.PUT builds the line of information one piece of information at a time
it can't take an entire text line. 
While DBMS_OUTPUT.PUT_LINE can take an entire text line with spaces and put it into
the buffer.
*/

/
-- Question 3
begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || '&sv_YourName');
end;

/*
It starts with a prompt asking for the sv_YourName input. It then prints:
old:begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || '&sv_YourName');
end;
new:begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || 'Landan');
end;
My name is Landan


PL/SQL procedure successfully completed.
*/

/
-- Question 4a
SET VERIFY ON;

/
-- Question 4b
begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || '&sv_YourName');
end;

/
-- Question 4c
SET VERIFY OFF;

/
-- Question 4d
begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || '&sv_YourName');
end;

/
-- Question 4e
/*
VERIFY attribute - 
Controls whether SQL*Plus lists the text of a SQL statement
or PL/SQL command before and after SQL*Plus replaces substitution variables with values.

Oracle, O. (2005, June 22). SQL*Plus® User's Guide and Reference. Retrieved
	September 25, 2020,
	from https://docs.oracle.com/cd/B19306_01/server.102/b14357/ch12040.htm
*/

/
-- Question 5
begin
    DBMS_OUTPUT.PUT_LINE ('My name is ' || '&sv_YourName');
end;

begin
    DBMS_OUTPUT.PUT_LINE ('My name is ' || '&sv_YourName');
end;

/*
I was prompted twice. This tells me that the values input are not presistent and
are cleared/forgotten as soon as the program ends.
*/

/
-- Question 6
begin
    DBMS_OUTPUT.PUT_LINE ('Today is ' || '&sv_day');
    DBMS_OUTPUT.PUT_LINE('Tomorrow is ' || '&sv_day');
end;

/*
Yes you can use the same variable twice. It prompts for both inputs and then displays 
both values the user inputs correctly.
*/

/
-- Question 7a
begin
    DBMS_OUTPUT.PUT_LINE ('Today is ' || '&&sv_day');
    DBMS_OUTPUT.PUT_LINE('Tomorrow is ' || '&sv_day');
end;

/*
I was promted to provide a value only once, I was not for the second call. The '&&'
part was changed turning it into a persisting value it seems.
*/

/
-- Question 7b
begin
    DBMS_OUTPUT.PUT_LINE ('Today is ' || '&&sv_day');
    DBMS_OUTPUT.PUT_LINE('Tomorrow is ' || '&sv_day');
end;

/*
It displayed the same values as 7a. I was not prompted to input any values. It seems the
persistence lasts between different runs as well. 
*/

/
-- Question 8
declare
    V_DAY varchar2(10) := '&sv_day1';
begin
    DBMS_OUTPUT.PUT_LINE('Today is '|| V_DAY);
END;

/
-- Question 9
declare
    V_DAY varchar2(10);

begin
    V_DAY := to_char (sysdate, 'Day');
    
    DBMS_OUTPUT.PUT_LINE('Today is '|| V_DAY);
    DBMS_OUTPUT.PUT_LINE('Tomorrow is '|| to_char (sysdate +1, 'Day'));
    
end;

/
-- Question 10a
select employeeID
from employee
where employeeID = '100001';

/*
One row is returned.
*/

/
-- Question 10b
declare
    V_EMPLOYEEID EMPLOYEE.EMPLOYEEID%TYPE;
    V_LASTNAME EMPLOYEE.LASTNAME%TYPE;
    V_FIRSTNAME EMPLOYEE.FIRSTNAME%TYPE;
    
begin
    select EMPLOYEEID, LASTNAME, FIRSTNAME
    into V_EMPLOYEEID, V_LASTNAME, v_FIRSTNAME
    from EMPLOYEE
    where EMPLOYEEID = '100001';
    
    DBMS_OUTPUT.PUT_LINE('Employee ID        LASTNAME           FIRSTNAME');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT(V_EMPLOYEEID);
    DBMS_OUTPUT.PUT('            ');
    DBMS_OUTPUT.PUT('V_LASTNAME');
    DBMS_OUTPUT.PUT('           ');
    DBMS_OUTPUT.PUT_LINE(V_FIRSTNAME);

END;

/
-- Question 10c
select employeeID
from employee;

/*
40 rows were returned.
*/

/
-- Question 10d
declare
    V_EMPLOYEEID EMPLOYEE.EMPLOYEEID%TYPE;
    V_LASTNAME EMPLOYEE.LASTNAME%TYPE;
    V_FIRSTNAME EMPLOYEE.FIRSTNAME%TYPE;
    
begin
    select EMPLOYEEID, LASTNAME, FIRSTNAME
    into V_EMPLOYEEID, V_LASTNAME, v_FIRSTNAME
    from EMPLOYEE;
    
    DBMS_OUTPUT.PUT_LINE('Employee ID        LASTNAME           FIRSTNAME');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT(V_EMPLOYEEID);
    DBMS_OUTPUT.PUT('            ');
    DBMS_OUTPUT.PUT('V_LASTNAME');
    DBMS_OUTPUT.PUT('           ');
    DBMS_OUTPUT.PUT_LINE(V_FIRSTNAME);

END;

/
-- Question 10e
/*
It is training to assign 40 values to each of the variables. You can not
successfully do this. It throws an exception "exact fetch returns more
than requested number of rows."
*/

/
-- Question 10f
/*
It seems that only one value can be held at a given time in a scalar-type variable.
*/

/
-- Question 10h
declare
    V_EMPLOYEE employee%ROWTYPE;   
begin
    select * into V_EMPLOYEE from EMPLOYEE where EMPLOYEEID = '100001';
    DBMS_OUTPUT.PUT_LINE('Employee ID        LASTNAME           FIRSTNAME');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT_LINE(V_EMPLOYEE.EMPLOYEEID||'           '||V_EMPLOYEE.LASTNAME||'           '||V_EMPLOYEE.FIRSTNAME);

END;

/*
In 10h you are calling the employeeID from specific employee's by taking
V_EMPLOYEE and then doing ".EMPLOYEEID", etc. to get the specific information from
that employee. Where in 10b the employeeID, etc are found in the select statements
and then just called to display.
*/

/
-- Question 11a
select jobtitle, count(employeeid)
from employee
group by jobtitle;

/
-- Question 11b
DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    IF V_NUMBER_EMPLOYEES < 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 7 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END IF;
END;

/
-- Question 11c
DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    IF V_NUMBER_EMPLOYEES < 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 7 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END IF;
END;

/
-- Question 11d
DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    IF V_NUMBER_EMPLOYEES < 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 7 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END IF;
END;

/
-- Question 11e
DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    IF V_NUMBER_EMPLOYEES < 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    ELSIF V_NUMBER_EMPLOYEES < 7 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END IF;
END;

/
-- Question 12a

DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    CASE V_NUMBER_EMPLOYEES
    WHEN 0 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    WHEN 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 2 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 3 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 5 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 6 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END CASE;
    
END;

/
-- Question 12b

DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    CASE V_NUMBER_EMPLOYEES
    WHEN 0 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    WHEN 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 2 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 3 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 5 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 6 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END CASE;
    
END;

/
-- Question 12c

DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    CASE V_NUMBER_EMPLOYEES
    WHEN 0 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    WHEN 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 2 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 3 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 5 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 6 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END CASE;
    
END;

/
-- Question 12d

DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE VARCHAR2(50) := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    CASE V_NUMBER_EMPLOYEES
    WHEN 0 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    WHEN 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 2 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 3 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 5 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 6 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END CASE;
    
END;

/
-- Question 13a

DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE EMPLOYEE.JOBTITLE%TYPE := '&V_JOBTITLE';
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    CASE V_NUMBER_EMPLOYEES
    WHEN 0 THEN
    DBMS_OUTPUT.PUT_LINE ('There are no employees with the Job Title: ' || V_JOBTITLE);
    WHEN 1 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 2 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 3 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 1 and 3 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 4 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 5 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    WHEN 6 THEN
    DBMS_OUTPUT.PUT_LINE ('There are between 4 and 6 employees with the Job Title: ' || V_JOBTITLE);
    ELSE
    DBMS_OUTPUT.PUT_LINE ('There are 7 or more employees with the Job Title: ' || V_JOBTITLE);
    END CASE;
    
END;

/
-- Question 13b
/*
It is good because you don't have to declare the type specifically.
*/

/
-- Question 14

DECLARE
    V_NUMBER_EMPLOYEES NUMBER;
    V_JOBTITLE EMPLOYEE.JOBTITLE%TYPE := '&V_JOBTITLE';
    V_STAFF_LEVEL VARCHAR(100);
    
BEGIN
    SELECT COUNT(employeeID)
    into V_NUMBER_EMPLOYEES
    FROM EMPLOYEE
    WHERE jobtitle = V_JOBTITLE;
    
    CASE V_NUMBER_EMPLOYEES
    WHEN 0 THEN
    V_STAFF_LEVEL := 'There are no employees with the Job Title: ';
    WHEN 1 THEN
     V_STAFF_LEVEL := 'There are between 1 and 3 employees with the Job Title: ';
    WHEN 2 THEN
     V_STAFF_LEVEL := 'There are between 1 and 3 employees with the Job Title: ';
    WHEN 3 THEN
     V_STAFF_LEVEL := 'There are between 1 and 3 employees with the Job Title: ';
    WHEN 4 THEN
     V_STAFF_LEVEL := 'There are between 4 and 6 employees with the Job Title: ';
    WHEN 5 THEN
     V_STAFF_LEVEL := 'There are between 4 and 6 employees with the Job Title: ';
    WHEN 6 THEN
     V_STAFF_LEVEL := 'There are between 4 and 6 employees with the Job Title: ';
    ELSE
    V_STAFF_LEVEL := 'There are 7 or more employees with the Job Title: ';
    END CASE;
    
    -- OUTPUT USER-FRIENDLY RESPONSE
    DBMS_OUTPUT.PUT_LINE (V_STAFF_LEVEL || V_JOBTITLE);
    
END;

/

/* Results

Question 1a
PL/SQL procedure successfully completed.

Question 1b
*blank*

Question 1c
Before Restart:
Hello World

PL/SQL procedure successfully completed.

After Restart:

PL/SQL procedure successfully completed.

SQL developer does not remember your SERVEROUTPUT.

Question 1d

serveroutput attribute - Controls whether to display the output (that is, DBMS_OUTPUT PUT_LINE)
of stored procedures or PL/SQL blocks in SQL*Plus.

Oracle, O. (2005, June 22). SQL*Plus® User's Guide and Reference. 
	Retrieved September 25, 2020, from 
	https://docs.oracle.com/cd/B19306_01/server.102/b14357/ch12040.htm

Question 2a
The ubiquitous Hello world


PL/SQL procedure successfully completed.

Question 2b
The Ubiquitous Hello World


PL/SQL procedure successfully completed.

Question 2c
It seems like DBMS_OUTPUT.PUT makes the data/string of data but doesn't display it while
DBMS_OUTPUT.PUT_LINE can make the data and then display it in the terminal as well.
Question 2d
DBMS_OUTPUT.PUT - builds a line of information piece by piece for DBMS_OUTPUT.

Oracle, O. (2016, September 02). Database PL/SQL Packages and Types Reference. Retrieved
	September 25, 2020, from https://docs.oracle.com/database/121/ARPLS/d_output.htm

Question 2e
DBMS_OUTPUT.PUT_LINE - places an entire line of information into the buffer for DBMS_OUTPUT.

Oracle, O. (2016, September 02). Database PL/SQL Packages and Types Reference. Retrieved 
	September 25, 2020, from https://docs.oracle.com/database/121/ARPLS/d_output.htm

Question 2f
DBMS_OUTPUT.PUT builds the line of information one piece of information at a time
it can't take an entire text line. 
While DBMS_OUTPUT.PUT_LINE can take an entire text line with spaces and put it into
the buffer.

Question 3
It starts with a prompt asking for the sv_YourName input. It then prints:
old:begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || '&sv_YourName');
end;
new:begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || 'Landan');
end;
My name is Landan


PL/SQL procedure successfully completed.

Question 4a
*Blank*

Question 4b
old:begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || '&sv_YourName');
end;
new:begin
    DBMS_OUTPUT.PUT_LINE('My name is ' || 'Landan');
end;
My name is Landan


PL/SQL procedure successfully completed.

Question 4c
*Blank*

Question 4d
My name is Landan


PL/SQL procedure successfully completed.

Question 4e
VERIFY attribute - 
Controls whether SQL*Plus lists the text of a SQL statement
or PL/SQL command before and after SQL*Plus replaces substitution variables with values.

Oracle, O. (2005, June 22). SQL*Plus® User's Guide and Reference. Retrieved
	September 25, 2020,
	from https://docs.oracle.com/cd/B19306_01/server.102/b14357/ch12040.htm

Question 5
My name is landan


PL/SQL procedure successfully completed.

My name is landan


PL/SQL procedure successfully completed.

I was prompted twice. This tells me that the values input are not presistent and
are cleared/forgotten as soon as the program ends.

Question 6
Today is thursday
Tomorrow is friday


PL/SQL procedure successfully completed.

Yes you can use the same variable twice. It prompts for both inputs and then displays 
both values the user inputs correctly.

Question 7a
Today is thursday
Tomorrow is thursday


PL/SQL procedure successfully completed.

I was promted to provide a value only once, I was not for the second call. The '&&'
part was changed turning it into a persisting value it seems.

Question 7b
Today is thursday
Tomorrow is thursday


PL/SQL procedure successfully completed.

It displayed the same values as 7a. I was not prompted to input any values. It seems the
persistence lasts between different runs as well. 

Question 8
Today is thursday


PL/SQL procedure successfully completed.

Question 9
Today is Thursday 
Tomorrow is Friday   


PL/SQL procedure successfully completed.

Question 10a
EMPLOYEEID
----------
100001

One row is returned.

Question 10b
Employee ID        LASTNAME           FIRSTNAME
================================================
100001            V_LASTNAME           Jim


PL/SQL procedure successfully completed.

Question 10c
EMPLOYEEID
----------
100001
100101
100103
100104
100106
100112
100120
100125
100127
100200
100204

EMPLOYEEID
----------
100206
100209
100220
100330
100365
100399
100475
100488
100550
100559
100600

EMPLOYEEID
----------
100650
100700
100880
100892
100944
100967
100989
101007
101030
101045
101066

EMPLOYEEID
----------
101088
101089
101097
101115
101135
101154
101166

40 rows selected. 

40 rows were returned.


Question 10d
Error starting at line : 2 in command -
declare
    V_EMPLOYEEID EMPLOYEE.EMPLOYEEID%TYPE;
    V_LASTNAME EMPLOYEE.LASTNAME%TYPE;
    V_FIRSTNAME EMPLOYEE.FIRSTNAME%TYPE;

begin
    select EMPLOYEEID, LASTNAME, FIRSTNAME
    into V_EMPLOYEEID, V_LASTNAME, v_FIRSTNAME
    from EMPLOYEE;

    DBMS_OUTPUT.PUT_LINE('Employee ID        LASTNAME           FIRSTNAME');
    DBMS_OUTPUT.PUT_LINE('================================================');
    DBMS_OUTPUT.PUT(V_EMPLOYEEID);
    DBMS_OUTPUT.PUT('            ');
    DBMS_OUTPUT.PUT('V_LASTNAME');
    DBMS_OUTPUT.PUT('           ');
    DBMS_OUTPUT.PUT_LINE(V_FIRSTNAME);

END;
Error report -
ORA-01422: exact fetch returns more than requested number of rows
ORA-06512: at line 7
01422. 00000 -  "exact fetch returns more than requested number of rows"
*Cause:    The number specified in exact fetch is less than the rows returned.
*Action:   Rewrite the query or change number of rows requested


Question 10e
It is training to assign 40 values to each of the variables. You can not
successfully do this. It throws an exception "exact fetch returns more
than requested number of rows."

Question 10f
It seems that only one value can be held at a given time in a scalar-type variable.

Question 10h
Employee ID        LASTNAME           FIRSTNAME
================================================
100001           Manaugh           Jim


PL/SQL procedure successfully completed.

In 10h you are calling the employeeID from specific employee's by taking
V_EMPLOYEE and then doing ".EMPLOYEEID", etc. to get the specific information from
that employee. Where in 10b the employeeID, etc are found in the select statements
and then just called to display.

Question 11a

JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
Chief Sales Officer                                 1
Engineer                                            5
President                                           1
DBA                                                 1
Chief Financial Officer                             1
Assembly                                           18
VP Operations                                       1
Programmer Analyst                                  2
Accountant                                          2
Sales                                               3
Chief Information Officer                           1

JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
Operations Officer                                  2
VP Finance                                          1
VP Information                                      1

14 rows selected. 

Question 11b
There are no employees with the Job Title: CIO


PL/SQL procedure successfully completed.

Question 11c
There are between 1 and 3 employees with the Job Title: Accountant


PL/SQL procedure successfully completed.

Question 11d
There are between 4 and 6 employees with the Job Title: Engineer


PL/SQL procedure successfully completed.


Question 11e
There are 7 or more employees with the Job Title: Assembly


PL/SQL procedure successfully completed.

Question 12a
There are no employees with the Job Title: CIO


PL/SQL procedure successfully completed.

Question 12b
There are between 1 and 3 employees with the Job Title: Accountant


PL/SQL procedure successfully completed.

Question 12c
There are between 4 and 6 employees with the Job Title: Engineer


PL/SQL procedure successfully completed.

Question 12d
There are 7 or more employees with the Job Title: Assembly


PL/SQL procedure successfully completed.


Question 13a
There are no employees with the Job Title: CIO


PL/SQL procedure successfully completed.


Question 13b
It is good because you don't have to declare the type specifically.

Question 14
There are between 4 and 6 employees with the Job Title: Engineer


PL/SQL procedure successfully completed.

*/




