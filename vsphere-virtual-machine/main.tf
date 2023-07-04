data "vsphere_datacenter" "datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.template-folder}/${var.vm-template-name}"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere-cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


data "vsphere_network" "network" {
  name          = var.vm-network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


resource "vsphere_virtual_machine" "vm" {
  name             = "${var.vm_name}-(owner=${var.owner})"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = "VirtualMachines"
  guest_id         = data.vsphere_virtual_machine.template.guest_id
  scsi_type        = data.vsphere_virtual_machine.template.scsi_type

  #wait_for_guest_net_timeout = 0

  num_cpus             = var.cpu
  num_cores_per_socket = var.cores-per-socket
  memory               = var.ram

  network_interface {
    network_id = data.vsphere_network.network.id
  }


  disk {
    label            = "${var.vm_name}-disk"
    thin_provisioned = true
    eagerly_scrub    = false
    size             = var.disksize == "" ? data.vsphere_virtual_machine.template.disks.0.size : var.disksize
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
  wait_for_guest_ip_timeout = 3
  provisioner "remote-exec" {
    inline = [
      "sudo /extend-lvm/extend-lvm.sh /dev/sda",
      "sudo fdisk -l | grep -i dev/mapper",
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("/home/ubuntu/devmain-jumphost.pem")
      host        = vsphere_virtual_machine.vm.default_ip_address
    }
  }
}
