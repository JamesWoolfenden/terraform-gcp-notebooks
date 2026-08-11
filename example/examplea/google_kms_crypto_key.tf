resource "google_kms_crypto_key" "notebooks" {
  name            = "notebooks-key"
  key_ring        = google_kms_key_ring.notebooks.id
  rotation_period = "7776000s" # 90 days

  lifecycle {
    prevent_destroy = true
  }
}
