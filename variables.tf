variable "vsphere_user" {}
variable "vsphere_password" {}

variable "vsphere_vm_annotation" {
  default = "Cisco ASAv - created by TERRAFORM"
}

variable "vsphere_server" {
  description = "E.g. vcenter.local"
}

variable "vsphere_datacenter" {
  description = "E.g. My Datacenter"
}

variable "vsphere_datastore" {
  description = "E.g. esxiserver01-local"
}

variable "vsphere_cluster" {
  description = "E.g. West"
}

variable "vsphere_host" {
  description = "E.g. esxiserver01.local"
}

variable "vsphere_vm_folder" {
  description = "E.g. Test"
}

variable "vsphere_vm_name" {
  description = "E.g. asav01.local"
}

variable "vsphere_vm_deployment_option" {
  default = "1Core2GB"
}

variable "vsphere_vm_networks" {
  type = map(string)
  default = {
    "01 Management0/0"      = "Internal01"
    "02 GigabitEthernet0/0" = "Internal01"
    "03 GigabitEthernet0/1" = "Internal01"
    "04 GigabitEthernet0/2" = "Internal01"
    "05 GigabitEthernet0/3" = "Internal01"
    "06 GigabitEthernet0/4" = "Internal01"
    "07 GigabitEthernet0/5" = "Internal01"
    "08 GigabitEthernet0/6" = "Internal01"
    "09 GigabitEthernet0/7" = "Internal01"
    "10 GigabitEthernet0/8" = "Internal01"
  }
}

variable "vsphere_vm_vapp_properties" {
  type = map(string)
  default = {
    # HARole property is mandatory
    "HARole" = "Standalone"

    /* day0-config is better. You can use both however
    "Hostname"                     = "asav01"
    "FWMode"                       = "routed"
    "ManagementIPv4"               = "192.168.1.50"
    "ManagementIPv4Subnet"         = "255.255.255.0"
    "ManagementIPv4DefaultGateway" = "192.168.1.1"
    "DNSServerIPv4"                = "192.168.1.1"
    "SSHEnable"                    = "True"
    "Username"                     = "admin"
    "Password"                     = "PW-Sec1ure"
    */
  }
}

variable "ovf_template_path" {
  description = "E.g. ~/asav9-20-3-10/asav-vi.ovf"
}

variable "day0_config_path" {
  description = "Leave empty to skip day0.iso. E.g. ~/day0-config.txt"
  default     = ""
}

