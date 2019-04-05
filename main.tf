//Hub RG
resource "azurerm_resource_group" "HubRG" {
  name     = "leg-muks-rg-p-vnf1"
  location = "UK South"
}
//Hub VNET
resource "azurerm_virtual_network" "HubVNET" {
  name          = "leg-muks-p-vnet"
  address_space = ["172.20.0.0/16"]
  location      = "${azurerm_resource_group.HubRG.location}"
  resource_group_name = "${azurerm_resource_group.HubRG.name}"
}

//Subnets
resource "azurerm_subnet "GatewaySubnet" {
    name           = "GatewaySubnet"
    address_prefix = "172.20.31.0/24"
    location      = "${azurerm_resource_group.HubRG.location}"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
}
resource "azurerm_subnet" "MGMT1-Subnet" {
    name           = "leg-muks-p-vnet-mgmt1"
    address_prefix = "172.20.0.0/24"
    location      = "${azurerm_resource_group.HubRG.location}"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
  }
output "MGMTSubnet-ID" {
  value = "${azurerm_subnet.MGMT1-Subnet.id}"
}
resource "azurerm_subnet" "WEB1-Subnet" {
    name           = "leg-muks-p-vnet-web1"
    address_prefix = "172.20.8.0/25"
    location      = "${azurerm_resource_group.HubRG.location}"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
  }
resource "azurerm_subnet" "APP1-Subnet" {
    name           = "leg-muks-p-vnet-app1"
    address_prefix = "172.20.16.0/25"
    location      = "${azurerm_resource_group.HubRG.location}"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
  }
resource "azurerm_subnet" "DB1-Subnet" {
    name           = "leg-muks-p-vnet-db1"
    address_prefix = "172.20.24.0/25"
    location      = "${azurerm_resource_group.HubRG.location}"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
  }