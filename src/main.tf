## PROD
locals {
  identifier_urls = "api://humanitec/${var.humanitec_saml_id}"
  reply_urls = "https://api.humanitec.io/auth/saml/${var.humanitec_saml_id}/acs"
}

data "azurerm_client_config" "tf_sp" {
}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result.MicrosoftGraph
}

data "azuread_application_template" "saml_toolkit" {
  display_name = var.template_display_name
}

resource "azuread_application_from_template" "this" {
  display_name = var.display_name
  template_id  = data.azuread_application_template.saml_toolkit.template_id
}

data "azuread_application" "this" {
  object_id = azuread_application_from_template.this.application_object_id
}

data "azurerm_client_config" "terraform_serviceprincipal" {
}

resource "azuread_group" "Humanitec_Adm" {
  display_name       = "GMAR_APL_Humanitec_Adm_P_M"
  owners             = [data.azurerm_client_config.terraform_serviceprincipal.object_id]
  security_enabled   = true
  assignable_to_role = false
  description        = "Assigne une licence et donne accès à Humanitec avec le rôle Administrator"
}

resource "azuread_group" "Humanitec_Members" {
  display_name       = "GMAR_APL_Humanitec_Usr_P"
  owners             = [data.azurerm_client_config.terraform_serviceprincipal.object_id]
  security_enabled   = true
  assignable_to_role = false
  description        = "Assigne une licence et donne accès à Humanitec avec le rôle membre"
}
