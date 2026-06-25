resource "google_kms_key_ring" "notebooks" {
  name     = "notebooks-keyring"
  location = "europe-west2"
}
