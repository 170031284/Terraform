
# Create a resource group
resource "azurerm_resource_group" "example_rg" {
  name     = "my-resource-group"
  location = "westeurope"
}
# Create a virtual network
resource "azurerm_virtual_network" "example_vnet" {
  name                = "my-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
}
# Create an Azure Kubernetes Service (AKS) cluster
resource "azurerm_kubernetes_cluster" "example_aks" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name

  dns_prefix          = "myaks"
  kubernetes_version = "1.25.11"  # Use a supported version from the output of the `az aks get-versions` command

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "development"
  }
}
# Create an Azure Container Registry (ACR)
resource "azurerm_container_registry" "example_acr" {
  name                = "myacrram1432"
  resource_group_name = azurerm_resource_group.example_rg.name
  location            = azurerm_resource_group.example_rg.location
  sku                 = "Basic"

  admin_enabled = false

  tags = {
    environment = "development"
  }
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.example_aks.name
}

output "acr_name" {
  value = azurerm_container_registry.example_acr.name
}

