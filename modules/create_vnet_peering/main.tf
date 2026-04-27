resource "azurerm_virtual_network_peering" "peering_vnet_local_remote" {
  name                      = "${var.local_name}_to_${var.remote_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.local_name
  remote_virtual_network_id = var.remote_id
}


resource "azurerm_virtual_network_peering" "peering_vnet_remote_local" {
  name                      = "${var.local_name}_to_${var.remote_name}"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.remote_name
  remote_virtual_network_id = var.local_id
}