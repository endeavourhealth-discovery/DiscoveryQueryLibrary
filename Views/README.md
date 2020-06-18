# Views

Views are used to create virtual tables that generally consist of a combination of 
columns from multiple tables.  They are used to abstract complicated logic into a 
simple select statement. 

## WSIC Views

We currently have mySQL and MSSQL versions of views based on the requirements set out
by WSIC.  The definition of the views can be found in the spreadsheet in the Dataset 
directory.

Install these by running each script in order against your database and then you can run 
sql such as  
`select * from patient_view where nhs_number = 'xxxxxxxxxx`;
