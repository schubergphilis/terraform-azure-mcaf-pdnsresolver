variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "resource_group" {
  description = "Resource group configuration"
  type = object({
    name     = string
    location = string
  })
}

variable "private_dns_resolver" {
  description = "Private DNS resolver configuration"
  type = object({
    name                 = string
    virtual_network_id   = string
    virtual_network_name = string
  })
}

variable "private_dns_resolver_inbound_endpoint" {
  description = "Private DNS resolver inbound endpoint configuration"
  type = object({
    name = string
    ip_configurations = list(object({
      private_ip_allocation_method = optional(string, "Static")
      subnet_id                    = string
      private_ip_address           = optional(string, null)
    }))
  })
}

variable "private_dns_resolver_outbound_endpoint" {
  description = "Private DNS resolver outbound endpoint configuration"
  type = object({
    enabled   = optional(bool, true)
    name      = string
    subnet_id = string
  })
}

variable "private_dns_resolver_forwarding_ruleset" {
  description = "Private DNS resolver forwarding ruleset configuration"
  type = object({
    name = string
  })
}

variable "private_dns_resolver_forwarding_rule" {
  description = "Private DNS resolver forwarding rule configuration"
  type = map(object({
    name        = optional(string, null)
    domain_name = optional(string, null)
    enabled     = optional(bool, true)
    target_dns_servers = list(object({
      ip_address = optional(string, null)
      port       = optional(number, 53)
    }))
  }))
}
