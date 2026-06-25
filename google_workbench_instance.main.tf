# HLD_GCP_230, HLD_GCP_231
resource "google_workbench_instance" "main" {
  project  = var.project_id
  location = var.location
  name     = "workbench-instance"

  gce_setup {
    machine_type      = "n1-standard-4"
    disable_public_ip = true

    boot_disk {
      kms_key = var.kms_key_name
    }
  }
}
