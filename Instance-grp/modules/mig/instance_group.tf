data "google_compute_instance_template" "instance_template" {
  name = var.vm_name
}


resource "google_compute_instance_group_manager" "instance_group" { 
    name               = "${var.vm_name}-instance-group"
    base_instance_name = var.vm_name
    zone               = var.zone
    target_size        = var.target_size
    version {
      instance_template  = data.google_compute_instance_template.instance_template.id
    }

    named_port {
        name = "http"
        port = "80"
    }

    lifecycle {
        create_before_destroy = true
  }
}






# allow all access from IAP and health check ranges
resource "google_compute_firewall" "fw_iap" {
  name          = "l7-ilb-fw-allow-iap-hc"
  provider      = google-beta
  direction     = "INGRESS"
  network       = "default"
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "tcp"
  }
}
