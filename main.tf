resource "azurerm_resource_group" "this" {
  name     = var.resource_group.name
  location = var.resource_group.location
  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Resource Group"
    })
  )
}

resource "azurerm_private_dns_resolver" "this" {
  name                = var.private_dns_resolver.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  virtual_network_id  = var.private_dns_resolver.virtual_network_id
  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Private DNS Resolver"
    })
  )
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
  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Private DNS Resolver Inbound Endpoint"
    })
  )
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  count = var.private_dns_resolver_outbound_endpoint.enabled ? 1 : 0

  name                    = var.private_dns_resolver_outbound_endpoint.name
  location                = azurerm_resource_group.this.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  subnet_id               = var.private_dns_resolver_outbound_endpoint.subnet_id

  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Private DNS Resolver Outbound Endpoint"
    })
  )
}

resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "this" {
  count = var.private_dns_resolver_outbound_endpoint.enabled ? 1 : 0

  name                                       = var.private_dns_resolver_forwarding_rule.each.name
  resource_group_name                        = azurerm_resource_group.this.name
  location                                   = azurerm_resource_group.this.location
  private_dns_resolver_outbound_endpoint_ids = [azurerm_private_dns_resolver_outbound_endpoint.this[count.index].id]

  tags = merge(
    try(var.tags),
    tomap({
      "Resource Type" = "Private DNS Resolver DNS Forwarding Ruleset"
    })
  )
}

resource "azurerm_private_dns_resolver_forwarding_rule" "this" {
  count = var.private_dns_resolver_outbound_endpoint.enabled ? 1 : 0

  name                      = var.private_dns_resolver_forwarding_rule.each.name
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_outbound_endpoint.this[count.index].id
  domain_name               = var.private_dns_resolver_forwarding_rule.each.domain_name
  enabled                   = var.private_dns_resolver_forwarding_rule.each.enabled

  dynamic "target_dns_servers" {
    for_each = var.private_dns_resolver_forwarding_rule.each.target_dns_servers
    content {
      ip_address = target_dns_servers.value.ip_address
      port       = target_dns_servers.value.port
    }
  }
}

resource "azurerm_private_dns_resolver_virtual_network_link" "this" {
  count = var.private_dns_resolver_outbound_endpoint.enabled ? 1 : 0

  name                      = "$(var.virtual_network.name)-link"
  dns_forwarding_ruleset_id = azurerm_private_dns_resolver_outbound_endpoint.this[count.index].id
  virtual_network_id        = var.virtual_network.id
}