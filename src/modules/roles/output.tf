output "role_id" {
  value = random_uuid.this_role.id
}

output "role_name" {
  value = var.name
}
