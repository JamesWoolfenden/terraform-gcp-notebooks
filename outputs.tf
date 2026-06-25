output "instance_id" {
  value       = google_notebooks_instance.main.id
  description = "ID of the legacy notebooks instance"
}

output "workbench_instance_id" {
  value       = google_workbench_instance.main.id
  description = "ID of the Workbench instance"
}
