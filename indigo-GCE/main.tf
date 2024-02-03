

# create vpc
resource "google_compute_network" "akshay_vpc" {
    name = "akshay-vpc"
}


data "google_compute_network" "ak_vpc" {
  name = "default"
}

resource "google_service_account" "gce-sa" {
  account_id   = "gce-sa"
  display_name = "Custom SA for VM Instance"
}
#Create VM

resource "google_compute_instance" "compute_instance" {
    name = "akshay-instance-tester"
    machine_type = "f1-micro"
    zone = "us-central1-a"

    boot_disk {
        mode = "READ_WRITE"
        auto_delete = true
        device_name = "akshay-instance-tester"
        initialize_params {
          image = "projects/cos-cloud/global/images/cos-stable-109-17800-66-65"
          size = 50
          type = "pd-ssd"
          labels = {
            my_label = "akshay"
          }
        }
        
    }
    network_interface {
      network = data.google_compute_network.ak_vpc.name
      access_config {
      network_tier = "PREMIUM"
    }
    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/akshay-412311/regions/us-central1/subnetworks/default"
    }
    # metadata_startup_script = "sudo apt update -y; sudo apt install nginx -y"
    metadata = {
    google-monitoring-enabled = "true"
    gce-container-declaration = "spec:\n  containers:\n  - name: instance-1\n    image: nginx\n    stdin: false\n    tty: false\n  restartPolicy: Always\n# This container declaration format is not public API and may change without notice. Please\n# use gcloud command-line tool or Google Cloud Console to run Containers on Google Compute Engine."

  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.gce-sa.email
    scopes = ["cloud-platform"]
  }
  labels = {
    container-vm = "cos-stable-109-17800-66-65"
    goog-ec-src  = "vm_add-tf"
  }
  tags = ["http-server", "https-server"]

}



# # Bucket to store stuff
# resource "google_storage_bucket" "website" {
#   name = "gcp-terraform-bucket-akshay-pathickal"
#   location = "US"
# }

# # make new objects public
# resource "google_storage_object_access_control" "public_rules" {
#   object = google_storage_bucket_object.static_site_src.name
#   bucket = google_storage_bucket.website.name
#   role = "READER"
#   entity = "allUsers"
# }

# # upload files to this bucket
# resource "google_storage_bucket_object" "static_site_src" {
#   name = "index.html"
#   source = "./webiste/index.html"
#   bucket = google_storage_bucket.website.name
# }


# # reserve external static ip for load balancer
# resource "google_compute_global_address" "website_ip" {
#   name = "website-lb-ip"
# }