#### Create bucket AWS S3

resource "aws_s3_bucket" "sandbox_bucket" {
  bucket = var.bucket-name  # Name of the bucket
#  acl    = "private"               # Set the ACL for the bucket (private by default)
}

resource "aws_s3_object" "backup_hana_folder" {
  bucket = aws_s3_bucket.sandbox_bucket.bucket
  key    = var.bucket-folder  # This creates the folder-like structure
#  acl    = "private"       # Set the ACL for the object (private by default)
  content = ""             # Empty content to simulate a folder
}