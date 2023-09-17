################################################################################
# Create a resource group
################################################################################

module "resource_group" {
  source                 = "../../modules/ResourceGroup"
  environment            = "${terraform.workspace}"
  region                 = var.location
  tags                   = var.tags
}

################################################################################
# Create a function App
################################################################################

module "function_app" {
  source                = "../../modules/FunctionApp"
  environment           = "${terraform.workspace}"
  tags                  = var.tags
  rg_name               = module.resource_group.rg_name
  region                = var.location
  sql_connection_string = module.sql_db.connection_string
}

################################################################################
# Create a SQL database
################################################################################

module "sql_db" {
  source                 = "../../modules/SQLDatabase"
  environment            = "${terraform.workspace}"
  tags                   = var.tags
  rg_name                = module.resource_group.rg_name
  region                 = var.location
}

