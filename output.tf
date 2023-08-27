output "load_balancer_public_ip" {
  value = azurerm_public_ip.example_pip.ip_address
}
