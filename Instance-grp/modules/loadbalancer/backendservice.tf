data "google_compute_instance_group" "instance_grp" {
  name = "${var.vm_name}-instance-group"
  zone = var.zone
  provider  = google-beta
  
}

data "google_compute_health_check" "health" {
  name = var.healthcheck_name
}


resource "google_compute_region_backend_service" "instance_service" {
  name      = var.backend_name
  provider  = google-beta
  port_name = "http"
  protocol  = "HTTP"
  region    = var.region

  load_balancing_scheme = "INTERNAL_MANAGED"

  backend {
    group = data.google_compute_instance_group.instance_grp.id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  health_checks = [
    data.google_compute_health_check.health.id
  ]
}