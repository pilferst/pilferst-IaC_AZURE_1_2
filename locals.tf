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
}