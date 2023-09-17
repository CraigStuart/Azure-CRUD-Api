resource "azurerm_resource_group" "crud_app_rg" {
  name     = "${var.environment}-azure-app-rg"
  location = var.region
  tags = var.tags
}
