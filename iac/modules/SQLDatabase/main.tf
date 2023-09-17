data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "default" {
  name                = "crud-app-admin"
  location            = var.region
  resource_group_name = var.rg_name
}

# Create a sql server instance
resource "azurerm_mssql_server" "default" {
  name                         = "mssql-server-resource"
  location                     = var.region
  resource_group_name          = var.rg_name
  version                      = "12.0"
  administrator_login          = "crud-app-administrator"
  administrator_login_password = "wscnihd28eyh28h!"
  minimum_tls_version          = "1.2"
  
  azuread_administrator {
    login_username = azurerm_user_assigned_identity.default.name
    object_id      = azurerm_user_assigned_identity.default.principal_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.default.id]
  }

  primary_user_assigned_identity_id            = azurerm_user_assigned_identity.default.id
}

# Create a key vault with access policies which allow for the current user to get, list, create, delete, update, recover, purge and getRotationPolicy for the key vault key.
resource "azurerm_key_vault" "default" {
  name                        = "crud-app-sqlserver-vault"
  location                    = var.region
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = azurerm_user_assigned_identity.default.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = true

  sku_name = "standard"

  access_policy {
    tenant_id = azurerm_user_assigned_identity.default.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", ]

    secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]

    storage_permissions = ["Get", "Set", "Delete", "Recover", "Backup", "Restore"]

    certificate_permissions = ["Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Purge"]

  }

}

# Create a key
resource "azurerm_key_vault_key" "default" {
  depends_on = [azurerm_key_vault.default]

  name         = "crud-app-sqlserver-key"
  key_vault_id = azurerm_key_vault.default.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = ["unwrapKey", "wrapKey"]
}

# Create mssql database leveraging the sql server
resource "azurerm_mssql_database" "db" {
  name      = "${var.environment}-mssql-db"
  server_id = azurerm_mssql_server.default.id
}
