output "database_id" {
  description = "UUID único de la base de datos D1 creada"
  value       = cloudflare_d1_database.this.id
}

output "database_name" {
  description = "Nombre asignado a la base de datos D1"
  value       = cloudflare_d1_database.this.name
}
