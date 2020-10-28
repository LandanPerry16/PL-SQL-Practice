--Lab06 Landan Perry

-- Question 1
CREATE TABLE PERSON_OF_INTEREST(
name varchar2(25),
company_name varchar2(30),
telephone varchar2(15),
email_address varchar2(30)
);

/
-- Question 2
select custfirstname || ' ' || custlastname, phone, emailaddr, NVL(companyname,'none on record')
from customer
union
select firstname || ' ' || lastname, homephone, emailaddr, 'Eagle Electronic'
from employee
union
select contactname, phone, emailaddr, NVL(companyname,'none on record') from supplier;

/
-- Question 3
insert into PERSON_OF_INTEREST(name,telephone, email_address, company_name)
select custfirstname || ' ' || custlastname, phone, emailaddr, NVL(companyname,'none on record')
from customer
union
select firstname || ' ' || lastname, homephone, emailaddr, 'Eagle Electronic'
from employee
union
select contactname, phone, emailaddr, NVL(companyname,'none on record') from supplier;

/
-- Question 4
update PERSON_OF_INTEREST
set email_address = 'none on record'
where email_address is null;

/

select email_address from PERSON_OF_INTEREST;

/
-- Question 5
delete from person_of_interest
where company_name = 'none on record';

/
select * from person_of_interest;

/
-- Question 6
truncate table person_of_interest;

/
select * from person_of_interest;

/
-- Question 7
CREATE TABLE COPY_CUSTOMER AS (SELECT * FROM CUSTOMER);

/
SELECT * FROM COPY_CUSTOMER;

/
-- Question 8
insert into copy_customer (customerid,companyname,custfirstname,custlastname,
custtitle,city,state) values
('Z-12345', 'Quick Stop', 'Randal', 'Graves', 'Mr.', 'Leonardo', 'NJ');

/
select * from copy_customer where customerid = 'Z-12345';

/
-- Question 9
update copy_customer set postalcode = '07737' where customerid = 'Z-12345';

/
select * from copy_customer where customerid = 'Z-12345';

/
-- Question 10
delete from copy_customer where state = 'OH';

/
select * from copy_customer;

/
-- Question 11
delete from copy_customer where customerid = 'Z-12345';

/
select * from copy_customer where customerid = 'Z-12345';

/
-- Question 12
update copy_customer set city = 'Leonardo' , state = 'NJ';

/
select * from copy_customer;

/
-- Question 13
CREATE TABLE EMPLOYEE_BOTTOM_25(
Employee_id varchar2(10),
Employee_name varchar2(35),
Job_title varchar2(35),
Salary number(9,2)
);

CREATE TABLE EMPLOYEE_TOP_10(
Employee_id varchar2(10),
Employee_name varchar2(35),
Job_title varchar2(35),
Salary number(9,2)
);

CREATE TABLE EMPLOYEE_OTHERS(
Employee_id varchar2(10),
Employee_name varchar2(35),
Job_title varchar2(35),
Salary number(9,2)
);

/
-- Question 14

insert first
when salarywage < (0.25 * (select AVG(employee.salarywage) from employee))
then into employee_bottom_25
when salarywage >= (0.9*(select (max(salarywage)-min(salarywage))+min(salarywage) from employee))
then into employee_top_10 
else into employee_others
select employeeid, firstname ||' '|| lastname, jobtitle, salarywage from employee;

/
select * from employee_bottom_25;
select * from employee_top_10;
select * from employee_others;

/
-- Question 15
DELETE from employee_bottom_25;
DELETE from employee_others;
DELETE from employee_top_10;

/
-- Question 16
CREATE TABLE EMPLOYEE_TOP_1(
Employee_id varchar2(10),
Employee_name varchar2(35),
Job_title varchar2(35),
Salary number(9,2)
);

/
-- Question 17
insert all
when salarywage < (0.25 * (select AVG(employee.salarywage) from employee))
then into employee_bottom_25
when salarywage >= (0.9*(select (max(salarywage)-min(salarywage))+min(salarywage) from employee))
then into employee_top_10
when salarywage >= (0.99*(select (max(salarywage)-min(salarywage))+min(salarywage) from employee))
then into employee_top_1
else into employee_others
select employeeid, firstname ||' '|| lastname, jobtitle, salarywage from employee;

/
select * from employee_bottom_25;
select * from employee_top_10;
select * from employee_others;
select * from employee_top_1;

/*
INSERT ALL achieves the desired result because it allows for the same employee to be inserted
into multiple tables. INSERT FIRST did not allow an employee to be in both the top 10 and top 1
tables because it only inserts into the first table that it fits into.
*/

/
-- Question 18
update employee_top_1 set salary = (select salary*1.2 from employee_top_1);
/
select * from employee_top_1;

/
-- Question 19
insert into employee_top_1 values ('101','Happy Owner','Big Boss',1000000);

/
select * from employee_top_1;

/
-- Question 20
merge into employee_top_10
using 
employee_top_1
on
(employee_top_10.employee_id = employee_top_1.employee_id)
when matched then update set employee_top_10.salary = employee_top_1.salary
when not matched then
insert values (employee_top_1.employee_id,employee_top_1.employee_name,
employee_top_1.job_title,
employee_top_1.salary);

/
select * from employee_top_10;

/
-- Question 21
DROP TABLE COPY_CUSTOMER CASCADE CONSTRAINTS;
DROP TABLE PERSON_OF_INTEREST CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_TOP_10 CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_TOP_1 CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_BOTTOM_25 CASCADE CONSTRAINTS;
DROP TABLE EMPLOYEE_OTHERS CASCADE CONSTRAINTS;

/

/* Results

Question 1
Table PERSON_OF_INTEREST created.

Question 2

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Adam Cyr                             315-474-5634 acyr@cablesany.com                                 Cables Anywhere                         
Alice Mynhier                        303-696-0557 almyn@Nway.magcomp.com                             Magic Components                        
Allen Robles                         644-730-8090 copy@onlineservice.com                             Copy Center                             
Allison Roland                       929-498-4174 alley@onlineservice.com                            none on record                          
Allison Roland                       929-498-4174                                                    Eagle Electronic                        
Amy Heide                            802-894-1024 letout@usol.com                                    Outlets                                 
Andrea Griswold                      970-746-0995 andygwold@usol.com                                 none on record                          
Andrea Montgomery                    349-397-7772                                                    none on record                          
Andrew Ray                           609-345-9680 andyray@usol.com                                   none on record                          
Andrew Smith                         709-307-2568 smokey@zeronet.net                                 none on record                          
Andrew Yelnick                       517-803-5818 family@free.com                                    none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Andy Huegel                          302-620-1366                                                    none on record                          
Angela Wainscott                     208-788-4112 awainscott@free.com                                none on record                          
Angie Hoover                         307-459-4165 ahoover@free.com                                   Goodwork Corporation                    
Anita Pastron                        901-796-4654 contracts@fast.com                                 Industrail Contracting Co               
Anna Mayton                          888-451-1233 doctor@free.com                                    none on record                          
Anne Hatzell                         302-651-6440 hazel@zeronet.net                                  none on record                          
Ansel Farrell                        712-440-3934 prickly@onlineservice.com                          none on record                          
Archie Doremski                      307-944-8959 sheetz@free.com                                    Greenpart Steet Metal                   
Aricka Bross                         419-676-9758 placetolive@free.com                               Apartment Referrals                     
Austin Ortman                        919-774-9999                                                    Eagle Electronic                        
Beth Zobitz                          919-747-8404 bzobitz@eagle.com                                  Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Bill Umbarger                        207-155-1577 cheezy@onlineservice.com                           none on record                          
Bob Weldy                            571-490-6449 sucker42@usol.com                                  none on record                          
Brad Arquette                        775-914-4294 arq@usol.com                                       none on record                          
Brenda Jones                         720-800-2638 show@free.com                                      none on record                          
Brenda Kitchel                       804-214-8732 cheesman@zeronet.net                               Cheesman Corporation                    
Brenda Pritchett                     302-696-1000 bpritchett@wizelec.com                             Wizard Electronics                      
Bridgette Kyger                      301-467-6480 homeloans@fast.com                                 Sampson Home Mortgages                  
Brittany Cottingham                  419-464-5273 plastic@onlineservice.com                          Cottingham Plastics                     
Bruce Fogarty                        598-791-1420 photoniche@usol.com                                Photography Niche                       
Bryan Price                          804-674-9666                                                    none on record                          
Calie Zollman                        929-763-2047                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Carey Dailey                         728-896-2767 shelty@usol.com                                    none on record                          
Carl Dallas                          864-541-5114 analyzeh20@fast.com                                Water Analysts                          
Carl Hague                           419-890-3531                                                    none on record                          
Carrie Buchko                        817-739-1335 goobert@free.com                                   none on record                          
Cathy Bending                        765-617-2811 rrair@zeronet.net                                  R and R Air                             
Cathy Harvey                         336-477-0249 findwork@onlineservice.com                         The Employment Agency                   
Cecil Scheetz                        207-679-9822 cecil@free.com                                     Tippe Inn                               
Charlene Franks                      307-892-2938 learn@rydell.edu                                   Rydell High School                      
Charles Jones                        919-774-5552 charlie@usol.com                                   none on record                          
Charles Jones                        919-774-5552 cjones@eagle.com                                   Eagle Electronic                        
Chas Funk                            860-498-3900 duck@usol.com                                      none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Chris Dunlap                         307-473-2281                                                    none on record                          
Christina Wilson                     316-210-8989                                                    none on record                          
Dan Lageveen                         307-344-8928 veenie@zeronet.net                                 none on record                          
Daniel Barton                        915-894-8034 dannie@zeronet.net                                 none on record                          
Daniel Ezra                          207-744-1997 swim@zeronet.net                                   Pools For You                           
Daniel Hundnall                      918-830-9731 fixit@usol.com                                     Bobs Repair Service                     
Daniel Rodkey                        719-748-3205 dannie@free.com                                    none on record                          
Daniel Stabnik                       636-746-4124                                                    none on record                          
Danita Sharp                         360-650-5604 girlfriend@fast.com                                none on record                          
Darlene Jenkins                      678-490-5461 DarJen@Germ.opticimag.com                          Optical Images                          
David Becker                         843-646-4187 BeckerDavid@Loadiu.com                             Load It Up                              

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
David Chang                          740-750-1272 lion@free.com                                      none on record                          
David Deppe                          919-747-5155                                                    Eagle Electronic                        
David Keck                           919-747-9921                                                    Eagle Electronic                        
David Schilling                      502-421-1516                                                    none on record                          
David Smith                          309-980-4350 emerald@onlineservice.com                          none on record                          
David Tarter                         518-500-0570 estate@fast.com                                    Realty Specialties                      
David Tietz                          651-912-1583 tietz@free.com                                     none on record                          
Dean Eagon                           970-581-8611                                                    none on record                          
Dean Katpally                        808-799-3727 phonecorp@usol.com                                 Phone Corporation                       
Debra Cruz                           812-547-7359 Debra@Francomp.com                                 Computer Fundamentals                   
Dennis Drazer                        253-315-4247 dollarplan@usol.com                                Financial Planning Consul               

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Dennis Eberle                        515-708-1802 deber@free.com                                     none on record                          
Dennis Mundy                         603-306-0774 rino@usol.com                                      none on record                          
Dennis Sammons                       616-544-1969 repairit@free.com                                  Gards Auto Repair                       
Don Kaleta                           724-695-2157 stud@zeronet.net                                   none on record                          
Don Torres                           706-649-6375 drill@usol.com                                     Down Deep Drilling Inc.                 
Donald Blythe                        520-486-6025 Dblythe@makenoise.com                              Make Some Noise Inc.                    
Dorlan Bresnaham                     603-497-7374 dorlan@usol.com                                    none on record                          
Dorthy Beering                       213-465-4900 dbeering@actual.com                                Actual  Computers                       
Doug Blizzard                        228-646-5114 collectit@onlineservice.com                        Collectibles Inc.                       
Dusty Jones                          674-727-0511 rr@usol.com                                        Railroad Express                        
Edna Lilley                          929-498-2840 elilley@eagle.com                                  Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Elizabeth Clark                      646-846-6232 eclark.com                                         Luxury Laptops                          
Elizabeth Derhammer                  785-970-9916 lizzy@onlineservice.com                            none on record                          
Elizabeth Henderson                  449-486-8018                                                    none on record                          
Eric Becker                          910-717-7613 daddyo@usol.com                                    none on record                          
Eric Fannon                          209-980-0812 ef@free.com                                        none on record                          
Eric Quintero                        812-805-1588 diamond@onlineservice.com                          none on record                          
Eugene Gasper                        705-580-6124 medcare@fast.com                                   Regency Hospital                        
Evelyn Cassens                       302-762-9526 dr.animal@onlineservice.com                        Vets Inc.                               
Frank Aamodt                         898-762-8741 fa@fast.com                                        Franklin Trinkets                       
Frank Malady                         574-493-0510 frankmala@zeronet.net                              none on record                          
Gabrielle Stevenson                  929-763-4873 gstevenson@eagle.com                               Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Gary German                          919-774-3325 ggerman@eagle.com                                  Eagle Electronic                        
Gary Kempf                           937-724-7313 kempfg@free.com                                    none on record                          
Gary Mikels                          505-660-9632 GaryMikels@Swiss.Alliance.com                      Networking Alliance                     
Geo Schofield                        228-480-9751 cleanit@usol.com                                   Cleaning Supply                         
George Purcell                       432-320-6905 design@zeronet.net                                 BMA Advertising Design                  
George Trenkle                       856-267-7913 cold@fast.com                                      none on record                          
Gerald Campbell                      431-087-1044 gcampbell@free.com                                 none on record                          
Ginger Xiao                          605-846-0451 acctsbryant@zeronet.net                            Bryant Accounting                       
Gordon Mayes                         207-634-1969 Gordon@den.modmagic.com                            Modem Magicians                         
Gregory Abbott                       812-447-3621 greggie@usol.com                                   Baker and Company                       
Gregory Hettinger                    929-498-7144                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Heather Wallpe                       816-433-9799 flex@onlineservice.com                             Reflexions Manufacturing                
Heather Waters                       869-741-7817 dates@free.com                                     Happytime Escort Service                
Helene Ziekart                       203-244-9192                                                    none on record                          
Hugo Gillespie                       785-981-0669 critters@free.com                                  Wadake Critters                         
Irene Poczekay                       401-461-9567                                                    none on record                          
Jack Akers                           301-454-6061 pizazz@usol.com                                    none on record                          
Jack Barrick                         786-494-4782 1natbank@free.com                                  First National Bank                     
Jack Brose                           919-486-5104                                                    Eagle Electronic                        
Jack Illingworth                     914-748-9829 illing@free.com                                    none on record                          
Jacob Richer                         425-942-3763 laugh@free.com                                     none on record                          
James Gross                          908-879-8672 jgross@fast.com                                    none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
James Jones                          971-522-5851 puffy@fast.com                                     none on record                          
James King                           207-708-3317 jamesk@usol.com                                    none on record                          
James Laake                          613-785-7063                                                    none on record                          
James Schilling                      319-429-9772                                                    none on record                          
Jamie Osman                          919-486-2519 josman@eagle.com                                   Eagle Electronic                        
Jamie Pickett                        937-147-2569 jpickett@machinemiracle.com                        Miracle Machines                        
Jamie Thompson                       706-471-1222 jthompson@onlineservice.com                        none on record                          
Jane Mumford                         270-428-5866                                                    none on record                          
Jared Meers                          701-371-1701 rehabsouth@zeronet.net                             South Street Rehabilitation             
Jason Krasner                        919-774-7920                                                    Eagle Electronic                        
Jason Laxton                         978-860-2824 coondog@usol.com                                   none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Jason Wendling                       919-774-6798 jwendling@eagle.com                                Eagle Electronic                        
Jay Hanau                            773-490-8254                                                    none on record                          
Jeff Kowaiski                        212-492-5644 equipit@usol.com                                   Quality Equipment Corp.                 
Jeffery Jordan                       509-989-9996 seeya@usol.com                                     none on record                          
Jennie Fry                           806-456-6285 Jfry@yourparts.com                                 Pick Your Parts                         
Jennifer Hundley                     304-713-3298 jenhund@fast.com                                   none on record                          
Jennifer Kmec                        443-542-1386 dancingk@free.com                                  Kelly Dance Studio                      
Jerry Mennen                         520-306-8426 mennenj@free.com                                   none on record                          
Jerry Muench                         464-669-8537 redhot@onlineservice.com                           none on record                          
Jessica Cain                         517-901-2610                                                    none on record                          
Jessica Nakamura                     605-324-2193 carsell@usol.com                                   Automart                                

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Jim Lichty                           618-847-1904 bankrupt@usol.com                                  Bankruptcy Help                         
Jim Manaugh                          919-747-5603 jmanaugh@eagle.com                                 Eagle Electronic                        
Jim Manaugh                          919-747-5603 jmanaugh@eagle.com                                 none on record                          
Jim Sokeland                         723-366-1117 employment@zeronet.net                             Powerful Employment                     
Jim Webb                             978-204-3019                                                    none on record                          
Jo Jacko                             856-752-7471                                                    none on record                          
Joan Hedden                          501-710-0658                                                    none on record                          
Joanne Rosner                        919-486-2822                                                    Eagle Electronic                        
John Garcia                          207-311-0174 jgar@onlineservice.com                             none on record                          
John McGinnis                        208-741-1963 john@zeronet.net                                   none on record                          
John Skadberg                        513-282-3919 skad@zeronet.net                                   none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Jon Clute                            480-181-8940                                                    none on record                          
Jonathon Blanco                      902-226-1858 hammer@free.com                                    none on record                          
Joseph Platt                         929-763-5228                                                    Eagle Electronic                        
Joseph Schuman                       330-209-1273                                                    none on record                          
Joshua Cole                          865-269-7782 fido@zeronet.net                                   none on record                          
Juicheng Nugent                      802-352-8923 nugent@fast.com                                    none on record                          
Kara Orze                            414-773-1017 appinc@zeronet.net                                 Appliances Inc.                         
Karen Burns                          707-598-2670 burnskaren@fast.com                                Recreation Supply                       
Karen Mangus                         863-623-0459 missright@onlineservice.com                        none on record                          
Karen Marko                          580-555-1871 marko@usol.com                                     none on record                          
Karen Randolph                       603-744-9002 cookin@zeronet.net                                 none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Kathleen Plyman                      507-543-2052 needles@onlineservice.com                          Needle Center                           
Kathleen Xolo                        929-763-5513 kxolo@eagle.com                                    Eagle Electronic                        
Kathryn Deagen                       919-747-9164                                                    Eagle Electronic                        
Kathy Gunderson                      941-330-3314                                                    none on record                          
Kelli Jones                          912-647-0391 kjoneskelli@DCI.com                                Dot Com Incorporated                    
Kelly Jordan                         727-951-7737 supplycrafts@fast.com                              Supplying Crafts                        
Kenneth Mintier                      323-673-0690 builder@usol.com                                   none on record                          
Kenneth Wilcox                       515-872-8848 kenny@onlineservice.com                            none on record                          
Kevin Jackson                        225-624-2341                                                    none on record                          
Kevin Martin                         606-677-9789 kmartin@easyaccess.com                             Easy Accessories                        
Kevin Zubarev                        208-364-3785 sign3@fast.com                                     Signs Signs Signs                       

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Kimber Spaller                       878-119-5448 mcgimmie@zero.net                                  none on record                          
Kris Shinn                           469-740-2748 shinnk@zeronet.net                                 none on record                          
Kristen Gustavel                     919-747-1530 kgustavel@eagle.com                                Eagle Electronic                        
Kristey Moore                        919-486-6765                                                    Eagle Electronic                        
Kristy Moore                         919-486-6765 fluffy@onlineservice.com                           none on record                          
Lance Andrews                        972-534-7322 LanceA@braz.monitorU.com                           Monitors for You                        
Larry Gardiner                       225-313-6268 square@onlineserveice.com                          none on record                          
Larry Osmanova                       541-905-4819 citybus@fast.com                                   City Bus Transport                      
Laura Rodgers                        929-763-0691                                                    Eagle Electronic                        
Lawrence Pullen                      644-591-3243 laurie@free.com                                    none on record                          
Linda Bowen                          605-234-4114                                                    none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Linda Hari                           270-411-2316                                                    none on record                          
Linda Li                             203-744-4677 ll@free.com                                        none on record                          
Lisa Pettry                          702-799-7272 lpett@zeronet.net                                  none on record                          
Loraine Platt                        520-475-5322 LoraineP@ComponGerm.com                            Greatest Components                     
Lou Caldwell                         606-901-1238 lucky@fast.com                                     none on record                          
Louise Cool                          208-956-0698                                                    none on record                          
Lucille Appleton                     914-497-2160 muscle@zeronet.net                                 none on record                          
Lynne Lagunes                        208-502-9976 hello@zeronet.net                                  none on record                          
Marc Williams                        435-774-4595 peanut@fast.com                                    none on record                          
Marjorie Vandermay                   308-489-1137 nam@fast com                                       National Art Museum                     
Marla Reeder                         728-442-3031 reedmar@zeronet.net                                none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Marty Fay                            501-631-3727 sparky@free.com                                    none on record                          
Mary Ann Rausch                      307-944-3324 spiritual@free.com                                 none on record                          
Mary Deets                           808-562-4081 camphere@fast.com                                  Camping Supplies                        
Mary Jo Wales                        852-441-4984 jomary@onlineservice.com                           none on record                          
Mary Uhl                             803-974-2809 mouse@fast.com                                     Flowers by Mickey                       
Matt Nakanishi                       435-710-5324 nakan@free.com                                     none on record                          
Matt Shade                           623-422-6616 shadtree@free.com                                  none on record                          
Matt Smith                           719-822-8828 matsm@fast.com                                     none on record                          
Matthew Quant                        910-577-1319 walker@onlineservice.com                           none on record                          
Meghan Tyrie                         919-747-8589 mtyrie@eagle.com                                   Eagle Electronic                        
Melissa Alvarez                      919-747-3781                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Melody Fazal                         760-877-4849 melfazal@zeronet.net                               none on record                          
Meredith Rushing                     606-608-2105 merry@free.com                                     none on record                          
Michael Abbott                       919-774-2720 mabbott@eagle.com                                  Eagle Electronic                        
Michael Emore                        352-472-1224 mikemore@usol.com                                  none on record                          
Michael Tendam                       406-424-7496 flute@usol.com                                     none on record                          
Michelle Nairn                       919-486-6919                                                    Eagle Electronic                        
Michelle Oakley                      978-514-5425 littleone@usol.com                                 none on record                          
Mike Condie                          336-211-1238 kidrec@zeronet.net                                 Kids Recreation Inc.                    
Mike Dunbar                          208-297-5374 duh@onlineservice.com                              none on record                          
Mildred Jones                        610-437-6687 compconsul@usol.com                                Computer Consultants                    
Nancy Basham                         207-422-7135                                                    none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Nicholas Albregts                    929-763-4843                                                    Eagle Electronic                        
Noemi Elston                         307-359-9514 closetoheaven@zeronet.net                          North Street Church                     
Norman Fields                        501-346-4841 catv@onlineservice.com                             The Cable Company                       
Orville Gilliland                    490-263-2957 eia@zeronet.net                                    Easy Internet Access                    
Pam Krick                            860-624-2539 pkrick@Passoc.com                                  Printing Associated                     
Patricha Underwood                   929-498-1956                                                    Eagle Electronic                        
Patricia Leong                       520-247-4141 patrice@usol.com                                   none on record                          
Patrick Bollock                      307-635-1692 pat@fast.com                                       none on record                          
Paul Eckelman                        919-486-6410 peckelman@eagle.com                                Eagle Electronic                        
Paul Kaakeh                          719-750-4539 graphit@usol.com                                   Laser Graphics Associates               
Paul Rice                            719-541-1837 paulier@onlineservice.com                          none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Paul Smith                           219-703-2277 psmith@computervideo.comq                          Computer Video                          
Paul Sullivan                        785-322-5896 sullie@zeronet.net                                 none on record                          
Peter Austin                         803-343-6063                                                    none on record                          
Phil Reece                           919-486-0649 sly@zeronet.net                                    none on record                          
Phil Reece                           919-486-0649                                                    Eagle Electronic                        
Phillip Hession                      231-711-6837 howdy@usol.com                                     none on record                          
Rachel Davis                         702-907-4818 rachdav@zeronet.net                                none on record                          
Randall Neely                        802-319-9805 storage@fast.com                                   Store It Here                           
Randolph Darling                     860-684-1620 randolph@fast.com                                  none on record                          
Randy Talauage                       347-671-2022 paintit@fast.com                                   Ceramic Supply                          
Richard Kluth                        302-296-8012 rickkluth@free.com                                 Main St. Bar and Grill                  

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Richard Scott                        304-774-2226 kick@onlineservice.com                             Karate Made Easy                        
Richard Stetler                      256-412-8112 screwball@free.com                                 none on record                          
Richard Strehle                      206-434-7305 vacation@fast.com                                  Vacation Car Rentals                    
Richard Zito                         603-787-0787 rzito@zeronet.net                                  none on record                          
Rita Bush                            919-747-4397 rbush@eagle.com                                    Eagle Electronic                        
Rob Thomas                           484-374-1998 rthomas@bestchoice.com                             Accessories and More                    
Robert Cortez                        603-442-3740                                                    none on record                          
Robert Dalury                        906-278-6446 tas@zeronet.net                                    TAS                                     
Robert Lister                        801-404-1240 fines@free.com                                     Fire Alarm Systems                      
Ronald Day                           929-763-6488                                                    Eagle Electronic                        
Ronald Miller                        734-820-2076 picky@zeronet.net                                  none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Rosemary Vanderhoff                  770-293-8783                                                    none on record                          
Roy Beer                             206-745-2584 wizzy@usol.com                                     none on record                          
Roy McGrew                           208-324-0783 grow@zeronet.net                                   none on record                          
Russ Mann                            775-549-1798 scooter@onlineservice.com                          none on record                          
Ruth Albeering                       784-444-0131 rabeering@free.com                                 none on record                          
Ruth Ball                            651-479-7538                                                    none on record                          
Ryan Stahley                         919-774-5340 rstahley@eagle.com                                 Eagle Electronic                        
Ryan Stahley                         919-774-5340 rstahley@eagle.com                                 none on record                          
Sally Valle                          972-234-2044 roi@usol.com                                       Investment Specialties                  
Sandy Goodman                        208-614-3136 Sgoodman@connex.com                                Connexions                              
Sarah McCammon                       520-438-7944 squirrel@zeronet.net                               none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Scott Gray                           484-453-7105 keepsafe@zeronet.net                               Security Installation                   
Scott Yarian                         252-310-2224 syarian@fast.com                                   none on record                          
Sean Akropolis                       907-262-4254 pickle@free.com                                    none on record                          
Sharon Rouls                         205-246-3224 irish@free.com                                     Sharons Shamrock                        
Sherman Cheswick                     929-498-8150 scheswick@eagle.com                                Eagle Electronic                        
Sherry Garling                       353-822-7623 homely@fast.com                                    Manufactured Homes Corp.                
Shirley Osborne                      706-333-7174                                                    none on record                          
Stephanie Pearl                      660-447-8319 mommyl@fast.com                                    none on record                          
Stephanie Yeinick                    573-455-4278 jewels@usol.com                                    Tuckers Jewels                          
Stephen Bird                         540-514-1415 sbird@storeit.com                                  Storage Specialties                     
Steve Cochran                        929-763-1283                                                    Eagle Electronic                        

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Steve Fulkerson                      602-129-1885 cellcall@usol.com                                  Cellular Services                       
Steve Hess                           919-486-8804                                                    Eagle Electronic                        
Steven Hickman                       919-774-4874 shickman@eagle.com                                 Eagle Electronic                        
Steven Yaun                          317-780-9804 yawn@fast.com                                      none on record                          
Susan Strong                         912-760-7840 fammed@onlineservice.com                           Family Medical Center                   
Susan Watson                         801-746-7701 mswatson@fast.com                                  none on record                          
Tammi Baldocchio                     401-989-4975                                                    none on record                          
Ted Zissa                            405-151-7445                                                    none on record                          
Terry Xu                             417-546-2570 muffin@fast.com                                    none on record                          
Thomas Wolfe                         610-365-9766 wolf@onlineservice.com                             none on record                          
Thomas Zelenka                       603-374-3706 zelenka@free.com                                   none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Thurman Mezzo                        415-967-1415 tmezzo@playingaround.com                           Playing Around                          
Tim Carlton                          203-608-3465                                                    none on record                          
Tim Leffert                          315-486-4777 trailrent@zeronet.net                              Trailor Rentals                         
Tim Parker                           315-985-4102 jeckle@onlineservice.com                           none on record                          
Tim White                            517-777-1905 twhite@networkN.com                                Network Niche                           
Timothy Neal                         704-736-9458 tneal@compAccess.com                               Computer Accessories                    
Tina Yates                           929-763-4438 tyates@eagle.com                                   Eagle Electronic                        
Todd Vigus                           919-486-7143 tvigus@eagle.com                                   Eagle Electronic                        
Tom Baker                            414-778-5640 bologna@free.com                                   none on record                          
Tom Irelan                           240-634-5581 tucker@free.com                                    none on record                          
Tom Moore                            270-692-2845 seedle@fast.com                                    none on record                          

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Tommy McFerren                       503-767-7054 mcferren@cole.com                                  Cole Sales and Associates               
Tonya Owens                          843-773-2751                                                    none on record                          
Tracy Cicholski                      601-959-1315 dixpharm@free.com                                  Dixon Pharmacy                          
Travis Camargo                       816-746-4913                                                    none on record                          
Travis Honn                          303-564-1515 thonn@radiant.com                                  Radiant Computers                       
Trevor Snuffer                       336-185-0630 snuffer@zeronet.net                                none on record                          
Trudi Antonio                        718-747-3259 toni@onlineservice.com                             none on record                          
Verna McGrew                         334-547-9329 verngrew@free.com                                  none on record                          
Wade Holle                           887-746-6174 Wade@jLi.com                                       Just Link It                            
Wade Jacobs                          803-477-5347 connernat@usol.com                                 Conner National                         
William Newlon                       909-452-4936 Wnewlon@ccs.com                                    Creative Computer Solutions             

CUSTFIRSTNAME||''||CUSTLASTNAME      PHONE        EMAILADDR                                          NVL(COMPANYNAME,'NONEONRECORD')         
------------------------------------ ------------ -------------------------------------------------- ----------------------------------------
Yauleng Depoe                        313-475-1177 ydepoe@sw.com                                      Scanning the World                      
Zach McGrew                          520-730-8494                                                    none on record                          
Zack Hill                            503-794-2322 boogie@free.com                                    none on record                          

300 rows selected. 

Question 3
300 rows inserted.

Question 4

60 rows updated.

EMAIL_ADDRESS                 
------------------------------
acyr@cablesany.com
almyn@Nway.magcomp.com
copy@onlineservice.com
alley@onlineservice.com
none on record
letout@usol.com
andygwold@usol.com
none on record
andyray@usol.com
smokey@zeronet.net
family@free.com

EMAIL_ADDRESS                 
------------------------------
none on record
awainscott@free.com
ahoover@free.com
contracts@fast.com
doctor@free.com
hazel@zeronet.net
prickly@onlineservice.com
sheetz@free.com
placetolive@free.com
none on record
bzobitz@eagle.com

EMAIL_ADDRESS                 
------------------------------
cheezy@onlineservice.com
sucker42@usol.com
arq@usol.com
show@free.com
cheesman@zeronet.net
bpritchett@wizelec.com
homeloans@fast.com
plastic@onlineservice.com
photoniche@usol.com
none on record
none on record

EMAIL_ADDRESS                 
------------------------------
shelty@usol.com
analyzeh20@fast.com
none on record
goobert@free.com
rrair@zeronet.net
findwork@onlineservice.com
cecil@free.com
learn@rydell.edu
charlie@usol.com
cjones@eagle.com
duck@usol.com

EMAIL_ADDRESS                 
------------------------------
none on record
none on record
veenie@zeronet.net
dannie@zeronet.net
swim@zeronet.net
fixit@usol.com
dannie@free.com
none on record
girlfriend@fast.com
DarJen@Germ.opticimag.com
BeckerDavid@Loadiu.com

EMAIL_ADDRESS                 
------------------------------
lion@free.com
none on record
none on record
none on record
emerald@onlineservice.com
estate@fast.com
tietz@free.com
none on record
phonecorp@usol.com
Debra@Francomp.com
dollarplan@usol.com

EMAIL_ADDRESS                 
------------------------------
deber@free.com
rino@usol.com
repairit@free.com
stud@zeronet.net
drill@usol.com
Dblythe@makenoise.com
dorlan@usol.com
dbeering@actual.com
collectit@onlineservice.com
rr@usol.com
elilley@eagle.com

EMAIL_ADDRESS                 
------------------------------
eclark.com
lizzy@onlineservice.com
none on record
daddyo@usol.com
ef@free.com
diamond@onlineservice.com
medcare@fast.com
dr.animal@onlineservice.com
fa@fast.com
frankmala@zeronet.net
gstevenson@eagle.com

EMAIL_ADDRESS                 
------------------------------
ggerman@eagle.com
kempfg@free.com
GaryMikels@Swiss.Alliance.com
cleanit@usol.com
design@zeronet.net
cold@fast.com
gcampbell@free.com
acctsbryant@zeronet.net
Gordon@den.modmagic.com
greggie@usol.com
none on record

EMAIL_ADDRESS                 
------------------------------
flex@onlineservice.com
dates@free.com
none on record
critters@free.com
none on record
pizazz@usol.com
1natbank@free.com
none on record
illing@free.com
laugh@free.com
jgross@fast.com

EMAIL_ADDRESS                 
------------------------------
puffy@fast.com
jamesk@usol.com
none on record
none on record
josman@eagle.com
jpickett@machinemiracle.com
jthompson@onlineservice.com
none on record
rehabsouth@zeronet.net
none on record
coondog@usol.com

EMAIL_ADDRESS                 
------------------------------
jwendling@eagle.com
none on record
equipit@usol.com
seeya@usol.com
Jfry@yourparts.com
jenhund@fast.com
dancingk@free.com
mennenj@free.com
redhot@onlineservice.com
none on record
carsell@usol.com

EMAIL_ADDRESS                 
------------------------------
bankrupt@usol.com
jmanaugh@eagle.com
jmanaugh@eagle.com
employment@zeronet.net
none on record
none on record
none on record
none on record
jgar@onlineservice.com
john@zeronet.net
skad@zeronet.net

EMAIL_ADDRESS                 
------------------------------
none on record
hammer@free.com
none on record
none on record
fido@zeronet.net
nugent@fast.com
appinc@zeronet.net
burnskaren@fast.com
missright@onlineservice.com
marko@usol.com
cookin@zeronet.net

EMAIL_ADDRESS                 
------------------------------
needles@onlineservice.com
kxolo@eagle.com
none on record
none on record
kjoneskelli@DCI.com
supplycrafts@fast.com
builder@usol.com
kenny@onlineservice.com
none on record
kmartin@easyaccess.com
sign3@fast.com

EMAIL_ADDRESS                 
------------------------------
mcgimmie@zero.net
shinnk@zeronet.net
kgustavel@eagle.com
none on record
fluffy@onlineservice.com
LanceA@braz.monitorU.com
square@onlineserveice.com
citybus@fast.com
none on record
laurie@free.com
none on record

EMAIL_ADDRESS                 
------------------------------
none on record
ll@free.com
lpett@zeronet.net
LoraineP@ComponGerm.com
lucky@fast.com
none on record
muscle@zeronet.net
hello@zeronet.net
peanut@fast.com
nam@fast com
reedmar@zeronet.net

EMAIL_ADDRESS                 
------------------------------
sparky@free.com
spiritual@free.com
camphere@fast.com
jomary@onlineservice.com
mouse@fast.com
nakan@free.com
shadtree@free.com
matsm@fast.com
walker@onlineservice.com
mtyrie@eagle.com
none on record

EMAIL_ADDRESS                 
------------------------------
melfazal@zeronet.net
merry@free.com
mabbott@eagle.com
mikemore@usol.com
flute@usol.com
none on record
littleone@usol.com
kidrec@zeronet.net
duh@onlineservice.com
compconsul@usol.com
none on record

EMAIL_ADDRESS                 
------------------------------
none on record
closetoheaven@zeronet.net
catv@onlineservice.com
eia@zeronet.net
pkrick@Passoc.com
none on record
patrice@usol.com
pat@fast.com
peckelman@eagle.com
graphit@usol.com
paulier@onlineservice.com

EMAIL_ADDRESS                 
------------------------------
psmith@computervideo.comq
sullie@zeronet.net
none on record
sly@zeronet.net
none on record
howdy@usol.com
rachdav@zeronet.net
storage@fast.com
randolph@fast.com
paintit@fast.com
rickkluth@free.com

EMAIL_ADDRESS                 
------------------------------
kick@onlineservice.com
screwball@free.com
vacation@fast.com
rzito@zeronet.net
rbush@eagle.com
rthomas@bestchoice.com
none on record
tas@zeronet.net
fines@free.com
none on record
picky@zeronet.net

EMAIL_ADDRESS                 
------------------------------
none on record
wizzy@usol.com
grow@zeronet.net
scooter@onlineservice.com
rabeering@free.com
none on record
rstahley@eagle.com
rstahley@eagle.com
roi@usol.com
Sgoodman@connex.com
squirrel@zeronet.net

EMAIL_ADDRESS                 
------------------------------
keepsafe@zeronet.net
syarian@fast.com
pickle@free.com
irish@free.com
scheswick@eagle.com
homely@fast.com
none on record
mommyl@fast.com
jewels@usol.com
sbird@storeit.com
none on record

EMAIL_ADDRESS                 
------------------------------
cellcall@usol.com
none on record
shickman@eagle.com
yawn@fast.com
fammed@onlineservice.com
mswatson@fast.com
none on record
none on record
muffin@fast.com
wolf@onlineservice.com
zelenka@free.com

EMAIL_ADDRESS                 
------------------------------
tmezzo@playingaround.com
none on record
trailrent@zeronet.net
jeckle@onlineservice.com
twhite@networkN.com
tneal@compAccess.com
tyates@eagle.com
tvigus@eagle.com
bologna@free.com
tucker@free.com
seedle@fast.com

EMAIL_ADDRESS                 
------------------------------
mcferren@cole.com
none on record
dixpharm@free.com
none on record
thonn@radiant.com
snuffer@zeronet.net
toni@onlineservice.com
verngrew@free.com
Wade@jLi.com
connernat@usol.com
Wnewlon@ccs.com

EMAIL_ADDRESS                 
------------------------------
ydepoe@sw.com
none on record
boogie@free.com

300 rows selected. 

Question 5
157 rows deleted.


NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Adam Cyr                  Cables Anywhere                315-474-5634    acyr@cablesany.com            
Alice Mynhier             Magic Components               303-696-0557    almyn@Nway.magcomp.com        
Allen Robles              Copy Center                    644-730-8090    copy@onlineservice.com        
Allison Roland            Eagle Electronic               929-498-4174    none on record                
Amy Heide                 Outlets                        802-894-1024    letout@usol.com               
Angie Hoover              Goodwork Corporation           307-459-4165    ahoover@free.com              
Anita Pastron             Industrail Contracting Co      901-796-4654    contracts@fast.com            
Archie Doremski           Greenpart Steet Metal          307-944-8959    sheetz@free.com               
Aricka Bross              Apartment Referrals            419-676-9758    placetolive@free.com          
Austin Ortman             Eagle Electronic               919-774-9999    none on record                
Beth Zobitz               Eagle Electronic               919-747-8404    bzobitz@eagle.com             

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Brenda Kitchel            Cheesman Corporation           804-214-8732    cheesman@zeronet.net          
Brenda Pritchett          Wizard Electronics             302-696-1000    bpritchett@wizelec.com        
Bridgette Kyger           Sampson Home Mortgages         301-467-6480    homeloans@fast.com            
Brittany Cottingham       Cottingham Plastics            419-464-5273    plastic@onlineservice.com     
Bruce Fogarty             Photography Niche              598-791-1420    photoniche@usol.com           
Calie Zollman             Eagle Electronic               929-763-2047    none on record                
Carl Dallas               Water Analysts                 864-541-5114    analyzeh20@fast.com           
Cathy Bending             R and R Air                    765-617-2811    rrair@zeronet.net             
Cathy Harvey              The Employment Agency          336-477-0249    findwork@onlineservice.com    
Cecil Scheetz             Tippe Inn                      207-679-9822    cecil@free.com                
Charlene Franks           Rydell High School             307-892-2938    learn@rydell.edu              

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Charles Jones             Eagle Electronic               919-774-5552    cjones@eagle.com              
Daniel Ezra               Pools For You                  207-744-1997    swim@zeronet.net              
Daniel Hundnall           Bobs Repair Service            918-830-9731    fixit@usol.com                
Darlene Jenkins           Optical Images                 678-490-5461    DarJen@Germ.opticimag.com     
David Becker              Load It Up                     843-646-4187    BeckerDavid@Loadiu.com        
David Deppe               Eagle Electronic               919-747-5155    none on record                
David Keck                Eagle Electronic               919-747-9921    none on record                
David Tarter              Realty Specialties             518-500-0570    estate@fast.com               
Dean Katpally             Phone Corporation              808-799-3727    phonecorp@usol.com            
Debra Cruz                Computer Fundamentals          812-547-7359    Debra@Francomp.com            
Dennis Drazer             Financial Planning Consul      253-315-4247    dollarplan@usol.com           

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Dennis Sammons            Gards Auto Repair              616-544-1969    repairit@free.com             
Don Torres                Down Deep Drilling Inc.        706-649-6375    drill@usol.com                
Donald Blythe             Make Some Noise Inc.           520-486-6025    Dblythe@makenoise.com         
Dorthy Beering            Actual  Computers              213-465-4900    dbeering@actual.com           
Doug Blizzard             Collectibles Inc.              228-646-5114    collectit@onlineservice.com   
Dusty Jones               Railroad Express               674-727-0511    rr@usol.com                   
Edna Lilley               Eagle Electronic               929-498-2840    elilley@eagle.com             
Elizabeth Clark           Luxury Laptops                 646-846-6232    eclark.com                    
Eugene Gasper             Regency Hospital               705-580-6124    medcare@fast.com              
Evelyn Cassens            Vets Inc.                      302-762-9526    dr.animal@onlineservice.com   
Frank Aamodt              Franklin Trinkets              898-762-8741    fa@fast.com                   

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Gabrielle Stevenson       Eagle Electronic               929-763-4873    gstevenson@eagle.com          
Gary German               Eagle Electronic               919-774-3325    ggerman@eagle.com             
Gary Mikels               Networking Alliance            505-660-9632    GaryMikels@Swiss.Alliance.com 
Geo Schofield             Cleaning Supply                228-480-9751    cleanit@usol.com              
George Purcell            BMA Advertising Design         432-320-6905    design@zeronet.net            
Ginger Xiao               Bryant Accounting              605-846-0451    acctsbryant@zeronet.net       
Gordon Mayes              Modem Magicians                207-634-1969    Gordon@den.modmagic.com       
Gregory Abbott            Baker and Company              812-447-3621    greggie@usol.com              
Gregory Hettinger         Eagle Electronic               929-498-7144    none on record                
Heather Wallpe            Reflexions Manufacturing       816-433-9799    flex@onlineservice.com        
Heather Waters            Happytime Escort Service       869-741-7817    dates@free.com                

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Hugo Gillespie            Wadake Critters                785-981-0669    critters@free.com             
Jack Barrick              First National Bank            786-494-4782    1natbank@free.com             
Jack Brose                Eagle Electronic               919-486-5104    none on record                
Jamie Osman               Eagle Electronic               919-486-2519    josman@eagle.com              
Jamie Pickett             Miracle Machines               937-147-2569    jpickett@machinemiracle.com   
Jared Meers               South Street Rehabilitation    701-371-1701    rehabsouth@zeronet.net        
Jason Krasner             Eagle Electronic               919-774-7920    none on record                
Jason Wendling            Eagle Electronic               919-774-6798    jwendling@eagle.com           
Jeff Kowaiski             Quality Equipment Corp.        212-492-5644    equipit@usol.com              
Jennie Fry                Pick Your Parts                806-456-6285    Jfry@yourparts.com            
Jennifer Kmec             Kelly Dance Studio             443-542-1386    dancingk@free.com             

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Jessica Nakamura          Automart                       605-324-2193    carsell@usol.com              
Jim Lichty                Bankruptcy Help                618-847-1904    bankrupt@usol.com             
Jim Manaugh               Eagle Electronic               919-747-5603    jmanaugh@eagle.com            
Jim Sokeland              Powerful Employment            723-366-1117    employment@zeronet.net        
Joanne Rosner             Eagle Electronic               919-486-2822    none on record                
Joseph Platt              Eagle Electronic               929-763-5228    none on record                
Kara Orze                 Appliances Inc.                414-773-1017    appinc@zeronet.net            
Karen Burns               Recreation Supply              707-598-2670    burnskaren@fast.com           
Kathleen Plyman           Needle Center                  507-543-2052    needles@onlineservice.com     
Kathleen Xolo             Eagle Electronic               929-763-5513    kxolo@eagle.com               
Kathryn Deagen            Eagle Electronic               919-747-9164    none on record                

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Kelli Jones               Dot Com Incorporated           912-647-0391    kjoneskelli@DCI.com           
Kelly Jordan              Supplying Crafts               727-951-7737    supplycrafts@fast.com         
Kevin Martin              Easy Accessories               606-677-9789    kmartin@easyaccess.com        
Kevin Zubarev             Signs Signs Signs              208-364-3785    sign3@fast.com                
Kristen Gustavel          Eagle Electronic               919-747-1530    kgustavel@eagle.com           
Kristey Moore             Eagle Electronic               919-486-6765    none on record                
Lance Andrews             Monitors for You               972-534-7322    LanceA@braz.monitorU.com      
Larry Osmanova            City Bus Transport             541-905-4819    citybus@fast.com              
Laura Rodgers             Eagle Electronic               929-763-0691    none on record                
Loraine Platt             Greatest Components            520-475-5322    LoraineP@ComponGerm.com       
Marjorie Vandermay        National Art Museum            308-489-1137    nam@fast com                  

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Mary Deets                Camping Supplies               808-562-4081    camphere@fast.com             
Mary Uhl                  Flowers by Mickey              803-974-2809    mouse@fast.com                
Meghan Tyrie              Eagle Electronic               919-747-8589    mtyrie@eagle.com              
Melissa Alvarez           Eagle Electronic               919-747-3781    none on record                
Michael Abbott            Eagle Electronic               919-774-2720    mabbott@eagle.com             
Michelle Nairn            Eagle Electronic               919-486-6919    none on record                
Mike Condie               Kids Recreation Inc.           336-211-1238    kidrec@zeronet.net            
Mildred Jones             Computer Consultants           610-437-6687    compconsul@usol.com           
Nicholas Albregts         Eagle Electronic               929-763-4843    none on record                
Noemi Elston              North Street Church            307-359-9514    closetoheaven@zeronet.net     
Norman Fields             The Cable Company              501-346-4841    catv@onlineservice.com        

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Orville Gilliland         Easy Internet Access           490-263-2957    eia@zeronet.net               
Pam Krick                 Printing Associated            860-624-2539    pkrick@Passoc.com             
Patricha Underwood        Eagle Electronic               929-498-1956    none on record                
Paul Eckelman             Eagle Electronic               919-486-6410    peckelman@eagle.com           
Paul Kaakeh               Laser Graphics Associates      719-750-4539    graphit@usol.com              
Paul Smith                Computer Video                 219-703-2277    psmith@computervideo.comq     
Phil Reece                Eagle Electronic               919-486-0649    none on record                
Randall Neely             Store It Here                  802-319-9805    storage@fast.com              
Randy Talauage            Ceramic Supply                 347-671-2022    paintit@fast.com              
Richard Kluth             Main St. Bar and Grill         302-296-8012    rickkluth@free.com            
Richard Scott             Karate Made Easy               304-774-2226    kick@onlineservice.com        

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Richard Strehle           Vacation Car Rentals           206-434-7305    vacation@fast.com             
Rita Bush                 Eagle Electronic               919-747-4397    rbush@eagle.com               
Rob Thomas                Accessories and More           484-374-1998    rthomas@bestchoice.com        
Robert Dalury             TAS                            906-278-6446    tas@zeronet.net               
Robert Lister             Fire Alarm Systems             801-404-1240    fines@free.com                
Ronald Day                Eagle Electronic               929-763-6488    none on record                
Ryan Stahley              Eagle Electronic               919-774-5340    rstahley@eagle.com            
Sally Valle               Investment Specialties         972-234-2044    roi@usol.com                  
Sandy Goodman             Connexions                     208-614-3136    Sgoodman@connex.com           
Scott Gray                Security Installation          484-453-7105    keepsafe@zeronet.net          
Sharon Rouls              Sharons Shamrock               205-246-3224    irish@free.com                

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Sherman Cheswick          Eagle Electronic               929-498-8150    scheswick@eagle.com           
Sherry Garling            Manufactured Homes Corp.       353-822-7623    homely@fast.com               
Stephanie Yeinick         Tuckers Jewels                 573-455-4278    jewels@usol.com               
Stephen Bird              Storage Specialties            540-514-1415    sbird@storeit.com             
Steve Cochran             Eagle Electronic               929-763-1283    none on record                
Steve Fulkerson           Cellular Services              602-129-1885    cellcall@usol.com             
Steve Hess                Eagle Electronic               919-486-8804    none on record                
Steven Hickman            Eagle Electronic               919-774-4874    shickman@eagle.com            
Susan Strong              Family Medical Center          912-760-7840    fammed@onlineservice.com      
Thurman Mezzo             Playing Around                 415-967-1415    tmezzo@playingaround.com      
Tim Leffert               Trailor Rentals                315-486-4777    trailrent@zeronet.net         

NAME                      COMPANY_NAME                   TELEPHONE       EMAIL_ADDRESS                 
------------------------- ------------------------------ --------------- ------------------------------
Tim White                 Network Niche                  517-777-1905    twhite@networkN.com           
Timothy Neal              Computer Accessories           704-736-9458    tneal@compAccess.com          
Tina Yates                Eagle Electronic               929-763-4438    tyates@eagle.com              
Todd Vigus                Eagle Electronic               919-486-7143    tvigus@eagle.com              
Tommy McFerren            Cole Sales and Associates      503-767-7054    mcferren@cole.com             
Tracy Cicholski           Dixon Pharmacy                 601-959-1315    dixpharm@free.com             
Travis Honn               Radiant Computers              303-564-1515    thonn@radiant.com             
Wade Holle                Just Link It                   887-746-6174    Wade@jLi.com                  
Wade Jacobs               Conner National                803-477-5347    connernat@usol.com            
William Newlon            Creative Computer Solutions    909-452-4936    Wnewlon@ccs.com               
Yauleng Depoe             Scanning the World             313-475-1177    ydepoe@sw.com                 

143 rows selected. 

Question 6
Table PERSON_OF_INTEREST truncated.

no rows selected


Question 7

Table COPY_CUSTOMER created.


CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300051                                            Lynne           Lagunes              Ms.   2820 Beechmont Ave.                      Pocatello            ID 83209      208-502-9976              hello@zeronet.net                                 
I-300052                                            Andrew          Yelnick              Mr.   6972 Winton Rd.                          Detroit              MI 48226      517-803-5818              family@free.com                                   
I-300053                                            Stephanie       Pearl                Mrs.  6460 Springdale Rd.                      Maryville            MO 64468      660-447-8319              mommyl@fast.com                                   
I-300054                                            Dorlan          Bresnaham            Dr.   1328 Mill Ave.                           Plymouth             NH 03264      603-497-7374              dorlan@usol.com                                   
I-300055                                            Jon             Clute                Dr.   1680 River Oaks Blvd.                    Tucson               AZ 85711      480-181-8940                                                                
I-300056                                            Elizabeth       Henderson            Ms.   2819 Otay Rd.                            Zeona                SD 57758      449-486-8018                                                                
I-300057                                            Tonya           Owens                Mrs.  1414 Fields Ertel Rd.                    Abbeville            SC 29620      843-773-2751                                                                
I-300058                                            Matthew         Quant                Mr.   253 Silver Creek Rd.                     Hamlet               NC 28345      910-577-1319              walker@onlineservice.com                          
I-300059                                            Kenneth         Mintier              Mr.   4831 Skeet Blvd.                         Eureka               CA 95534      323-673-0690              builder@usol.com                                  
I-300060                                            Lucille         Appleton             Ms.   5260 Blue Mound Rd.                      Newburgh             NY 12553      914-497-2160              muscle@zeronet.net                                
I-300061                                            Brenda          Jones                Mrs.  3696 Cooper St.                          Aurora               CO 80230      720-800-2638              show@free.com                                     

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300062                                            John            McGinnis             Dr.   7841 Hurst Blvd.                         Preston              ID 83263      208-741-1963              john@zeronet.net                                  
I-300063                                            Dennis          Eberle               Mr.   9425 James Rd.                           Waterloo             IA 50707      515-708-1802              deber@free.com                                    
I-300064                                            Jo              Jacko                Mrs.  6588 Ken Caryl Rd.                       Vineland             NJ 08361      856-752-7471                                                                
I-300065                                            Karen           Randolph             Ms.   1038 Coal Mine Rd.                       Franklin             NH 03235      603-744-9002              cookin@zeronet.net                                
I-300066                                            Ruth            Ball                 Dr.   1093 Valley View Ln.                     St. Cloud            MN 56387      651-479-7538                                                                
I-300067                                            Travis          Camargo              Mr.   6681 Forrest Ln.                         Neosho               MO 64853      816-746-4913                                                                
I-300068                                            Jerry           Muench               Mr.   1694 Stone Valley Rd.                    Miami                TX 79059      464-669-8537              redhot@onlineservice.com                          
I-300069                                            Verna           McGrew               Ms.   4755 Rocket Blvd.                        Huntsville           AL 35811      334-547-9329              verngrew@free.com                                 
I-300070                                            Elizabeth       Derhammer            Ms.   2343 Pioneer Pkwy.                       Garden City          KS 67868      785-970-9916              lizzy@onlineservice.com                           
I-300071                                            Ted             Zissa                Mr.   4935 Cedar Hill Rd.                      Ardmore              OK 73402      405-151-7445                                                                
I-300072                                            Matt            Shade                Mr.   8441 Skillman Ave.                       Green Valley         AZ 85622      623-422-6616              shadtree@free.com                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300073                                            Dean            Eagon                Mr..  616 Burton Rd.                           Peublo               CO 81011      970-581-8611                                                                
I-300074                                            Andrew          Ray                  Mr.   1246 Ferry St.                           Millville            NJ 08332      609-345-9680              andyray@usol.com                                  
I-300075                                            Robert          Cortez               Mr.   219 Pleasant Run Rd.                     Keene                NH 03435      603-442-3740                                                                
I-300076                                            Tim             Carlton              Mr.   1038 Lancaster St.                       Enfield              CT 06082      203-608-3465                                                                
I-300077                                            Jennifer        Hundley              Mrs.  6354 Buckner Blvd.                       Richwood             WV 26261      304-713-3298              jenhund@fast.com                                  
I-300078                                            Andrea          Griswold             Dr.   8215 Garland Rd.                         Leadville            CO 80429      970-746-0995              andygwold@usol.com                                
I-300079                                            Christina       Wilson               Mrs.  5766 Scyene Rd.                          Pratt                KS 67124      316-210-8989                                                                
I-300080                                            Juicheng        Nugent               Mr.   9443 Illinois Ave.                       Springfield          VT 05156      802-352-8923              nugent@fast.com                                   
I-300081                                            Bryan           Price                Mr.   1745 Best Line Rd.                       Hampton              VA 23666      804-674-9666                                                                
I-300082                                            Helene          Ziekart              Mrs.  9533 Simonds Rd.                         New Haven            CT 06511      203-244-9192                                                                
I-300083                                            Marty           Fay                  Ms.   9241 School Rd.                          Fairbanks            AK 99775      501-631-3727              sparky@free.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300084                                            Lisa            Pettry               Mrs.  8515 Cossell Ave.                        Carson City          NV 89714      702-799-7272              lpett@zeronet.net                                 
I-300085                                            Zach            McGrew               Mr.   5788 Rockville Rd.                       Globe                AZ 85502      520-730-8494                                                                
I-300086                                            Jamie           Thompson             Ms.   6878 Holt Ave.                           Athens               GA 30606      706-471-1222              jthompson@onlineservice.com                       
I-300087                                            Charles         Jones                Mr.   1420 N. Highland Ave.                    Grand                FL 33606      919-774-5552              charlie@usol.com                                  
I-300088                                            Thomas          Zelenka              Dr.   5371 Brookeville Rd.                     Manchester           NH 03108      603-374-3706              zelenka@free.com                                  
I-300089                                            James           Laake                Mr.   3434 Great Street                        Aladdin              WY 82710      613-785-7063                                                                
I-300090                                            Daniel          Stabnik              Mr.   3745 35th St.                            Perryville           MO 63775      636-746-4124                                                                
I-300091                                            Trudi           Antonio              Ms.   9882 Strother Rd.                        Potsdam              NY 13699      718-747-3259              toni@onlineservice.com                            
I-300092                                            John            Garcia               Mr.   231 63rd St.                             Portland             ME 04122      207-311-0174              jgar@onlineservice.com                            
I-300093                                            Jay             Hanau                Mr.   5897 Sunset Rd.                          Marion               IL 62959      773-490-8254                                                                
I-300094                                            Joseph          Schuman              Dr.   5893 Warm Springs Rd.                    Akron                OH 44304      330-209-1273                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300095                                            Joshua          Cole                 Mr.   7903 Paradise Rd.                        Jackson              TN 38308      865-269-7782              fido@zeronet.net                                  
I-300096                                            David           Schilling            Mr.   8671 Chapel Rd.                          Bowling Green        KY 42102      502-421-1516                                                                
I-300097                                            Mary Ann        Rausch               Mrs.  3679 Western Ave.                        Green River          WY 82938      307-944-3324              spiritual@free.com                                
I-300098                                            Allison         Roland               Mrs.  4599 S. Maodill Ave.                     Palma                FL 33604      929-498-4174              alley@onlineservice.com                           
I-300099                                            Roy             Beer                 Mr.   8065 Colina Rd.                          Yakima               WA 98907      206-745-2584              wizzy@usol.com                                    
I-300100                                            Chris           Dunlap               Mrs.  3526 10th St.                            Gillette             WY 82731      307-473-2281                                                                
I-300101                                            Ansel           Farrell              Mr.   316 Birch St.                            Storm Lake           IA 50588      712-440-3934              prickly@onlineservice.com                         
I-300102                                            Jason           Laxton               Mr.   7858 Dowling Ave. N.                     Athol                MA 01368      978-860-2824              coondog@usol.com                                  
I-300103                                            Larry           Gardiner             Mr.   1739 W 39th St.                          Winnsboro            LA 71295      225-313-6268              square@onlineserveice.com                         
I-300104                                            Lawrence        Pullen               Mr.   4599 Rheem Blvd.                         Greenbush            MN 56726      644-591-3243              laurie@free.com                                   
I-300105                                            Matt            Nakanishi            Mr.   8108 Middle Rd.                          Price                UT 84501      435-710-5324              nakan@free.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300106                                            Nancy           Basham               Mrs.  3409 36th Ave. N.                        Dexter               ME 04930      207-422-7135                                                                
I-300107                                            Rachel          Davis                Ms.   2954 Cedar Lake Rd.                      Reno                 NV 89523      702-907-4818              rachdav@zeronet.net                               
I-300108                                            Sarah           McCammon             Mrs.  3216 Dimond Lake Rd.                     Kingman              AZ 86411      520-438-7944              squirrel@zeronet.net                              
I-300109                                            David           Tietz                Mr.   5235 E. 44th St.                         Montevideo           MN 56265      651-912-1583              tietz@free.com                                    
I-300110                                            Jim             Manaugh              Mr.   1011 W. Hillsborough Ave.                Garyville            FL 33605      919-747-5603              jmanaugh@eagle.com                                
I-300111                                            Richard         Stetler              Mr.   7496 University Ave.                     Auburn               AL 36832      256-412-8112              screwball@free.com                                
I-300112                                            Jonathon        Blanco               Mr.   8095 Mounty Rd.                          Oshkosh              WI 54904      902-226-1858              hammer@free.com                                   
I-300113                                            Randolph        Darling              Mr.   8254 Coral Way                           Putnam               CT 06260      860-684-1620              randolph@fast.com                                 
I-300114                                            Melody          Fazal                Mrs.  4603 Killian Rd.                         Bakersfield          CA 93311      760-877-4849              melfazal@zeronet.net                              
I-300115                                            Michael         Tendam               Dr.   190 Dixie St.                            Glasgow              MT 592331     406-424-7496              flute@usol.com                                    
I-300116                                            Sean            Akropolis            Mr.   6603 E. Little Yak Rd.                   Anchorage            AK 99509      907-262-4254              pickle@free.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300117                                            Anne            Hatzell              Ms.   5200 Belfat Blvd.                        Seaford              DE 19973      302-651-6440              hazel@zeronet.net                                 
I-300118                                            Meredith        Rushing              Dr.   1856 Cullen Blvd.                        Lexington            KY 40516      606-608-2105              merry@free.com                                    
I-300119                                            John            Skadberg             Mr.   7577 Holmes Rd.                          Findlay              OH 45840      513-282-3919              skad@zeronet.net                                  
I-300120                                            Zack            Hill                 Mr.   2064 Preston Rd.                         Winston              OR 97496      503-794-2322              boogie@free.com                                   
I-300121                                            Dan             Lageveen             Mr.   3056 Southern Ave. N.                    Laramie              WY 82073      307-344-8928              veenie@zeronet.net                                
I-300122                                            Marla           Reeder               Mrs.  1029 Moraga Ave. W.                      Bonifay              FL 32425      728-442-3031              reedmar@zeronet.net                               
I-300123                                            Linda           Bowen                Mrs.  5541 Bell Rd.                            Huron                SD 57350      605-234-4114                                                                
I-300124                                            Michael         Emore                Mr.   7347 Peoria Ave.                         Orlando              FL 32810      352-472-1224              mikemore@usol.com                                 
I-300125                                            Mary Jo         Wales                Dr.   1416 Wynnewood Ave.                      Wallowa              OR 97885      852-441-4984              jomary@onlineservice.com                          
I-300126                                            Tom             Moore                Mr.   7742 Glendale Ave.                       Morehead             KY 04351      270-692-2845              seedle@fast.com                                   
I-300127                                            Susan           Watson               Mrs.  6151 Indian School Rd.                   Ogden                UT 84414      801-746-7701              mswatson@fast.com                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300128                                            Tom             Irelan               Mr.   7833 McDowell Rd.                        Cumberland           MD 21503      240-634-5581              tucker@free.com                                   
I-300129                                            Rosemary        Vanderhoff           Dr.   843 99th St.                             Macon                GA 31206      770-293-8783                                                                
I-300130                                            Mike            Dunbar               Mr.   1750 Broadway St.                        Grangeville          ID 83531      208-297-5374              duh@onlineservice.com                             
I-300131                                            Ryan            Stahley              Mr.   9281 E. Bird St.                         Grand                FL 33606      919-774-5340              rstahley@eagle.com                                
I-300132                                            Patricia        Leong                Ms.   6213 Baseline Rd.                        Prescott             AZ 86313      520-247-4141              patrice@usol.com                                  
I-300133                                            Roy             McGrew               Mr.   1968 Elliot Rd.                          Nampa                ID 83686      208-324-0783              grow@zeronet.net                                  
I-300134                                            Tom             Baker                Mr.   483 Greenway St.                         Sparta               WI 54656      414-778-5640              bologna@free.com                                  
I-300135                                            Bill            Umbarger             Mr.   1476 Eastern Pkwy.                       Belfast              ME 04915      207-155-1577              cheezy@onlineservice.com                          
I-300136                                            Bob             Weldy                Mr.   8227 Oak Ridge Rd.                       Lynchburg            VA 24506      571-490-6449              sucker42@usol.com                                 
I-300137                                            Kris            Shinn                Dr.   7451 Tiden St.                           Pecos                TX 79772      469-740-2748              shinnk@zeronet.net                                
I-300138                                            James           King                 Dr.   2734 Mulga Loop Rd.                      Lincoln              ME 04457      207-708-3317              jamesk@usol.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300139                                            Frank           Malady               Mr.   7894 Geary Blvd.                         Nahunta              GA 31533      574-493-0510              frankmala@zeronet.net                             
I-300140                                            Jim             Webb                 Mr.   3577 Hessian Ave.                        Lowell               MA 01853      978-204-3019                                                                
I-300141                                            Daniel          Rodkey               Ms.   4024 Mill Plain Blvd.                    Lamar                CO 81052      719-748-3205              dannie@free.com                                   
I-300142                                            Marc            Williams             Mr.   8443 15th St.                            Cedar City           VT 84721      435-774-4595              peanut@fast.com                                   
I-300143                                            Kristy          Moore                Ms.   4410 W. Spruce St.                       Fort Sutton          FL 33603      919-486-6765              fluffy@onlineservice.com                          
I-300144                                            Russ            Mann                 Mr.   6879 Island Ave.                         Las Vegas            NV 89199      775-549-1798              scooter@onlineservice.com                         
I-300145                                            Carrie          Buchko               Mrs.  3793 Leheigh Ave.                        Jasper               TX 75951      817-739-1335              goobert@free.com                                  
I-300146                                            Michelle        Oakley               Ms.   5348 Elmwood Ave.                        Brockton             MA 02303      978-514-5425              littleone@usol.com                                
I-300147                                            Steven          Yaun                 Mr.   4711 Hook Rd.                            Indianapolis         IN 46208      317-780-9804              yawn@fast.com                                     
I-300148                                            Jack            Illingworth          Mr.   2741 Ashland Ave.                        Buffalo              NY 14206      914-748-9829              illing@free.com                                   
I-300149                                            Thomas          Wolfe                Mr.   7347 Broad St.                           Scranton             PA 18510      610-365-9766              wolf@onlineservice.com                            

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300150                                            Irene           Poczekay             Mrs.  7000 W. 7th St.                          Newport              RI 02840      401-461-9567                                                                
I-300151                                            Andy            Huegel               Dr.   7542 Haverford Blvd.                     Milford              DE 19963      302-620-1366                                                                
I-300152                                            Karen           Marko                Ms.   4954 Clifton Rd.                         Lawton               OK 73506      580-555-1871              marko@usol.com                                    
I-300153                                            Trevor          Snuffer              Mr.   6550 Forbes Ave.                         Rocky Mount          NC 27803      336-185-0630              snuffer@zeronet.net                               
I-300154                                            Phil            Reece                Mr.   1204 N. Nebraska Ave.                    Fort Sutton          FL 33603      919-486-0649              sly@zeronet.net                                   
I-300155                                            Linda           Hari                 Mrs.  791 McKnight Rd.                         Franklin             KY 42134      270-411-2316                                                                
I-300156                                            Andrew          Smith                Mr.   1244 Fremont Ave.                        Tribune              KS 67879      709-307-2568              smokey@zeronet.net                                
I-300157                                            Linda           Li                   Ms.   5920 Grove St.                           Torrington           CT 06790      203-744-4677              ll@free.com                                       
C-300001   Baker and Company                        Gregory         Abbott               Mr.   7837 Busse Rd.                           Terre Haute          IN 47813      812-447-3621 812-447-4602 greggie@usol.com                                  
C-300002   Cole Sales and Associates                Tommy           McFerren             Dr.   3817 Farrell Rd.                         Bend                 OR 97709      503-767-7054 503-767-3394 mcferren@cole.com                                 
C-300003   Tippe Inn                                Cecil           Scheetz              Ms.   391 Weber Rd.                            Waterville           ME 04903      207-679-9822 207-679-6367 cecil@free.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300004   Franklin Trinkets                        Frank           Aamodt               Mr.   3304 Leredo Ave.                         New Milford          CT 06776      898-762-8741 898-762-9493 fa@fast.com                                       
C-300005   Needle Center                            Kathleen        Plyman               Ms.   7627 Belmont Ave                         New York City        NY 10131      507-543-2052 507-543-1845 needles@onlineservice.com                         
C-300006   BMA Advertising Design                   George          Purcell              Mr.   4281 Jefferson Rd.                       Scranton             PA 18522      432-320-6905 432-320-5741 design@zeronet.net                                
C-300007   Regency Hospital                         Eugene          Gasper               Mr.   7022 Ward Lake Rd.                       Barre                VT 05641      705-580-6124 705-580-4250 medcare@fast.com                                  
C-300008   South Street Rehabilitation              Jared           Meers                Mr.   4271 Airport Rd.                         Grand Forks          ND 58026      701-371-1701 701-371-1372 rehabsouth@zeronet.net                            
C-300009   Dixon Pharmacy                           Tracy           Cicholski            Mrs.  1920 Albion St.                          Crystal Springs      MS 39059      601-959-1315 601-959-4277 dixpharm@free.com                                 
C-300010   Photography Niche                        Bruce           Fogarty              Mr.   1012 Island Ave.                         Ellenboro            WV 26346      598-791-1420 598-791-8582 photoniche@usol.com                               
C-300011   Family Medical Center                    Susan           Strong               Mrs.  5883 Sudbury Rd.                         Adel                 GA 31620      912-760-7840 912-760-8489 fammed@onlineservice.com                          
C-300012   Bryant Accounting                        Ginger          Xiao                 Mrs.  6636 Walnut St.                          Rapid City           SD 57703      605-846-0451 605-846-5219 acctsbryant@zeronet.net                           
C-300013   Recreation Supply                        Karen           Burns                Dr.   2850 Farm St.                            Modesto              CA 95354      707-598-2670 707-598-3072 burnskaren@fast.com                               
C-300014   R and R Air                              Cathy           Bending              Mrs.  9573 Chestnut St.                        Evansville           IN 47732      765-617-2811 765-617-5319 rrair@zeronet.net                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300015   Vets Inc.                                Evelyn          Cassens              Ms.   6094 Pearson St.                         Newark               DE 19726      302-762-9526 302-762-3338 dr.animal@onlineservice.com                       
C-300016   Goodwork Corporation                     Angie           Hoover               Ms.   6427 Genesee St.                         Casper               WY 82638      307-459-4165 307-459-2606 ahoover@free.com                                  
C-300017   Powerful Employment                      Jim             Sokeland             Mr.   6671 Pearl Rd.                           Reisterstown         MD 21136      723-366-1117 723-366-0896 employment@zeronet.net                            
C-300018   Wadake Critters                          Hugo            Gillespie            Mr.   4194 Northfield Rd.                      Salina               KS 67402      785-981-0669 785-981-6634 critters@free.com                                 
C-300019   Conner National                          Wade            Jacobs               Ms.   2610 E. Lake Rd.                         Scranton             ND 58653      803-477-5347 803-477-5487 connernat@usol.com                                
C-300020   Cottingham Plastics                      Brittany        Cottingham           Ms.   4234 Taylor Rd.                          Lima                 OH 45819      419-464-5273 419-464-7239 plastic@onlineservice.com                         
C-300021   Realty Specialties                       David           Tarter               Mr.   6274 Blue Rock Rd.                       Syracuse             NY 13261      518-500-0570 518-500-6159 estate@fast.com                                   
C-300022   Reflexions Manufacturing                 Heather         Wallpe               Ms.   4128 Hulen St.                           Park Hills           MO 63653      816-433-9799 816-433-3621 flex@onlineservice.com                            
C-300023   TAS                                      Robert          Dalury               Mr.   4718 Pleasant Valley Rd.                 Bay City             MI 48708      906-278-6446 906-278-4345 tas@zeronet.net                                   
C-300024   Bankruptcy Help                          Jim             Lichty               Mr.   5991 Kenwood Rd.                         Chicago              IL 60624      618-847-1904 618-847-6439 bankrupt@usol.com                                 
C-300025   Railroad Express                         Dusty           Jones                Dr.   1390 Clearview Pkwy.                     Eastport             ID 83826      674-727-0511 674-727-1560 rr@usol.com                                       

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300026   City Bus Transport                       Larry           Osmanova             Mr.   256 Royal Ln.                            Salem                OR 97311      541-905-4819 541-905-8042 citybus@fast.com                                  
C-300027   Vacation Car Rentals                     Richard         Strehle              Mr.   9862 Rock Island Rd.                     Walla Walla          WA 99362      206-434-7305 206-434-1892 vacation@fast.com                                 
C-300028   Cheesman Corporation                     Brenda          Kitchel              Mrs.  6482 Thomasen Rd.                        Roanoke              VA 24011      804-214-8732 804-214-1253 cheesman@zeronet.net                              
C-300029   Down Deep Drilling Inc.                  Don             Torres               Mr.   1979 Illinois Ave.                       Elberton             GA 30635      706-649-6375 706-649-0420 drill@usol.com                                    
C-300030   Main St. Bar and Grill                   Richard         Kluth                Dr.   7901 Peach Tree Dr.                      Middletown           DE 19709      302-296-8012 302-296-5060 rickkluth@free.com                                
C-300031   Copy Center                              Allen           Robles               Mr.   1228 Bailey Rd.                          Haxtun               CO 80761      644-730-8090 644-730-3557 copy@onlineservice.com                            
C-300032   Greenpart Steet Metal                    Archie          Doremski             Mr.   6580 Midway Rd.                          Cody                 WY 82414      307-944-8959 307-944-3950 sheetz@free.com                                   
C-300033   Pools For You                            Daniel          Ezra                 Mr.   7393 Lake June Rd.                       Auburn               ME 04212      207-744-1997 207-744-8795 swim@zeronet.net                                  
C-300034   Phone Corporation                        Dean            Katpally             Mr.   1179 38th St.                            Kapaa                HI 96746      808-799-3727 808-7991677  phonecorp@usol.com                                
C-300035   Store It Here                            Randall         Neely                Mr.   1132 Madison St.                         Rutland              VT 05701      802-319-9805 802-319-1266 storage@fast.com                                  
C-300036   Kids Recreation Inc.                     Mike            Condie               Mr.   449 Troy Ave.                            Wilson               NC 27895      336-211-1238 336-211-3812 kidrec@zeronet.net                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300037   Trailor Rentals                          Tim             Leffert              Mr.   2765 Independence Ave.                   Rome                 NY 13442      315-486-4777 315-486-0683 trailrent@zeronet.net                             
C-300038   Water Analysts                           Carl            Dallas               Mr.   2530 Lakewood Blvd.                      Sumter               SC 29153      864-541-5114 864-541-9632 analyzeh20@fast.com                               
C-300039   Gards Auto Repair                        Dennis          Sammons              Mr.   581 Sahara Blvd.                         Saginaw              MI 48609      616-544-1969 616-544-3365 repairit@free.com                                 
C-300040   Computer Consultants                     Mildred         Jones                Ms.   2278 Flamingo Rd.                        Allentown            PA 18195      610-437-6687 610-437-6210 compconsul@usol.com                               
C-300041   Laser Graphics Associates                Paul            Kaakeh               Mr.   3616 Jones Blvd.                         Gunnison             CO 81247      719-750-4539 719-750-9842 graphit@usol.com                                  
C-300042   Signs Signs Signs                        Kevin           Zubarev              Mr.   5933 Valley St.                          Blackfoot            ID 83221      208-364-3785 208-364-5230 sign3@fast.com                                    
C-300043   Flowers by Mickey                        Mary            Uhl                  Ms.   6936 Citrus Blvd.                        Charleston           SC 29413      803-974-2809 803-974-6131 mouse@fast.com                                    
C-300044   Kelly Dance Studio                       Jennifer        Kmec                 Mrs.  9413 E. Broadway St.                     Taneytown            MD 21787      443-542-1386 443-542-0474 dancingk@free.com                                 
C-300045   National Art Museum                      Marjorie        Vandermay            Ms.   5384 Raymond Ave.                        Beatrice             NE 68310      308-489-1137 308-489-9640 nam@fast com                                      
C-300046   Tuckers Jewels                           Stephanie       Yeinick              Ms.   2596 S. Fairview Rd.                     Moberly              MO 65270      573-455-4278 573-455-3163 jewels@usol.com                                   
C-300047   The Employment Agency                    Cathy           Harvey               Mrs.  9481 Town Line Rd.                       Asheville            NC 28810      336-477-0249 336-477-7464 findwork@onlineservice.com                        

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300048   Cleaning Supply                          Geo             Schofield            Mr.   4931 Talbot Blvd.                        Winona               MS 38967      228-480-9751 228-480-4037 cleanit@usol.com                                  
C-300049   Appliances Inc.                          Kara            Orze                 Ms.   2666 Stillwater Rd.                      Wausau               WI 54401      414-773-1017 414-773-2842 appinc@zeronet.net                                
C-300050   Quality Equipment Corp.                  Jeff            Kowaiski             Mr.   3323 Mission Pkwy.                       Wellsville           NY 14895      212-492-5644 212-492-9525 equipit@usol.com                                  
C-300051   Sharons Shamrock                         Sharon          Rouls                Mrs.  1274 Weaver Rd.                          Dothan               AL 36303      205-246-3224 205-246-5699 irish@free.com                                    
C-300052   Manufactured Homes Corp.                 Sherry          Garling              Ms.   4350 Concord Blvd.                       Millinockets         ME 04462      353-822-7623 353-822-9722 homely@fast.com                                   
C-300053   Camping Supplies                         Mary            Deets                Mrs.  4534 South Acres Rd.                     Pearl City           HI 96782      808-562-4081 808-562-0004 camphere@fast.com                                 
C-300054   Financial Planning Consul                Dennis          Drazer               Dr.   4799 Silverstar Rd.                      Seattle              WA 98115      253-315-4247 253-315-7522 dollarplan@usol.com                               
C-300055   Fire Alarm Systems                       Robert          Lister               Mr.   3016 Dunlap Ave.                         Provo                UT 84603      801-404-1240 801-404-8056 fines@free.com                                    
C-300056   Happytime Escort Service                 Heather         Waters               Mrs.  805 Cactus Rd.                           Lake City            SC 29560      869-741-7817 869-741-0539 dates@free.com                                    
C-300057   Industrail Contracting Co                Anita           Pastron              Ms.   2817 Northern Ave.                       McMinnville          TN 37111      901-796-4654 901-796-3276 contracts@fast.com                                
C-300058   Outlets                                  Amy             Heide                Ms.   9119 Camelback Rd.                       Brattleboro          VT 05304      802-894-1024 802-894-1135 letout@usol.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300059   Rydell High School                       Charlene        Franks               Mrs.  1627 Thomas Rd.                          Douglas              WY 82633      307-892-2938 307-892-1477 learn@rydell.edu                                  
C-300060   Collectibles Inc.                        Doug            Blizzard             Mr.   856 Van Buren St.                        Mars Hill            MS 39666      228-646-5114 228-646-2170 collectit@onlineservice.com                       
C-300061   Karate Made Easy                         Richard         Scott                Mr.   1489 Dobbins Rd.                         Fairmont             WV 26555      304-774-2226 304-774-8150 kick@onlineservice.com                            
C-300062   Security Installation                    Scott           Gray                 Mr.   115 Shea Blvd.                           York                 PA 17406      484-453-7105 484-453-6614 keepsafe@zeronet.net                              
C-300063   Ceramic Supply                           Randy           Talauage             Mr.   6364 Brown St.                           Northport            WA 99157      347-671-2022 347-671-9116 paintit@fast.com                                  
C-300064   Bobs Repair Service                      Daniel          Hundnall             Mr.   909 Reams Rd.                            Enid                 OK 73705      918-830-9731 918-830-3898 fixit@usol.com                                    
C-300065   Investment Specialties                   Sally           Valle                Dr.   6298 Killingsworth St.                   Denton               TX 76208      972-234-2044 972-234-1543 roi@usol.com                                      
C-300066   North Street Church                      Noemi           Elston               Mr.   3024 28th St.                            Rock Springs         WY 82902      307-359-9514 307-359-8090 closetoheaven@zeronet.net                         
C-300067   Supplying Crafts                         Kelly           Jordan               Ms.   168 Division St.                         Jacksonville         FL 32205      727-951-7737 727-951-9889 supplycrafts@fast.com                             
C-300068   Cellular Services                        Steve           Fulkerson            Mr.   6912 White Horse Rd.                     Snowflake            AZ 85937      602-129-1885 602-129-5545 cellcall@usol.com                                 
C-300069   Easy Internet Access                     Orville         Gilliland            Mr.   5515 Page-Mill Rd.                       Vancleeve            MS 39565      490-263-2957 490-263-6303 eia@zeronet.net                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300070   Sampson Home Mortgages                   Bridgette       Kyger                Mrs.  5682 Chester Pike Rd.                    Annapolis            MD 21412      301-467-6480 301-467-5740 homeloans@fast.com                                
C-300071   The Cable Company                        Norman          Fields               Dr.   4174 Collings St.                        Juneau               AK 99811      501-346-4841 501-346-0928 catv@onlineservice.com                            
C-300072   Automart                                 Jessica         Nakamura             Ms.   8233 Clairton Ave.                       Mitchell             SD 57301      605-324-2193 605-324-1030 carsell@usol.com                                  
C-300073   First National Bank                      Jack            Barrick              Mr.   2638 Becks Run Rd.                       Titusville           FL 32783      786-494-4782 786-494-1359 1natbank@free.com                                 
C-300074   Apartment Referrals                      Aricka          Bross                Ms.   555 W. Liberty Ave.                      Jewett               OH 43986      419-676-9758 419-676-3995 placetolive@free.com                              
I-300001                                            Anna            Mayton               Dr.   2381 Basse Rd.                           McKenzie             Al 36456      888-451-1233              doctor@free.com                                   
I-300002                                            Lou             Caldwell             Mr.   1486 Joliet Rd.                          Louisville           KY 40211      606-901-1238              lucky@fast.com                                    
I-300003                                            Carl            Hague                Mr.   2711 143rd St.                           Cincinnati           OH 45207      419-890-3531                                                                
I-300004                                            Jeffery         Jordan               Mr.   1500 Normantown Rd.                      Spokane              WA 99211      509-989-9996              seeya@usol.com                                    
I-300005                                            Kimber          Spaller              Mrs.  1565 Culebra Rd.                         Sitka                AK 99836      878-119-5448              mcgimmie@zero.net                                 
I-300006                                            Eric            Fannon               Mr.   2526 Nelson Rd.                          Redding              CA 96003      209-980-0812              ef@free.com                                       

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300007                                            Jessica         Cain                 Ms.   942 55th St.                             Greenville           MI 48838      517-901-2610                                                                
I-300008                                            Richard         Zito                 Mr.   7569 130th St.                           Lebanon              NH 03766      603-787-0787              rzito@zeronet.net                                 
I-300009                                            Angela          Wainscott            Dr.   3646 North Ave.                          Idaho Falls          ID 83415      208-788-4112              awainscott@free.com                               
I-300010                                            James           Gross                Dr.   1983 Mill St.                            Lakewood             NJ 08701      908-879-8672              jgross@fast.com                                   
I-300011                                            Jack            Akers                Mr.   1485 71st St.                            Wilmington           DE 19850      301-454-6061              pizazz@usol.com                                   
I-300012                                            Kevin           Jackson              Mr.   5990 Cuba Rd.                            New Orleans          LA 70123      225-624-2341                                                                
I-300013                                            Shirley         Osborne              Mrs.  816 Penny Rd.                            Swainsboro           GA 30401      706-333-7174                                                                
I-300014                                            Eric            Becker               Mr.   8784 Wabash Ave.                         Kinston              NC 28504      910-717-7613              daddyo@usol.com                                   
I-300015                                            Karen           Mangus               Mrs.  4804 Ridge Rd.                           Sebring              FL 33871      863-623-0459              missright@onlineservice.com                       
I-300016                                            Peter           Austin               Mr.   4804 River Rd.                           Barnwell             SC 29812      803-343-6063                                                                
I-300017                                            Brad            Arquette             Mr.   2599 Ben Hill Rd.                        Tonopah              NV 89049      775-914-4294              arq@usol.com                                      

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300018                                            Daniel          Barton               Mr.   4599 Atlanta Rd.                         Sweetwater           TX 79556      915-894-8034              dannie@zeronet.net                                
I-300019                                            Jerry           Mennen               Dr.   869 Clay St.                             Flagstaff            AZ 86038      520-306-8426              mennenj@free.com                                  
I-300020                                            Kenneth         Wilcox               Mr.   9364 Hershell Rd.                        Creston              IA 50801      515-872-8848              kenny@onlineservice.com                           
I-300021                                            Matt            Smith                Mr.   6804 All Rd.                             Montrose             CO 81402      719-822-8828              matsm@fast.com                                    
I-300022                                            Paul            Sullivan             Mr.   9399 Flat Rd.                            Wichita              KS 67251      785-322-5896              sullie@zeronet.net                                
I-300023                                            Gerald          Campbell             Dr.   1869 Boundary St.                        Westfield            WI 53964      431-087-1044              gcampbell@free.com                                
I-300024                                            Joan            Hedden               Mrs.  4518 Red Bud Trail                       Springdale           AR 72765      501-710-0658                                                                
I-300025                                            Ronald          Miller               Mr.   360 Spring St.                           Kalamazoo            MI 49008      734-820-2076              picky@zeronet.net                                 
I-300026                                            Terry           Xu                   Ms.   2019 Elm St.                             Columbia             MO 65215      417-546-2570              muffin@fast.com                                   
I-300027                                            Danita          Sharp                Ms.   3475 Mystic St.                          Yakima               WA 98908      360-650-5604              girlfriend@fast.com                               
I-300028                                            Don             Kaleta               Mr.   8948 Washington St.                      Altoona              PA 16602      724-695-2157              stud@zeronet.net                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300029                                            Tammi           Baldocchio           Ms.   924 North Ave.                           Slatersville         RI 02876      401-989-4975                                                                
I-300030                                            Eric            Quintero             Mr.   144 Concord Rd.                          Columbus             IN 47202      812-805-1588              diamond@onlineservice.com                         
I-300031                                            Phillip         Hession              Mr.   7610 Hartford Ct.                        Battle Creek         MI 49016      231-711-6837              howdy@usol.com                                    
I-300032                                            Ruth            Albeering            Dr.   1348 Yonge Rd.                           Galax                VA 24333      784-444-0131              rabeering@free.com                                
I-300033                                            Jacob           Richer               Mr.   1490 N. Shore Rd.                        Ephrata              WA 98823      425-942-3763              laugh@free.com                                    
I-300034                                            James           Jones                Mr.   4685 Vernon St.                          Burns                OR 97720      971-522-5851              puffy@fast.com                                    
I-300035                                            Tim             Parker               Mr.   2848 Marrett Rd.                         Troy                 NY 12182      315-985-4102              jeckle@onlineservice.com                          
I-300036                                            Andrea          Montgomery           Ms.   1699 Conner Dr.                          Thurmont             MD 21788      349-397-7772                                                                
I-300037                                            Chas            Funk                 Mr.   2490 Maple St.                           Trumbull             CT 06611      860-498-3900              duck@usol.com                                     
I-300038                                            David           Smith                Mr.   9245 Main St.                            Rockford             IL 61125      309-980-4350              emerald@onlineservice.com                         
I-300039                                            David           Chang                Mr.   5786 Manor Rd.                           Mansfield            OH 44907      740-750-1272              lion@free.com                                     

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300040                                            Kathy           Gunderson            Mrs.  2257 Oak Springs Rd.                     Marianna             FL 32447      941-330-3314                                                                
I-300041                                            Dennis          Mundy                Mr.   5781 Red Bud Trail                       Littleton            NH 03561      603-306-0774              rino@usol.com                                     
I-300042                                            George          Trenkle              Mr.   1874 Jefferson Ave.                      Edison               NJ 08837      856-267-7913              cold@fast.com                                     
I-300043                                            Carey           Dailey               Ms.   234 Sheridan Dr.                         Denver               CO 80219      728-896-2767              shelty@usol.com                                   
I-300044                                            Louise          Cool                 Mrs.  6831 Walden Ave.                         Hailey               ID 83333      208-956-0698                                                                
I-300045                                            Gary            Kempf                Mr.   3908 William St.                         Kenton               OH 43326      937-724-7313              kempfg@free.com                                   
I-300046                                            Jane            Mumford              Dr.   8235 Center Rd.                          Campbellsville       KY 42719      270-428-5866                                                                
I-300047                                            Scott           Yarian               Dr.   4198 Center Ridge Rd.                    Whiteville           NC 28472      252-310-2224              syarian@fast.com                                  
I-300048                                            Patrick         Bollock              Mr.   1472 Bayley Rd.                          Powell               WY 82435      307-635-1692              pat@fast.com                                      
I-300049                                            Paul            Rice                 Mr.   830 Shaker Blvd.                         Craig                CO 81626      719-541-1837              paulier@onlineservice.com                         
I-300050                                            James           Schilling            Mr.   2021 North Bend Rd.                      Cedar Rapids         IA 52498      319-429-9772                                                                

231 rows selected. 

Question 8

1 row inserted.


CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
Z-12345    Quick Stop                               Randal          Graves               Mr.                                            Leonardo             NJ                                                                                        

Question 9

1 row updated.


CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
Z-12345    Quick Stop                               Randal          Graves               Mr.                                            Leonardo             NJ 07737                                                                                  

Question 10
7 rows deleted.

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300051                                            Lynne           Lagunes              Ms.   2820 Beechmont Ave.                      Pocatello            ID 83209      208-502-9976              hello@zeronet.net                                 
I-300052                                            Andrew          Yelnick              Mr.   6972 Winton Rd.                          Detroit              MI 48226      517-803-5818              family@free.com                                   
I-300053                                            Stephanie       Pearl                Mrs.  6460 Springdale Rd.                      Maryville            MO 64468      660-447-8319              mommyl@fast.com                                   
I-300054                                            Dorlan          Bresnaham            Dr.   1328 Mill Ave.                           Plymouth             NH 03264      603-497-7374              dorlan@usol.com                                   
I-300055                                            Jon             Clute                Dr.   1680 River Oaks Blvd.                    Tucson               AZ 85711      480-181-8940                                                                
I-300056                                            Elizabeth       Henderson            Ms.   2819 Otay Rd.                            Zeona                SD 57758      449-486-8018                                                                
I-300057                                            Tonya           Owens                Mrs.  1414 Fields Ertel Rd.                    Abbeville            SC 29620      843-773-2751                                                                
I-300058                                            Matthew         Quant                Mr.   253 Silver Creek Rd.                     Hamlet               NC 28345      910-577-1319              walker@onlineservice.com                          
I-300059                                            Kenneth         Mintier              Mr.   4831 Skeet Blvd.                         Eureka               CA 95534      323-673-0690              builder@usol.com                                  
I-300060                                            Lucille         Appleton             Ms.   5260 Blue Mound Rd.                      Newburgh             NY 12553      914-497-2160              muscle@zeronet.net                                
I-300061                                            Brenda          Jones                Mrs.  3696 Cooper St.                          Aurora               CO 80230      720-800-2638              show@free.com                                     

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300062                                            John            McGinnis             Dr.   7841 Hurst Blvd.                         Preston              ID 83263      208-741-1963              john@zeronet.net                                  
I-300063                                            Dennis          Eberle               Mr.   9425 James Rd.                           Waterloo             IA 50707      515-708-1802              deber@free.com                                    
I-300064                                            Jo              Jacko                Mrs.  6588 Ken Caryl Rd.                       Vineland             NJ 08361      856-752-7471                                                                
I-300065                                            Karen           Randolph             Ms.   1038 Coal Mine Rd.                       Franklin             NH 03235      603-744-9002              cookin@zeronet.net                                
I-300066                                            Ruth            Ball                 Dr.   1093 Valley View Ln.                     St. Cloud            MN 56387      651-479-7538                                                                
I-300067                                            Travis          Camargo              Mr.   6681 Forrest Ln.                         Neosho               MO 64853      816-746-4913                                                                
I-300068                                            Jerry           Muench               Mr.   1694 Stone Valley Rd.                    Miami                TX 79059      464-669-8537              redhot@onlineservice.com                          
I-300069                                            Verna           McGrew               Ms.   4755 Rocket Blvd.                        Huntsville           AL 35811      334-547-9329              verngrew@free.com                                 
I-300070                                            Elizabeth       Derhammer            Ms.   2343 Pioneer Pkwy.                       Garden City          KS 67868      785-970-9916              lizzy@onlineservice.com                           
I-300071                                            Ted             Zissa                Mr.   4935 Cedar Hill Rd.                      Ardmore              OK 73402      405-151-7445                                                                
I-300072                                            Matt            Shade                Mr.   8441 Skillman Ave.                       Green Valley         AZ 85622      623-422-6616              shadtree@free.com                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300073                                            Dean            Eagon                Mr..  616 Burton Rd.                           Peublo               CO 81011      970-581-8611                                                                
I-300074                                            Andrew          Ray                  Mr.   1246 Ferry St.                           Millville            NJ 08332      609-345-9680              andyray@usol.com                                  
I-300075                                            Robert          Cortez               Mr.   219 Pleasant Run Rd.                     Keene                NH 03435      603-442-3740                                                                
I-300076                                            Tim             Carlton              Mr.   1038 Lancaster St.                       Enfield              CT 06082      203-608-3465                                                                
I-300077                                            Jennifer        Hundley              Mrs.  6354 Buckner Blvd.                       Richwood             WV 26261      304-713-3298              jenhund@fast.com                                  
I-300078                                            Andrea          Griswold             Dr.   8215 Garland Rd.                         Leadville            CO 80429      970-746-0995              andygwold@usol.com                                
I-300079                                            Christina       Wilson               Mrs.  5766 Scyene Rd.                          Pratt                KS 67124      316-210-8989                                                                
I-300080                                            Juicheng        Nugent               Mr.   9443 Illinois Ave.                       Springfield          VT 05156      802-352-8923              nugent@fast.com                                   
I-300081                                            Bryan           Price                Mr.   1745 Best Line Rd.                       Hampton              VA 23666      804-674-9666                                                                
I-300082                                            Helene          Ziekart              Mrs.  9533 Simonds Rd.                         New Haven            CT 06511      203-244-9192                                                                
I-300083                                            Marty           Fay                  Ms.   9241 School Rd.                          Fairbanks            AK 99775      501-631-3727              sparky@free.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300084                                            Lisa            Pettry               Mrs.  8515 Cossell Ave.                        Carson City          NV 89714      702-799-7272              lpett@zeronet.net                                 
I-300085                                            Zach            McGrew               Mr.   5788 Rockville Rd.                       Globe                AZ 85502      520-730-8494                                                                
I-300086                                            Jamie           Thompson             Ms.   6878 Holt Ave.                           Athens               GA 30606      706-471-1222              jthompson@onlineservice.com                       
I-300087                                            Charles         Jones                Mr.   1420 N. Highland Ave.                    Grand                FL 33606      919-774-5552              charlie@usol.com                                  
I-300088                                            Thomas          Zelenka              Dr.   5371 Brookeville Rd.                     Manchester           NH 03108      603-374-3706              zelenka@free.com                                  
I-300089                                            James           Laake                Mr.   3434 Great Street                        Aladdin              WY 82710      613-785-7063                                                                
I-300090                                            Daniel          Stabnik              Mr.   3745 35th St.                            Perryville           MO 63775      636-746-4124                                                                
I-300091                                            Trudi           Antonio              Ms.   9882 Strother Rd.                        Potsdam              NY 13699      718-747-3259              toni@onlineservice.com                            
I-300092                                            John            Garcia               Mr.   231 63rd St.                             Portland             ME 04122      207-311-0174              jgar@onlineservice.com                            
I-300093                                            Jay             Hanau                Mr.   5897 Sunset Rd.                          Marion               IL 62959      773-490-8254                                                                
I-300095                                            Joshua          Cole                 Mr.   7903 Paradise Rd.                        Jackson              TN 38308      865-269-7782              fido@zeronet.net                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300096                                            David           Schilling            Mr.   8671 Chapel Rd.                          Bowling Green        KY 42102      502-421-1516                                                                
I-300097                                            Mary Ann        Rausch               Mrs.  3679 Western Ave.                        Green River          WY 82938      307-944-3324              spiritual@free.com                                
I-300098                                            Allison         Roland               Mrs.  4599 S. Maodill Ave.                     Palma                FL 33604      929-498-4174              alley@onlineservice.com                           
I-300099                                            Roy             Beer                 Mr.   8065 Colina Rd.                          Yakima               WA 98907      206-745-2584              wizzy@usol.com                                    
I-300100                                            Chris           Dunlap               Mrs.  3526 10th St.                            Gillette             WY 82731      307-473-2281                                                                
I-300101                                            Ansel           Farrell              Mr.   316 Birch St.                            Storm Lake           IA 50588      712-440-3934              prickly@onlineservice.com                         
I-300102                                            Jason           Laxton               Mr.   7858 Dowling Ave. N.                     Athol                MA 01368      978-860-2824              coondog@usol.com                                  
I-300103                                            Larry           Gardiner             Mr.   1739 W 39th St.                          Winnsboro            LA 71295      225-313-6268              square@onlineserveice.com                         
I-300104                                            Lawrence        Pullen               Mr.   4599 Rheem Blvd.                         Greenbush            MN 56726      644-591-3243              laurie@free.com                                   
I-300105                                            Matt            Nakanishi            Mr.   8108 Middle Rd.                          Price                UT 84501      435-710-5324              nakan@free.com                                    
I-300106                                            Nancy           Basham               Mrs.  3409 36th Ave. N.                        Dexter               ME 04930      207-422-7135                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300107                                            Rachel          Davis                Ms.   2954 Cedar Lake Rd.                      Reno                 NV 89523      702-907-4818              rachdav@zeronet.net                               
I-300108                                            Sarah           McCammon             Mrs.  3216 Dimond Lake Rd.                     Kingman              AZ 86411      520-438-7944              squirrel@zeronet.net                              
I-300109                                            David           Tietz                Mr.   5235 E. 44th St.                         Montevideo           MN 56265      651-912-1583              tietz@free.com                                    
I-300110                                            Jim             Manaugh              Mr.   1011 W. Hillsborough Ave.                Garyville            FL 33605      919-747-5603              jmanaugh@eagle.com                                
I-300111                                            Richard         Stetler              Mr.   7496 University Ave.                     Auburn               AL 36832      256-412-8112              screwball@free.com                                
I-300112                                            Jonathon        Blanco               Mr.   8095 Mounty Rd.                          Oshkosh              WI 54904      902-226-1858              hammer@free.com                                   
I-300113                                            Randolph        Darling              Mr.   8254 Coral Way                           Putnam               CT 06260      860-684-1620              randolph@fast.com                                 
I-300114                                            Melody          Fazal                Mrs.  4603 Killian Rd.                         Bakersfield          CA 93311      760-877-4849              melfazal@zeronet.net                              
I-300115                                            Michael         Tendam               Dr.   190 Dixie St.                            Glasgow              MT 592331     406-424-7496              flute@usol.com                                    
I-300116                                            Sean            Akropolis            Mr.   6603 E. Little Yak Rd.                   Anchorage            AK 99509      907-262-4254              pickle@free.com                                   
I-300117                                            Anne            Hatzell              Ms.   5200 Belfat Blvd.                        Seaford              DE 19973      302-651-6440              hazel@zeronet.net                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300118                                            Meredith        Rushing              Dr.   1856 Cullen Blvd.                        Lexington            KY 40516      606-608-2105              merry@free.com                                    
I-300120                                            Zack            Hill                 Mr.   2064 Preston Rd.                         Winston              OR 97496      503-794-2322              boogie@free.com                                   
I-300121                                            Dan             Lageveen             Mr.   3056 Southern Ave. N.                    Laramie              WY 82073      307-344-8928              veenie@zeronet.net                                
I-300122                                            Marla           Reeder               Mrs.  1029 Moraga Ave. W.                      Bonifay              FL 32425      728-442-3031              reedmar@zeronet.net                               
I-300123                                            Linda           Bowen                Mrs.  5541 Bell Rd.                            Huron                SD 57350      605-234-4114                                                                
I-300124                                            Michael         Emore                Mr.   7347 Peoria Ave.                         Orlando              FL 32810      352-472-1224              mikemore@usol.com                                 
I-300125                                            Mary Jo         Wales                Dr.   1416 Wynnewood Ave.                      Wallowa              OR 97885      852-441-4984              jomary@onlineservice.com                          
I-300126                                            Tom             Moore                Mr.   7742 Glendale Ave.                       Morehead             KY 04351      270-692-2845              seedle@fast.com                                   
I-300127                                            Susan           Watson               Mrs.  6151 Indian School Rd.                   Ogden                UT 84414      801-746-7701              mswatson@fast.com                                 
I-300128                                            Tom             Irelan               Mr.   7833 McDowell Rd.                        Cumberland           MD 21503      240-634-5581              tucker@free.com                                   
I-300129                                            Rosemary        Vanderhoff           Dr.   843 99th St.                             Macon                GA 31206      770-293-8783                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300130                                            Mike            Dunbar               Mr.   1750 Broadway St.                        Grangeville          ID 83531      208-297-5374              duh@onlineservice.com                             
I-300131                                            Ryan            Stahley              Mr.   9281 E. Bird St.                         Grand                FL 33606      919-774-5340              rstahley@eagle.com                                
I-300132                                            Patricia        Leong                Ms.   6213 Baseline Rd.                        Prescott             AZ 86313      520-247-4141              patrice@usol.com                                  
I-300133                                            Roy             McGrew               Mr.   1968 Elliot Rd.                          Nampa                ID 83686      208-324-0783              grow@zeronet.net                                  
I-300134                                            Tom             Baker                Mr.   483 Greenway St.                         Sparta               WI 54656      414-778-5640              bologna@free.com                                  
I-300135                                            Bill            Umbarger             Mr.   1476 Eastern Pkwy.                       Belfast              ME 04915      207-155-1577              cheezy@onlineservice.com                          
I-300136                                            Bob             Weldy                Mr.   8227 Oak Ridge Rd.                       Lynchburg            VA 24506      571-490-6449              sucker42@usol.com                                 
I-300137                                            Kris            Shinn                Dr.   7451 Tiden St.                           Pecos                TX 79772      469-740-2748              shinnk@zeronet.net                                
I-300138                                            James           King                 Dr.   2734 Mulga Loop Rd.                      Lincoln              ME 04457      207-708-3317              jamesk@usol.com                                   
I-300139                                            Frank           Malady               Mr.   7894 Geary Blvd.                         Nahunta              GA 31533      574-493-0510              frankmala@zeronet.net                             
I-300140                                            Jim             Webb                 Mr.   3577 Hessian Ave.                        Lowell               MA 01853      978-204-3019                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300141                                            Daniel          Rodkey               Ms.   4024 Mill Plain Blvd.                    Lamar                CO 81052      719-748-3205              dannie@free.com                                   
I-300142                                            Marc            Williams             Mr.   8443 15th St.                            Cedar City           VT 84721      435-774-4595              peanut@fast.com                                   
I-300143                                            Kristy          Moore                Ms.   4410 W. Spruce St.                       Fort Sutton          FL 33603      919-486-6765              fluffy@onlineservice.com                          
I-300144                                            Russ            Mann                 Mr.   6879 Island Ave.                         Las Vegas            NV 89199      775-549-1798              scooter@onlineservice.com                         
I-300145                                            Carrie          Buchko               Mrs.  3793 Leheigh Ave.                        Jasper               TX 75951      817-739-1335              goobert@free.com                                  
I-300146                                            Michelle        Oakley               Ms.   5348 Elmwood Ave.                        Brockton             MA 02303      978-514-5425              littleone@usol.com                                
I-300147                                            Steven          Yaun                 Mr.   4711 Hook Rd.                            Indianapolis         IN 46208      317-780-9804              yawn@fast.com                                     
I-300148                                            Jack            Illingworth          Mr.   2741 Ashland Ave.                        Buffalo              NY 14206      914-748-9829              illing@free.com                                   
I-300149                                            Thomas          Wolfe                Mr.   7347 Broad St.                           Scranton             PA 18510      610-365-9766              wolf@onlineservice.com                            
I-300150                                            Irene           Poczekay             Mrs.  7000 W. 7th St.                          Newport              RI 02840      401-461-9567                                                                
I-300151                                            Andy            Huegel               Dr.   7542 Haverford Blvd.                     Milford              DE 19963      302-620-1366                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300152                                            Karen           Marko                Ms.   4954 Clifton Rd.                         Lawton               OK 73506      580-555-1871              marko@usol.com                                    
I-300153                                            Trevor          Snuffer              Mr.   6550 Forbes Ave.                         Rocky Mount          NC 27803      336-185-0630              snuffer@zeronet.net                               
I-300154                                            Phil            Reece                Mr.   1204 N. Nebraska Ave.                    Fort Sutton          FL 33603      919-486-0649              sly@zeronet.net                                   
I-300155                                            Linda           Hari                 Mrs.  791 McKnight Rd.                         Franklin             KY 42134      270-411-2316                                                                
I-300156                                            Andrew          Smith                Mr.   1244 Fremont Ave.                        Tribune              KS 67879      709-307-2568              smokey@zeronet.net                                
I-300157                                            Linda           Li                   Ms.   5920 Grove St.                           Torrington           CT 06790      203-744-4677              ll@free.com                                       
C-300001   Baker and Company                        Gregory         Abbott               Mr.   7837 Busse Rd.                           Terre Haute          IN 47813      812-447-3621 812-447-4602 greggie@usol.com                                  
C-300002   Cole Sales and Associates                Tommy           McFerren             Dr.   3817 Farrell Rd.                         Bend                 OR 97709      503-767-7054 503-767-3394 mcferren@cole.com                                 
C-300003   Tippe Inn                                Cecil           Scheetz              Ms.   391 Weber Rd.                            Waterville           ME 04903      207-679-9822 207-679-6367 cecil@free.com                                    
C-300004   Franklin Trinkets                        Frank           Aamodt               Mr.   3304 Leredo Ave.                         New Milford          CT 06776      898-762-8741 898-762-9493 fa@fast.com                                       
C-300005   Needle Center                            Kathleen        Plyman               Ms.   7627 Belmont Ave                         New York City        NY 10131      507-543-2052 507-543-1845 needles@onlineservice.com                         

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300006   BMA Advertising Design                   George          Purcell              Mr.   4281 Jefferson Rd.                       Scranton             PA 18522      432-320-6905 432-320-5741 design@zeronet.net                                
C-300007   Regency Hospital                         Eugene          Gasper               Mr.   7022 Ward Lake Rd.                       Barre                VT 05641      705-580-6124 705-580-4250 medcare@fast.com                                  
C-300008   South Street Rehabilitation              Jared           Meers                Mr.   4271 Airport Rd.                         Grand Forks          ND 58026      701-371-1701 701-371-1372 rehabsouth@zeronet.net                            
C-300009   Dixon Pharmacy                           Tracy           Cicholski            Mrs.  1920 Albion St.                          Crystal Springs      MS 39059      601-959-1315 601-959-4277 dixpharm@free.com                                 
C-300010   Photography Niche                        Bruce           Fogarty              Mr.   1012 Island Ave.                         Ellenboro            WV 26346      598-791-1420 598-791-8582 photoniche@usol.com                               
C-300011   Family Medical Center                    Susan           Strong               Mrs.  5883 Sudbury Rd.                         Adel                 GA 31620      912-760-7840 912-760-8489 fammed@onlineservice.com                          
C-300012   Bryant Accounting                        Ginger          Xiao                 Mrs.  6636 Walnut St.                          Rapid City           SD 57703      605-846-0451 605-846-5219 acctsbryant@zeronet.net                           
C-300013   Recreation Supply                        Karen           Burns                Dr.   2850 Farm St.                            Modesto              CA 95354      707-598-2670 707-598-3072 burnskaren@fast.com                               
C-300014   R and R Air                              Cathy           Bending              Mrs.  9573 Chestnut St.                        Evansville           IN 47732      765-617-2811 765-617-5319 rrair@zeronet.net                                 
C-300015   Vets Inc.                                Evelyn          Cassens              Ms.   6094 Pearson St.                         Newark               DE 19726      302-762-9526 302-762-3338 dr.animal@onlineservice.com                       
C-300016   Goodwork Corporation                     Angie           Hoover               Ms.   6427 Genesee St.                         Casper               WY 82638      307-459-4165 307-459-2606 ahoover@free.com                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300017   Powerful Employment                      Jim             Sokeland             Mr.   6671 Pearl Rd.                           Reisterstown         MD 21136      723-366-1117 723-366-0896 employment@zeronet.net                            
C-300018   Wadake Critters                          Hugo            Gillespie            Mr.   4194 Northfield Rd.                      Salina               KS 67402      785-981-0669 785-981-6634 critters@free.com                                 
C-300019   Conner National                          Wade            Jacobs               Ms.   2610 E. Lake Rd.                         Scranton             ND 58653      803-477-5347 803-477-5487 connernat@usol.com                                
C-300021   Realty Specialties                       David           Tarter               Mr.   6274 Blue Rock Rd.                       Syracuse             NY 13261      518-500-0570 518-500-6159 estate@fast.com                                   
C-300022   Reflexions Manufacturing                 Heather         Wallpe               Ms.   4128 Hulen St.                           Park Hills           MO 63653      816-433-9799 816-433-3621 flex@onlineservice.com                            
C-300023   TAS                                      Robert          Dalury               Mr.   4718 Pleasant Valley Rd.                 Bay City             MI 48708      906-278-6446 906-278-4345 tas@zeronet.net                                   
C-300024   Bankruptcy Help                          Jim             Lichty               Mr.   5991 Kenwood Rd.                         Chicago              IL 60624      618-847-1904 618-847-6439 bankrupt@usol.com                                 
C-300025   Railroad Express                         Dusty           Jones                Dr.   1390 Clearview Pkwy.                     Eastport             ID 83826      674-727-0511 674-727-1560 rr@usol.com                                       
C-300026   City Bus Transport                       Larry           Osmanova             Mr.   256 Royal Ln.                            Salem                OR 97311      541-905-4819 541-905-8042 citybus@fast.com                                  
C-300027   Vacation Car Rentals                     Richard         Strehle              Mr.   9862 Rock Island Rd.                     Walla Walla          WA 99362      206-434-7305 206-434-1892 vacation@fast.com                                 
C-300028   Cheesman Corporation                     Brenda          Kitchel              Mrs.  6482 Thomasen Rd.                        Roanoke              VA 24011      804-214-8732 804-214-1253 cheesman@zeronet.net                              

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300029   Down Deep Drilling Inc.                  Don             Torres               Mr.   1979 Illinois Ave.                       Elberton             GA 30635      706-649-6375 706-649-0420 drill@usol.com                                    
C-300030   Main St. Bar and Grill                   Richard         Kluth                Dr.   7901 Peach Tree Dr.                      Middletown           DE 19709      302-296-8012 302-296-5060 rickkluth@free.com                                
C-300031   Copy Center                              Allen           Robles               Mr.   1228 Bailey Rd.                          Haxtun               CO 80761      644-730-8090 644-730-3557 copy@onlineservice.com                            
C-300032   Greenpart Steet Metal                    Archie          Doremski             Mr.   6580 Midway Rd.                          Cody                 WY 82414      307-944-8959 307-944-3950 sheetz@free.com                                   
C-300033   Pools For You                            Daniel          Ezra                 Mr.   7393 Lake June Rd.                       Auburn               ME 04212      207-744-1997 207-744-8795 swim@zeronet.net                                  
C-300034   Phone Corporation                        Dean            Katpally             Mr.   1179 38th St.                            Kapaa                HI 96746      808-799-3727 808-7991677  phonecorp@usol.com                                
C-300035   Store It Here                            Randall         Neely                Mr.   1132 Madison St.                         Rutland              VT 05701      802-319-9805 802-319-1266 storage@fast.com                                  
C-300036   Kids Recreation Inc.                     Mike            Condie               Mr.   449 Troy Ave.                            Wilson               NC 27895      336-211-1238 336-211-3812 kidrec@zeronet.net                                
C-300037   Trailor Rentals                          Tim             Leffert              Mr.   2765 Independence Ave.                   Rome                 NY 13442      315-486-4777 315-486-0683 trailrent@zeronet.net                             
C-300038   Water Analysts                           Carl            Dallas               Mr.   2530 Lakewood Blvd.                      Sumter               SC 29153      864-541-5114 864-541-9632 analyzeh20@fast.com                               
C-300039   Gards Auto Repair                        Dennis          Sammons              Mr.   581 Sahara Blvd.                         Saginaw              MI 48609      616-544-1969 616-544-3365 repairit@free.com                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300040   Computer Consultants                     Mildred         Jones                Ms.   2278 Flamingo Rd.                        Allentown            PA 18195      610-437-6687 610-437-6210 compconsul@usol.com                               
C-300041   Laser Graphics Associates                Paul            Kaakeh               Mr.   3616 Jones Blvd.                         Gunnison             CO 81247      719-750-4539 719-750-9842 graphit@usol.com                                  
C-300042   Signs Signs Signs                        Kevin           Zubarev              Mr.   5933 Valley St.                          Blackfoot            ID 83221      208-364-3785 208-364-5230 sign3@fast.com                                    
C-300043   Flowers by Mickey                        Mary            Uhl                  Ms.   6936 Citrus Blvd.                        Charleston           SC 29413      803-974-2809 803-974-6131 mouse@fast.com                                    
C-300044   Kelly Dance Studio                       Jennifer        Kmec                 Mrs.  9413 E. Broadway St.                     Taneytown            MD 21787      443-542-1386 443-542-0474 dancingk@free.com                                 
C-300045   National Art Museum                      Marjorie        Vandermay            Ms.   5384 Raymond Ave.                        Beatrice             NE 68310      308-489-1137 308-489-9640 nam@fast com                                      
C-300046   Tuckers Jewels                           Stephanie       Yeinick              Ms.   2596 S. Fairview Rd.                     Moberly              MO 65270      573-455-4278 573-455-3163 jewels@usol.com                                   
C-300047   The Employment Agency                    Cathy           Harvey               Mrs.  9481 Town Line Rd.                       Asheville            NC 28810      336-477-0249 336-477-7464 findwork@onlineservice.com                        
C-300048   Cleaning Supply                          Geo             Schofield            Mr.   4931 Talbot Blvd.                        Winona               MS 38967      228-480-9751 228-480-4037 cleanit@usol.com                                  
C-300049   Appliances Inc.                          Kara            Orze                 Ms.   2666 Stillwater Rd.                      Wausau               WI 54401      414-773-1017 414-773-2842 appinc@zeronet.net                                
C-300050   Quality Equipment Corp.                  Jeff            Kowaiski             Mr.   3323 Mission Pkwy.                       Wellsville           NY 14895      212-492-5644 212-492-9525 equipit@usol.com                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300051   Sharons Shamrock                         Sharon          Rouls                Mrs.  1274 Weaver Rd.                          Dothan               AL 36303      205-246-3224 205-246-5699 irish@free.com                                    
C-300052   Manufactured Homes Corp.                 Sherry          Garling              Ms.   4350 Concord Blvd.                       Millinockets         ME 04462      353-822-7623 353-822-9722 homely@fast.com                                   
C-300053   Camping Supplies                         Mary            Deets                Mrs.  4534 South Acres Rd.                     Pearl City           HI 96782      808-562-4081 808-562-0004 camphere@fast.com                                 
C-300054   Financial Planning Consul                Dennis          Drazer               Dr.   4799 Silverstar Rd.                      Seattle              WA 98115      253-315-4247 253-315-7522 dollarplan@usol.com                               
C-300055   Fire Alarm Systems                       Robert          Lister               Mr.   3016 Dunlap Ave.                         Provo                UT 84603      801-404-1240 801-404-8056 fines@free.com                                    
C-300056   Happytime Escort Service                 Heather         Waters               Mrs.  805 Cactus Rd.                           Lake City            SC 29560      869-741-7817 869-741-0539 dates@free.com                                    
C-300057   Industrail Contracting Co                Anita           Pastron              Ms.   2817 Northern Ave.                       McMinnville          TN 37111      901-796-4654 901-796-3276 contracts@fast.com                                
C-300058   Outlets                                  Amy             Heide                Ms.   9119 Camelback Rd.                       Brattleboro          VT 05304      802-894-1024 802-894-1135 letout@usol.com                                   
C-300059   Rydell High School                       Charlene        Franks               Mrs.  1627 Thomas Rd.                          Douglas              WY 82633      307-892-2938 307-892-1477 learn@rydell.edu                                  
C-300060   Collectibles Inc.                        Doug            Blizzard             Mr.   856 Van Buren St.                        Mars Hill            MS 39666      228-646-5114 228-646-2170 collectit@onlineservice.com                       
C-300061   Karate Made Easy                         Richard         Scott                Mr.   1489 Dobbins Rd.                         Fairmont             WV 26555      304-774-2226 304-774-8150 kick@onlineservice.com                            

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300062   Security Installation                    Scott           Gray                 Mr.   115 Shea Blvd.                           York                 PA 17406      484-453-7105 484-453-6614 keepsafe@zeronet.net                              
C-300063   Ceramic Supply                           Randy           Talauage             Mr.   6364 Brown St.                           Northport            WA 99157      347-671-2022 347-671-9116 paintit@fast.com                                  
C-300064   Bobs Repair Service                      Daniel          Hundnall             Mr.   909 Reams Rd.                            Enid                 OK 73705      918-830-9731 918-830-3898 fixit@usol.com                                    
C-300065   Investment Specialties                   Sally           Valle                Dr.   6298 Killingsworth St.                   Denton               TX 76208      972-234-2044 972-234-1543 roi@usol.com                                      
C-300066   North Street Church                      Noemi           Elston               Mr.   3024 28th St.                            Rock Springs         WY 82902      307-359-9514 307-359-8090 closetoheaven@zeronet.net                         
C-300067   Supplying Crafts                         Kelly           Jordan               Ms.   168 Division St.                         Jacksonville         FL 32205      727-951-7737 727-951-9889 supplycrafts@fast.com                             
C-300068   Cellular Services                        Steve           Fulkerson            Mr.   6912 White Horse Rd.                     Snowflake            AZ 85937      602-129-1885 602-129-5545 cellcall@usol.com                                 
C-300069   Easy Internet Access                     Orville         Gilliland            Mr.   5515 Page-Mill Rd.                       Vancleeve            MS 39565      490-263-2957 490-263-6303 eia@zeronet.net                                   
C-300070   Sampson Home Mortgages                   Bridgette       Kyger                Mrs.  5682 Chester Pike Rd.                    Annapolis            MD 21412      301-467-6480 301-467-5740 homeloans@fast.com                                
C-300071   The Cable Company                        Norman          Fields               Dr.   4174 Collings St.                        Juneau               AK 99811      501-346-4841 501-346-0928 catv@onlineservice.com                            
C-300072   Automart                                 Jessica         Nakamura             Ms.   8233 Clairton Ave.                       Mitchell             SD 57301      605-324-2193 605-324-1030 carsell@usol.com                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300073   First National Bank                      Jack            Barrick              Mr.   2638 Becks Run Rd.                       Titusville           FL 32783      786-494-4782 786-494-1359 1natbank@free.com                                 
I-300001                                            Anna            Mayton               Dr.   2381 Basse Rd.                           McKenzie             Al 36456      888-451-1233              doctor@free.com                                   
I-300002                                            Lou             Caldwell             Mr.   1486 Joliet Rd.                          Louisville           KY 40211      606-901-1238              lucky@fast.com                                    
I-300004                                            Jeffery         Jordan               Mr.   1500 Normantown Rd.                      Spokane              WA 99211      509-989-9996              seeya@usol.com                                    
I-300005                                            Kimber          Spaller              Mrs.  1565 Culebra Rd.                         Sitka                AK 99836      878-119-5448              mcgimmie@zero.net                                 
I-300006                                            Eric            Fannon               Mr.   2526 Nelson Rd.                          Redding              CA 96003      209-980-0812              ef@free.com                                       
I-300007                                            Jessica         Cain                 Ms.   942 55th St.                             Greenville           MI 48838      517-901-2610                                                                
I-300008                                            Richard         Zito                 Mr.   7569 130th St.                           Lebanon              NH 03766      603-787-0787              rzito@zeronet.net                                 
I-300009                                            Angela          Wainscott            Dr.   3646 North Ave.                          Idaho Falls          ID 83415      208-788-4112              awainscott@free.com                               
I-300010                                            James           Gross                Dr.   1983 Mill St.                            Lakewood             NJ 08701      908-879-8672              jgross@fast.com                                   
I-300011                                            Jack            Akers                Mr.   1485 71st St.                            Wilmington           DE 19850      301-454-6061              pizazz@usol.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300012                                            Kevin           Jackson              Mr.   5990 Cuba Rd.                            New Orleans          LA 70123      225-624-2341                                                                
I-300013                                            Shirley         Osborne              Mrs.  816 Penny Rd.                            Swainsboro           GA 30401      706-333-7174                                                                
I-300014                                            Eric            Becker               Mr.   8784 Wabash Ave.                         Kinston              NC 28504      910-717-7613              daddyo@usol.com                                   
I-300015                                            Karen           Mangus               Mrs.  4804 Ridge Rd.                           Sebring              FL 33871      863-623-0459              missright@onlineservice.com                       
I-300016                                            Peter           Austin               Mr.   4804 River Rd.                           Barnwell             SC 29812      803-343-6063                                                                
I-300017                                            Brad            Arquette             Mr.   2599 Ben Hill Rd.                        Tonopah              NV 89049      775-914-4294              arq@usol.com                                      
I-300018                                            Daniel          Barton               Mr.   4599 Atlanta Rd.                         Sweetwater           TX 79556      915-894-8034              dannie@zeronet.net                                
I-300019                                            Jerry           Mennen               Dr.   869 Clay St.                             Flagstaff            AZ 86038      520-306-8426              mennenj@free.com                                  
I-300020                                            Kenneth         Wilcox               Mr.   9364 Hershell Rd.                        Creston              IA 50801      515-872-8848              kenny@onlineservice.com                           
I-300021                                            Matt            Smith                Mr.   6804 All Rd.                             Montrose             CO 81402      719-822-8828              matsm@fast.com                                    
I-300022                                            Paul            Sullivan             Mr.   9399 Flat Rd.                            Wichita              KS 67251      785-322-5896              sullie@zeronet.net                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300023                                            Gerald          Campbell             Dr.   1869 Boundary St.                        Westfield            WI 53964      431-087-1044              gcampbell@free.com                                
I-300024                                            Joan            Hedden               Mrs.  4518 Red Bud Trail                       Springdale           AR 72765      501-710-0658                                                                
I-300025                                            Ronald          Miller               Mr.   360 Spring St.                           Kalamazoo            MI 49008      734-820-2076              picky@zeronet.net                                 
I-300026                                            Terry           Xu                   Ms.   2019 Elm St.                             Columbia             MO 65215      417-546-2570              muffin@fast.com                                   
I-300027                                            Danita          Sharp                Ms.   3475 Mystic St.                          Yakima               WA 98908      360-650-5604              girlfriend@fast.com                               
I-300028                                            Don             Kaleta               Mr.   8948 Washington St.                      Altoona              PA 16602      724-695-2157              stud@zeronet.net                                  
I-300029                                            Tammi           Baldocchio           Ms.   924 North Ave.                           Slatersville         RI 02876      401-989-4975                                                                
I-300030                                            Eric            Quintero             Mr.   144 Concord Rd.                          Columbus             IN 47202      812-805-1588              diamond@onlineservice.com                         
I-300031                                            Phillip         Hession              Mr.   7610 Hartford Ct.                        Battle Creek         MI 49016      231-711-6837              howdy@usol.com                                    
I-300032                                            Ruth            Albeering            Dr.   1348 Yonge Rd.                           Galax                VA 24333      784-444-0131              rabeering@free.com                                
I-300033                                            Jacob           Richer               Mr.   1490 N. Shore Rd.                        Ephrata              WA 98823      425-942-3763              laugh@free.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300034                                            James           Jones                Mr.   4685 Vernon St.                          Burns                OR 97720      971-522-5851              puffy@fast.com                                    
I-300035                                            Tim             Parker               Mr.   2848 Marrett Rd.                         Troy                 NY 12182      315-985-4102              jeckle@onlineservice.com                          
I-300036                                            Andrea          Montgomery           Ms.   1699 Conner Dr.                          Thurmont             MD 21788      349-397-7772                                                                
I-300037                                            Chas            Funk                 Mr.   2490 Maple St.                           Trumbull             CT 06611      860-498-3900              duck@usol.com                                     
I-300038                                            David           Smith                Mr.   9245 Main St.                            Rockford             IL 61125      309-980-4350              emerald@onlineservice.com                         
I-300040                                            Kathy           Gunderson            Mrs.  2257 Oak Springs Rd.                     Marianna             FL 32447      941-330-3314                                                                
I-300041                                            Dennis          Mundy                Mr.   5781 Red Bud Trail                       Littleton            NH 03561      603-306-0774              rino@usol.com                                     
I-300042                                            George          Trenkle              Mr.   1874 Jefferson Ave.                      Edison               NJ 08837      856-267-7913              cold@fast.com                                     
I-300043                                            Carey           Dailey               Ms.   234 Sheridan Dr.                         Denver               CO 80219      728-896-2767              shelty@usol.com                                   
I-300044                                            Louise          Cool                 Mrs.  6831 Walden Ave.                         Hailey               ID 83333      208-956-0698                                                                
I-300046                                            Jane            Mumford              Dr.   8235 Center Rd.                          Campbellsville       KY 42719      270-428-5866                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300047                                            Scott           Yarian               Dr.   4198 Center Ridge Rd.                    Whiteville           NC 28472      252-310-2224              syarian@fast.com                                  
I-300048                                            Patrick         Bollock              Mr.   1472 Bayley Rd.                          Powell               WY 82435      307-635-1692              pat@fast.com                                      
I-300049                                            Paul            Rice                 Mr.   830 Shaker Blvd.                         Craig                CO 81626      719-541-1837              paulier@onlineservice.com                         
I-300050                                            James           Schilling            Mr.   2021 North Bend Rd.                      Cedar Rapids         IA 52498      319-429-9772                                                                
Z-12345    Quick Stop                               Randal          Graves               Mr.                                            Leonardo             NJ 07737                                                                                  

225 rows selected. 

Question 11
1 row deleted.

no rows selected

Question 12

224 rows updated.


CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300051                                            Lynne           Lagunes              Ms.   2820 Beechmont Ave.                      Leonardo             NJ 83209      208-502-9976              hello@zeronet.net                                 
I-300052                                            Andrew          Yelnick              Mr.   6972 Winton Rd.                          Leonardo             NJ 48226      517-803-5818              family@free.com                                   
I-300053                                            Stephanie       Pearl                Mrs.  6460 Springdale Rd.                      Leonardo             NJ 64468      660-447-8319              mommyl@fast.com                                   
I-300054                                            Dorlan          Bresnaham            Dr.   1328 Mill Ave.                           Leonardo             NJ 03264      603-497-7374              dorlan@usol.com                                   
I-300055                                            Jon             Clute                Dr.   1680 River Oaks Blvd.                    Leonardo             NJ 85711      480-181-8940                                                                
I-300056                                            Elizabeth       Henderson            Ms.   2819 Otay Rd.                            Leonardo             NJ 57758      449-486-8018                                                                
I-300057                                            Tonya           Owens                Mrs.  1414 Fields Ertel Rd.                    Leonardo             NJ 29620      843-773-2751                                                                
I-300058                                            Matthew         Quant                Mr.   253 Silver Creek Rd.                     Leonardo             NJ 28345      910-577-1319              walker@onlineservice.com                          
I-300059                                            Kenneth         Mintier              Mr.   4831 Skeet Blvd.                         Leonardo             NJ 95534      323-673-0690              builder@usol.com                                  
I-300060                                            Lucille         Appleton             Ms.   5260 Blue Mound Rd.                      Leonardo             NJ 12553      914-497-2160              muscle@zeronet.net                                
I-300061                                            Brenda          Jones                Mrs.  3696 Cooper St.                          Leonardo             NJ 80230      720-800-2638              show@free.com                                     

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300062                                            John            McGinnis             Dr.   7841 Hurst Blvd.                         Leonardo             NJ 83263      208-741-1963              john@zeronet.net                                  
I-300063                                            Dennis          Eberle               Mr.   9425 James Rd.                           Leonardo             NJ 50707      515-708-1802              deber@free.com                                    
I-300064                                            Jo              Jacko                Mrs.  6588 Ken Caryl Rd.                       Leonardo             NJ 08361      856-752-7471                                                                
I-300065                                            Karen           Randolph             Ms.   1038 Coal Mine Rd.                       Leonardo             NJ 03235      603-744-9002              cookin@zeronet.net                                
I-300066                                            Ruth            Ball                 Dr.   1093 Valley View Ln.                     Leonardo             NJ 56387      651-479-7538                                                                
I-300067                                            Travis          Camargo              Mr.   6681 Forrest Ln.                         Leonardo             NJ 64853      816-746-4913                                                                
I-300068                                            Jerry           Muench               Mr.   1694 Stone Valley Rd.                    Leonardo             NJ 79059      464-669-8537              redhot@onlineservice.com                          
I-300069                                            Verna           McGrew               Ms.   4755 Rocket Blvd.                        Leonardo             NJ 35811      334-547-9329              verngrew@free.com                                 
I-300070                                            Elizabeth       Derhammer            Ms.   2343 Pioneer Pkwy.                       Leonardo             NJ 67868      785-970-9916              lizzy@onlineservice.com                           
I-300071                                            Ted             Zissa                Mr.   4935 Cedar Hill Rd.                      Leonardo             NJ 73402      405-151-7445                                                                
I-300072                                            Matt            Shade                Mr.   8441 Skillman Ave.                       Leonardo             NJ 85622      623-422-6616              shadtree@free.com                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300073                                            Dean            Eagon                Mr..  616 Burton Rd.                           Leonardo             NJ 81011      970-581-8611                                                                
I-300074                                            Andrew          Ray                  Mr.   1246 Ferry St.                           Leonardo             NJ 08332      609-345-9680              andyray@usol.com                                  
I-300075                                            Robert          Cortez               Mr.   219 Pleasant Run Rd.                     Leonardo             NJ 03435      603-442-3740                                                                
I-300076                                            Tim             Carlton              Mr.   1038 Lancaster St.                       Leonardo             NJ 06082      203-608-3465                                                                
I-300077                                            Jennifer        Hundley              Mrs.  6354 Buckner Blvd.                       Leonardo             NJ 26261      304-713-3298              jenhund@fast.com                                  
I-300078                                            Andrea          Griswold             Dr.   8215 Garland Rd.                         Leonardo             NJ 80429      970-746-0995              andygwold@usol.com                                
I-300079                                            Christina       Wilson               Mrs.  5766 Scyene Rd.                          Leonardo             NJ 67124      316-210-8989                                                                
I-300080                                            Juicheng        Nugent               Mr.   9443 Illinois Ave.                       Leonardo             NJ 05156      802-352-8923              nugent@fast.com                                   
I-300081                                            Bryan           Price                Mr.   1745 Best Line Rd.                       Leonardo             NJ 23666      804-674-9666                                                                
I-300082                                            Helene          Ziekart              Mrs.  9533 Simonds Rd.                         Leonardo             NJ 06511      203-244-9192                                                                
I-300083                                            Marty           Fay                  Ms.   9241 School Rd.                          Leonardo             NJ 99775      501-631-3727              sparky@free.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300084                                            Lisa            Pettry               Mrs.  8515 Cossell Ave.                        Leonardo             NJ 89714      702-799-7272              lpett@zeronet.net                                 
I-300085                                            Zach            McGrew               Mr.   5788 Rockville Rd.                       Leonardo             NJ 85502      520-730-8494                                                                
I-300086                                            Jamie           Thompson             Ms.   6878 Holt Ave.                           Leonardo             NJ 30606      706-471-1222              jthompson@onlineservice.com                       
I-300087                                            Charles         Jones                Mr.   1420 N. Highland Ave.                    Leonardo             NJ 33606      919-774-5552              charlie@usol.com                                  
I-300088                                            Thomas          Zelenka              Dr.   5371 Brookeville Rd.                     Leonardo             NJ 03108      603-374-3706              zelenka@free.com                                  
I-300089                                            James           Laake                Mr.   3434 Great Street                        Leonardo             NJ 82710      613-785-7063                                                                
I-300090                                            Daniel          Stabnik              Mr.   3745 35th St.                            Leonardo             NJ 63775      636-746-4124                                                                
I-300091                                            Trudi           Antonio              Ms.   9882 Strother Rd.                        Leonardo             NJ 13699      718-747-3259              toni@onlineservice.com                            
I-300092                                            John            Garcia               Mr.   231 63rd St.                             Leonardo             NJ 04122      207-311-0174              jgar@onlineservice.com                            
I-300093                                            Jay             Hanau                Mr.   5897 Sunset Rd.                          Leonardo             NJ 62959      773-490-8254                                                                
I-300095                                            Joshua          Cole                 Mr.   7903 Paradise Rd.                        Leonardo             NJ 38308      865-269-7782              fido@zeronet.net                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300096                                            David           Schilling            Mr.   8671 Chapel Rd.                          Leonardo             NJ 42102      502-421-1516                                                                
I-300097                                            Mary Ann        Rausch               Mrs.  3679 Western Ave.                        Leonardo             NJ 82938      307-944-3324              spiritual@free.com                                
I-300098                                            Allison         Roland               Mrs.  4599 S. Maodill Ave.                     Leonardo             NJ 33604      929-498-4174              alley@onlineservice.com                           
I-300099                                            Roy             Beer                 Mr.   8065 Colina Rd.                          Leonardo             NJ 98907      206-745-2584              wizzy@usol.com                                    
I-300100                                            Chris           Dunlap               Mrs.  3526 10th St.                            Leonardo             NJ 82731      307-473-2281                                                                
I-300101                                            Ansel           Farrell              Mr.   316 Birch St.                            Leonardo             NJ 50588      712-440-3934              prickly@onlineservice.com                         
I-300102                                            Jason           Laxton               Mr.   7858 Dowling Ave. N.                     Leonardo             NJ 01368      978-860-2824              coondog@usol.com                                  
I-300103                                            Larry           Gardiner             Mr.   1739 W 39th St.                          Leonardo             NJ 71295      225-313-6268              square@onlineserveice.com                         
I-300104                                            Lawrence        Pullen               Mr.   4599 Rheem Blvd.                         Leonardo             NJ 56726      644-591-3243              laurie@free.com                                   
I-300105                                            Matt            Nakanishi            Mr.   8108 Middle Rd.                          Leonardo             NJ 84501      435-710-5324              nakan@free.com                                    
I-300106                                            Nancy           Basham               Mrs.  3409 36th Ave. N.                        Leonardo             NJ 04930      207-422-7135                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300107                                            Rachel          Davis                Ms.   2954 Cedar Lake Rd.                      Leonardo             NJ 89523      702-907-4818              rachdav@zeronet.net                               
I-300108                                            Sarah           McCammon             Mrs.  3216 Dimond Lake Rd.                     Leonardo             NJ 86411      520-438-7944              squirrel@zeronet.net                              
I-300109                                            David           Tietz                Mr.   5235 E. 44th St.                         Leonardo             NJ 56265      651-912-1583              tietz@free.com                                    
I-300110                                            Jim             Manaugh              Mr.   1011 W. Hillsborough Ave.                Leonardo             NJ 33605      919-747-5603              jmanaugh@eagle.com                                
I-300111                                            Richard         Stetler              Mr.   7496 University Ave.                     Leonardo             NJ 36832      256-412-8112              screwball@free.com                                
I-300112                                            Jonathon        Blanco               Mr.   8095 Mounty Rd.                          Leonardo             NJ 54904      902-226-1858              hammer@free.com                                   
I-300113                                            Randolph        Darling              Mr.   8254 Coral Way                           Leonardo             NJ 06260      860-684-1620              randolph@fast.com                                 
I-300114                                            Melody          Fazal                Mrs.  4603 Killian Rd.                         Leonardo             NJ 93311      760-877-4849              melfazal@zeronet.net                              
I-300115                                            Michael         Tendam               Dr.   190 Dixie St.                            Leonardo             NJ 592331     406-424-7496              flute@usol.com                                    
I-300116                                            Sean            Akropolis            Mr.   6603 E. Little Yak Rd.                   Leonardo             NJ 99509      907-262-4254              pickle@free.com                                   
I-300117                                            Anne            Hatzell              Ms.   5200 Belfat Blvd.                        Leonardo             NJ 19973      302-651-6440              hazel@zeronet.net                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300118                                            Meredith        Rushing              Dr.   1856 Cullen Blvd.                        Leonardo             NJ 40516      606-608-2105              merry@free.com                                    
I-300120                                            Zack            Hill                 Mr.   2064 Preston Rd.                         Leonardo             NJ 97496      503-794-2322              boogie@free.com                                   
I-300121                                            Dan             Lageveen             Mr.   3056 Southern Ave. N.                    Leonardo             NJ 82073      307-344-8928              veenie@zeronet.net                                
I-300122                                            Marla           Reeder               Mrs.  1029 Moraga Ave. W.                      Leonardo             NJ 32425      728-442-3031              reedmar@zeronet.net                               
I-300123                                            Linda           Bowen                Mrs.  5541 Bell Rd.                            Leonardo             NJ 57350      605-234-4114                                                                
I-300124                                            Michael         Emore                Mr.   7347 Peoria Ave.                         Leonardo             NJ 32810      352-472-1224              mikemore@usol.com                                 
I-300125                                            Mary Jo         Wales                Dr.   1416 Wynnewood Ave.                      Leonardo             NJ 97885      852-441-4984              jomary@onlineservice.com                          
I-300126                                            Tom             Moore                Mr.   7742 Glendale Ave.                       Leonardo             NJ 04351      270-692-2845              seedle@fast.com                                   
I-300127                                            Susan           Watson               Mrs.  6151 Indian School Rd.                   Leonardo             NJ 84414      801-746-7701              mswatson@fast.com                                 
I-300128                                            Tom             Irelan               Mr.   7833 McDowell Rd.                        Leonardo             NJ 21503      240-634-5581              tucker@free.com                                   
I-300129                                            Rosemary        Vanderhoff           Dr.   843 99th St.                             Leonardo             NJ 31206      770-293-8783                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300130                                            Mike            Dunbar               Mr.   1750 Broadway St.                        Leonardo             NJ 83531      208-297-5374              duh@onlineservice.com                             
I-300131                                            Ryan            Stahley              Mr.   9281 E. Bird St.                         Leonardo             NJ 33606      919-774-5340              rstahley@eagle.com                                
I-300132                                            Patricia        Leong                Ms.   6213 Baseline Rd.                        Leonardo             NJ 86313      520-247-4141              patrice@usol.com                                  
I-300133                                            Roy             McGrew               Mr.   1968 Elliot Rd.                          Leonardo             NJ 83686      208-324-0783              grow@zeronet.net                                  
I-300134                                            Tom             Baker                Mr.   483 Greenway St.                         Leonardo             NJ 54656      414-778-5640              bologna@free.com                                  
I-300135                                            Bill            Umbarger             Mr.   1476 Eastern Pkwy.                       Leonardo             NJ 04915      207-155-1577              cheezy@onlineservice.com                          
I-300136                                            Bob             Weldy                Mr.   8227 Oak Ridge Rd.                       Leonardo             NJ 24506      571-490-6449              sucker42@usol.com                                 
I-300137                                            Kris            Shinn                Dr.   7451 Tiden St.                           Leonardo             NJ 79772      469-740-2748              shinnk@zeronet.net                                
I-300138                                            James           King                 Dr.   2734 Mulga Loop Rd.                      Leonardo             NJ 04457      207-708-3317              jamesk@usol.com                                   
I-300139                                            Frank           Malady               Mr.   7894 Geary Blvd.                         Leonardo             NJ 31533      574-493-0510              frankmala@zeronet.net                             
I-300140                                            Jim             Webb                 Mr.   3577 Hessian Ave.                        Leonardo             NJ 01853      978-204-3019                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300141                                            Daniel          Rodkey               Ms.   4024 Mill Plain Blvd.                    Leonardo             NJ 81052      719-748-3205              dannie@free.com                                   
I-300142                                            Marc            Williams             Mr.   8443 15th St.                            Leonardo             NJ 84721      435-774-4595              peanut@fast.com                                   
I-300143                                            Kristy          Moore                Ms.   4410 W. Spruce St.                       Leonardo             NJ 33603      919-486-6765              fluffy@onlineservice.com                          
I-300144                                            Russ            Mann                 Mr.   6879 Island Ave.                         Leonardo             NJ 89199      775-549-1798              scooter@onlineservice.com                         
I-300145                                            Carrie          Buchko               Mrs.  3793 Leheigh Ave.                        Leonardo             NJ 75951      817-739-1335              goobert@free.com                                  
I-300146                                            Michelle        Oakley               Ms.   5348 Elmwood Ave.                        Leonardo             NJ 02303      978-514-5425              littleone@usol.com                                
I-300147                                            Steven          Yaun                 Mr.   4711 Hook Rd.                            Leonardo             NJ 46208      317-780-9804              yawn@fast.com                                     
I-300148                                            Jack            Illingworth          Mr.   2741 Ashland Ave.                        Leonardo             NJ 14206      914-748-9829              illing@free.com                                   
I-300149                                            Thomas          Wolfe                Mr.   7347 Broad St.                           Leonardo             NJ 18510      610-365-9766              wolf@onlineservice.com                            
I-300150                                            Irene           Poczekay             Mrs.  7000 W. 7th St.                          Leonardo             NJ 02840      401-461-9567                                                                
I-300151                                            Andy            Huegel               Dr.   7542 Haverford Blvd.                     Leonardo             NJ 19963      302-620-1366                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300152                                            Karen           Marko                Ms.   4954 Clifton Rd.                         Leonardo             NJ 73506      580-555-1871              marko@usol.com                                    
I-300153                                            Trevor          Snuffer              Mr.   6550 Forbes Ave.                         Leonardo             NJ 27803      336-185-0630              snuffer@zeronet.net                               
I-300154                                            Phil            Reece                Mr.   1204 N. Nebraska Ave.                    Leonardo             NJ 33603      919-486-0649              sly@zeronet.net                                   
I-300155                                            Linda           Hari                 Mrs.  791 McKnight Rd.                         Leonardo             NJ 42134      270-411-2316                                                                
I-300156                                            Andrew          Smith                Mr.   1244 Fremont Ave.                        Leonardo             NJ 67879      709-307-2568              smokey@zeronet.net                                
I-300157                                            Linda           Li                   Ms.   5920 Grove St.                           Leonardo             NJ 06790      203-744-4677              ll@free.com                                       
C-300001   Baker and Company                        Gregory         Abbott               Mr.   7837 Busse Rd.                           Leonardo             NJ 47813      812-447-3621 812-447-4602 greggie@usol.com                                  
C-300002   Cole Sales and Associates                Tommy           McFerren             Dr.   3817 Farrell Rd.                         Leonardo             NJ 97709      503-767-7054 503-767-3394 mcferren@cole.com                                 
C-300003   Tippe Inn                                Cecil           Scheetz              Ms.   391 Weber Rd.                            Leonardo             NJ 04903      207-679-9822 207-679-6367 cecil@free.com                                    
C-300004   Franklin Trinkets                        Frank           Aamodt               Mr.   3304 Leredo Ave.                         Leonardo             NJ 06776      898-762-8741 898-762-9493 fa@fast.com                                       
C-300005   Needle Center                            Kathleen        Plyman               Ms.   7627 Belmont Ave                         Leonardo             NJ 10131      507-543-2052 507-543-1845 needles@onlineservice.com                         

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300006   BMA Advertising Design                   George          Purcell              Mr.   4281 Jefferson Rd.                       Leonardo             NJ 18522      432-320-6905 432-320-5741 design@zeronet.net                                
C-300007   Regency Hospital                         Eugene          Gasper               Mr.   7022 Ward Lake Rd.                       Leonardo             NJ 05641      705-580-6124 705-580-4250 medcare@fast.com                                  
C-300008   South Street Rehabilitation              Jared           Meers                Mr.   4271 Airport Rd.                         Leonardo             NJ 58026      701-371-1701 701-371-1372 rehabsouth@zeronet.net                            
C-300009   Dixon Pharmacy                           Tracy           Cicholski            Mrs.  1920 Albion St.                          Leonardo             NJ 39059      601-959-1315 601-959-4277 dixpharm@free.com                                 
C-300010   Photography Niche                        Bruce           Fogarty              Mr.   1012 Island Ave.                         Leonardo             NJ 26346      598-791-1420 598-791-8582 photoniche@usol.com                               
C-300011   Family Medical Center                    Susan           Strong               Mrs.  5883 Sudbury Rd.                         Leonardo             NJ 31620      912-760-7840 912-760-8489 fammed@onlineservice.com                          
C-300012   Bryant Accounting                        Ginger          Xiao                 Mrs.  6636 Walnut St.                          Leonardo             NJ 57703      605-846-0451 605-846-5219 acctsbryant@zeronet.net                           
C-300013   Recreation Supply                        Karen           Burns                Dr.   2850 Farm St.                            Leonardo             NJ 95354      707-598-2670 707-598-3072 burnskaren@fast.com                               
C-300014   R and R Air                              Cathy           Bending              Mrs.  9573 Chestnut St.                        Leonardo             NJ 47732      765-617-2811 765-617-5319 rrair@zeronet.net                                 
C-300015   Vets Inc.                                Evelyn          Cassens              Ms.   6094 Pearson St.                         Leonardo             NJ 19726      302-762-9526 302-762-3338 dr.animal@onlineservice.com                       
C-300016   Goodwork Corporation                     Angie           Hoover               Ms.   6427 Genesee St.                         Leonardo             NJ 82638      307-459-4165 307-459-2606 ahoover@free.com                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300017   Powerful Employment                      Jim             Sokeland             Mr.   6671 Pearl Rd.                           Leonardo             NJ 21136      723-366-1117 723-366-0896 employment@zeronet.net                            
C-300018   Wadake Critters                          Hugo            Gillespie            Mr.   4194 Northfield Rd.                      Leonardo             NJ 67402      785-981-0669 785-981-6634 critters@free.com                                 
C-300019   Conner National                          Wade            Jacobs               Ms.   2610 E. Lake Rd.                         Leonardo             NJ 58653      803-477-5347 803-477-5487 connernat@usol.com                                
C-300021   Realty Specialties                       David           Tarter               Mr.   6274 Blue Rock Rd.                       Leonardo             NJ 13261      518-500-0570 518-500-6159 estate@fast.com                                   
C-300022   Reflexions Manufacturing                 Heather         Wallpe               Ms.   4128 Hulen St.                           Leonardo             NJ 63653      816-433-9799 816-433-3621 flex@onlineservice.com                            
C-300023   TAS                                      Robert          Dalury               Mr.   4718 Pleasant Valley Rd.                 Leonardo             NJ 48708      906-278-6446 906-278-4345 tas@zeronet.net                                   
C-300024   Bankruptcy Help                          Jim             Lichty               Mr.   5991 Kenwood Rd.                         Leonardo             NJ 60624      618-847-1904 618-847-6439 bankrupt@usol.com                                 
C-300025   Railroad Express                         Dusty           Jones                Dr.   1390 Clearview Pkwy.                     Leonardo             NJ 83826      674-727-0511 674-727-1560 rr@usol.com                                       
C-300026   City Bus Transport                       Larry           Osmanova             Mr.   256 Royal Ln.                            Leonardo             NJ 97311      541-905-4819 541-905-8042 citybus@fast.com                                  
C-300027   Vacation Car Rentals                     Richard         Strehle              Mr.   9862 Rock Island Rd.                     Leonardo             NJ 99362      206-434-7305 206-434-1892 vacation@fast.com                                 
C-300028   Cheesman Corporation                     Brenda          Kitchel              Mrs.  6482 Thomasen Rd.                        Leonardo             NJ 24011      804-214-8732 804-214-1253 cheesman@zeronet.net                              

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300029   Down Deep Drilling Inc.                  Don             Torres               Mr.   1979 Illinois Ave.                       Leonardo             NJ 30635      706-649-6375 706-649-0420 drill@usol.com                                    
C-300030   Main St. Bar and Grill                   Richard         Kluth                Dr.   7901 Peach Tree Dr.                      Leonardo             NJ 19709      302-296-8012 302-296-5060 rickkluth@free.com                                
C-300031   Copy Center                              Allen           Robles               Mr.   1228 Bailey Rd.                          Leonardo             NJ 80761      644-730-8090 644-730-3557 copy@onlineservice.com                            
C-300032   Greenpart Steet Metal                    Archie          Doremski             Mr.   6580 Midway Rd.                          Leonardo             NJ 82414      307-944-8959 307-944-3950 sheetz@free.com                                   
C-300033   Pools For You                            Daniel          Ezra                 Mr.   7393 Lake June Rd.                       Leonardo             NJ 04212      207-744-1997 207-744-8795 swim@zeronet.net                                  
C-300034   Phone Corporation                        Dean            Katpally             Mr.   1179 38th St.                            Leonardo             NJ 96746      808-799-3727 808-7991677  phonecorp@usol.com                                
C-300035   Store It Here                            Randall         Neely                Mr.   1132 Madison St.                         Leonardo             NJ 05701      802-319-9805 802-319-1266 storage@fast.com                                  
C-300036   Kids Recreation Inc.                     Mike            Condie               Mr.   449 Troy Ave.                            Leonardo             NJ 27895      336-211-1238 336-211-3812 kidrec@zeronet.net                                
C-300037   Trailor Rentals                          Tim             Leffert              Mr.   2765 Independence Ave.                   Leonardo             NJ 13442      315-486-4777 315-486-0683 trailrent@zeronet.net                             
C-300038   Water Analysts                           Carl            Dallas               Mr.   2530 Lakewood Blvd.                      Leonardo             NJ 29153      864-541-5114 864-541-9632 analyzeh20@fast.com                               
C-300039   Gards Auto Repair                        Dennis          Sammons              Mr.   581 Sahara Blvd.                         Leonardo             NJ 48609      616-544-1969 616-544-3365 repairit@free.com                                 

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300040   Computer Consultants                     Mildred         Jones                Ms.   2278 Flamingo Rd.                        Leonardo             NJ 18195      610-437-6687 610-437-6210 compconsul@usol.com                               
C-300041   Laser Graphics Associates                Paul            Kaakeh               Mr.   3616 Jones Blvd.                         Leonardo             NJ 81247      719-750-4539 719-750-9842 graphit@usol.com                                  
C-300042   Signs Signs Signs                        Kevin           Zubarev              Mr.   5933 Valley St.                          Leonardo             NJ 83221      208-364-3785 208-364-5230 sign3@fast.com                                    
C-300043   Flowers by Mickey                        Mary            Uhl                  Ms.   6936 Citrus Blvd.                        Leonardo             NJ 29413      803-974-2809 803-974-6131 mouse@fast.com                                    
C-300044   Kelly Dance Studio                       Jennifer        Kmec                 Mrs.  9413 E. Broadway St.                     Leonardo             NJ 21787      443-542-1386 443-542-0474 dancingk@free.com                                 
C-300045   National Art Museum                      Marjorie        Vandermay            Ms.   5384 Raymond Ave.                        Leonardo             NJ 68310      308-489-1137 308-489-9640 nam@fast com                                      
C-300046   Tuckers Jewels                           Stephanie       Yeinick              Ms.   2596 S. Fairview Rd.                     Leonardo             NJ 65270      573-455-4278 573-455-3163 jewels@usol.com                                   
C-300047   The Employment Agency                    Cathy           Harvey               Mrs.  9481 Town Line Rd.                       Leonardo             NJ 28810      336-477-0249 336-477-7464 findwork@onlineservice.com                        
C-300048   Cleaning Supply                          Geo             Schofield            Mr.   4931 Talbot Blvd.                        Leonardo             NJ 38967      228-480-9751 228-480-4037 cleanit@usol.com                                  
C-300049   Appliances Inc.                          Kara            Orze                 Ms.   2666 Stillwater Rd.                      Leonardo             NJ 54401      414-773-1017 414-773-2842 appinc@zeronet.net                                
C-300050   Quality Equipment Corp.                  Jeff            Kowaiski             Mr.   3323 Mission Pkwy.                       Leonardo             NJ 14895      212-492-5644 212-492-9525 equipit@usol.com                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300051   Sharons Shamrock                         Sharon          Rouls                Mrs.  1274 Weaver Rd.                          Leonardo             NJ 36303      205-246-3224 205-246-5699 irish@free.com                                    
C-300052   Manufactured Homes Corp.                 Sherry          Garling              Ms.   4350 Concord Blvd.                       Leonardo             NJ 04462      353-822-7623 353-822-9722 homely@fast.com                                   
C-300053   Camping Supplies                         Mary            Deets                Mrs.  4534 South Acres Rd.                     Leonardo             NJ 96782      808-562-4081 808-562-0004 camphere@fast.com                                 
C-300054   Financial Planning Consul                Dennis          Drazer               Dr.   4799 Silverstar Rd.                      Leonardo             NJ 98115      253-315-4247 253-315-7522 dollarplan@usol.com                               
C-300055   Fire Alarm Systems                       Robert          Lister               Mr.   3016 Dunlap Ave.                         Leonardo             NJ 84603      801-404-1240 801-404-8056 fines@free.com                                    
C-300056   Happytime Escort Service                 Heather         Waters               Mrs.  805 Cactus Rd.                           Leonardo             NJ 29560      869-741-7817 869-741-0539 dates@free.com                                    
C-300057   Industrail Contracting Co                Anita           Pastron              Ms.   2817 Northern Ave.                       Leonardo             NJ 37111      901-796-4654 901-796-3276 contracts@fast.com                                
C-300058   Outlets                                  Amy             Heide                Ms.   9119 Camelback Rd.                       Leonardo             NJ 05304      802-894-1024 802-894-1135 letout@usol.com                                   
C-300059   Rydell High School                       Charlene        Franks               Mrs.  1627 Thomas Rd.                          Leonardo             NJ 82633      307-892-2938 307-892-1477 learn@rydell.edu                                  
C-300060   Collectibles Inc.                        Doug            Blizzard             Mr.   856 Van Buren St.                        Leonardo             NJ 39666      228-646-5114 228-646-2170 collectit@onlineservice.com                       
C-300061   Karate Made Easy                         Richard         Scott                Mr.   1489 Dobbins Rd.                         Leonardo             NJ 26555      304-774-2226 304-774-8150 kick@onlineservice.com                            

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300062   Security Installation                    Scott           Gray                 Mr.   115 Shea Blvd.                           Leonardo             NJ 17406      484-453-7105 484-453-6614 keepsafe@zeronet.net                              
C-300063   Ceramic Supply                           Randy           Talauage             Mr.   6364 Brown St.                           Leonardo             NJ 99157      347-671-2022 347-671-9116 paintit@fast.com                                  
C-300064   Bobs Repair Service                      Daniel          Hundnall             Mr.   909 Reams Rd.                            Leonardo             NJ 73705      918-830-9731 918-830-3898 fixit@usol.com                                    
C-300065   Investment Specialties                   Sally           Valle                Dr.   6298 Killingsworth St.                   Leonardo             NJ 76208      972-234-2044 972-234-1543 roi@usol.com                                      
C-300066   North Street Church                      Noemi           Elston               Mr.   3024 28th St.                            Leonardo             NJ 82902      307-359-9514 307-359-8090 closetoheaven@zeronet.net                         
C-300067   Supplying Crafts                         Kelly           Jordan               Ms.   168 Division St.                         Leonardo             NJ 32205      727-951-7737 727-951-9889 supplycrafts@fast.com                             
C-300068   Cellular Services                        Steve           Fulkerson            Mr.   6912 White Horse Rd.                     Leonardo             NJ 85937      602-129-1885 602-129-5545 cellcall@usol.com                                 
C-300069   Easy Internet Access                     Orville         Gilliland            Mr.   5515 Page-Mill Rd.                       Leonardo             NJ 39565      490-263-2957 490-263-6303 eia@zeronet.net                                   
C-300070   Sampson Home Mortgages                   Bridgette       Kyger                Mrs.  5682 Chester Pike Rd.                    Leonardo             NJ 21412      301-467-6480 301-467-5740 homeloans@fast.com                                
C-300071   The Cable Company                        Norman          Fields               Dr.   4174 Collings St.                        Leonardo             NJ 99811      501-346-4841 501-346-0928 catv@onlineservice.com                            
C-300072   Automart                                 Jessica         Nakamura             Ms.   8233 Clairton Ave.                       Leonardo             NJ 57301      605-324-2193 605-324-1030 carsell@usol.com                                  

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
C-300073   First National Bank                      Jack            Barrick              Mr.   2638 Becks Run Rd.                       Leonardo             NJ 32783      786-494-4782 786-494-1359 1natbank@free.com                                 
I-300001                                            Anna            Mayton               Dr.   2381 Basse Rd.                           Leonardo             NJ 36456      888-451-1233              doctor@free.com                                   
I-300002                                            Lou             Caldwell             Mr.   1486 Joliet Rd.                          Leonardo             NJ 40211      606-901-1238              lucky@fast.com                                    
I-300004                                            Jeffery         Jordan               Mr.   1500 Normantown Rd.                      Leonardo             NJ 99211      509-989-9996              seeya@usol.com                                    
I-300005                                            Kimber          Spaller              Mrs.  1565 Culebra Rd.                         Leonardo             NJ 99836      878-119-5448              mcgimmie@zero.net                                 
I-300006                                            Eric            Fannon               Mr.   2526 Nelson Rd.                          Leonardo             NJ 96003      209-980-0812              ef@free.com                                       
I-300007                                            Jessica         Cain                 Ms.   942 55th St.                             Leonardo             NJ 48838      517-901-2610                                                                
I-300008                                            Richard         Zito                 Mr.   7569 130th St.                           Leonardo             NJ 03766      603-787-0787              rzito@zeronet.net                                 
I-300009                                            Angela          Wainscott            Dr.   3646 North Ave.                          Leonardo             NJ 83415      208-788-4112              awainscott@free.com                               
I-300010                                            James           Gross                Dr.   1983 Mill St.                            Leonardo             NJ 08701      908-879-8672              jgross@fast.com                                   
I-300011                                            Jack            Akers                Mr.   1485 71st St.                            Leonardo             NJ 19850      301-454-6061              pizazz@usol.com                                   

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300012                                            Kevin           Jackson              Mr.   5990 Cuba Rd.                            Leonardo             NJ 70123      225-624-2341                                                                
I-300013                                            Shirley         Osborne              Mrs.  816 Penny Rd.                            Leonardo             NJ 30401      706-333-7174                                                                
I-300014                                            Eric            Becker               Mr.   8784 Wabash Ave.                         Leonardo             NJ 28504      910-717-7613              daddyo@usol.com                                   
I-300015                                            Karen           Mangus               Mrs.  4804 Ridge Rd.                           Leonardo             NJ 33871      863-623-0459              missright@onlineservice.com                       
I-300016                                            Peter           Austin               Mr.   4804 River Rd.                           Leonardo             NJ 29812      803-343-6063                                                                
I-300017                                            Brad            Arquette             Mr.   2599 Ben Hill Rd.                        Leonardo             NJ 89049      775-914-4294              arq@usol.com                                      
I-300018                                            Daniel          Barton               Mr.   4599 Atlanta Rd.                         Leonardo             NJ 79556      915-894-8034              dannie@zeronet.net                                
I-300019                                            Jerry           Mennen               Dr.   869 Clay St.                             Leonardo             NJ 86038      520-306-8426              mennenj@free.com                                  
I-300020                                            Kenneth         Wilcox               Mr.   9364 Hershell Rd.                        Leonardo             NJ 50801      515-872-8848              kenny@onlineservice.com                           
I-300021                                            Matt            Smith                Mr.   6804 All Rd.                             Leonardo             NJ 81402      719-822-8828              matsm@fast.com                                    
I-300022                                            Paul            Sullivan             Mr.   9399 Flat Rd.                            Leonardo             NJ 67251      785-322-5896              sullie@zeronet.net                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300023                                            Gerald          Campbell             Dr.   1869 Boundary St.                        Leonardo             NJ 53964      431-087-1044              gcampbell@free.com                                
I-300024                                            Joan            Hedden               Mrs.  4518 Red Bud Trail                       Leonardo             NJ 72765      501-710-0658                                                                
I-300025                                            Ronald          Miller               Mr.   360 Spring St.                           Leonardo             NJ 49008      734-820-2076              picky@zeronet.net                                 
I-300026                                            Terry           Xu                   Ms.   2019 Elm St.                             Leonardo             NJ 65215      417-546-2570              muffin@fast.com                                   
I-300027                                            Danita          Sharp                Ms.   3475 Mystic St.                          Leonardo             NJ 98908      360-650-5604              girlfriend@fast.com                               
I-300028                                            Don             Kaleta               Mr.   8948 Washington St.                      Leonardo             NJ 16602      724-695-2157              stud@zeronet.net                                  
I-300029                                            Tammi           Baldocchio           Ms.   924 North Ave.                           Leonardo             NJ 02876      401-989-4975                                                                
I-300030                                            Eric            Quintero             Mr.   144 Concord Rd.                          Leonardo             NJ 47202      812-805-1588              diamond@onlineservice.com                         
I-300031                                            Phillip         Hession              Mr.   7610 Hartford Ct.                        Leonardo             NJ 49016      231-711-6837              howdy@usol.com                                    
I-300032                                            Ruth            Albeering            Dr.   1348 Yonge Rd.                           Leonardo             NJ 24333      784-444-0131              rabeering@free.com                                
I-300033                                            Jacob           Richer               Mr.   1490 N. Shore Rd.                        Leonardo             NJ 98823      425-942-3763              laugh@free.com                                    

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300034                                            James           Jones                Mr.   4685 Vernon St.                          Leonardo             NJ 97720      971-522-5851              puffy@fast.com                                    
I-300035                                            Tim             Parker               Mr.   2848 Marrett Rd.                         Leonardo             NJ 12182      315-985-4102              jeckle@onlineservice.com                          
I-300036                                            Andrea          Montgomery           Ms.   1699 Conner Dr.                          Leonardo             NJ 21788      349-397-7772                                                                
I-300037                                            Chas            Funk                 Mr.   2490 Maple St.                           Leonardo             NJ 06611      860-498-3900              duck@usol.com                                     
I-300038                                            David           Smith                Mr.   9245 Main St.                            Leonardo             NJ 61125      309-980-4350              emerald@onlineservice.com                         
I-300040                                            Kathy           Gunderson            Mrs.  2257 Oak Springs Rd.                     Leonardo             NJ 32447      941-330-3314                                                                
I-300041                                            Dennis          Mundy                Mr.   5781 Red Bud Trail                       Leonardo             NJ 03561      603-306-0774              rino@usol.com                                     
I-300042                                            George          Trenkle              Mr.   1874 Jefferson Ave.                      Leonardo             NJ 08837      856-267-7913              cold@fast.com                                     
I-300043                                            Carey           Dailey               Ms.   234 Sheridan Dr.                         Leonardo             NJ 80219      728-896-2767              shelty@usol.com                                   
I-300044                                            Louise          Cool                 Mrs.  6831 Walden Ave.                         Leonardo             NJ 83333      208-956-0698                                                                
I-300046                                            Jane            Mumford              Dr.   8235 Center Rd.                          Leonardo             NJ 42719      270-428-5866                                                                

CUSTOMERID COMPANYNAME                              CUSTFIRSTNAME   CUSTLASTNAME         CUSTT ADDRESS                                  CITY                 ST POSTALCODE PHONE        FAX          EMAILADDR                                         
---------- ---------------------------------------- --------------- -------------------- ----- ---------------------------------------- -------------------- -- ---------- ------------ ------------ --------------------------------------------------
I-300047                                            Scott           Yarian               Dr.   4198 Center Ridge Rd.                    Leonardo             NJ 28472      252-310-2224              syarian@fast.com                                  
I-300048                                            Patrick         Bollock              Mr.   1472 Bayley Rd.                          Leonardo             NJ 82435      307-635-1692              pat@fast.com                                      
I-300049                                            Paul            Rice                 Mr.   830 Shaker Blvd.                         Leonardo             NJ 81626      719-541-1837              paulier@onlineservice.com                         
I-300050                                            James           Schilling            Mr.   2021 North Bend Rd.                      Leonardo             NJ 52498      319-429-9772                                                                

224 rows selected. 

Question 13

Table EMPLOYEE_BOTTOM_25 created.


Table EMPLOYEE_TOP_10 created.


Table EMPLOYEE_OTHERS created.

Question 14

40 rows inserted.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100101     Joanne Rosner                       Assembly                                  16.3
100120     Michelle Nairn                      Assembly                                 16.75
100204     David Keck                          Assembly                                  17.8
100220     Todd Vigus                          Accountant                                  15
100399     Ronald Day                          Assembly                                 16.25
100475     Steve Hess                          Assembly                                  17.6
100550     Allison Roland                      Assembly                                 16.85
100600     Calie Zollman                       Sales                                    17.35
100892     Joseph Platt                        Assembly                                 17.95
100967     Nicholas Albregts                   Assembly                                  15.5
100989     Kathryn Deagen                      Assembly                                 16.95

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
101007     Jason Krasner                       Sales                                    12.75
101030     Kristey Moore                       Assembly                                  13.6
101045     Austin Ortman                       Assembly                                  10.5
101066     Laura Rodgers                       Sales                                     12.6
101088     Patricha Underwood                  Assembly                                 18.45
101089     Melissa Alvarez                     Assembly                                 13.25
101097     Jack Brose                          Assembly                                 12.05
101115     Steve Cochran                       Assembly                                  10.5
101135     David Deppe                         Assembly                                 11.65
101154     Gregory Hettinger                   Assembly                                 11.25
101166     Phil Reece                          Assembly                                  10.5

22 rows selected. 


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100365     Sherman Cheswick                    President                                99900
100650     Edna Lilley                         VP Information                           93900


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100001     Jim Manaugh                         Chief Financial Officer                  75500
100103     Rita Bush                           VP Operations                            85800
100104     Michael Abbott                      Engineer                                 74400
100106     Paul Eckelman                       Accountant                               53600
100112     Steven Hickman                      Programmer Analyst                       57600
100125     Gabrielle Stevenson                 Chief Information Officer                75300
100127     Jason Wendling                      Operations Officer                       65600
100200     Beth Zobitz                         Engineer                                 55200
100206     Kathleen Xolo                       VP Finance                               80700
100209     Tina Yates                          Engineer                                 52000
100330     Kristen Gustavel                    Operations Officer                       68800

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100488     Jamie Osman                         Programmer Analyst                       46300
100559     Meghan Tyrie                        Engineer                                 50100
100700     Charles Jones                       DBA                                      65600
100880     Gary German                         Chief Sales Officer                      48900
100944     Ryan Stahley                        Engineer                                 48600

16 rows selected. 

Question 15

22 rows deleted.


16 rows deleted.


2 rows deleted.


Question 16
Table EMPLOYEE_TOP_1 created.

Question 17

41 rows inserted.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100101     Joanne Rosner                       Assembly                                  16.3
100120     Michelle Nairn                      Assembly                                 16.75
100204     David Keck                          Assembly                                  17.8
100220     Todd Vigus                          Accountant                                  15
100399     Ronald Day                          Assembly                                 16.25
100475     Steve Hess                          Assembly                                  17.6
100550     Allison Roland                      Assembly                                 16.85
100600     Calie Zollman                       Sales                                    17.35
100892     Joseph Platt                        Assembly                                 17.95
100967     Nicholas Albregts                   Assembly                                  15.5
100989     Kathryn Deagen                      Assembly                                 16.95

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
101007     Jason Krasner                       Sales                                    12.75
101030     Kristey Moore                       Assembly                                  13.6
101045     Austin Ortman                       Assembly                                  10.5
101066     Laura Rodgers                       Sales                                     12.6
101088     Patricha Underwood                  Assembly                                 18.45
101089     Melissa Alvarez                     Assembly                                 13.25
101097     Jack Brose                          Assembly                                 12.05
101115     Steve Cochran                       Assembly                                  10.5
101135     David Deppe                         Assembly                                 11.65
101154     Gregory Hettinger                   Assembly                                 11.25
101166     Phil Reece                          Assembly                                  10.5

22 rows selected. 


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100365     Sherman Cheswick                    President                                99900
100650     Edna Lilley                         VP Information                           93900


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100001     Jim Manaugh                         Chief Financial Officer                  75500
100103     Rita Bush                           VP Operations                            85800
100104     Michael Abbott                      Engineer                                 74400
100106     Paul Eckelman                       Accountant                               53600
100112     Steven Hickman                      Programmer Analyst                       57600
100125     Gabrielle Stevenson                 Chief Information Officer                75300
100127     Jason Wendling                      Operations Officer                       65600
100200     Beth Zobitz                         Engineer                                 55200
100206     Kathleen Xolo                       VP Finance                               80700
100209     Tina Yates                          Engineer                                 52000
100330     Kristen Gustavel                    Operations Officer                       68800

EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100488     Jamie Osman                         Programmer Analyst                       46300
100559     Meghan Tyrie                        Engineer                                 50100
100700     Charles Jones                       DBA                                      65600
100880     Gary German                         Chief Sales Officer                      48900
100944     Ryan Stahley                        Engineer                                 48600

16 rows selected. 


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100365     Sherman Cheswick                    President                                99900


INSERT ALL achieves the desired result because it allows for the same employee to be inserted
into multiple tables. INSERT FIRST did not allow an employee to be in both the top 10 and top 1
tables because it only inserts into the first table that it fits into.


Question 18

1 row updated.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100365     Sherman Cheswick                    President                               119880

Question 19

1 row inserted.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100365     Sherman Cheswick                    President                               119880
101        Happy Owner                         Big Boss                               1000000

Question 20

2 rows merged.


EMPLOYEE_I EMPLOYEE_NAME                       JOB_TITLE                               SALARY
---------- ----------------------------------- ----------------------------------- ----------
100365     Sherman Cheswick                    President                               119880
100650     Edna Lilley                         VP Information                           93900
101        Happy Owner                         Big Boss                               1000000


Question 21

Table COPY_CUSTOMER dropped.


Table PERSON_OF_INTEREST dropped.


Table EMPLOYEE_TOP_10 dropped.


Table EMPLOYEE_TOP_1 dropped.


Table EMPLOYEE_BOTTOM_25 dropped.


Table EMPLOYEE_OTHERS dropped.



*/




