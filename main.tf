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

  subnet {
    name           = "GatewaySubnet"
    address_prefix = "172.20.31.0/24"
  }
  subnet {
    name           = "leg-muks-p-vnet-mgmt1"
    address_prefix = "172.20.0.0/24"
  }
  subnet {
    name           = "leg-muks-p-vnet-web1"
    address_prefix = "172.20.8.0/25"
  }
  subnet {
    name           = "leg-muks-p-vnet-app1"
    address_prefix = "172.20.16.0/25"
  }
  subnet {
    name           = "leg-muks-p-vnet-db1"
    address_prefix = "172.20.24.0/25"
  }
}