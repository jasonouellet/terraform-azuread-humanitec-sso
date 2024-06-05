data "azuread_group" "this_GMAR" {
  display_name = var.name
}

resource "random_uuid" "this_role" {}

resource "azuread_application_app_role" "this" {
  application_id = var.application_id
  role_id        = random_uuid.this_role.id

  allowed_member_types = ["User"]
  value                = var.name
  display_name         = var.name
  description          = var.description
}

## App role assignment (GRANT)
resource "azuread_app_role_assignment" "this" {
  app_role_id         = random_uuid.this_role.result
  principal_object_id = data.azuread_group.this_GMAR.object_id
  resource_object_id  = var.service_principal_id
}
