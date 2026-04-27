resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  # Dynamic block — rules creating
  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol

      source_port_range      = length(security_rule.value.source_port_ranges) == 1 && security_rule.value.source_port_ranges[0] == "*" ? "*" : null
      source_port_ranges     = length(security_rule.value.source_port_ranges) == 1 && security_rule.value.source_port_ranges[0] == "*" ? null : security_rule.value.source_port_ranges

      destination_port_range      = length(security_rule.value.destination_port_ranges) == 1 && security_rule.value.destination_port_ranges[0] == "*" ? "*" : null
      destination_port_ranges     = length(security_rule.value.destination_port_ranges) == 1 && security_rule.value.destination_port_ranges[0] == "*" ? null : security_rule.value.destination_port_ranges

      source_address_prefix       = length(security_rule.value.source_address_prefixes) == 1 && security_rule.value.source_address_prefixes[0] == "*" ? "*" : null
      source_address_prefixes     = length(security_rule.value.source_address_prefixes) == 1 && security_rule.value.source_address_prefixes[0] == "*" ? null : security_rule.value.source_address_prefixes

      destination_address_prefix  = length(security_rule.value.destination_address_prefixes) == 1 && security_rule.value.destination_address_prefixes[0] == "*" ? "*" : null
      destination_address_prefixes = length(security_rule.value.destination_address_prefixes) == 1 && security_rule.value.destination_address_prefixes[0] == "*" ? null : security_rule.value.destination_address_prefixes

      description = try(security_rule.value.description, null)
    }
  }
}

# links NSG to subnet
resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.this.id
}