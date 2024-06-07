resource "azuread_service_principal" "this" {
  depends_on = [azuread_application_from_template.this]  #To force template to be created first

  client_id                    = data.azuread_application.this.client_id
#  owners                       = var.owners_sp
  app_role_assignment_required = true
  notification_email_addresses = ["platform_team@exemple.com"]

  # SAML Config
  alternative_names             = var.identifier_urls
  login_url                     = var.sign_in_url
  preferred_single_sign_on_mode = "saml"
  saml_single_sign_on {
    relay_state = var.relay_state_url
  }
  tags = [
    "WindowsAzureActiveDirectoryGalleryApplicationPrimaryV1",
    "WindowsAzureActiveDirectoryIntegratedApp"
  ]

  use_existing = true
}

resource "azuread_service_principal_token_signing_certificate" "this" {
  service_principal_id = azuread_service_principal.this.id
}

resource "azuread_claims_mapping_policy" "saml" {
  display_name = "SAML - ${var.display_name}"
  definition = [
    jsonencode(
      {
        ClaimsMappingPolicy = {
          ClaimsSchema = [
            {
              ID            = "userprincipalname"
              SamlClaimType = "name"
              Source        = "user"
            },
            {
              ID            = "displayname"
              SamlClaimType = "displayName"
              Source        = "user"
            },
            {
              ID            = "groups"
              SamlClaimType = "groups"
              Source        = "user"
            },
            {
              ID            = "givenname"
              SamlClaimType = "firstName"
              Source        = "user"
            },
            {
              ID            = "surname"
              SamlClaimType = "lastName"
              Source        = "user"
            },
            {
              ID            = "mail"
              SamlClaimType = "email"
              Source        = "user"
            }
          ]
          IncludeBasicClaimSet = "true"
          Version              = 1
        }
      }
    ),
  ]
}

resource "azuread_service_principal_claims_mapping_policy_assignment" "saml" {
  claims_mapping_policy_id = azuread_claims_mapping_policy.saml.id
  service_principal_id     = azuread_service_principal.this.id
}
