resource "azurerm_resource_group" "crud_app_rg" {
  name     = "${var.environment}-azure-app-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "crud_app_sa" {
  name                     = "functioncrudapp"
  resource_group_name      = azurerm_resource_group.crud_app_rg.name
  location                 = azurerm_resource_group.crud_app_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "crud_app_sp" {
  name                = "${var.environment}-functions-sp"
  location            = azurerm_resource_group.crud_app_rg.location
  resource_group_name = azurerm_resource_group.crud_app_rg.name
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
}

resource "azurerm_function_app" "crud_app_fa" {
  name                       = "${var.environment}-function-app"
  location                   = azurerm_resource_group.crud_app_rg.location
  resource_group_name        = azurerm_resource_group.crud_app_rg.name
  app_service_plan_id        = azurerm_app_service_plan.crud_app_sp.id
  storage_account_name       = azurerm_storage_account.crud_app_sa.name
  storage_account_access_key = azurerm_storage_account.crud_app_sa.primary_access_key
  os_type                    = "linux"
  version                    = "~4"

  site_config {
    linux_fx_version = "python|3.9"
  }
}