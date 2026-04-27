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
      id = module.vnet["hub"].vnet_id
    name = module.vnet["hub"].vnet_name, },
    spoke1 = {
      id   = module.vnet["spoke1"].vnet_id,
      name = module.vnet["spoke1"].vnet_name,
    }
    spoke2 = {
      id = module.vnet["spoke2"].vnet_id,
    name = module.vnet["spoke2"].vnet_name, }

  }
  lb_subnet_id = module.vnet["hub"].subnet_ids["lb_frontend"]
  server_subnet_id = { "spoke1" = module.vnet["spoke1"].vnet_id,
  "spoke2" = module.vnet["spoke2"].vnet_id }

}
