
variable "project_id" {
  type        = string
  description = "Project that owns the notebook resources"

  validation {
    condition     = length(trimspace(var.project_id)) > 0
    error_message = "var.project_id must be a non-empty string"
  }
}

variable "location" {
  type        = string
  description = "Zone for the legacy notebooks instance, e.g. europe-west2-a"
  default     = "europe-west2-a"

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "var.location must be a non-empty string"
  }
}

variable "region" {
  type        = string
  description = "Region for the notebook runtime and Workbench instance"
  default     = "europe-west2"

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "var.region must be a non-empty string"
  }
}

variable "kms_key_name" {
  type        = string
  description = "ID of the KMS crypto key used to encrypt notebook disks"
  sensitive   = true

  validation {
    condition     = length(trimspace(var.kms_key_name)) > 0
    error_message = "var.kms_key_name must be a non-empty string"
  }
}

variable "network" {
  type        = string
  description = "ID of the private VPC network for the legacy notebooks instance"

  validation {
    condition     = length(trimspace(var.network)) > 0
    error_message = "var.network must be a non-empty string"
  }
}

variable "subnet" {
  type        = string
  description = "ID of the private subnetwork for the legacy notebooks instance"

  validation {
    condition     = length(trimspace(var.subnet)) > 0
    error_message = "var.subnet must be a non-empty string"
  }
}

variable "machine_type" {
  type        = string
  description = "Machine type for the legacy notebooks instance, the notebooks runtime, and the Workbench VM"
  default     = "n1-standard-4"

  validation {
    condition     = length(trimspace(var.machine_type)) > 0
    error_message = "var.machine_type must be a non-empty string"
  }
}

variable "data_disk_size_gb" {
  type        = number
  description = "Size in GB of the notebooks runtime's data disk"
  default     = 100

  validation {
    condition     = var.data_disk_size_gb > 0
    error_message = "var.data_disk_size_gb must be greater than 0"
  }
}

variable "data_disk_type" {
  type        = string
  description = "Disk type for the notebooks runtime's data disk"
  default     = "PD_STANDARD"

  validation {
    condition     = contains(["PD_STANDARD", "PD_SSD", "PD_BALANCED"], var.data_disk_type)
    error_message = "var.data_disk_type must be one of: PD_STANDARD, PD_SSD, PD_BALANCED"
  }
}

variable "name_prefix" {
  type        = string
  description = "Prefix applied to all resource names created by this module, so it can be instantiated more than once per project"
  default     = ""

  validation {
    condition     = var.name_prefix == "" || can(regex("^[a-z][a-z0-9-]*-$", var.name_prefix))
    error_message = "var.name_prefix must be empty, or lowercase alphanumeric/hyphens starting with a letter and ending in a hyphen, e.g. \"team-a-\""
  }
}

variable "notebook_sa_roles" {
  type        = set(string)
  description = "Project-level IAM roles to grant the dedicated notebook service account (google_service_account.notebooks), e.g. [\"roles/storage.objectViewer\", \"roles/bigquery.dataViewer\"]. The right set depends on what the notebook workload actually reads/writes — empty by default, grant only what's needed."
  default     = []

  validation {
    condition     = alltrue([for r in var.notebook_sa_roles : can(regex("^roles/", r))])
    error_message = "each entry in var.notebook_sa_roles must be a valid IAM role ID starting with \"roles/\""
  }
}
