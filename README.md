# Terraform IaC — Azure Hub-Spoke Network

[![Terraform](https://img.shields.io/badge/Terraform-1.10+-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Azure-0078D4?logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Automated deployment of a **Hub-and-Spoke** network infrastructure in Microsoft Azure using Terraform.

## 🎯 Project Overview

This project deploys a complete, production-ready **Hub-and-Spoke** networking architecture in Azure:

- **1 Hub** Virtual Network (central hub)
- **2 Spoke** Virtual Networks (workload networks)
- VNet Peering between Hub and all Spokes
- Network Security Groups (NSG) with predefined rules
- Internal Load Balancer in the Hub
- Private DNS Zone
- Route Tables with force-tunnel example
- Consistent tagging and Azure best practices

## 🏗 Architecture

```mermaid
graph TD
    A[Resource Group] --> B[Hub VNet]
    A --> C[Spoke1 VNet]
    A --> D[Spoke2 VNet]
    B <--> C
    B <--> D
    B --> E[Load Balancer subnet]
    C --> F[Frontend Subnets + NSG]
    D --> G[Backend Subnets + UDR]
```
🚀 Quick Start
Prerequisites

Terraform ≥ 1.10
Azure CLI (logged in)
Azure subscription


📁 Project Structure

.
├── main.tf                 # Main file (resource group + module calls)
├── variables.tf            # Input variables
├── locals.tf               # Local values and tags
├── providers.tf
├── versions.tf
├── modules/
│   ├── vnet/               # Virtual Network + Subnets
│   ├── peering/            # VNet Peering (Hub ↔ Spokes)
│   ├── nsg/                # Network Security Groups
│   ├── lb/                 # Load Balancer
│   ├── private_dns/        # Private DNS Zone
│   └── route_table/        # Route Tables (UDR)
└── README.md

