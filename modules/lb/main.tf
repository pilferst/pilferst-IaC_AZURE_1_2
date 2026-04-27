resource "azurerm_lb" "main" {
  name                = "internal-lb-${var.id}"
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "internal-lb-${var.id}-frontend-ip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"     
   
  }
}

# Backend Pool (один на каждый LB)
#resource "azurerm_lb_backend_address_pool" "main" {
#  count           = var.number_of_lb
#  name            = "backend-pool"
#  loadbalancer_id = azurerm_lb.main[count.index].id
#}

