
output "vsphere_vm_name" {
  value = vsphere_virtual_machine.vm.name
}

output "vsphere_vm_id" {
  value = vsphere_virtual_machine.vm.id
}

output "vsphere_vm_ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}

output "vsphere_vm_creator" {
  value = var.vsphere_user
}

output "vsphere_vm_creation_date" {
  value = formatdate("EEEE, DD-MMM-YY hh:mm:ss ZZZ", vsphere_virtual_machine.vm.change_version)
}

output "vsphere_networks" {
  value = tomap({
    for network in distinct(values(var.vsphere_vm_networks)) :
    data.vsphere_network.network[network].name => data.vsphere_network.network[network].id
  })
}

