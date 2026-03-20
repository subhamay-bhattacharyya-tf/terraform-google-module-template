# ============================================================================
# GCS Bucket Module - Main
# Creates and manages a Google Cloud Storage bucket.
# ============================================================================

locals {
  bucket = var.gcs_config
}

resource "google_storage_bucket" "this" {
  name                        = local.bucket.bucket_name
  project                     = local.bucket.project_id
  location                    = local.bucket.location
  storage_class               = upper(local.bucket.storage_class)
  force_destroy               = local.bucket.force_destroy
  uniform_bucket_level_access = local.bucket.uniform_bucket_level_access
  public_access_prevention    = lower(local.bucket.public_access_prevention)
  labels                      = local.bucket.labels

  versioning {
    enabled = local.bucket.versioning
  }
}