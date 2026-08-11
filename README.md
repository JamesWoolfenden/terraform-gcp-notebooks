# terraform-gcp-notebooks

Terraform module for Vertex AI Notebooks / Workbench. Exercises holden's `policies/gcp/notebooks` policy set.

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.update",
    "notebooks.instances.create",
    "notebooks.instances.delete",
    "notebooks.instances.get",
    "notebooks.instances.update",
    "notebooks.runtimes.create",
    "notebooks.runtimes.delete",
    "notebooks.runtimes.get",
    "notebooks.runtimes.update",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy"
  ]
}

# plan role
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "A user with least privileges"
  permissions = [
    "iam.serviceAccounts.get",
    "notebooks.instances.get",
    "notebooks.runtimes.get",
    "resourcemanager.projects.getIamPolicy"
  ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->