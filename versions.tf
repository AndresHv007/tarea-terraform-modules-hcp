terraform {
  required_version = ">= 1.5.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }

  # Configuración para HCP Terraform (Terraform Cloud):
  # En workspaces conectados mediante VCS (GitHub -> Terraform Cloud), el backend
  # remoto se gestiona de forma nativa sin requerir declarar el bloque cloud.
  # Si deseas ejecutar vía CLI remota ('terraform apply' desde tu terminal hacia HCP),
  # descomenta el siguiente bloque con el nombre de tu organización y workspace:
  #
  # cloud {
  #   organization = "TU_ORGANIZACION_HCP"
  #   workspaces {
  #     name = "tarea-terraform-modules-hcp"
  #   }
  # }
}

provider "cloudflare" {
  api_token = var.api_token
}
