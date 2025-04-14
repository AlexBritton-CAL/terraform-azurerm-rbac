variable "elevated_groups" {
  type = set(string)
  description = "Set of Elevated Groups Names"
}

variable "default_groups" {
  type = set(string)
  description = "Set of Default Groups Names"
}

variable "additional_elevated_groups" {
  type = set(string)
  description = "Optional: Set of additiaonl Elevated Groups Names"
  default = []
}

variable "additional_default_groups" {
  type = set(string)
  description = "Optional: Set of additiaonl Default Groups Names"
  default = []
}

locals {
  resource_types = ["aks", "storageaccount", "servicebus", "keyvault"]
}
variable "resource_type" {
  type = string

  validation {
    condition     = contains(local.resource_types, var.resource_type)
    error_message = "The context must be a valid resource type (see readme for details)"
  }
}

variable "context" {
  type    = string
  default = "prod"

  validation {
    condition     = contains(["prod", "nonprod", "pr"], var.context)
    error_message = "The context must be 'prod', 'nonprod' or'pr'"
  }
}

variable "resource_id" {
  type = string
}