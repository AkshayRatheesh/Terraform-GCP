terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  credentials = file("../gcpkey.json")

  project = "northern-audio-375106"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#virtual private cloud -vpc
resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "terraform-vpc-subnetwork"
  ip_cidr_range = "10.20.0.0/16"
  network       = google_compute_network.vpc_network.id
}


#virtual machine code
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-c"   
  tags         = ["web", "dev"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.vpc_subnetwork.self_link
    access_config {
    }
  }
}
