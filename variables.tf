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
    name               = string
    virtual_network_id = string
  })
}

variable "private_dns_resolver_inbound_endpoint" {
  description = "Private DNS resolver inbound endpoint configuration"
  type = object({
    name                         = string
    private_ip_allocation_method = string
    subnet_id                    = string
  })
}

variable "private_dns_resolver_outbound_endpoint" {
  description = "Private DNS resolver outbound endpoint configuration"
  type = object({
    enabled   = bool
    name      = string
    subnet_id = string
  })
}
variable "private_dns_resolver_forwarding_rule" {
  description = "Private DNS resolver forwarding rule configuration"
  type = map(object({
    name        = string
    domain_name = string
    enabled     = optional(bool)
    target_dns_servers = list(object({
      ip_address = string
      port       = optional(number, 53)
    }))
  }))
}

variable "virtual_network" {
  description = "Vitual Network details"
  type = object({
    name = string
    id   = string
  })
}