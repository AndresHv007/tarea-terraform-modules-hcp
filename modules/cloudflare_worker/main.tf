resource "cloudflare_workers_script" "this" {
  account_id         = var.account_id
  script_name        = var.worker_name
  main_module        = var.main_module
  content            = var.content != null ? var.content : file("${path.module}/worker.js")
  compatibility_date = var.compatibility_date

  bindings = var.d1_database_id != null && var.d1_database_id != "" ? [
    {
      name = var.d1_binding_name
      type = "d1"
      id   = var.d1_database_id
    }
  ] : []
}

resource "cloudflare_workers_script_subdomain" "this" {
  count       = var.enable_subdomain ? 1 : 0
  account_id  = var.account_id
  script_name = cloudflare_workers_script.this.script_name
  enabled     = true
}
