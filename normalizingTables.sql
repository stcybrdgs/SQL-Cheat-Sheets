/*
** Normalize your tables to reduce redundancy and to prevent inconsistencies.
** Rules for First Normal Form (aka 1NF): 
**     1NF RULE 1 - Create a unique identifier to serve as a primary key
**     1NF RULE 2 - (one col becomes many) Break fields into smallest component parts with one column for each part
**     1NF RULE 3 - (many cols become few) Remove areas where you want multiple instances of the same type of data 
**                  (such as phone number, credit card number, etc), and then 
**                  require a separate record for each instance rather than a separate column,
**                  i.e., just one column for each type of data, 
**                        just one record for each different instance of each type of data
*/
-- Example of normalizing a new table per First Normal Form (1NF)
CREATE TABLE Customers2(
	-- 1NF RULE 1: create a unique ID
	Customer_ID,			
	-- 1NF RULE 2: one col becomes many
	-- Customer_Name --> First_Name  | Last_Name
	First_Name,			
	Last_Name,
	-- 1NF RULE 2: one col becomes many
	-- Home_Address --> Street_Address | City | State  | Zip
	Street_Address,
	City,
	State,
	Zip,
	Email_Address,
	-- 1NF RULE 3: many cols become few 
	-- Cell_Phone | Work_Phone | Home_Phone --> Phone_Number | Phone_Type
	Phone_Number,
	Phone_Type,
	-- INF RULE 3: many cols become few
	-- Primary_Card | Secondary_Card | Tertiary_Card --> Credit_Card | Card_Type
	Credit_Card_Number,
	Card_Type
	-- rem: in the case of Phone_Number and Credit_Card_Number, you may want to create keys
	-- to separate tables to create relationships that will allow for 
	-- many possible Credit_Card_Number and Phone_Number instances
);