output "worker_name" {
  description = "Nombre del Worker aprovisionado en Cloudflare"
  value       = cloudflare_workers_script.this.script_name
}

output "worker_id" {
  description = "Identificador del script Worker"
  value       = cloudflare_workers_script.this.id
}

output "subdomain_enabled" {
  description = "Indica si el subdominio workers.dev está activo"
  value       = var.enable_subdomain ? cloudflare_workers_script_subdomain.this[0].enabled : false
}
