# ============================================================================
# GCS Bucket - Main
# Provisions a Google Cloud Storage bucket via the terraform-google-module-template module.
# ============================================================================

module "gcs_bucket" {
  source = "github.com/subhamay-bhattacharyya-tf/terraform-google-module-template"

  gcs_config = {
    bucket_name                 = var.bucket_name
    project_id                  = var.project_id
    location                    = var.location
    storage_class               = var.storage_class
    force_destroy               = var.force_destroy
    uniform_bucket_level_access = true
    public_access_prevention    = "enforced"
    versioning                  = var.versioning
    labels = merge(var.labels, {
      project     = var.project
      environment = var.environment
    })
  }
}
