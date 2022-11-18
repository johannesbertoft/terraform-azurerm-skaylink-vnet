# A Terraform module to create a subset of cloud components
# Copyright (C) 2022 Skaylink GmbH

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# For questions and contributions please contact info@iq3cloud.com

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "rule_default_prefix" {
  type        = string
  description = "The prefix to add to the NSG and ASG rules"
  default     = "iq3"
}

variable "management_ip_range" {
  type        = string
  description = "The IP range of the IQ3 management virtual network"
}

variable "vnet_ip_range" {
  type        = list(string)
  description = "The IP range of the whole Virtual Network"
}

variable "vnet_resourcegroup" {
  type        = string
  description = "The resource group where the virtual network and network security group will be located"
}

variable "dns_servers" {
  type        = list(string)
  description = <<EOF
  (Optional) DNS servers to be configured for the virtual network. Leaving this value empty will use the default Azure DNS servers.
  EOF
  default     = null
}

variable "vnet_subnet_ranges" {
  type        = map(any)
  description = <<EOF
  (Required) A map of subnet names and their ranges (key: Subnet Name, Value: Subnet Range)."
  Provided in the following format:
  ```terraform
  vnet_subnet_range = {
    # Subnet without service_delegation
    "backend-subnet" = {
      "ip_range"                        = "10.10.10.0/24"
      "attach_nsg"                      = true
      "attach_route_table"              = false
      "service_endpoints"               = []
      "apply_service_endpoint_policies" = true
      "apply_service_link_policies"     = false
      "service_delegation"              = null
      "service_delegation_actions"      = []
  }
  ```
  EOF
}

variable "route_table_id" {
  type        = string
  default     = null
  description = "Resource Id of the route table to be attached to the subnets"
}

variable "virtual_network_tags" {
  type        = map(any)
  default     = null
  description = <<EOT
  (Optional) A set of virtual network tags that will be applied to the virtual network.
  Provided in key : value format
  EOT
}

variable "bastion_subnet_range" {
  type        = string
  default     = null
  description = <<EOT
  (Optional) A Bastion subnet range.

  NOTE: The IP range must be a /27 or larger.
  EOT
}
