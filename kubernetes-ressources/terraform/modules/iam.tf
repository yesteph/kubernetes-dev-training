data "google_compute_default_service_account" "default" {
}

resource "google_service_account" "k8s_cnd" {
  account_id   = "k8s-cnd"
  display_name = "k8s CND Service Account"
}

resource "google_service_account_iam_member" "use-role-on-node" {
  service_account_id = data.google_compute_default_service_account.default.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.k8s_cnd.email}"
}

resource "google_project_iam_member" "gke-admin" {
  project = var.MOD_PROJECT
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.k8s_cnd.email}"
}

resource "google_project_iam_member" "project-viewer" {
  project = var.MOD_PROJECT
  role    = "roles/viewer"
  member  = "serviceAccount:${google_service_account.k8s_cnd.email}"
}

resource "google_service_account" "gke_workload" {
  account_id   = "gke-workload"
  display_name = "GKE workload identity service account"
}

resource "google_service_account_iam_member" "gke_workload_identity_user" {
  service_account_id = google_service_account.gke_workload.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.MOD_PROJECT}.svc.id.goog[wsc-training-db/wsc-db-client]"
}

resource "google_project_iam_member" "gke_workload_secret_accessor" {
  project = var.MOD_PROJECT
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.gke_workload.email}"
}

