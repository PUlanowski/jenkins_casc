terraform {
  required_providers {
    google = {
        source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project
  region = var.region
}

resource "google_cloud_run_service" "jenkinscac-docker" {
  name     = "cloudrun-jenkinscac"
  location = "us-central1"

  template {
    spec {
      containers {
	image = "us-central1-docker.pkg.dev/gcp101730-pulanowskisandbox/mentoring/jenkinscac"
                 }
    
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

#no auth for testing purposes

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.jenkinscac-docker.location
  project     = google_cloud_run_service.jenkinscac-docker.project
  service     = google_cloud_run_service.jenkinscac-docker.name

  policy_data = data.google_iam_policy.noauth.policy_data
}