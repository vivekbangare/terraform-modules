#=============================#
# VMware vCenter Connections  #
#=============================#

variable "username" {
  type        = string
  description = "VMware vSphere user name"
  sensitive = true
}

variable "password" {
  type        = string
  description = "VMware vSphere password"
  sensitive = true
}

variable "vcenter" {
  type        = string
  description = "VMWare vCenter server FQDN / IP"
  sensitive = true
}

variable "datacenter" {
  type        = string
  description = "VMWare vSphere datacenter"
}

variable "datastore" {
  type        = string
  description = "Datastore used for the vSphere virtual machines"
}

variable "template-folder" {
  type        = string
  description = "Template folder"
  default = "Templates"
}

variable "vsphere-cluster" {
  type        = string
  description = "VMWare vSphere cluster"
}

#=================================#
# VMware vSphere Virtual machine  #
#=================================#

variable "owner" {
  type = string
  description = "Owner of resource"
}


variable "vm_name" {
  type = string
  description = "Virtual Machine name"
}

variable "cpu" {
  type = number
  description = "Number of vCPU for the vSphere virtual machines"
}

variable "vm-network" {
  type        = string
  description = "Network used for the vSphere virtual machines"
}

variable "cores-per-socket" {
  type = number
  description = "Number of cores per cpu for workers"
}

variable "ram" {
  type = number
  description = "Amount of RAM for the vSphere virtual machines (example: 2048)"
}


variable "disksize" {
  type = number
  description = "Disk size, example 100 for 100 GB"
}

variable "vm-template-name" {
  type        = string
  description = "The template to clone to create the VM"
  default = "ubuntu-20-04-live-server-template"
}