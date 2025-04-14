locals {
  # load in config values from specific file
  rbac_config_content = file("${path.module}/rbac_config.yaml")
  config              = yamldecode(local.rbac_config_content)
}

locals {
  elevated_roles  = coalesce(try(local.config.rbac[var.resource_type][var.context].elevated_roles, []), [])
  default_roles   = coalesce(try(local.config.rbac[var.resource_type][var.context].default_roles, []), [])
  elevated_groups = toset(var.elevated_groups)
  default_groups  = toset(var.default_groups)

  elevated_rbac = distinct(flatten([
    for role in setunion(local.elevated_roles, local.default_roles) : [
      for group in local.elevated_groups : {
        role  = role
        group = group
  }]]))

  default_rbac = distinct(flatten([
    for role in local.default_roles : [
      for group in local.default_groups : {
        role  = role
        group = group
  }]]))

  all_rbac = setunion(local.elevated_rbac, local.default_rbac)
}

data "azuread_group" "elevated" {
  for_each         = local.elevated_groups
  display_name     = each.value
  security_enabled = true
}

resource "azurerm_role_assignment" "elevated" {
  for_each             = { for k, v in local.elevated_rbac : k => v }
  scope                = var.resource_id
  role_definition_name = each.value.role
  principal_id         = data.azuread_group.elevated[each.value.group].object_id
}

data "azuread_group" "default" {
  for_each         = local.default_groups
  display_name     = each.value
  security_enabled = true
}

resource "azurerm_role_assignment" "default" {
  for_each             = { for k, v in local.default_rbac : k => v }
  scope                = var.resource_id
  role_definition_name = each.value.role
  principal_id         = data.azuread_group.default[each.value.group].object_id
}
