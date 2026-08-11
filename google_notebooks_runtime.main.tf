resource "google_notebooks_runtime" "main" {
  project  = var.project_id
  location = var.region
  name     = "${var.name_prefix}managed-runtime"

  virtual_machine {
    virtual_machine_config {
      machine_type     = var.machine_type
      internal_ip_only = true
      network          = var.network
      subnet           = var.subnet

      data_disk {
        auto_delete = true

        initialize_params {
          disk_size_gb = var.data_disk_size_gb
          disk_type    = var.data_disk_type
        }
      }

      encryption_config {
        kms_key = var.kms_key_name
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
