resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.rg_location

  tags = {
    rg_name = var.rg_name
  }
}

variable "rg_location" {
    type = string
    default = "West US"
}

variable "rg_name" {
    type = string
    default = "defult_rg_name"
}