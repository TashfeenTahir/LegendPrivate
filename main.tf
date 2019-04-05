//Hub RG
resource "azurerm_resource_group" "HubRG" {
  name     = "leg-muks-rg-p"
  location = "UK South"
}
//Hub RG
resource "azurerm_resource_group" "Dev-RG" {
  name     = "leg-muks-rg-d"
  location = "UK South"
}
//Hub VNET Prod
resource "azurerm_virtual_network" "HubVNET" {
  name          = "leg-muks-p-vnet"
  address_space = ["172.20.0.0/16"]
  location      = "${azurerm_resource_group.HubRG.location}"
  resource_group_name = "${azurerm_resource_group.HubRG.name}"
}

//Subnets
resource "azurerm_subnet" "GatewaySubnet" {
    name           = "GatewaySubnet"
    address_prefix = "172.20.31.0/24"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
    virtual_network_name = "${azurerm_virtual_network.HubVNET.name}"
}
resource "azurerm_subnet" "MGMT1-Subnet" {
    name           = "leg-muks-p-vnet-mgmt1"
    address_prefix = "172.20.0.0/24"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
    virtual_network_name = "${azurerm_virtual_network.HubVNET.name}"
  }
output "MGMTSubnet-ID" {
  value = "${azurerm_subnet.MGMT1-Subnet.id}"
}
resource "azurerm_subnet" "WEB1-Subnet" {
    name           = "leg-muks-p-vnet-web1"
    address_prefix = "172.20.8.0/25"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
    virtual_network_name = "${azurerm_virtual_network.HubVNET.name}"
  }
resource "azurerm_subnet" "APP1-Subnet" {
    name           = "leg-muks-p-vnet-app1"
    address_prefix = "172.20.16.0/25" 
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
    virtual_network_name = "${azurerm_virtual_network.HubVNET.name}"
  }
resource "azurerm_subnet" "DB1-Subnet" {
    name           = "leg-muks-p-vnet-db1"
    address_prefix = "172.20.24.0/25"
    resource_group_name = "${azurerm_resource_group.HubRG.name}"
    virtual_network_name = "${azurerm_virtual_network.HubVNET.name}"
  }

  //VNET Dev
resource "azurerm_virtual_network" "DEV-VNET" {
  name          = "leg-muks-p-vnet"
  address_space = ["172.21.0.0/16"]
  location      = "${azurerm_resource_group.Dev-RG.location}"
  resource_group_name = "${azurerm_resource_group.Dev-RG.name}"
}

//Subnets
/*
resource "azurerm_subnet" "Dev-GatewaySubnet" {
    name           = "GatewaySubnet"
    address_prefix = "172.20.31.0/24"
    resource_group_name = "${azurerm_resource_group.Dev-RG.name}"
    virtual_network_name = "${azurerm_virtual_network.DEV-VNET.name}"
}
resource "azurerm_subnet" "MGMT1-Subnet" {
    name           = "leg-muks-p-vnet-mgmt1"
    address_prefix = "172.20.0.0/24"
    resource_group_name = "${azurerm_resource_group.Dev-RG.name}"
    virtual_network_name = "${azurerm_virtual_network.DEV-VNET.name}"
  }
*/
resource "azurerm_subnet" "Dev-WEB1-Subnet" {
    name           = "leg-muks-p-vnet-web1"
    address_prefix = "172.21.8.0/25"
    resource_group_name = "${azurerm_resource_group.Dev-RG.name}"
    virtual_network_name = "${azurerm_virtual_network.DEV-VNET.name}"
  }
resource "azurerm_subnet" "Dev-APP1-Subnet" {
    name           = "leg-muks-p-vnet-app1"
    address_prefix = "172.21.16.0/25" 
    resource_group_name = "${azurerm_resource_group.Dev-RG.name}"
    virtual_network_name = "${azurerm_virtual_network.DEV-VNET.name}"
  }
resource "azurerm_subnet" "Dev-DB1-Subnet" {
    name           = "leg-muks-p-vnet-db1"
    address_prefix = "172.21.24.0/25"
    resource_group_name = "${azurerm_resource_group.Dev-RG.name}"
    virtual_network_name = "${azurerm_virtual_network.DEV-VNET.name}"
  }