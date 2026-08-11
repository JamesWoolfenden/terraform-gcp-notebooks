resource "google_compute_network" "private" {
  name                            = "notebooks-private"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

resource "google_compute_subnetwork" "private" {
  name                     = "notebooks-private"
  ip_cidr_range            = "10.10.0.0/24"
  region                   = "europe-west2"
  network                  = google_compute_network.private.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
  }
}

resource "google_compute_router" "private" {
  name    = "notebooks-private-router"
  network = google_compute_network.private.id
  region  = "europe-west2"
}

# Cloud NAT (google_compute_router_nat.private below) has no route of its
# own — it only intercepts traffic from instances with no external IP that
# would otherwise match this route. Without it, deleting the network's
# implicit default route (delete_default_routes_on_create above) leaves
# zero egress path and the NAT gateway has nothing to catch.
resource "google_compute_route" "private_egress" {
  name             = "notebooks-private-egress"
  network          = google_compute_network.private.id
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_router_nat" "private" {
  name                               = "notebooks-private-nat"
  router                             = google_compute_router.private.name
  region                             = "europe-west2"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm                   = 64

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "allow_internal" {
  name    = "notebooks-private-allow-internal"
  network = google_compute_network.private.id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.10.0.0/24"]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
