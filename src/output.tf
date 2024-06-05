output "application_name" {
  value = azuread_application_from_template.this.display_name
}

output "application_id" {
  value = azuread_application_from_template.this.application_object_id
}

output "service_principal_id" {
  value = azuread_application_from_template.this.service_principal_object_id
}
