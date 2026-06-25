resource "google_kms_crypto_key" "notebooks" {
  name     = "notebooks-key"
  key_ring = google_kms_key_ring.notebooks.id

  lifecycle {
    prevent_destroy = true
  }
}
