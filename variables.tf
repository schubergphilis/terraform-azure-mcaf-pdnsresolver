variable "azure_resource_group" {
    description = "Azure Resource Group"
    type        = object({
        name     = string
        location = string
}


variable "dns_zones" {
    description = "List of DNS zones"
    type        = list(string)
    default     = [
        "privatelink.blob.core.windows.net",
        "privatelink.database.windows.net",
        "privatelink.file.core.windows.net",
        "privatelink.queue.core.windows.net",
        "privatelink.redis.cache.windows.net",
        "privatelink.servicebus.windows.net",
        "privatelink.sql.database.windows.net",
        "privatelink.vaultcore.azure.net",
        "privatelink.web.core.windows.net"
    ]
}