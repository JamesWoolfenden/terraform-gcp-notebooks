
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
}

variable "region" {
  type        = string
  description = "Region for the notebook runtime and Workbench instance"
  default     = "europe-west2"
}

variable "kms_key_name" {
  type        = string
  description = "ID of the KMS crypto key used to encrypt notebook disks"

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
