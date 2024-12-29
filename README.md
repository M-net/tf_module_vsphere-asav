# tf_module_vsphere-asav

This Terraform module deploys Cisco ASAv firewall on VMware vSphere from OVF template.

Initial configuration can either be passed by vApp properties or by day0 ISO-image file.

## Prerequisites

- Terraform or OpenTofu
- Cisco ASAv OVF template downloaded
- HTTPS network access to your vSphere server 
- HTTPS network access to your ESXi host
- genisoimage, jq and unzip package installed

## Preparation

Install required software packages

RHEL/CentOS/Rocky/AlmaLinux:

`sudo dnf install genisoimage jq unzip`

Debian/Ubuntu:

`sudo apt install genisoimage jq unzip`

Extract ASAv OVF zip file

`unzip -o asav9-20-3-10.zip -d ~/asav9-20-3-10`

Place your day0-config (optional)

`cp ./day0-config_example.txt ~/day0-config_asav01.txt`

## Deployment

```
export TF_VAR_vsphere_vm_name=asav01.local
export TF_VAR_vsphere_user=your-own-username
read -s TF_VAR_vsphere_password; export TF_VAR_vsphere_password

export TF_VAR_ovf_template_path='~/asav9-20-3-10/asav-vi.ovf'
export TF_VAR_day0_config_path='~/day0-config_asav01.txt'

export TF_VAR_vsphere_vm_networks='
{
  "01 Ma0/0": "dv_oobm",
  "02 Gi0/0": "dv_outside",
  "03 Gi0/1": "dv_inside"
}'

terraform init
terraform apply
```

Other variables may passed. See variables.tf for details.

If you prefer configuration by vApp properties rather than day0.iso:

```
unset TF_VAR_day0_config_path

# Overwrite previous day0.iso generation
unzip -o asav9-20-3-10.zip -d ~/asav9-20-3-10

export TF_VAR_vsphere_vm_vapp_properties='
{
  "HARole": "Standalone",
  "Hostname": "asav01",
  "ManagementIPv4": "192.168.1.50",
  "ManagementIPv4Subnet": "255.255.255.0",
  "ManagementIPv4DefaultGateway": "192.168.1.1",
  "DNSServerIPv4": "192.168.1.1",
  "SSHEnable": "True",
  "Username": "admin",
  "Password": "PW-Sec1ure"
}'
```

## Remove ASAv from vSphere

`terraform destroy`

## Known issues and caveats

Location of day0.iso on vSphere must be known before vm is going to be created.
This module uploads day0.iso to a datastore folder other then the actual vm.

`[DATASTORE]/${vsphere_vm_name}_day0/day0.iso`

## Troubleshooting

Sometimes a just created ASAv floods your console with message like this:

`ERROR: /etc/ssh/lina_sshd.conf: No such file or directory`

This may happen if the ESXi host is under heavy load. Another reload/reboot usually fix it.

