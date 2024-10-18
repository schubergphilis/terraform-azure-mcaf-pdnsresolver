resource "azure_resource_group" "rg" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_private_dns_zone" "pdns_zones" {
    for_each = toset(var.dns_zones)
    name                = each.key
    resource_group_name = azure_resource_group.rg.name
}