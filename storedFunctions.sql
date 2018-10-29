/*
**  Functions in SQL provide a consistent way to accept parameters into logical routines.  
**  This code creates a Scalar function (ie, returns a single value from the function)
*/


-- ///////////////////////////////////////////////////
-- add a new table to the database for sales tax figures
USE [H+Active];

CREATE TABLE SalesTaxRates (
    State nchar(2) NOT NULL,
    TaxRate decimal(4,2) NOT NULL
);
GO
INSERT INTO SalesTaxRates (State, TaxRate)
VALUES ('CA', 9.0), ('CT', 5.0), ('FL', 8.5), ('IL', 3.8), ('IN', 6.2), ('NJ', 7.25), ('OH', 4.87), ('PA', 5.5), ('UT', 0);

*/
--
-- statement for function
CREATE FUNCTION CalcSalesTax
(
    -- Add the parameters for the function here
    @Total money,
    @TaxRate decimal(4,2)
)
RETURNS money
AS
BEGIN
    -- Declare the return variable here
    DECLARE @SalesTaxDue money

    -- Add the T-SQL statements to compute the return value here
    SELECT @SalesTaxDue = ((@TaxRate * .01) * @Total);

    -- Return the result of the function
    RETURN @SalesTaxDue

END
GO


-- ///////////////////////////////////////////////////
-- use your new CalcSalesTax function in a query
SELECT  Invoices.InvoiceID, Customers.FirstName, Customers.LastName, Customers.State, 
		InvoiceTotals.InvoiceTotal, SalesTaxRates.TaxRate, 
		-- use new CalcSalesTax function to return TaxDue values
		-- based on existing values for InvoiceTotal and TaxRate
		dbo.CalcSalesTax(InvoiceTotals.InvoiceTotal, SalesTaxRates.TaxRate) AS TaxDue
FROM    InvoiceTotals INNER JOIN
        Invoices ON InvoiceTotals.InvoiceID = Invoices.InvoiceID INNER JOIN
        Customers ON Invoices.CustomerID = Customers.CustomerID INNER JOIN
        SalesTaxRates ON Customers.State = SalesTaxRates.State
ORDER BY Invoices.InvoiceID;