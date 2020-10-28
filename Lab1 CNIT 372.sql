-- Question 1
select distinct(substr(phone,1,3)) as areacode from customer where state = 'CO';

/
-- Question 2
select unique(substr(phone,1,3))as area, count(*) from customer where state = 'CO'
group by (substr(phone,1,3)) order by count(*) desc;

/
-- Question 3
select unique(substr(phone,1,3))as area from customer where state = 'CO'group by (substr(phone,1,3))
having count(*) = (select max(cnt) from (select unique(substr(phone,1,3)),count(*)as cnt
from customer where state = 'CO' group by (substr(phone,1,3))));

/
-- Question 4
select custlastname || ', ' || custfirstname, city, state, phone from customer group 
by phone, custlastname || ', ' || custfirstname, city, state having substr(phone,1,3) = 
(select unique(substr(phone,1,3))as area from customer where state = 'CO'group by (substr(phone,1,3))
having count(*) = (select max(cnt) from (select unique(substr(phone,1,3)),count(*)as cnt
from customer where state = 'CO' group by (substr(phone,1,3)))));

/
-- Question 5
/*
It could be used for a lot of different things. The could mean there are more people to target
in that area for other products or that there are just a lot more people their in general. It
could also show you that possibly this area is already saturated since it has the most 
customers, so it may be that you want to move some resource from this current popular area
to an area that currently has less customers. There are lots of different reasons you might
want this information.
*/

/
-- Question 6
select customerid, count(orderid) from custorder where orderdate
between '01-AUG-10' and '31-AUG-10' group by customerid order by count(orderid) desc;

/
-- Question 7
select MAX(num) from(
select customerid, count(orderid) as num from custorder where orderdate
between '01-AUG-10' and '31-AUG-10' group by customerid order by count(orderid) desc);

/
-- Question 8
select customerid, count(orderid) from custorder where
orderdate between '01-AUG-10' and '31-AUG-10' group by customerid having count(orderid) = 
(select max(cnt) from (select customerid, count(orderid) as cnt from custorder where
orderdate between '01-AUG-10' and '31-AUG-10' group by customerid));

/
-- Question 9
select AVG(count(orderid)) from custorder orderdate where 
orderdate between '01-AUG-10' and '31-AUG-10'
group by customerid ;

/
-- Question 10
select customerid, count(orderid) from custorder where orderdate between '01-AUG-10' and '31-AUG-10'
group by customerid having count(orderid) > 
(select AVG(count(orderid)) from custorder orderdate where 
orderdate between '01-AUG-10' and '31-AUG-10'
group by customerid) order by count(orderid) desc ;

/
-- Question 11
select customerid, count(orderid) from custorder where orderdate between '01-AUG-10' and '31-AUG-10'
group by customerid having count(orderid) < 
(select AVG(count(orderid)) from custorder orderdate where 
orderdate between '01-AUG-10' and '31-AUG-10'
group by customerid) order by count(orderid) asc ;

/
-- Question 12
/*
This information can be used to try to find customers that need to be targeted so they can
increase their sales for the month of august. It could also be used to find why some
people are buying more in august and possibly use that information/strategy to get the 
customers who are buying less to buy more. It could also be used to predict how spending
will be in the next month. If someone buys significantly more in august than they normally
do you may be able to predict that they will buy less in september and plan for that
and vice-versa.
*/

/
-- Question 13
select custorder.customerid,companyname, custlastname || ', ' ||custfirstname as name, 
TO_CHAR (custorder.orderdate, 'MM.DD.YYYY') as thedate from custorder inner join customer on
custorder.customerid = customer.customerid where state = 'IN' and custorder.orderdate between
'01-JAN-10' and '31-DEC-10' order by custorder.orderdate;

/
-- Question 14
select companyname, contactname, orderdate, requireddate from customer inner join
custorder on customer.customerid = custorder.customerid inner join shipment on
custorder.orderid = shipment.orderid inner join shipper on shipper.shipperid = 
shipment.shipperid where custorder.customerid = 'C-300001' order by custorder.orderdate asc;

/
-- Question 15
select custorderline.orderid, custorderline.partnumber, inventorypart.partdescription, unitprice,
orderquantity, categoryname from custorderline inner join inventorypart on
custorderline.partnumber = inventorypart.partnumber inner join category on
category.categoryid = inventorypart.categoryid where inventorypart.partdescription
like '%BOARD GAMES%' order by custorderline.orderquantity desc;

/
-- Question 16
select custorderline.orderid, inventorypart.partnumber, inventorypart.partdescription,
custorderline.unitprice, custorderline.orderquantity from custorderline
inner join inventorypart on custorderline.partnumber = inventorypart.partnumber
inner join custorder on custorderline.orderid = custorder.orderid where custorder.customerid
= 'C-300001' and custorder.orderdate = '14-JUL-10' order by custorderline.orderquantity desc;

/
-- Question 17
select TO_CHAR (custorder.orderdate, 'MM.DD.YYYY'), custorder.orderid, inventorypart.partnumber, 
inventorypart.partdescription, custorderline.unitprice, custorderline.orderquantity
from custorder inner join custorderline on custorderline.orderid = custorder.orderid
inner join inventorypart on inventorypart.partnumber = custorderline.partnumber
inner join customer on custorder.customerid = customer.customerid where companyname
= 'Bankruptcy Help' and custorder.orderdate between '01-JAN-11' and '31-DEC-11'
order by custorder.orderdate asc, custorderline.orderquantity desc;

/
-- Question 18
select TO_CHAR (custorder.orderdate, 'MM.DD.YYYY'), custorder.orderid, inventorypart.partnumber, 
inventorypart.partdescription, (custorderline.unitprice*custorderline.orderquantity)as lineitemtotal
from custorder inner join custorderline on custorderline.orderid = custorder.orderid
inner join inventorypart on inventorypart.partnumber = custorderline.partnumber
inner join customer on custorder.customerid = customer.customerid where companyname
= 'Bankruptcy Help' and custorder.orderdate between '01-JAN-11' and '31-DEC-11'
order by custorder.orderdate asc, custorderline.orderquantity desc;

/
-- Question 19
select distinct(customer.customerID), customer.companyname,
substr(shipper.contactname,instr(contactname,' '))
|| ', '||substr(shipper.contactname,1,instr(shipper.contactname,' ')) as contactname, 
count(custorder.orderid)
from custorder inner join customer on custorder.customerid = customer.customerid
inner join shipment on shipment.orderid = custorder.orderid
inner join shipper on shipper.shipperid = shipment.shipperid
where state = 'IN' and orderdate between '01-JAN-11' and '31-JAN-11'
group by custorder.customerid, (customer.customerID), customer.customerID, customer.companyname, shipper.contactname
order by count(custorder.orderid) asc;

/
-- Question 20
select categoryname, cast (AVG(stocklevel) as decimal (10,2)) from category inner join inventorypart
on inventorypart.categoryid = category.categoryid 
group by inventorypart.categoryid, categoryname order by AVG(stocklevel) asc;

/
-- Question 21
select category.categoryname || ': ' || category.description as categorydetail, count(partdescription)
as numberofparttypes from category
inner join inventorypart on inventorypart.categoryid = category.categoryid
group by category.categoryname, category.categoryname || ': ' || category.description
order by count(partdescription) asc;

/
-- Question 22
select max(weight) from inventorypart inner join category
on inventorypart.categoryid = category.categoryid
where category.categoryname = 'Software';

/
-- Question 23
select category.categoryname, max(weight) from inventorypart inner join category
on inventorypart.categoryid = category.categoryid 
where category.categoryname = 'Software' or category.categoryname = 'Power' 
or category.categoryname = 'Storage' group by category.categoryname 
order by category.categoryname asc;

/
-- Question 24
select category.categoryname, max(weight), partdescription  from inventorypart inner join category
on inventorypart.categoryid = category.categoryid 
where category.categoryname = 'Software' or category.categoryname = 'Power' 
or category.categoryname = 'Storage' group by category.categoryname, partdescription 
order by category.categoryname asc;

/* Results


Question 1
ARE
---
970
728
720
644
719

Question 2
ARE   COUNT(*)
--- ----------
719          4
970          2
644          1
728          1
720          1


Question 3
ARE
---
719

Question 4
CUSTLASTNAME||','||CUSTFIRSTNAME      CITY                 ST PHONE       
------------------------------------- -------------------- -- ------------
Rodkey, Daniel                        Lamar                CO 719-748-3205
Kaakeh, Paul                          Gunnison             CO 719-750-4539
Rice, Paul                            Craig                CO 719-541-1837
Smith, Matt                           Montrose             CO 719-822-8828


Question 5
/*
It could be used for a lot of different things. The could mean there are more people to target
in that area for other products or that there are just a lot more people their in general. It
could also show you that possibly this area is already saturated since it has the most 
customers, so it may be that you want to move some resource from this current popular area
to an area that currently has less customers. There are lots of different reasons you might
want this information.
*/

Question 6
CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300006                3
I-300010                2
I-300016                2
I-300014                2
C-300055                2
C-300041                2
C-300031                2
I-300015                2
C-300027                2
C-300005                2
C-300003                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300004                1
I-300007                1
I-300043                1
I-300108                1
I-300110                1
I-300031                1
C-300053                1
I-300070                1
I-300068                1
I-300093                1
C-300017                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300061                1
C-300051                1
C-300004                1
I-300042                1
I-300091                1
I-300088                1
C-300011                1
I-300017                1
C-300010                1
I-300132                1
I-300076                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300020                1
I-300095                1
I-300120                1
I-300129                1
I-300002                1
C-300002                1
I-300026                1
I-300097                1
C-300001                1
C-300026                1
I-300126                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300081                1
I-300012                1
I-300013                1
I-300138                1
I-300115                1
I-300122                1
I-300009                1
C-300013                1
C-300020                1
I-300102                1
I-300096                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300033                1
I-300044                1
I-300112                1
I-300011                1
C-300035                1
I-300005                1
I-300069                1
I-300024                1
I-300018                1
I-300117                1
I-300025                1

66 rows selected. 


Question 7
  MAX(NUM)
----------
         3

Question 8
CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300006                3

Question 9
AVG(COUNT(ORDERID))
-------------------
         1.16666667

Question 10

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300006                3
I-300010                2
I-300016                2
I-300014                2
C-300055                2
C-300041                2
C-300031                2
I-300015                2
C-300027                2
C-300005                2

10 rows selected. 

10 rows selected. 

Question 11
CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300003                1
I-300025                1
I-300007                1
I-300043                1
I-300108                1
I-300110                1
I-300031                1
C-300053                1
I-300070                1
I-300068                1
I-300093                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300017                1
I-300061                1
C-300051                1
C-300004                1
I-300042                1
I-300091                1
I-300088                1
C-300011                1
I-300017                1
C-300010                1
I-300132                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300076                1
I-300020                1
I-300095                1
I-300120                1
I-300129                1
I-300002                1
C-300002                1
I-300026                1
I-300097                1
C-300001                1
C-300026                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300126                1
I-300081                1
I-300012                1
I-300013                1
I-300138                1
I-300115                1
I-300122                1
I-300009                1
C-300013                1
C-300020                1
I-300102                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300096                1
C-300033                1
I-300044                1
I-300112                1
I-300011                1
C-300035                1
I-300005                1
I-300069                1
I-300024                1
I-300018                1
I-300117                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300004                1

56 rows selected. 

Question 12
/*
This information can be used to try to find customers that need to be targeted so they can
increase their sales for the month of august. It could also be used to find why some
people are buying more in august and possibly use that information/strategy to get the 
customers who are buying less to buy more. It could also be used to predict how spending
will be in the next month. If someone buys significantly more in august than they normally
do you may be able to predict that they will buy less in september and plan for that
and vice-versa.
*/ 

Question 13
CUSTOMERID COMPANYNAME                              NAME                                  THEDATE   
---------- ---------------------------------------- ------------------------------------- ----------
C-300001   Baker and Company                        Abbott, Gregory                       07.08.2010
C-300001   Baker and Company                        Abbott, Gregory                       07.14.2010
C-300001   Baker and Company                        Abbott, Gregory                       08.13.2010
I-300030                                            Quintero, Eric                        09.15.2010
C-300014   R and R Air                              Bending, Cathy                        10.04.2010
C-300001   Baker and Company                        Abbott, Gregory                       12.02.2010
I-300147                                            Yaun, Steven                          12.07.2010

7 rows selected. 

Question 14
COMPANYNAME                              CONTACTNAME          ORDERDATE REQUIREDD
---------------------------------------- -------------------- --------- ---------
Baker and Company                        Barbara Hull         08-JUL-10 12-JUL-10
Baker and Company                        Barbara Hull         14-JUL-10 15-JUL-10
Baker and Company                        Richard Slagel       13-AUG-10 20-AUG-10
Baker and Company                        Michael Emilson      02-DEC-10 08-DEC-10
Baker and Company                        Richard Slagel       27-JAN-11 03-FEB-11
Baker and Company                        Michael Emilson      24-FEB-11 03-MAR-11
Baker and Company                        Barbara Hull         10-MAR-11 15-MAR-11

7 rows selected. 

Question 15
ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY CATEGORYNAME                  
---------- ---------- -------------------------------------------------- ---------- ------------- ------------------------------
2001000536 SFT-005    BOARD GAMES                                              9.99            15 Software                      
2000000050 SFT-005    BOARD GAMES                                              9.99            14 Software                      
2000000279 SFT-005    BOARD GAMES                                              9.99            10 Software                      
2000000426 SFT-005    BOARD GAMES                                              9.99            10 Software                      
2000000348 SFT-005    BOARD GAMES                                              9.99             2 Software                      
2000000139 SFT-005    BOARD GAMES                                              9.99             2 Software                      
2001000722 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000206 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000362 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000005 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000436 SFT-005    BOARD GAMES                                              9.99             1 Software                      

ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY CATEGORYNAME                  
---------- ---------- -------------------------------------------------- ---------- ------------- ------------------------------
2001000600 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000040 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000011 SFT-005    BOARD GAMES                                              9.99             1 Software                      

14 rows selected. 


Question 16
ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY
---------- ---------- -------------------------------------------------- ---------- -------------
2000000032 BRK-011    2ND PARALLEL PORT                                        5.99            20
2000000032 CTR-019    FLY XPST                                              1717.99             9
2000000032 ADT-003    EXTERNAL SCSI-3 MALE TERMINATOR                         39.99             8
2000000032 CAB-027    2FT 3/1 SCSI CABLE                                      44.99             6
2000000032 SCN-002    SCANJET BUSINESS SERIES COLOR SCANNER                     249             4

Question 17
TO_CHAR(CU ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY
---------- ---------- ---------- -------------------------------------------------- ---------- -------------
02.14.2011 2001000622 BB-004     SOCKET MINI BAREBONE                                   199.99             6
02.14.2011 2001000622 P-005      700 PENTIUM III PROCESSOR                              399.99             4
02.24.2011 2001000676 MIC-009    WHEEL MOUSE                                              29.5            27
02.28.2011 2001000699 MOD-002    112K DUAL MODEM                                         89.99            16
02.28.2011 2001000699 MEM-001    2MB FLASH BUFFER MEMORY                                259.95            12
02.28.2011 2001000699 PRT-003    LASER JET 2500SE                                          699             3
03.22.2011 2001000778 BRK-002    1X4 USB CABLE AND BRACKET                                9.99            20
03.22.2011 2001000778 MEM-004    30.7GB HARD DRIVE                                      269.99            10
03.22.2011 2001000778 P-006      600 PENTIUM III PROCESSOR                              339.99             6

9 rows selected. 

Question 18
TO_CHAR(CU ORDERID    PARTNUMBER PARTDESCRIPTION                                    LINEITEMTOTAL
---------- ---------- ---------- -------------------------------------------------- -------------
02.14.2011 2001000622 BB-004     SOCKET MINI BAREBONE                                     1199.94
02.14.2011 2001000622 P-005      700 PENTIUM III PROCESSOR                                1599.96
02.24.2011 2001000676 MIC-009    WHEEL MOUSE                                                796.5
02.28.2011 2001000699 MOD-002    112K DUAL MODEM                                          1439.84
02.28.2011 2001000699 MEM-001    2MB FLASH BUFFER MEMORY                                   3119.4
02.28.2011 2001000699 PRT-003    LASER JET 2500SE                                            2097
03.22.2011 2001000778 BRK-002    1X4 USB CABLE AND BRACKET                                  199.8
03.22.2011 2001000778 MEM-004    30.7GB HARD DRIVE                                         2699.9
03.22.2011 2001000778 P-006      600 PENTIUM III PROCESSOR                                2039.94

9 rows selected. 

Question 19
CUSTOMERID COMPANYNAME                              CONTACTNAME                                COUNT(CUSTORDER.ORDERID)
---------- ---------------------------------------- ------------------------------------------ ------------------------
C-300001   Baker and Company                         Slagel, Richard                                                  1
C-300014   R and R Air                               Hull, Barbara                                                    1
I-300030                                             Carroll, Suzanne                                                 2


Question 20
CATEGORYNAME                   CAST(AVG(STOCKLEVEL)ASDECIMAL(10,2))
------------------------------ ------------------------------------
Computers                                                      2.45
Accessories                                                    9.21
Power                                                          10.5
Storage                                                       20.47
Basics                                                         20.5
Processors                                                    23.74
Software                                                      33.89
Cables                                                        35.86

8 rows selected. 

Question 21

CATEGORYDETAIL                                                                                                                       NUMBEROFPARTTYPES
------------------------------------------------------------------------------------------------------------------------------------ -----------------
Power: Power Supplies                                                                                                                                4
Software: Games, maps                                                                                                                                9
Accessories: Scanners, Printers, Modems                                                                                                             14
Processors: Athlon, Celeron, Pentium, Fans                                                                                                          19
Storage: CD-ROM, DVD, Hard Drives, Memory                                                                                                           19
Computers: Assembled Computers                                                                                                                      29
Cables: Printer, Keyboard, Internal, SCSI, Connectors, Brackets                                                                                     36
Basics: Casing, Barebone, Monitors, Keyboards, Mice                                                                                                 44

8 rows selected. 

Question 22
MAX(WEIGHT)
-----------
       .438

Question 23
CATEGORYNAME                   MAX(WEIGHT)
------------------------------ -----------
Power                                    3
Software                              .438
Storage                                  4

Question 24

CATEGORYNAME                   MAX(WEIGHT) PARTDESCRIPTION                                   
------------------------------ ----------- --------------------------------------------------
Power                                    3 250 WATT POWER SUPPLY                             
Power                                    2 250 WATT PS/2 POWER SUPPLY                        
Power                                    3 300 WATT POWER SUPPLY                             
Power                                    2 300 WATT PS/2 POWER SUPPLY                        
Software                               .25 1000 BEST GAMES                                   
Software                              .438 BOARD GAMES                                       
Software                              .313 CARD GAMES                                        
Software                               .25 CLIPART AND FONTS DELUXE                          
Software                              .438 DESKTOP PUBLISHER                                 
Software                              .313 HOME AND GARDEN                                   
Software                              .375 SCREEN SAVER                                      

CATEGORYNAME                   MAX(WEIGHT) PARTDESCRIPTION                                   
------------------------------ ----------- --------------------------------------------------
Software                              .188 STREET MAPS USA                                   
Software                              .375 TRAVEL MAPS USA                                   
Storage                                  2 10.2GB HARD DRIVE                                 
Storage                                1.5 10X DVD DRIVE                                     
Storage                                2.5 13GB HARD DRIVE                                   
Storage                               2.75 20GB HARD DRIVE                                   
Storage                                 .5 2MB FLASH BUFFER MEMORY                           
Storage                                1.5 2TB EXTERNAL DRIVE                                
Storage                                  3 30.7GB HARD DRIVE                                 
Storage                                1.5 32 MB MEMORY                                      
Storage                               1.75 4.3GB HARD DRIVE                                  

CATEGORYNAME                   MAX(WEIGHT) PARTDESCRIPTION                                   
------------------------------ ----------- --------------------------------------------------
Storage                                  1 48X CD-ROM IDE                                    
Storage                                  1 48XCD-ROM DRIVE                                   
Storage                                  1 4GB MICROSD CARD                                  
Storage                                  1 4X36-60 72 PIM MEMORY                             
Storage                                  1 4X4X24 CDRW                                       
Storage                                1.5 6X DVD-ROM KIT                                    
Storage                               1.75 8.4GB HARD DRIVE                                  
Storage                               1.25 8GB MICROSD CARD                                  
Storage                                1.5 8X4X32 CDRW                                       
Storage                                  4 ETHERNET FIBER OPTIC MINI-TRANSCEIVER             

32 rows selected. 
*/




