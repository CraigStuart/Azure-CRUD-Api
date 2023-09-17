output "connection_string" {
  description = "Connection string for the Azure SQL Database created."
  sensitive   = true
  value       = "Server=tcp:mssql-server-resource.database.windows.net,1433;Initial Catalog=${azurerm_mssql_database.db.name};Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;Authentication='Active Directory Default';"
}
