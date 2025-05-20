locals {
  private_dns_resolver_forwarding_rulesets = { for item in flatten([
    for ruleset_name, ruleset_properties in var.private_dns_resolver_forwarding_rulesets : [
      for rule in ruleset_properties.forwarding_rules : {
        ruleset_name       = ruleset_name
        domain_name        = rule.domain_name
        target_dns_servers = rule.target_dns_servers
      }
    ]
  ]) : "${item.ruleset_name}${item.domain_name}" => item }
}
