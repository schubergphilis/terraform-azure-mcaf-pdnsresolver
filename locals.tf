locals {
  private_dns_resolver_forwarding_rulesets = { for item in flatten([
    for ruleset_name, ruleset_properties in var.private_dns_resolver_forwarding_rulesets : [
      for rule in ruleset_properties.forwarding_rules : {
        domain_name        = rule_properties.domain_name
        target_dns_servers = rule_properties.target_dns_servers
      }
    ]
  ]) : "${item.management_group}${item.role}" => item }
}
