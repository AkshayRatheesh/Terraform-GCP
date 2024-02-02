# GCP Provider

provider "google" {
    credentials = file(var.gcp-terra-sa)
    project = var.gcp_project
    region = var.gcp_region
  
}