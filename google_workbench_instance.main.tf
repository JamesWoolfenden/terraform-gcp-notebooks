# HLD_GCP_230, HLD_GCP_231
resource "google_workbench_instance" "main" {
  project  = var.project_id
  location = var.location
  name     = "${var.name_prefix}workbench-instance"

  gce_setup {
    machine_type      = var.machine_type
    disable_public_ip = true

    metadata = {
      "idle-timeout-seconds" = "10800"
    }

    network_interfaces {
      network = var.network
      subnet  = var.subnet
    }

    boot_disk {
      kms_key = var.kms_key_name
    }

    service_accounts {
      email = google_service_account.notebooks.email
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
