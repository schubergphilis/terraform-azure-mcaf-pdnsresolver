terraform {


  required_version = ">= 1.8"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.5, < 5.0"
    }
  }
}


module "pdns_resolver" {
  source = "../../"

  resource_group = {
    name     = "example-resource-group"
    location = "eastus"
  }

  private_dns_resolver = {
    name                  = "example-dns-resolver"
    virtual_network_id    = "vnet-id"
    virtual_network_name = "vnet-name"
  }

  private_dns_resolver_inbound_endpoint = {
    name                         = "inbound-endpoint"
    private_ip_allocation_method = "Static"
    subnet_id                    = "subnet-id"
  }

  private_dns_resolver_outbound_endpoint = {
    enabled   = true
    name      = "outbound-endpoint"
    subnet_id = "subnet-id"
  }

  private_dns_resolver_forwarding_rule = {
    rule1 = {
      name        = "rule1"
      domain_name = "example.com"
      enabled     = true
      target_dns_servers = [
        {
          ip_address = "10.0.0.1"
          port       = 53
        }
      ]
    }
  }


  tags = {
    Owner       = "team-name"
    Environment = "production"
  }
}