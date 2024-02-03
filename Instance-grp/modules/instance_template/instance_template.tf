


data "google_compute_default_service_account" "default" {
}

data "google_compute_image" "my_image" {
  family  = "cos-stable"
  project = "cos-cloud"
}

resource "google_compute_disk" "foobar" {
  name  = "existing-disk"
  image = data.google_compute_image.my_image.self_link
  size  = var.boot_disk_size
  type  = var.boot_disk_type
  zone  = var.vm_zone
}

resource "google_compute_instance_template" "foobar" {
  name           = var.vm_name
  machine_type   = var.vm_machine_type
  can_ip_forward = false
  tags           = var.vm_tags

  disk {
    source       = google_compute_disk.foobar.name
    auto_delete  = true
    boot         = true
  }


  scheduling {
    preemptible       = false
    automatic_restart = true
  }


  service_account {
    email  = data.google_compute_default_service_account.default.email
    scopes = ["cloud-platform"]
  }

  labels = {
    gce-service-proxy = "on"
    container-vm = data.google_compute_image.my_image.name

  }

  metadata = {
    gce-container-declaration = "spec:\n  containers:\n  - name: ${var.vm_name}\n    image: ${var.vm_container}\n    stdin: false\n    tty: false\n  restartPolicy: Always\n# This container declaration format is not public API and may change without notice. Please\n# use gcloud command-line tool or Google Cloud Console to run Containers on Google Compute Engine."
  }

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = var.vpc_subnetwork
  }
}


