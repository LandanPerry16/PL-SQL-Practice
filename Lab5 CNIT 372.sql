-- Lab05 Landan Perry
--PART A

-- Question 1a

create or replace procedure print_employee_roster
as
    current_employeeid employee.employeeid%TYPE;
    current_lastname employee.lastname%TYPE;
    current_firstname employee.firstname%TYPE;
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname, firstname from employee;
        
BEGIN
    OPEN all_employees;
    
    FETCH all_employees into current_employeeid, current_lastname, current_firstname;
    
    WHILE all_employees%FOUND LOOP
    
        DBMS_OUTPUT.PUT (RPAD(current_employeeid, 15, ' '));
        DBMS_OUTPUT.PUT (RPAD(current_lastname, 30, ' '));
        DBMS_OUTPUT.PUT_LINE (current_firstname);
        FETCH all_employees into current_employeeid, current_lastname, current_firstname;
    END LOOP;
    
    CLOSE all_employees;
END print_employee_roster;


/
-- Question 1b
EXECUTE print_employee_roster;

/
-- Question 2a

create or replace procedure print_employee_roster
as
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname, firstname from employee;
        
    current_employee all_employees%ROWTYPE;
        
BEGIN
    OPEN all_employees;
    
    FETCH all_employees into current_employee;
    
    WHILE all_employees%FOUND LOOP
    
        DBMS_OUTPUT.PUT (RPAD(current_employee.employeeid, 15, ' '));
        DBMS_OUTPUT.PUT (RPAD(current_employee.lastname, 30, ' '));
        DBMS_OUTPUT.PUT_LINE (current_employee.firstname);
        FETCH all_employees into current_employee;
    END LOOP;
    
    CLOSE all_employees;
END print_employee_roster;


/
-- Question 2b
EXECUTE print_employee_roster;

/
-- Question 2c
/*
It is based off the most recent fetch from the cursor. 
*/

/
-- Question 3a
create or replace procedure print_employee_roster
as
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', '|| firstname as name from employee;
        
    current_employee all_employees%ROWTYPE;
        
BEGIN
    OPEN all_employees;
    
    FETCH all_employees into current_employee;
    
    WHILE all_employees%FOUND LOOP
    
        DBMS_OUTPUT.PUT (RPAD(current_employee.employeeid, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (current_employee.name);
        FETCH all_employees into current_employee;
    END LOOP;
    
    CLOSE all_employees;
END print_employee_roster;

/
-- Question 3b
EXECUTE print_employee_roster;


/
-- Question 4a
create or replace procedure print_employee_roster
as
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', '|| firstname as name from employee;
        
        
BEGIN
    
    FOR current_employee IN all_employees LOOP
    
        DBMS_OUTPUT.PUT (RPAD(current_employee.employeeid, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (current_employee.name);
    END LOOP;
    
END print_employee_roster;

/
-- Question 4b
EXECUTE print_employee_roster;

/
-- Question 4c
/*
The steps that are implicitly handled are open, fetch, and close.
*/

/
-- Question 5a
create or replace procedure print_employee_roster
(p_jobtitle in employee.jobtitle%type)
as
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', '|| firstname as name
        from employee
        where UPPER(TRIM(JOBTITLE)) = UPPER(TRIM(p_jobtitle));
        
        
BEGIN
    
    FOR current_employee IN all_employees LOOP
    
        DBMS_OUTPUT.PUT (RPAD(current_employee.employeeid, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (current_employee.name);
    END LOOP;
    
END print_employee_roster;

/
-- Question 5b
EXECUTE print_employee_roster('sales');

/
-- Question 5c
EXECUTE print_employee_roster('assembly');

/
-- Question 5d
EXECUTE print_employee_roster('student');

/*
It successfully completes/runs but it just displays nothing except for that it was successful.
*/

/
-- Question 6a
create or replace procedure print_employee_roster
(p_jobtitle in employee.jobtitle%type)
as
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', '|| firstname as name
        from employee
        where UPPER(TRIM(JOBTITLE)) = UPPER(TRIM(p_jobtitle));
                
BEGIN
    
    FOR current_employee IN all_employees LOOP
    
        DBMS_OUTPUT.PUT (RPAD(current_employee.employeeid, 15, ' '));
        DBMS_OUTPUT.PUT_LINE (current_employee.name);
    END LOOP;
    
EXCEPTION

    when others then
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT(': ');
        DBMS_OUTPUT.PUT_LINE(SUBSTR(SQLERRM, 1, 100));
    
END print_employee_roster;

/
-- Question 6b
EXECUTE print_employee_roster('assembly');

/
-- Question 6c
/*
SQLCODE returns the number of the last encountered error.
SQLERRM return a message associated with the error-number which is
the current value of SQLCODE if there is no error-number argument input.

It will display something like this:
####:ORA-######: error description

Citation:
Oratable, O. (2018, January 04). What are SQLCODE and SQLERRM?
	Retrieved October 15, 2020, from https://www.oratable.com/sqlcode-and-sqlerrm/
*/

/
-- Question 7a
create or replace procedure customer_roster
(p_state in customer.state%type)
as
    
    CURSOR all_customers
    IS
        SELECT companyname, city, state, custlastname || ', '|| custfirstname as name
        from customer
        where UPPER(TRIM(state)) = UPPER(TRIM(p_state));
                
        current_customer all_customers%ROWTYPE;
BEGIN
    
    open all_customers;
    
    fetch all_customers into current_customer;
    
    while all_customers%FOUND LOOP
    
    
    
    
        
        DBMS_OUTPUT.PUT(RPAD(current_customer.city,15, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.state,15, ' ' ));
        DBMS_OUTPUT.PUT(RPAD(current_customer.name,25, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.companyname,15,' ' ));
        DBMS_OUTPUT.PUT_LINE(RPAD('',15,''));
        
        
        
        
        FETCH all_customers into current_customer;
        
        
    
    END LOOP;
    CLOSE all_customers;

    
EXCEPTION

    when others then
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT(': ');
        DBMS_OUTPUT.PUT_LINE(SUBSTR(SQLERRM, 1, 100));
    
END customer_roster;


/
-- Question 7b
EXECUTE customer_roster('GA');

/
-- Question 8a

create or replace procedure customer_search
(p_name in customer.custlastname%type)
as
    
    CURSOR all_customers
    IS
        SELECT companyname, custfirstname, custlastname, custtitle
        from customer
        where UPPER(TRIM(custlastname)) like UPPER(TRIM(p_name));
            
        current_customer all_customers%ROWTYPE;    
       
BEGIN
    
    OPEN all_customers;
    
    FETCH all_customers into current_customer;
    
    WHILE all_customers%FOUND LOOP
    
    
       
        DBMS_OUTPUT.PUT(RPAD(current_customer.custfirstname,15, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.custlastname,15, ' ' ));
        DBMS_OUTPUT.PUT(RPAD(current_customer.custtitle,25, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.companyname,15,' ' ));
         DBMS_OUTPUT.PUT_LINE(RPAD('',15,''));
          
          FETCH all_customers into current_customer;
    
    END LOOP;
    CLOSE all_customers;
   

    
EXCEPTION

    when others then
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT(': ');
        DBMS_OUTPUT.PUT_LINE(SUBSTR(SQLERRM, 1, 100));
    
END customer_search;


/
-- Question 8b
EXECUTE customer_search('%NA%');

/
-- Question 8c

create or replace procedure customer_search
(p_name in customer.custlastname%type)
as
    
    CURSOR all_customers
    IS
        SELECT companyname, custfirstname, custlastname, custtitle
        from customer
        where UPPER(TRIM(custlastname)) like UPPER(TRIM(p_name))
        or UPPER(TRIM(custfirstname)) like UPPER(TRIM(p_name));
            
        current_customer all_customers%ROWTYPE;    
       
BEGIN
    
    OPEN all_customers;
    
    FETCH all_customers into current_customer;
    
    WHILE all_customers%FOUND LOOP
    
    
       
        DBMS_OUTPUT.PUT(RPAD(current_customer.custfirstname,15, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.custlastname,15, ' ' ));
        DBMS_OUTPUT.PUT(RPAD(current_customer.custtitle,25, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.companyname,15,' ' ));
         DBMS_OUTPUT.PUT_LINE(RPAD('',15,''));
          
          FETCH all_customers into current_customer;
    
    END LOOP;
    CLOSE all_customers;
   

    
EXCEPTION

    when others then
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT(': ');
        DBMS_OUTPUT.PUT_LINE(SUBSTR(SQLERRM, 1, 100));
    
END customer_search;


/
-- Question 8d
EXECUTE customer_search('%na%');

/
-- Question 8e

create or replace procedure customer_search
(p_name in customer.custlastname%type)
as
    
    CURSOR all_customers
    IS
        SELECT companyname, custfirstname, custlastname, custtitle
        from customer
        where UPPER(TRIM(custlastname)) like UPPER(TRIM(p_name))
        or UPPER(TRIM(custfirstname)) like UPPER(TRIM(p_name));
                
       
BEGIN
    
    FOR current_customer IN all_customers LOOP
    
    
    
    
       
        DBMS_OUTPUT.PUT(RPAD(current_customer.custfirstname,15, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.custlastname,15, ' ' ));
        DBMS_OUTPUT.PUT(RPAD(current_customer.custtitle,25, ' '));
        DBMS_OUTPUT.PUT(RPAD(current_customer.companyname,15,' ' ));
         DBMS_OUTPUT.PUT_LINE(RPAD('',15,''));
          
    
    END LOOP;
   

    
EXCEPTION

    when others then
        DBMS_OUTPUT.PUT (SQLCODE);
        DBMS_OUTPUT.PUT(': ');
        DBMS_OUTPUT.PUT_LINE(SUBSTR(SQLERRM, 1, 100));
    
END customer_search;


/
-- Question 8f
EXECUTE customer_search('%na%');

/

/* Results

Question 1a

Procedure PRINT_EMPLOYEE_ROSTER compiled


Question 1b
100001         Manaugh                       Jim
100101         Rosner                        Joanne
100103         Bush                          Rita
100104         Abbott                        Michael
100106         Eckelman                      Paul
100112         Hickman                       Steven
100120         Nairn                         Michelle
100125         Stevenson                     Gabrielle
100127         Wendling                      Jason
100200         Zobitz                        Beth
100204         Keck                          David
100206         Xolo                          Kathleen
100209         Yates                         Tina
100220         Vigus                         Todd
100330         Gustavel                      Kristen
100365         Cheswick                      Sherman
100399         Day                           Ronald
100475         Hess                          Steve
100488         Osman                         Jamie
100550         Roland                        Allison
100559         Tyrie                         Meghan
100600         Zollman                       Calie
100650         Lilley                        Edna
100700         Jones                         Charles
100880         German                        Gary
100892         Platt                         Joseph
100944         Stahley                       Ryan
100967         Albregts                      Nicholas
100989         Deagen                        Kathryn
101007         Krasner                       Jason
101030         Moore                         Kristey
101045         Ortman                        Austin
101066         Rodgers                       Laura
101088         Underwood                     Patricha
101089         Alvarez                       Melissa
101097         Brose                         Jack
101115         Cochran                       Steve
101135         Deppe                         David
101154         Hettinger                     Gregory
101166         Reece                         Phil


PL/SQL procedure successfully completed.


Question 2a
Procedure PRINT_EMPLOYEE_ROSTER compiled


Question 2b
100001         Manaugh                       Jim
100101         Rosner                        Joanne
100103         Bush                          Rita
100104         Abbott                        Michael
100106         Eckelman                      Paul
100112         Hickman                       Steven
100120         Nairn                         Michelle
100125         Stevenson                     Gabrielle
100127         Wendling                      Jason
100200         Zobitz                        Beth
100204         Keck                          David
100206         Xolo                          Kathleen
100209         Yates                         Tina
100220         Vigus                         Todd
100330         Gustavel                      Kristen
100365         Cheswick                      Sherman
100399         Day                           Ronald
100475         Hess                          Steve
100488         Osman                         Jamie
100550         Roland                        Allison
100559         Tyrie                         Meghan
100600         Zollman                       Calie
100650         Lilley                        Edna
100700         Jones                         Charles
100880         German                        Gary
100892         Platt                         Joseph
100944         Stahley                       Ryan
100967         Albregts                      Nicholas
100989         Deagen                        Kathryn
101007         Krasner                       Jason
101030         Moore                         Kristey
101045         Ortman                        Austin
101066         Rodgers                       Laura
101088         Underwood                     Patricha
101089         Alvarez                       Melissa
101097         Brose                         Jack
101115         Cochran                       Steve
101135         Deppe                         David
101154         Hettinger                     Gregory
101166         Reece                         Phil


PL/SQL procedure successfully completed.


Question 2c
It is based off the most recent fetch from the cursor. 

Question 3a
Procedure PRINT_EMPLOYEE_ROSTER compiled

Question 3b
100001         Manaugh, Jim
100101         Rosner, Joanne
100103         Bush, Rita
100104         Abbott, Michael
100106         Eckelman, Paul
100112         Hickman, Steven
100120         Nairn, Michelle
100125         Stevenson, Gabrielle
100127         Wendling, Jason
100200         Zobitz, Beth
100204         Keck, David
100206         Xolo, Kathleen
100209         Yates, Tina
100220         Vigus, Todd
100330         Gustavel, Kristen
100365         Cheswick, Sherman
100399         Day, Ronald
100475         Hess, Steve
100488         Osman, Jamie
100550         Roland, Allison
100559         Tyrie, Meghan
100600         Zollman, Calie
100650         Lilley, Edna
100700         Jones, Charles
100880         German, Gary
100892         Platt, Joseph
100944         Stahley, Ryan
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101007         Krasner, Jason
101030         Moore, Kristey
101045         Ortman, Austin
101066         Rodgers, Laura
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil


PL/SQL procedure successfully completed.

Question 4a
Procedure PRINT_EMPLOYEE_ROSTER compiled


Question 4b
100001         Manaugh, Jim
100101         Rosner, Joanne
100103         Bush, Rita
100104         Abbott, Michael
100106         Eckelman, Paul
100112         Hickman, Steven
100120         Nairn, Michelle
100125         Stevenson, Gabrielle
100127         Wendling, Jason
100200         Zobitz, Beth
100204         Keck, David
100206         Xolo, Kathleen
100209         Yates, Tina
100220         Vigus, Todd
100330         Gustavel, Kristen
100365         Cheswick, Sherman
100399         Day, Ronald
100475         Hess, Steve
100488         Osman, Jamie
100550         Roland, Allison
100559         Tyrie, Meghan
100600         Zollman, Calie
100650         Lilley, Edna
100700         Jones, Charles
100880         German, Gary
100892         Platt, Joseph
100944         Stahley, Ryan
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101007         Krasner, Jason
101030         Moore, Kristey
101045         Ortman, Austin
101066         Rodgers, Laura
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil


PL/SQL procedure successfully completed.


Question 4c
The steps that are implicitly handled are open, fetch, and close.

Question 5a
Procedure PRINT_EMPLOYEE_ROSTER compiled

Question 5b
100600         Zollman, Calie
101007         Krasner, Jason
101066         Rodgers, Laura


PL/SQL procedure successfully completed.

Question 5c
100101         Rosner, Joanne
100120         Nairn, Michelle
100204         Keck, David
100399         Day, Ronald
100475         Hess, Steve
100550         Roland, Allison
100892         Platt, Joseph
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101030         Moore, Kristey
101045         Ortman, Austin
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil


PL/SQL procedure successfully completed.


Question 5d
PL/SQL procedure successfully completed.

It successfully completes/runs but it just displays nothing except for that it was successful.

Question 6a
Procedure PRINT_EMPLOYEE_ROSTER compiled

Question 6b
100101         Rosner, Joanne
100120         Nairn, Michelle
100204         Keck, David
100399         Day, Ronald
100475         Hess, Steve
100550         Roland, Allison
100892         Platt, Joseph
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101030         Moore, Kristey
101045         Ortman, Austin
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil


PL/SQL procedure successfully completed.


Question 6c
SQLCODE returns the number of the last encountered error.
SQLERRM return a message associated with the error-number which is
the current value of SQLCODE if there is no error-number argument input.

It will display something like this:
####:ORA-######: error description

Citation:
Oratable, O. (2018, January 04). What are SQLCODE and SQLERRM?
	Retrieved October 15, 2020, from https://www.oratable.com/sqlcode-and-sqlerrm/

Question 7a
Procedure CUSTOMER_ROSTER compiled


Question 7b
Athens         GA             Thompson, Jamie          
Macon          GA             Vanderhoff, Rosemary     
Nahunta        GA             Malady, Frank            
Adel           GA             Strong, Susan            Family Medical 
Elberton       GA             Torres, Don              Down Deep Drill
Swainsboro     GA             Osborne, Shirley         


PL/SQL procedure successfully completed.



Question 8a

Procedure CUSTOMER_SEARCH compiled


Question 8b
Dorlan         Bresnaham      Dr.                      
Jay            Hanau          Mr.                      
Matt           Nakanishi      Mr.                      
Jim            Manaugh        Mr.                      
Daniel         Hundnall       Mr.                      Bobs Repair Ser
Jessica        Nakamura       Ms.                      Automart       


PL/SQL procedure successfully completed.


Question 8c



Question 8d
Dorlan         Bresnaham      Dr.                      
Verna          McGrew         Ms.                      
Christina      Wilson         Mrs.                     
Jay            Hanau          Mr.                      
Matt           Nakanishi      Mr.                      
Nancy          Basham         Mrs.                     
Jim            Manaugh        Mr.                      
Jonathon       Blanco         Mr.                      
Daniel         Hundnall       Mr.                      Bobs Repair Ser
Jessica        Nakamura       Ms.                      Automart       
Anna           Mayton         Dr.                      
Ronald         Miller         Mr.                      


PL/SQL procedure successfully completed.


Question 8e
Procedure CUSTOMER_SEARCH compiled


Question 8f
Dorlan         Bresnaham      Dr.                      
Verna          McGrew         Ms.                      
Christina      Wilson         Mrs.                     
Jay            Hanau          Mr.                      
Matt           Nakanishi      Mr.                      
Nancy          Basham         Mrs.                     
Jim            Manaugh        Mr.                      
Jonathon       Blanco         Mr.                      
Daniel         Hundnall       Mr.                      Bobs Repair Ser
Jessica        Nakamura       Ms.                      Automart       
Anna           Mayton         Dr.                      
Ronald         Miller         Mr.                      


PL/SQL procedure successfully completed.

*/




