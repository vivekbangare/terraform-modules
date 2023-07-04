output "virtual_machine_details" {
 value = [
      vsphere_virtual_machine.vm.name,
      vsphere_virtual_machine.vm.default_ip_address]
}