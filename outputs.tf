output "d1_database_id" {
  description = "UUID único de la base de datos D1 generada por el módulo d1"
  value       = module.d1.database_id
}

output "d1_database_name" {
  description = "Nombre de la base de datos D1 aprovisionada"
  value       = module.d1.database_name
}

output "worker_name" {
  description = "Nombre del Cloudflare Worker aprovisionado por el módulo worker"
  value       = module.worker.worker_name
}

output "worker_id" {
  description = "Identificador del script Worker generado en Cloudflare"
  value       = module.worker.worker_id
}

output "subdomain_enabled" {
  description = "Indica si el Worker se encuentra expuesto en el subdominio workers.dev"
  value       = module.worker.subdomain_enabled
}
