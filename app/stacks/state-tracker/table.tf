resource "azurerm_storage_table" "functions_job_runs_table" {
  name                 = replace("${var.project_name}-functions-job-runs", "-", "")
  storage_account_name = module.functionapp_storage.storage_name
}
