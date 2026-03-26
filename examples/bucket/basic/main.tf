# -- examples/bucket/basic/main.tf (Example)
# ============================================================================
# Example: Basic GCS Bucket
# ============================================================================

module "gcs_bucket" {
  source = "../../.."

  gcs_config = merge(var.gcs, {
    project_id = coalesce(var.gcs.project_id, var.project_id)
  })
}