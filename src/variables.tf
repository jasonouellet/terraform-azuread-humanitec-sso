variable "display_name" {
  description = "Nom visible de l'application"
  type        = string
}

# variable "owners_app" {
#   description = "Propriétaire de l'application"
#   type        = list(string)
# }

# variable "owners_sp" {
#   description = "Propriétaire de l'application"
#   type        = list(string)
# }

variable "template_display_name" {
  description = "Nom visible du gabarit de l'application à utiliser."
  type        = string
}

variable "identifier_urls" {
  description = "List of unique identifiers application urls"
  type        = list(string)
  default = [ "api://humanitec.io" ]
}

variable "homepage_url" {
  description = "Application homepage URL"
  type        = string
  default      = "https://app.humanitec.io"
}

variable "sign_in_url" {
  description = "Application login URL"
  type        = string
  default = "https://app.humanitec.io/auth/login"
}

variable "logout_url" {
  description = "Application logout URL"
  type        = string
  default     = "https://app.humanitec.io/auth/logout"
}

variable "relay_state_url" {
  description = "Relay state URL"
  type        = string
  default     = "https://api.humanitec.io/orgs/[org]/"
}

variable "humanitec_saml_id" {
  description = "Humanitec SAML ID"
  type = string
}

variable "user_roles" {
  description = "List of application roles."
  type = list(object({
    name        = string
    description = string
  }))
  default = []
}
