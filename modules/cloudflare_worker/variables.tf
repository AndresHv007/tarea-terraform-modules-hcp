variable "account_id" {
  description = "ID de la cuenta de Cloudflare"
  type        = string
}

variable "worker_name" {
  description = "Nombre del script Worker a desplegar"
  type        = string
}

variable "main_module" {
  description = "Nombre del archivo módulo principal del Worker"
  type        = string
  default     = "worker.js"
}

variable "content" {
  description = "Contenido en texto del script Worker (si no se especifica, se lee worker.js local del módulo)"
  type        = string
  default     = null
}

variable "compatibility_date" {
  description = "Fecha de compatibilidad del runtime de Cloudflare Workers"
  type        = string
  default     = "2025-01-01"
}

variable "d1_database_id" {
  description = "UUID de la base de datos D1 a enlazar mediante binding"
  type        = string
  default     = null
}

variable "d1_binding_name" {
  description = "Nombre de la variable de entorno para el binding con D1 dentro del Worker"
  type        = string
  default     = "DB"
}

variable "enable_subdomain" {
  description = "Habilitar la publicación del Worker en el subdominio workers.dev"
  type        = bool
  default     = true
}
