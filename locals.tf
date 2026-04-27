locals {
  # Basic tags
  tags = merge({
    Environment = "Development"
    Project     = "IaC_AZURE_1_2"
    Owner       = "AL"
    ManagedBy   = "Terraform"
    Terraform   = "true"
    Repository  = "https://github.com/pilferst/IaC_AZURE_1_2"
  }, var.tags)
  peering_id_name = {
    hub = {
      id = module.create_vnet_subnet["hub"].vnet_id
    name = module.create_vnet_subnet["hub"].vnet_name, },
    spoke1 = {
      id   = module.create_vnet_subnet["spoke1"].vnet_id,
      name = module.create_vnet_subnet["spoke1"].vnet_name,
    }
    spoke2 = {
      id = module.create_vnet_subnet["spoke2"].vnet_id,
    name = module.create_vnet_subnet["spoke2"].vnet_name, }

  }
  lb_subnet_id = module.create_vnet_subnet["hub"].subnet_ids["lb_frontend"]
  server_subnet_id = {"spoke1" = module.create_vnet_subnet["spoke1"].vnet_id,
                            "spoke2" = module.create_vnet_subnet["spoke2"].vnet_id} 

}
