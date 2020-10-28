-- Question 1a
select inventorypart.partnumber, inventorypart.partdescription, ROUND(AVG(orderquantity),1)
from inventorypart inner join custorderline on 
inventorypart.partnumber = custorderline.partnumber where inventorypart.categoryid = 'ACCESS'
group by inventorypart.partnumber, inventorypart.partdescription 
order by AVG(custorderline.orderquantity) desc;

/
-- Question 1b
/*
If that part was removed you could be taking the average of all the orders together no matter
what the part is. It would just be the average amount of parts ordered instead of the average
amount of that specific part.
*/

/
-- Question 2a
select inventorypart.partdescription, 
TO_CHAR(custorder.orderdate,'YYYY'), ROUND(AVG(custorderline.orderquantity),1)
from inventorypart inner join custorderline
on inventorypart.partnumber = custorderline.partnumber inner join custorder on 
custorderline.orderid = custorder.orderid where inventorypart.partnumber = 'DVD-001' 
and custorderline.orderquantity > 1
group by inventorypart.partdescription, TO_CHAR(custorder.orderdate,'YYYY');

/
-- Question 2b
/*
Between 2010 and 2011 the average quantity sold per order tripled. In 2010 it was 5 and
in 2011 it was 15.
*/

/
-- Question 3a
select inventorypart.partdescription, 
TO_CHAR(custorder.orderdate,'YYYY'), ROUND(sum(custorderline.orderquantity),1) as totalquantity
from inventorypart inner join custorderline
on inventorypart.partnumber = custorderline.partnumber inner join custorder on 
custorderline.orderid = custorder.orderid where inventorypart.partnumber = 'DVD-001' 
and custorderline.orderquantity > 1
group by inventorypart.partdescription, TO_CHAR(custorder.orderdate,'YYYY');

/
-- Question 3b
/*
The total quantity actually didn't change at all. The total quantity sold was 15 for 
both years.
*/

/
-- Question 4a
select inventorypart.partdescription, 
TO_CHAR(custorder.orderdate,'YYYY'), ROUND(count(custorderline.orderquantity),1)
from inventorypart inner join custorderline
on inventorypart.partnumber = custorderline.partnumber inner join custorder on 
custorderline.orderid = custorder.orderid where inventorypart.partnumber like '%DVD-001%' 
and custorderline.orderquantity > 1
group by inventorypart.partdescription, TO_CHAR(custorder.orderdate,'YYYY');

/
-- Question 4b
/*
There were more orders in 2010 than there was in 2011. There was 1 in 2011 and 3 in 2010.
That is how they have the same total quantity sold for both years
but the average per order is lower for 2010.
*/

/
-- Question 5a
/*
The underlying question is basically trying to figure out how sales are doing in each year.
In both years the same quantity of individual items was purchased. However, in 2011 there
were less orders but more items per order, while in 2010 there were more orders but
less items ordered per order. 
*/

/
-- Question 5b
/*
We can see that the overall amount of purchases for 6X DVD-ROM KIT remained the same but
it could be assumed that they are starting to be bought more in bulk. It could be that
one company embraced it and now orders in bulk instead of spreading out their orders.
*/

/
-- Question 5c
/*
They don't really conflict with each other they just show a different trend as long
as you know how to read it. If you don't though it could be easy to confuse. If you use
2b you may assume 2011 was a better year for sales, if you use 4b you may assume that
2010 was a better year for sales. However, if you look at 3b the fact is that
the same amount of items (6X DVD-ROM KIT) were sold.
*/

/
-- Question 6a
select shipment.orderid, packingslip.shipmentid, packingslip.packagenumber,
packingslip.shippeddate, shipment.shipname, shipment.shipaddress from packingslip
inner join shipment on packingslip.shipmentid = shipment.shipmentid where 
shipment.orderid = '2000000007';

/
-- Question 6b
/*
The package number is the only thing that is different. Everything else is the same
because it is a single orderID and therefore a single order. The package number
is different because multiple items may have to be in different packages but part
of the same order.
*/

/
-- Question 7a
select custlastname ||', '||custfirstname, customer.customerid, orderid from customer
left join custorder on customer.customerid = custorder.customerid where state = 'PA' and
companyname is null;

/
-- Question 7b
select custlastname ||', '||custfirstname, customer.customerid, orderid from custorder
right join customer on customer.customerid = custorder.customerid where state = 'PA' and
companyname is null;

/
-- Question 7c
select partnumber, categoryname from inventorypart full outer join category 
on inventorypart.categoryid = category.categoryid;

/
-- Question 7d
select customer.custfirstname ||' '|| customer.custlastname, custorder.customerid, custorder.orderdate,
shipment.shipmentid, packingslip.packagenumber, shipment.shipname, packingslip.shippeddate from customer
full outer join custorder on customer.customerid = custorder.customerid
full outer join shipment on custorder.orderid = shipment.orderid
full outer join packingslip on shipment.shipmentid = packingslip.shipmentid
where custorder.orderid = '2001000791';

/
-- Question 8a
select unique(customerid) from customer where state = 'PA'
intersect
select unique(customerid) from custorder where orderid is not null;

/
-- Question 8b
select unique(customerid) from customer where state = 'PA'
minus
select unique(customerid) from custorder where orderid is not null;

/
-- Question 8c
select unique(customerid) from customer where state = 'PA'
intersect
select unique(customerid) from custorder where orderid is not null and
orderdate between
'01-JAN-2011' and '31-DEC-2011';

/
-- Question 8d
select unique(customerid) from customer where state = 'PA'
minus
select unique(customerid) from custorder where (orderid is not null and
orderdate between
'01-JAN-2011' and '31-DEC-2011');

/
-- Question 9a
select unique(partnumber) from inventorypart where categoryid = 'CAB'
intersect
select unique(partnumber) from custorderline;

/
-- Question 9b
select unique(partnumber) from inventorypart where categoryid = 'CAB'
minus
select unique(partnumber) from custorderline;

/
-- Question 9c
select unique(partnumber) from inventorypart where categoryid = 'CAB'
intersect
select unique(partnumber) from custorderline
inner join custorder on custorderline.orderid = custorder.orderid
where orderdate between
'01-JAN-2011' and '31-DEC-2011';

/
-- Question 9d
select unique(partnumber) from inventorypart where categoryid = 'CAB'
minus
select unique(partnumber) from custorderline
inner join custorder on custorderline.orderid = custorder.orderid
where orderdate between
'01-JAN-2011' and '31-DEC-2011';

/
-- Question 10a
select custfirstname as fname, custlastname as lname from customer where state = 'FL'
union
select firstname as fname, lastname as lname from employee
order by fname asc, lname asc;

/
-- Question 10b
select custfirstname as fname, custlastname as lname from customer where state = 'FL'
union all
select firstname as fname, lastname as lname from employee
order by fname asc, lname asc;

/
-- Question 11
select customer.companyname as name, customer.customerid as custid, custorder.orderid as ordid from customer 
left join custorder on customer.customerid = custorder.customerid where companyname is not null
and state = 'PA'
union
select (customer.custlastname ||', '||customer.custfirstname) as name, customer.customerid as custid, 
custorder.orderid as ordid from customer
left join custorder on customer.customerid = custorder.customerid where companyname is null
and state = 'PA' 
order by custid, ordid;

/

/* Results


Question 1a

PARTNUMBER PARTDESCRIPTION                                    ROUND(AVG(ORDERQUANTITY),1)
---------- -------------------------------------------------- ---------------------------
MOD-001    PCI DATA/FAX/VOICE MODEM                                                   8.3
MOD-002    112K DUAL MODEM                                                            5.1
PRT-006    SINGLEHEAD THERMAL INKJET PRINTER                                          3.8
PRT-004    3-IN-1 COLOR INKJET PRINTER                                                3.6
SCN-002    SCANJET BUSINESS SERIES COLOR SCANNER                                      3.5
PRT-003    LASER JET 2500SE                                                           3.4
MOD-005    V.90/K56 FLEX 56K FAX MODEM                                                3.1
PRT-001    LASER JET 1999SE                                                           2.9
MOD-003    PCI MODEM                                                                  2.4
PRT-002    LASER JET 2000SE                                                           2.3
SCN-001    SCANJET CSE COLOR SCANNER                                                  1.8

PARTNUMBER PARTDESCRIPTION                                    ROUND(AVG(ORDERQUANTITY),1)
---------- -------------------------------------------------- ---------------------------
MOD-004    PCI V.90 DATA/FAX/VOICE MODEM                                              1.6

12 rows selected. 

Question 1b

If that part was removed you could be taking the average of all the orders together no matter
what the part is. It would just be the average amount of parts ordered instead of the average
amount of that specific part.


Question 2a

PARTDESCRIPTION                                    TO_C ROUND(AVG(CUSTORDERLINE.ORDERQUANTITY),1)
-------------------------------------------------- ---- -----------------------------------------
6X DVD-ROM KIT                                     2011                                        15
6X DVD-ROM KIT                                     2010                                         5


Question 2b
Between 2010 and 2011 the average quantity sold per order tripled. In 2010 it was 5 and
in 2011 it was 15.


Question 3a

PARTDESCRIPTION                                    TO_C TOTALQUANTITY
-------------------------------------------------- ---- -------------
6X DVD-ROM KIT                                     2011            15
6X DVD-ROM KIT                                     2010            15


Question 3b
The total quantity actually didn't change at all. The total quantity sold was 15 for 
both years.


Question 4a

PARTDESCRIPTION                                    TO_C ROUND(COUNT(CUSTORDERLINE.ORDERQUANTITY),1)
-------------------------------------------------- ---- -------------------------------------------
6X DVD-ROM KIT                                     2011                                           1
6X DVD-ROM KIT                                     2010                                           3


Question 4b
There were more orders in 2010 than there was in 2011. There was 1 in 2011 and 3 in 2010.
That is how they have the same total quantity sold for both years
but the average per order is lower for 2010.

Question 5a
The underlying question is basically trying to figure out how sales are doing in each year.
In both years the same quantity of individual items was purchased. However, in 2011 there
were less orders but more items per order, while in 2010 there were more orders but
less items ordered per order. 

Question 5b
We can see that the overall amount of purchases for 6X DVD-ROM KIT remained the same but
it could be assumed that they are starting to be bought more in bulk. It could be that
one company embraced it and now orders in bulk instead of spreading out their orders.

Question 5c
They don't really conflict with each other they just show a different trend as long
as you know how to read it. If you don't though it could be easy to confuse. If you use
2b you may assume 2011 was a better year for sales, if you use 4b you may assume that
2010 was a better year for sales. However, if you look at 3b the fact is that
the same amount of items (6X DVD-ROM KIT) were sold.

Question 6a

ORDERID    SHIPMENTID PACKAGENUMBER SHIPPEDDA SHIPNAME             SHIPADDRESS                             
---------- ---------- ------------- --------- -------------------- ----------------------------------------
2000000007 H003                   1 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.                       
2000000007 H003                   2 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.                       
2000000007 H003                   3 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.                       
 

Question 6b
The package number is the only thing that is different. Everything else is the same
because it is a single orderID and therefore a single order. The package number
is different because multiple items may have to be in different packages but part
of the same order.

Question 7a

CUSTLASTNAME||','||CUSTFIRSTNAME      CUSTOMERID ORDERID   
------------------------------------- ---------- ----------
Wolfe, Thomas                         I-300149   2000000497
Wolfe, Thomas                         I-300149   2001000670
Wolfe, Thomas                         I-300149   2001000736
Wolfe, Thomas                         I-300149   2001000751
Wolfe, Thomas                         I-300149   2001000768
Kaleta, Don                           I-300028             

6 rows selected. 


Question 7b

CUSTLASTNAME||','||CUSTFIRSTNAME      CUSTOMERID ORDERID   
------------------------------------- ---------- ----------
Wolfe, Thomas                         I-300149   2000000497
Wolfe, Thomas                         I-300149   2001000670
Wolfe, Thomas                         I-300149   2001000736
Wolfe, Thomas                         I-300149   2001000751
Wolfe, Thomas                         I-300149   2001000768
Kaleta, Don                           I-300028             

6 rows selected. 

Question 7c

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
ADT-001    Storage                       
ADT-002    Cables                        
ADT-003    Cables                        
ADT-004    Cables                        
ADT-005    Cables                        
ADT-006    Cables                        
ADT-007    Cables                        
BB-001     Basics                        
BB-002     Basics                        
BB-003     Basics                        
BB-004     Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
BB-005     Basics                        
BRK-001    Cables                        
BRK-002    Cables                        
BRK-003    Cables                        
BRK-004    Cables                        
BRK-005    Cables                        
BRK-006    Cables                        
BRK-007    Cables                        
BRK-008    Cables                        
BRK-009    Cables                        
BRK-010    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
BRK-011    Cables                        
C-001      Basics                        
C-002      Basics                        
C-003      Basics                        
CAB-001    Cables                        
CAB-002    Cables                        
CAB-003    Cables                        
CAB-004    Cables                        
CAB-005    Cables                        
CAB-006    Cables                        
CAB-007    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CAB-008    Cables                        
CAB-009                                  
CAB-010                                  
CAB-011                                  
CAB-012                                  
CAB-013                                  
CAB-014                                  
CAB-015                                  
CAB-016                                  
CAB-017                                  
CAB-018                                  

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CAB-019                                  
CAB-020                                  
CAB-021                                  
CAB-022                                  
CAB-023                                  
CAB-024                                  
CAB-025                                  
CAB-026                                  
CAB-027                                  
CAB-028                                  
CD-001     Storage                       

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CD-002     Storage                       
CD-003     Storage                       
CD-004     Storage                       
CF-001     Processors                    
CF-002     Processors                    
CF-003     Processors                    
CF-004     Processors                    
CF-005     Processors                    
CF-006     Processors                    
CF-007     Processors                    
CF-008     Processors                    

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CF-009     Processors                    
CRD-001                                  
CRD-002                                  
CRD-003                                  
CRD-004                                  
CRD-005                                  
CRD-006                                  
CRD-007                                  
CRD-008                                  
CRD-009                                  
CTR-001    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-002    Computers                     
CTR-003    Computers                     
CTR-004    Computers                     
CTR-005    Computers                     
CTR-006    Computers                     
CTR-007    Computers                     
CTR-008    Computers                     
CTR-009    Computers                     
CTR-010    Computers                     
CTR-011    Computers                     
CTR-012    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-013    Computers                     
CTR-014    Computers                     
CTR-015    Computers                     
CTR-016    Computers                     
CTR-017    Computers                     
CTR-018    Computers                     
CTR-019    Computers                     
CTR-020    Computers                     
CTR-021    Computers                     
CTR-022    Computers                     
CTR-023    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-024    Computers                     
CTR-025    Computers                     
CTR-026    Computers                     
CTR-027    Computers                     
CTR-028    Computers                     
CTR-029    Computers                     
DVD-001    Storage                       
DVD-002    Storage                       
ICAB-001   Cables                        
ICAB-002   Cables                        
ICAB-003   Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
ICAB-004   Cables                        
ICAB-005   Cables                        
ICAB-006   Cables                        
ICAB-007   Cables                        
ICAB-008   Cables                        
KEY-001    Basics                        
KEY-002    Basics                        
KEY-003    Basics                        
KEY-004    Basics                        
KEY-005    Basics                        
KEY-006    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
KEY-007    Basics                        
KEY-008    Basics                        
KEY-009    Basics                        
MEM-001    Storage                       
MEM-002    Storage                       
MEM-003    Storage                       
MEM-004    Storage                       
MEM-005    Storage                       
MEM-006    Storage                       
MEM-007    Storage                       
MEM-008    Storage                       

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MEM-009    Storage                       
MEM-010    Storage                       
MEM-011    Storage                       
MEM-012    Storage                       
MIC-001    Basics                        
MIC-002    Basics                        
MIC-003    Basics                        
MIC-004    Basics                        
MIC-005    Basics                        
MIC-006    Basics                        
MIC-007    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MIC-008    Basics                        
MIC-009    Basics                        
MIC-010    Basics                        
MIC-011    Basics                        
MIC-012    Basics                        
MOD-001    Accessories                   
MOD-002    Accessories                   
MOD-003    Accessories                   
MOD-004    Accessories                   
MOD-005    Accessories                   
MOM-001    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MOM-002    Basics                        
MOM-003    Basics                        
MOM-004    Basics                        
MON-001    Basics                        
MON-002    Basics                        
MON-003    Basics                        
MON-004    Basics                        
MON-005    Basics                        
MON-006    Basics                        
MON-007    Basics                        
MON-008    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
P-001      Processors                    
P-002      Processors                    
P-003      Processors                    
P-004      Processors                    
P-005      Processors                    
P-006      Processors                    
P-007      Processors                    
P-008      Processors                    
P-009      Processors                    
P-010      Processors                    
POW-001    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
POW-002    Cables                        
POW-003    Cables                        
PRT-001    Accessories                   
PRT-002    Accessories                   
PRT-003    Accessories                   
PRT-004    Accessories                   
PRT-005    Accessories                   
PRT-006    Accessories                   
PS-001     Power                         
PS-002     Power                         
PS-003     Power                         

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
PS-004     Power                         
SCN-001    Accessories                   
SCN-002    Accessories                   
SCN-003    Accessories                   
SFT-001    Software                      
SFT-002    Software                      
SFT-003    Software                      
SFT-004    Software                      
SFT-005    Software                      
SFT-006    Software                      
SFT-007    Software                      

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
SFT-008    Software                      
SFT-009    Software                      
SP-001     Basics                        
SP-002     Basics                        
SP-003     Basics                        
           Tablets                       

204 rows selected. 

Question 7d

CUSTOMER.CUSTFIRSTNAME||''||CUSTOMER CUSTOMERID ORDERDATE SHIPMENTID PACKAGENUMBER SHIPNAME             SHIPPEDDA
------------------------------------ ---------- --------- ---------- ------------- -------------------- ---------
Steven Yaun                          I-300147   27-MAR-11 L258                     Michelle Oakley               

 

Question 8a

CUSTOMERID
----------
C-300006
C-300040
C-300062
I-300149
 

Question 8b

CUSTOMERID
----------
I-300028


Question 8c

CUSTOMERID
----------
C-300006
C-300040
I-300149

Question 8d

CUSTOMERID
----------
C-300062
I-300028

Question 9a

PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected. 

Question 9b

PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001

Question 9c

PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected.  

Question 9d
PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001

Question 10a

FNAME           LNAME               
--------------- --------------------
Allison         Roland              
Austin          Ortman              
Beth            Zobitz              
Calie           Zollman             
Charles         Jones               
David           Deppe               
David           Keck                
Edna            Lilley              
Gabrielle       Stevenson           
Gary            German              
Gregory         Hettinger           

FNAME           LNAME               
--------------- --------------------
Jack            Barrick             
Jack            Brose               
Jamie           Osman               
Jason           Krasner             
Jason           Wendling            
Jim             Manaugh             
Joanne          Rosner              
Joseph          Platt               
Karen           Mangus              
Kathleen        Xolo                
Kathryn         Deagen              

FNAME           LNAME               
--------------- --------------------
Kathy           Gunderson           
Kelly           Jordan              
Kristen         Gustavel            
Kristey         Moore               
Kristy          Moore               
Laura           Rodgers             
Marla           Reeder              
Meghan          Tyrie               
Melissa         Alvarez             
Michael         Abbott              
Michael         Emore               

FNAME           LNAME               
--------------- --------------------
Michelle        Nairn               
Nicholas        Albregts            
Patricha        Underwood           
Paul            Eckelman            
Phil            Reece               
Rita            Bush                
Ronald          Day                 
Ryan            Stahley             
Sherman         Cheswick            
Steve           Cochran             
Steve           Hess                

FNAME           LNAME               
--------------- --------------------
Steven          Hickman             
Tina            Yates               
Todd            Vigus               

47 rows selected. 

Question 10b

FNAME           LNAME               
--------------- --------------------
Allison         Roland              
Allison         Roland              
Austin          Ortman              
Beth            Zobitz              
Calie           Zollman             
Charles         Jones               
Charles         Jones               
David           Deppe               
David           Keck                
Edna            Lilley              
Gabrielle       Stevenson           

FNAME           LNAME               
--------------- --------------------
Gary            German              
Gregory         Hettinger           
Jack            Barrick             
Jack            Brose               
Jamie           Osman               
Jason           Krasner             
Jason           Wendling            
Jim             Manaugh             
Jim             Manaugh             
Joanne          Rosner              
Joseph          Platt               

FNAME           LNAME               
--------------- --------------------
Karen           Mangus              
Kathleen        Xolo                
Kathryn         Deagen              
Kathy           Gunderson           
Kelly           Jordan              
Kristen         Gustavel            
Kristey         Moore               
Kristy          Moore               
Laura           Rodgers             
Marla           Reeder              
Meghan          Tyrie               

FNAME           LNAME               
--------------- --------------------
Melissa         Alvarez             
Michael         Abbott              
Michael         Emore               
Michelle        Nairn               
Nicholas        Albregts            
Patricha        Underwood           
Paul            Eckelman            
Phil            Reece               
Phil            Reece               
Rita            Bush                
Ronald          Day                 

FNAME           LNAME               
--------------- --------------------
Ryan            Stahley             
Ryan            Stahley             
Sherman         Cheswick            
Steve           Cochran             
Steve           Hess                
Steven          Hickman             
Tina            Yates               
Todd            Vigus               

52 rows selected.  

Question 11

NAME                                     CUSTID     ORDID     
---------------------------------------- ---------- ----------
BMA Advertising Design                   C-300006   2000000050
BMA Advertising Design                   C-300006   2000000083
BMA Advertising Design                   C-300006   2000000110
BMA Advertising Design                   C-300006   2000000130
BMA Advertising Design                   C-300006   2000000355
BMA Advertising Design                   C-300006   2001000643
BMA Advertising Design                   C-300006   2001000729
Computer Consultants                     C-300040   2000000012
Computer Consultants                     C-300040   2000000284
Computer Consultants                     C-300040   2001000721
Computer Consultants                     C-300040   2001000782

NAME                                     CUSTID     ORDID     
---------------------------------------- ---------- ----------
Security Installation                    C-300062   2000000361
Security Installation                    C-300062   2000000421
Security Installation                    C-300062   2000000440
Security Installation                    C-300062   2000000496
Kaleta, Don                              I-300028             
Wolfe, Thomas                            I-300149   2000000497
Wolfe, Thomas                            I-300149   2001000670
Wolfe, Thomas                            I-300149   2001000736
Wolfe, Thomas                            I-300149   2001000751
Wolfe, Thomas                            I-300149   2001000768

21 rows selected. 

*/




