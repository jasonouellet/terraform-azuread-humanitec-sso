locals {
  user_roles = [
    {
      name        = azuread_group.Humanitec_Adm.display_name
      description = azuread_group.Humanitec_Adm.description
    },
    {
      name        = azuread_group.Humanitec_Members.display_name
      description = azuread_group.Humanitec_Members.description
    }
  ]
}

### App role assignment (GRANT)
resource "azuread_app_role_assignment" "sso_graph_user_read_all" {
  app_role_id         = data.azuread_service_principal.msgraph.app_role_ids["User.Read.All"]
  principal_object_id = azuread_service_principal.this.object_id
  resource_object_id  = data.azuread_service_principal.msgraph.object_id
}

## User roles creation and assignments
module "roles" {
  source = "./modules/roles"

  for_each = { for r in var.user_roles : r.name => r }

  application_id       = data.azuread_application.this.id
  service_principal_id = azuread_service_principal.this.object_id
  description          = each.value.description
  name                 = each.value.name
}
