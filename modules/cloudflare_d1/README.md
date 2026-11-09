# Módulo Terraform: Cloudflare D1 Database

Módulo reutilizable para aprovisionar bases de datos SQL relacionales serverless en el edge mediante **Cloudflare D1**.

## Características
- Creación declarativa de la base de datos D1 asociada a una cuenta de Cloudflare.
- Exportación del ID único (UUID) para bindings con Workers u otros servicios.

## Uso

```hcl
module "d1" {
  source = "./modules/cloudflare_d1"

  account_id    = var.account_id
  database_name = "mi-base-datos-d1"
}
```

## Inputs

| Nombre | Tipo | Descripción | Requerido |
| :--- | :--- | :--- | :--- |
| `account_id` | `string` | ID de la cuenta de Cloudflare | Sí |
| `database_name` | `string` | Nombre para la base de datos D1 | Sí |

## Outputs

| Nombre | Tipo | Descripción |
| :--- | :--- | :--- |
| `database_id` | `string` | UUID único de la base de datos D1 |
| `database_name` | `string` | Nombre asignado a la base de datos |
