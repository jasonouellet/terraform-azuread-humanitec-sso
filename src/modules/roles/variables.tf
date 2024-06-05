variable "application_id" {
  description = "The ID of the application to assign the app role to"
  type        = string
}

variable "service_principal_id" {
  description = "The ID of the service principal to assign the app role to"
  type        = string
}

variable "description" {
  description = "Descrition of user role"
  type        = string
}

variable "name" {
  description = "Name of user role"
  type        = string
}
