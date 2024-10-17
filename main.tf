resource "azure_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_private_dns_zone" "privatelink_zones" {
    for_each = toset([
        "privatelink.blob.core.windows.net",
        "privatelink.database.windows.net",
        "privatelink.file.core.windows.net",
        "privatelink.queue.core.windows.net",
        "privatelink.redis.cache.windows.net",
        "privatelink.servicebus.windows.net",
        "privatelink.sql.database.windows.net",
        "privatelink.vaultcore.azure.net",
        "privatelink.web.core.windows.net"
    ])

    name                = each.key
    resource_group_name = azure_resource_group.rg.name
}