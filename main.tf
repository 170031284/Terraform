resource "azurerm_resource_group" "example_rg" {
  name     = "example-resources123"
  location = "West Europe" # Ireland is part of the West Europe region
}

resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
}

resource "azurerm_subnet" "example_subnet" {
  name                 = "example-subnet"
  resource_group_name = azurerm_resource_group.example_rg.name
  virtual_network_name = azurerm_virtual_network.example_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "example_pip" {
  name                = "example-pip"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name
  allocation_method  = "Static"
}

resource "azurerm_lb" "example_lb" {
  name                = "example-lb"
  location            = azurerm_resource_group.example_rg.location
  resource_group_name = azurerm_resource_group.example_rg.name

  frontend_ip_configuration {
    name                 = "example-lb-fe"
    public_ip_address_id = azurerm_public_ip.example_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "example_bap" {
 # resource_group_name = azurerm_resource_group.example_rg.name
  loadbalancer_id     = azurerm_lb.example_lb.id
  name                = "example-lb-backend"
}

resource "azurerm_lb_rule" "example_rule" {
  #resource_group_name            = azurerm_resource_group.example_rg.name
  loadbalancer_id                = azurerm_lb.example_lb.id
  name                           = "example-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.example_lb.frontend_ip_configuration[0].name
  #backend_address_pool_id        = azurerm_lb_backend_address_pool.example_bap.id
}
