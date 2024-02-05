# # VPC network
# resource "google_compute_network" "ilb_network" {
#   name                    = "${loadbalancer_name}-network"
#   provider                = google-beta
#   auto_create_subnetworks = false
# }


data "google_compute_network" "ilb_network" {
  name  = var.vpc_network
}



# proxy-only subnet
resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "${var.loadbalancer_name}-proxy-subnet"
  provider      = google-beta
  ip_cidr_range = var.ip_cidr_proxy_subnet
  region        = var.region
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = data.google_compute_network.ilb_network.id
}

# backend subnet
resource "google_compute_subnetwork" "ilb_subnet" {
  name          = "${var.loadbalancer_name}-subnet"
  provider      = google-beta
  ip_cidr_range = var.ip_cidr_ilb_subnet
  region        = var.region
  network       = data.google_compute_network.ilb_network.id
}

# forwarding rule
resource "google_compute_forwarding_rule" "google_compute_forwarding_rule" {
  name                  = "${var.loadbalancer_name}-forwarding-rule"
  provider              = google-beta
  region                = var.region
  depends_on            = [google_compute_subnetwork.proxy_subnet]
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.default.id
  network               = data.google_compute_network.ilb_network.id
  subnetwork            = google_compute_subnetwork.ilb_subnet.id
  network_tier          = "PREMIUM"
}

# HTTP target proxy
resource "google_compute_region_target_http_proxy" "default" {
  name     = "${var.loadbalancer_name}-target-http-proxy"
  provider = google-beta
  region   = var.region
  url_map  = google_compute_region_url_map.default.id
}

# URL map
resource "google_compute_region_url_map" "default" {
  name            = "${var.loadbalancer_name}-regional-url-map"
  provider        = google-beta
  region          = var.region
  default_service = google_compute_region_backend_service.instance_service.id
}







# allow all access from IAP and health check ranges
resource "google_compute_firewall" "fw_iap2" {
  name          = "${var.loadbalancer_name}-fw-allow-iap-hc2"
  provider      = google-beta
  direction     = "INGRESS"
  network       = data.google_compute_network.ilb_network.id
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "tcp"
  }
}

# allow http from proxy subnet to backends
resource "google_compute_firewall" "fw_ilb_to_backends" {
  name          = "${var.loadbalancer_name}-fw-allow-ilb-to-backends"
  provider      = google-beta
  direction     = "INGRESS"
  network       = data.google_compute_network.ilb_network.id
  source_ranges = ["10.0.0.0/24"]
  target_tags   = ["http-server"]
  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }
}

