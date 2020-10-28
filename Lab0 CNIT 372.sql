-- Question 1
select user from dual;

/
-- Question 2
select current_timestamp from dual;

/
-- Question 3
select count(CUSTOMERID) from CUSTOMER where COMPANYNAME is not null;

/
-- Question 4
select count(CUSTOMERID) from CUSTOMER where COMPANYNAME is null; 

/
-- Question 5
select count(CUSTOMERID) from CUSTOMER where STATE = 'IN'; 

/
-- Question 6
select count(CUSTOMERID) from CUSTOMER where CITY = 'Scranton'
and STATE = 'PA';

/
-- Question 7
select LOWER(CUSTOMERID), LOWER(COMPANYNAME), LOWER(CUSTLASTNAME), 
LOWER(CUSTFIRSTNAME), PHONE, LOWER(EMAILADDR) from 
CUSTOMER where STATE = 'IL' or STATE = 'MI' order by CUSTLASTNAME asc

/
-- Question 8
select CUSTOMERID, CUSTLASTNAME ||','|| CUSTFIRSTNAME, PHONE from CUSTOMER where
state = 'OH' and companyname is null;

/
-- Question 9
select CUSTOMERID, (SUBSTR(CUSTFIRSTNAME,1,1) ||'. '|| CUSTLASTNAME)as name, PHONE, EMAILADDR
from CUSTOMER where state in ('OH','IN') and COMPANYNAME is null order by CUSTLASTNAME desc;

/
-- Question 10
select count(distinct(customerid)) from customer where state = 'OH' and companyname is not null;

/
-- Question 11
select companyname, count(address) from customer where state in ('IN','IL') and
companyname is not null group by companyname;

/
-- Question 12
select customerid, companyname, custfirstname||' '|| custlastname as name, phone
from customer where state = 'CO' order by phone asc;

/* Results

Question 1
USER                                                                                                                            
--------------------------------------------------------------------------------------------------------------------------------
LDPERRY

Question 2
CURRENT_TIMESTAMP                                   
----------------------------------------------------
09-SEP-20 05.26.10.347207000 PM AMERICA/INDIANAPOLIS

Question 3
COUNT(CUSTOMERID)
-----------------
               74

Question 4
COUNT(CUSTOMERID)
-----------------
              157


Question 5
COUNT(CUSTOMERID)
-----------------
                4


Question 6
COUNT(CUSTOMERID)
-----------------
                2

Question 7
LOWER(CUST LOWER(COMPANYNAME)                       LOWER(CUSTLASTNAME)  LOWER(CUSTFIRST PHONE        LOWER(EMAILADDR)                                  
---------- ---------------------------------------- -------------------- --------------- ------------ --------------------------------------------------
i-300007                                            cain                 jessica         517-901-2610                                                   
c-300023   tas                                      dalury               robert          906-278-6446 tas@zeronet.net                                   
i-300093                                            hanau                jay             773-490-8254                                                   
i-300031                                            hession              phillip         231-711-6837 howdy@usol.com                                    
c-300024   bankruptcy help                          lichty               jim             618-847-1904 bankrupt@usol.com                                 
i-300025                                            miller               ronald          734-820-2076 picky@zeronet.net                                 
c-300039   gards auto repair                        sammons              dennis          616-544-1969 repairit@free.com                                 
i-300038                                            smith                david           309-980-4350 emerald@onlineservice.com                         
i-300052                                            yelnick              andrew          517-803-5818 family@free.com                                   

9 rows selected.

Question 8
CUSTOMERID CUSTLASTNAME||','||CUSTFIRSTNAME     PHONE       
---------- ------------------------------------ ------------
I-300094   Schuman,Joseph                       330-209-1273
I-300119   Skadberg,John                        513-282-3919
I-300003   Hague,Carl                           419-890-3531
I-300039   Chang,David                          740-750-1272
I-300045   Kempf,Gary                           937-724-7313

Question 9
CUSTOMERID NAME                    PHONE        EMAILADDR                                         
---------- ----------------------- ------------ --------------------------------------------------
I-300147   S. Yaun                 317-780-9804 yawn@fast.com                                     
I-300119   J. Skadberg             513-282-3919 skad@zeronet.net                                  
I-300094   J. Schuman              330-209-1273                                                   
I-300030   E. Quintero             812-805-1588 diamond@onlineservice.com                         
I-300045   G. Kempf                937-724-7313 kempfg@free.com                                   
I-300003   C. Hague                419-890-3531                                                   
I-300039   D. Chang                740-750-1272 lion@free.com                                     

7 rows selected. 

Question 10
COUNT(DISTINCT(CUSTOMERID))
---------------------------
                          2

Question 11
COMPANYNAME                              COUNT(ADDRESS)
---------------------------------------- --------------
Baker and Company                                     1
Bankruptcy Help                                       1
R and R Air                                           1

Question 12
CUSTOMERID COMPANYNAME                              NAME                                 PHONE       
---------- ---------------------------------------- ------------------------------------ ------------
C-300031   Copy Center                              Allen Robles                         644-730-8090
I-300049                                            Paul Rice                            719-541-1837
I-300141                                            Daniel Rodkey                        719-748-3205
C-300041   Laser Graphics Associates                Paul Kaakeh                          719-750-4539
I-300021                                            Matt Smith                           719-822-8828
I-300061                                            Brenda Jones                         720-800-2638
I-300043                                            Carey Dailey                         728-896-2767
I-300073                                            Dean Eagon                           970-581-8611
I-300078                                            Andrea Griswold                      970-746-0995

9 rows selected. 

*/


