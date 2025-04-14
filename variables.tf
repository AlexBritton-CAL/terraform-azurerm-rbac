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
    error_message = "Must be a valid resource type (see readme for details)"
  }
}

locals {
  context = ["prod", "nonprod", "pr"]
}

variable "context" {
  type    = string
  description = "The security context to apply to this resource"
  default = "prod"

  validation {
    condition     = contains(local.context, var.context)
    error_message = "Must be a vaild context (see readme for details)"
  }
}

variable "resource_id" {
  type = string
}
