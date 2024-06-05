# resource "azuread_application_owner" "this" {
#   for_each = toset(var.owners_app)

#   application_id  = data.azuread_application.this.id
#   owner_object_id = each.value
# }

resource "azuread_application_redirect_uris" "this" {
  application_id = data.azuread_application.this.id
  type           = "Web"

  redirect_uris = [local.reply_urls]
}

resource "azuread_application_api_access" "sso_msgraph" {
  application_id = data.azuread_application.this.id
  api_client_id  = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]

  role_ids = [
    data.azuread_service_principal.msgraph.app_role_ids["User.Read.All"],
  ]
}

resource "azuread_application_optional_claims" "this" {
  application_id = data.azuread_application.this.id

  saml2_token {
    name = "groups"
    additional_properties = [
      "cloud_displayname"
    ]
  }
}
