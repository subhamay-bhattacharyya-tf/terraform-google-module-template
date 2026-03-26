# -- examples/bucket/basic/variables.tf (Example)
# ============================================================================
# Example: Basic GCS Bucket - Variables
# ============================================================================

variable "project_id" {
  description = "Google Cloud project ID"
  type        = string
}

variable "gcs" {
  description = "GCS bucket configuration"
  type = object({
    bucket_name                 = string
    project_id                  = optional(string, null)
    location                    = optional(string, "US")
    storage_class               = optional(string, "STANDARD")
    force_destroy               = optional(bool, false)
    uniform_bucket_level_access = optional(bool, true)
    public_access_prevention    = optional(string, "enforced")
    versioning                  = optional(bool, false)
    labels                      = optional(map(string), {})
  })
}