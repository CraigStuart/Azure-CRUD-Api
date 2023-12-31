# Create a standard storage account
resource "azurerm_storage_account" "crud_app_sa" {
  name                     = "functioncrudapp"
  resource_group_name      = var.rg_name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = var.tags
}

# Create a service plan
resource "azurerm_app_service_plan" "crud_app_sp" {
  name                = "${var.environment}-functions-sp"
  location            = var.region
  resource_group_name = var.rg_name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  lifecycle {
    ignore_changes = [
      kind
    ]
  }
  tags = var.tags
}

# Create a function app
resource "azurerm_function_app" "crud_app_fa" {
  name                       = "${var.environment}-function-app"
  location                   = var.region
  resource_group_name        = var.rg_name
  app_service_plan_id        = azurerm_app_service_plan.crud_app_sp.id
  storage_account_name       = azurerm_storage_account.crud_app_sa.name
  storage_account_access_key = azurerm_storage_account.crud_app_sa.primary_access_key
  os_type                    = "linux"
  version                    = "~4"
  https_only                 = false

  connection_string {
    name  = "SqlConnectionString"
    type  = "MySql"
    value = "${var.sql_connection_string}"
  }

  site_config {
    linux_fx_version = "python|3.9"
  }
  tags = var.tags
}

# Create a api managment to expose the functions
resource "azurerm_api_management" "default" {
  name                       = "${var.environment}-api-management"
  location                   = var.region
  resource_group_name        = var.rg_name
  publisher_name             = "My Company"
  publisher_email            = "craigstuart@icloud.com"
  sku_name                   = "Developer_1"
}

# Create a api managment backend to the functions
resource "azurerm_api_management_backend" "default" {
  name                       = "${var.environment}-api-management-backend"
  api_management_name        = azurerm_api_management.default.name
  resource_group_name        = var.rg_name
  protocol                   = "http"
  url                        = "https://${azurerm_function_app.crud_app_fa.name}.azurewebsites.net/api/"
}

