# Módulo Terraform: Cloudflare Worker

Módulo reutilizable para aprovisionar un script de **Cloudflare Worker** (JavaScript/TypeScript ES Module), configurar bindings con bases de datos **D1** y habilitar la publicación en el subdominio público `workers.dev`.

## Arquitectura

El módulo abstrae la configuración de:
1. `cloudflare_workers_script`: Carga del código fuente, configuración de `compatibility_date` y bindings con base de datos D1.
2. `cloudflare_workers_script_subdomain`: Habilitación del subdominio de cuenta en `*.workers.dev`.

## Uso

```hcl
module "worker" {
  source = "./modules/cloudflare_worker"

  account_id     = var.account_id
  worker_name    = "mi-worker-modular"
  d1_database_id = module.d1.database_id
}
```

## Inputs

| Nombre | Tipo | Default | Descripción | Requerido |
| :--- | :--- | :--- | :--- | :--- |
| `account_id` | `string` | N/A | ID de la cuenta de Cloudflare | Sí |
| `worker_name` | `string` | N/A | Nombre del script Worker a desplegar | Sí |
| `main_module` | `string` | `"worker.js"` | Archivo módulo principal | No |
| `content` | `string` | `null` | Código JS del Worker (opcional; si es null usa el `worker.js` local) | No |
| `compatibility_date` | `string` | `"2025-01-01"` | Fecha de compatibilidad del runtime | No |
| `d1_database_id` | `string` | `null` | UUID de base de datos D1 para binding | No |
| `d1_binding_name` | `string` | `"DB"` | Nombre de la variable de binding en el runtime | No |
| `enable_subdomain` | `bool` | `true` | Habilitar endpoint público en `workers.dev` | No |

## Outputs

| Nombre | Tipo | Descripción |
| :--- | :--- | :--- |
| `worker_name` | `string` | Nombre del Worker creado |
| `worker_id` | `string` | Identificador del recurso en Cloudflare |
| `subdomain_enabled` | `bool` | Estado de publicación en el subdominio |
