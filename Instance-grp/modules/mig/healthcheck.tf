resource "google_compute_health_check" "instance_health" {
  name = var.healthcheck_name
  http_health_check {
    port = 80
  }  
}