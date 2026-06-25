# HLD_GCP_234, HLD_GCP_235
resource "google_notebooks_runtime" "main" {
  project  = var.project_id
  location = var.region
  name     = "managed-runtime"

  virtual_machine {
    virtual_machine_config {
      machine_type     = "n1-standard-4"
      internal_ip_only = true

      encryption_config {
        kms_key = var.kms_key_name
      }
    }
  }
}
