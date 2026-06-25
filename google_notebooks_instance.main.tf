# HLD_GCP_227, HLD_GCP_244, HLD_GCP_245, HLD_GCP_248
resource "google_notebooks_instance" "main" {
  project      = var.project_id
  location     = var.location
  name         = "legacy-notebook"
  machine_type = "n1-standard-4"

  vm_image {
    project      = "deeplearning-platform-release"
    image_family = "common-cpu-notebooks"
  }

  disk_encryption = "CMEK"
  kms_key         = var.kms_key_name
  no_public_ip    = true
  network         = var.network
  subnet          = var.subnet

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}
