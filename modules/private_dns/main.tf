resource "azurerm_private_dns_zone" "internal" {
  resource_group_name = var.rg_name
  name                = var.private_dns_zone_name

}

resource "azurerm_private_dns_zone_virtual_network_link" "links" {
  for_each              = var.private_dns_zone_auto_registration ? var.server_subnet_id : {}
  name                  = "link-${each.key}"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.internal.name
  virtual_network_id    = each.value

  registration_enabled = var.private_dns_zone_auto_registration
}