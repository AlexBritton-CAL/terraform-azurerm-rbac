variable "elevated_groups" {
  type = set(string)
}

variable "default_groups" {
  type = set(string)
}

variable "resource_type" {
  type = string
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