CREATE USER "dev-azure-crud-example-function-app" FROM EXTERNAL PROVIDER;
ALTER ROLE db_datareader ADD MEMBER "dev-azure-crud-example-function-app"
ALTER ROLE db_datawriter ADD MEMBER "dev-azure-crud-example-function-app"
