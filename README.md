# terraform-azure-mcaf-pdns
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_dns_resolver.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver) | resource |
| [azurerm_private_dns_resolver_dns_forwarding_ruleset.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_dns_forwarding_ruleset) | resource |
| [azurerm_private_dns_resolver_forwarding_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_forwarding_rule) | resource |
| [azurerm_private_dns_resolver_inbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_inbound_endpoint) | resource |
| [azurerm_private_dns_resolver_outbound_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_outbound_endpoint) | resource |
| [azurerm_private_dns_resolver_virtual_network_link.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_resolver_virtual_network_link) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_dns_resolver"></a> [private\_dns\_resolver](#input\_private\_dns\_resolver) | Private DNS resolver configuration | <pre>object({<br>    name                 = string<br>    virtual_network_id   = string<br>    virtual_network_name = string<br>  })</pre> | n/a | yes |
| <a name="input_private_dns_resolver_inbound_endpoint"></a> [private\_dns\_resolver\_inbound\_endpoint](#input\_private\_dns\_resolver\_inbound\_endpoint) | Private DNS resolver inbound endpoint configuration | <pre>object({<br>    name = string<br>    ip_configurations = list(object({<br>      private_ip_allocation_method = optional(string, "Static")<br>      subnet_id                    = string<br>      private_ip_address           = optional(string, null)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group configuration | <pre>object({<br>    name     = string<br>    location = string<br>  })</pre> | n/a | yes |
| <a name="input_private_dns_resolver_forwarding_rulesets"></a> [private\_dns\_resolver\_forwarding\_rulesets](#input\_private\_dns\_resolver\_forwarding\_rulesets) | Private DNS resolver forwarding ruleset configurations | <pre>map(object({<br>    forwarding_rules = map(object({<br>      domain_name = optional(string, null)<br>      target_dns_servers = list(object({<br>        ip_address = optional(string, null)<br>        port       = optional(number, 53)<br>      }))<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_private_dns_resolver_outbound_endpoint"></a> [private\_dns\_resolver\_outbound\_endpoint](#input\_private\_dns\_resolver\_outbound\_endpoint) | Private DNS resolver outbound endpoint configuration | <pre>object({<br>    name      = string<br>    subnet_id = string<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_id"></a> [resource\_group\_id](#output\_resource\_group\_id) | ID of the Resource Group created by the module |
<!-- END_TF_DOCS -->