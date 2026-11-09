variable "account_id" {
  description = "ID de la cuenta de Cloudflare"
  type        = string
}

variable "api_token" {
  description = "Token de API de Cloudflare con permisos de edición para Workers Scripts y D1"
  type        = string
  sensitive   = true
}

variable "worker_name" {
  description = "Nombre del Worker de Cloudflare a crear mediante el módulo"
  type        = string
  default     = "practica-11-worker-modular"
}

variable "d1_database_name" {
  description = "Nombre de la base de datos D1 a crear mediante el módulo"
  type        = string
  default     = "practica-11-d1-modular"
}
