resource "azurerm_resource_group" "this" {
  name     = var.resource_group.name
  location = var.resource_group.location
}

resource "azurerm_private_dns_resolver" "this" {
  name                = var.private_dns_resolver.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  virtual_network_id  = var.private_dns_resolver.virtual_network_id
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  name                    = var.private_dns_resolver_inbound_endpoint.name
  location                = azurerm_resource_group.this.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id

  ip_configurations {
    private_ip_allocation_method = var.private_dns_resolver_inbound_endpoint.private_ip_allocation_method
    subnet_id                    = var.private_dns_resolver_inbound_endpoint.subnet_id
    private_ip_address           = "static"

  }
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  name                    = var.private_dns_resolver_outbound_endpoint.name
  location                = azurerm_resource_group.this.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  subnet_id               = var.private_dns_resolver_outbound_endpoint.subnet_id
}

resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  name                      = var.private_dns_resolver_forwarding_rule.each.name
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver.this.id
  domain_name               = var.private_dns_resolver_forwarding_rule.each.domain_name
  enabled                   = var.private_dns_resolver_forwarding_rule.each.enabled
  target_dns_servers {
    ip_address = var.private_dns_resolver_forwarding_rule.each.target_dns_servers
    port       = var.private_dns_resolver_forwarding_rule.each.port
  }
}

