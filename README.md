# Azure-CRUD-Api
Basic CRUD Api using Azure and Terraform stack

# Executing terraform

```terraform init```
```terraform workspace select azure-crud-example```
```terraform init```
```terraform plan -var-file=./config/azure-crud-example.tfvars -out=./azure-crud-example.tfplan```

```terraform apply -input=false ./azure-crud-example.tfplan```

