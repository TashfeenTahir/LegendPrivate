resource "azurerm_network_interface" "Network" {
  count                 = 4 //"${var.Count}"
  name                = "muks-org-p-nic-${count.index}"
  location            = "${azurerm_resource_group.HubRG.location}"
  resource_group_name = "${azurerm_resource_group.HubRG.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${Azurerm_subnet.}"
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_virtual_machine" "VM" {
 count                 = 4 //"${var.Count}"
 name                  = "muks-org-p-${count.index}"
 location              = "${azurerm_resource_group.HubRG.location}"
 #availability_set_id   = "${azurerm_availability_set.avset.id}"
 resource_group_name   = "${azurerm_resource_group.HubRG.name}"
 network_interface_ids = ["${element(azurerm_network_interface.Network.*.id, count.index)}"]
 vm_size               = "Standard_DS1_v2"

 # Uncomment this line to delete the OS disk automatically when deleting the VM
 # delete_os_disk_on_termination = true

 # Uncomment this line to delete the data disks automatically when deleting the VM
 # delete_data_disks_on_termination = true

 storage_image_reference {
  publisher = "MicrosoftWindowsDesktop"
  offer     = "Windows-10"
  sku       = "rs5-pro"
  version   = "latest"
 }
 storage_os_disk {
   name              = "muks-org-p-storage-${count.index}"
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }
 # Optional data disks
 /*
 storage_data_disk {
   name              = "datadisk_new_${count.index}"
   managed_disk_type = "Standard_LRS"
   create_option     = "Empty"
   lun               = 0
   disk_size_gb      = "1023"
 }
 
 storage_data_disk {
   name            = "${element(azurerm_managed_disk.MD.*.name, count.index)}"
   managed_disk_id = "${element(azurerm_managed_disk.MD.*.id, count.index)}"
   create_option   = "Attach"
   lun             = 1
   disk_size_gb    = "${element(azurerm_managed_disk.MD.*.disk_size_gb, count.index)}"
 }
*/
 os_profile {
   computer_name  = "hostname${count.index}"
   admin_username = "testadmin"
   admin_password = "Password1234!"
 }
 os_profile_windows_config {
    enable_automatic_upgrades = false
    provision_vm_agent = true
  }
}  
/*
resource "azurerm_virtual_machine_extension" "domainjoin" {
  count = "${var.Count}"
  name                 = "join-domain"
  location             = "${azurerm_resource_group.Heat-TEST.location}"
  resource_group_name  = "${azurerm_resource_group.Heat-TEST.name}"
  virtual_machine_name = "${element(azurerm_virtual_machine.VM.*.name, count.index)}"
  publisher            = "Microsoft.Compute"
  type                 = "JsonADDomainExtension"
  type_handler_version = "1.0"

  settings = <<SETTINGS
    {
        "Name": "basketballtest.onmicrosoft.com",
        "OUPath": "",
        "User": "basketballtest.onmicrosoft.com\\tashisking",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
        "Password": "Nuru4491"
    }
PROTECTED_SETTINGS
}

*/