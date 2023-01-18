resource "google_storage_bucket" "my_bucket_tp764242" {
  name          = "my_bucket_tp764242"
  storage_class = "COLDLINE"
  location      = "EU"
  lifecycle_rule {
    condition {
      age = 10
    }
    action {
      type = "Delete"
    }
  }
}

resource "google_service_account" "bucket_uploader" {
  account_id = "bucket-uploader"
}

resource "google_storage_bucket_iam_binding" "bucket_uploader_binding" {
  bucket  = google_storage_bucket.my_bucket_tp764242.name
  role    = "roles/storage.objectCreator"
  members = ["serviceAccount:${google_service_account.bucket_uploader.email}"]
}
