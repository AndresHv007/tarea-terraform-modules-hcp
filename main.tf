# ==============================================================================
# Práctica 11 Refactorizada en Módulos de Terraform
# ==============================================================================
# Esta configuración de raíz orquesta dos módulos desacoplados y reutilizables:
# 1. cloudflare_d1: Aprovisiona la base de datos serverless D1.
# 2. cloudflare_worker: Aprovisiona el Worker con runtime ES Module,
#    configura el binding con la base de datos D1 y activa el subdominio público.
# ==============================================================================

module "d1" {
  source = "./modules/cloudflare_d1"

  account_id    = var.account_id
  database_name = var.d1_database_name
}

module "worker" {
  source = "./modules/cloudflare_worker"

  account_id     = var.account_id
  worker_name    = var.worker_name
  d1_database_id = module.d1.database_id
}
