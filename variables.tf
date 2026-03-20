# ============================================================================
# GCS Bucket Module - Variables
# ============================================================================

variable "gcs_config" {
  description = "Configuration for the Google Cloud Storage (GCS) bucket."

  type = object({
    bucket_name                 = string
    project_id                  = string
    location                    = optional(string, "US")
    storage_class               = optional(string, "STANDARD")
    force_destroy               = optional(bool, false)
    uniform_bucket_level_access = optional(bool, true)
    public_access_prevention    = optional(string, "enforced")
    versioning                  = optional(bool, false)
    labels                      = optional(map(string), {})
  })

  validation {
    condition = (
      length(var.gcs_config.bucket_name) >= 3 &&
      length(var.gcs_config.bucket_name) <= 63 &&
      can(regex("^[a-z0-9][a-z0-9._-]*[a-z0-9]$", var.gcs_config.bucket_name)) &&
      !can(regex("^goog", var.gcs_config.bucket_name)) &&
      !can(regex("^(\\d{1,3}\\.){3}\\d{1,3}$", var.gcs_config.bucket_name))
    )

    error_message = "gcs_config.bucket_name must be 3-63 chars, lowercase letters/numbers with . _ -, start/end with letter or number, must not start with 'goog', and must not be an IP address."
  }

  validation {
    condition = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.gcs_config.project_id))

    error_message = "gcs_config.project_id must be 6-30 characters, start with a letter, contain only lowercase letters, numbers, or hyphens, and not end with a hyphen."
  }

  validation {
    condition = contains([
      "STANDARD",
      "NEARLINE",
      "COLDLINE",
      "ARCHIVE",
      "MULTI_REGIONAL",
      "REGIONAL",
      "DURABLE_REDUCED_AVAILABILITY"
    ], upper(var.gcs_config.storage_class))

    error_message = "gcs_config.storage_class must be one of: STANDARD, NEARLINE, COLDLINE, ARCHIVE, MULTI_REGIONAL, REGIONAL, DURABLE_REDUCED_AVAILABILITY."
  }

  validation {
    condition = contains(["enforced", "inherited"], lower(var.gcs_config.public_access_prevention))

    error_message = "gcs_config.public_access_prevention must be either 'enforced' or 'inherited'."
  }

  validation {
    condition = trimspace(var.gcs_config.location) != ""

    error_message = "gcs_config.location must not be empty."
  }
}
