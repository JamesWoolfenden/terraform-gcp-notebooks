# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "notebooks" {
  source       = "../../"
  project_id   = "pike-477416"
  location     = "europe-west2-a"
  region       = "europe-west2"
  kms_key_name = google_kms_crypto_key.notebooks.id
  network      = google_compute_network.private.id
  subnet       = google_compute_subnetwork.private.id
}
