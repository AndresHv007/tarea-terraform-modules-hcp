# Tarea 8 — Terraform Modules y HCP (Terraform Cloud)

**Estudiante:** Andrés Huerta  
**Carrera:** Ingeniería en Desarrollo de Software, ITESO  
**Materia:** Desarrollo Continuo  
**Repositorio GitHub:** `https://github.com/AndresHv007/tarea-terraform-modules-hcp`  

---

## 1. Descripción del Proyecto

Esta actividad refactoriza la infraestructura de la **Práctica 11 (Cloudflare Worker + D1 Database + Subdominio)** en una arquitectura modular y desacoplada mediante **Terraform Modules**, automatizando su aprovisionamiento remoto a través de **HCP Terraform (Terraform Cloud)** vinculado a un flujo de integración continua por VCS (**GitHub Push-driven deployment**).

### Módulos Implementados

1. **`modules/cloudflare_d1`**:
   - Aprovisiona una base de datos SQLite distribuida en el edge mediante `cloudflare_d1_database`.
   - Expone como outputs el UUID y el nombre de la base de datos para consumo de otros módulos.
2. **`modules/cloudflare_worker`**:
   - Despliega el script del Worker (`cloudflare_workers_script`) en formato ES Module (`worker.js`).
   - Configura de forma dinámica el enlace (binding) hacia la base de datos D1 (`env.DB`).
   - Publica el servicio en el subdominio público `workers.dev` (`cloudflare_workers_script_subdomain`).

---

## 2. Estructura del Repositorio

```text
.
├── .gitignore                      # Excluye .terraform, tfstate y terraform.tfvars
├── README.md                       # Documentación principal y guía de despliegue
├── EVIDENCIAS.md                   # Reporte completo de evidencias para Canvas
├── TASK_SPEC.md                    # Trazabilidad de la actividad académica
├── main.tf                         # Raíz: Invocación y orquestación de módulos
├── variables.tf                    # Definición de variables de entrada raíz
├── outputs.tf                      # Salidas del proyecto (URLs, IDs de D1 y Worker)
├── versions.tf                     # Configuración de provider cloudflare (~> 5.0) y HCP
├── terraform.tfvars.example        # Plantilla de variables sin credenciales
├── terraform.tfvars                # Variables locales (ignorado en Git)
└── modules/
    ├── cloudflare_d1/              # Módulo de base de datos D1
    │   ├── main.tf                 # Recurso cloudflare_d1_database
    │   ├── variables.tf            # Variables requeridas por el módulo
    │   ├── outputs.tf              # database_id y database_name
    │   ├── versions.tf             # Provider cloudflare requerido en el submódulo
    │   └── README.md               # Overview y documentación del módulo D1
    └── cloudflare_worker/          # Módulo de Cloudflare Worker
        ├── main.tf                 # cloudflare_workers_script y subdomain
        ├── variables.tf            # Variables y configuración de bindings
        ├── outputs.tf              # worker_name, worker_id, subdomain_enabled
        ├── versions.tf             # Provider cloudflare requerido en el submódulo
        ├── worker.js               # Script JavaScript del Worker (GET + SELECT 1 D1)
        └── README.md               # Overview y documentación del módulo Worker
```

---

## 3. Archivo `main.tf` de la Raíz

El archivo `main.tf` de la raíz desacopla la creación de recursos delegando la responsabilidad a los dos módulos:

```hcl
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
```

---

## 4. Flujo de Despliegue en HCP Terraform (Terraform Cloud)

### Paso 1: Configurar Cuenta y Organización en Terraform Cloud
1. Iniciar sesión o crear cuenta en [HCP Terraform (Terraform Cloud)](https://app.terraform.io/).
2. Crear una Organización (ej. `iteso-andreshu`).

### Paso 2: Subir el Repositorio a GitHub
1. Crear un repositorio público o privado en tu cuenta de GitHub (ej. `tarea-terraform-modules-hcp`).
2. Vincular el repositorio local y hacer push:
   ```bash
   git init -b main
   git add .
   git commit -m "feat: refactorizar practica 11 con terraform modules y soporte hcp"
   git remote add origin https://github.com/<tu-usuario>/tarea-terraform-modules-hcp.git
   git push -u origin main
   ```

### Paso 3: Crear Workspace Conectado a VCS en Terraform Cloud
1. En HCP Terraform, pulsar **New > Workspace**.
2. Seleccionar el flujo **Version control workflow (VCS)**.
3. Conectar el proveedor de VCS (**GitHub**) y autorizar el acceso.
4. Seleccionar el repositorio `tarea-terraform-modules-hcp`.
5. En **Workspace Name**, asignar `tarea-terraform-modules-hcp` y pulsar **Create workspace**.

### Paso 4: Agregar Variables en el Workspace
Ir a la pestaña **Variables** del Workspace y agregar las siguientes **Terraform Variables**:

| Variable | Tipo | Valor | Sensible |
| :--- | :--- | :--- | :--- |
| `account_id` | Terraform | `c46491cc6b6b2d1d4bdc57dc0b5a09aa` | No |
| `api_token` | Terraform | `<TU_CLOUDFLARE_API_TOKEN>` | **Sí (Marcar Sensitive)** |
| `worker_name` | Terraform | `practica-11-worker-modular` | No |
| `d1_database_name` | Terraform | `practica-11-d1-modular` | No |

### Paso 5: Despliegue Automatizado (Push al Repositorio)
1. Hacer un commit o disparar una ejecución manual con **New Run > Start Run**.
2. Terraform Cloud iniciará automáticamente el pipeline:
   - `Terraform Plan`: Analiza los módulos y detecta los 3 recursos a crear.
   - `Terraform Apply`: Aprovisiona los recursos en Cloudflare.
3. El estado de la ejecución cambiará a **`Apply Finished`**.

---

## 5. Validación Local (Opcional)

Puedes verificar la sintaxis y ejecutar el plan localmente con el CLI de Terraform:

```bash
# Inicializar módulos y plugins
terraform init

# Validar sintaxis
terraform validate

# Previsualizar cambios
terraform plan
```
