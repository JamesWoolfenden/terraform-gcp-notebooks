resource "google_service_account" "notebooks" {
  project      = var.project_id
  account_id   = "${var.name_prefix}notebooks-sa"
  display_name = "Dedicated service account for notebook workloads"
  description  = "IAM roles are supplied by the caller via var.notebook_sa_roles — none granted by default."
}

resource "google_project_iam_member" "notebooks" {
  for_each = var.notebook_sa_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.notebooks.email}"
}
