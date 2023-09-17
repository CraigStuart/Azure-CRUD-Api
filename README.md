# Azure-CRUD-Api
Basic CRUD Api using Azure and Terraform stack

# Steps
1. Create infrastructure
2. Execute sql scripts in folder "sqlScripts" - create a table and stored proc
3. Deploy functions

# Executing scripts

```
terraform init
```
```
terraform workspace new dev-azure-crud-example
```
```
terraform workspace select dev-azure-crud-example
```
```
terraform init
```
```
terraform plan -var-file=./config/dev-azure-crud-example.tfvars -out=./dev-azure-crud-example.tfplan
```
```
terraform apply -input=false ./dev-azure-crud-example.tfplan
```

# References

```
https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-azure-sql-input?tabs=in-process&pivots=programming-language-python
```

```
https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-azure-sql-output?tabs=in-process&pivots=programming-language-python
```

# Testing 


Example json for functions:

```
{"Id":1, "title":"1"}
```
