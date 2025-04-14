# Terraform-AzureRM-RBAC

This module applies pre-configured RBAC settings to a resource. 2 levels of access can be applied in the form of a set of group names.

## Examples

```terraform
module "rbac_aks" {
  source = "github.com/AlexBritton-CAL/terraform-azurerm-rbac"
  resource_type = "aks"
  context = var.config.context
  default_groups = ["Azure_RO_Group"]
  elevated_groups = ["Azure_BG_Group","Azure_BG_Group2"]
  resource_id = azurerm_resource_group.this.id
}
```

## Requirements

| Name | Version |  
| --- | --- |   
| terraform | >=1.11  |  
| azurerm | >=4.25.0 |
| azuread | >=3.3.0 |

## Inputs

| Name | Description | Default Value |
| --- | --- | --- |
| elevated_groups | Set of elevated group names | [ ] |   
| default_groups | Set of default group names | [ ] |   
| additional_elevated_groups | Optional: Set of additiaonl Elevated Groups Names | [ ] |   
| additional_default_groups | Optional: Set of additiaonl Default Groups Names | [ ] |   
| resource_type | Resource Type | See list [here](variables.tf#L24) |   
| context | The security context to apply to this resource | The context must be 'prod', 'nonprod' or'pr'" |  
| resource_id | The ID of the resource (usually the resource group) |  
