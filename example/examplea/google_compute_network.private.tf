resource "google_compute_network" "private" {
  name                    = "notebooks-private"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private" {
  name          = "notebooks-private"
  ip_cidr_range = "10.10.0.0/24"
  region        = "europe-west2"
  network       = google_compute_network.private.id
}
