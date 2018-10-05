provider "aws" {
  region     = "us-west-2"
}

resource "aws_s3_bucket" "workshop_s3_bucket" {
  bucket_prefix = "worksop-s3-bucket-"
  acl    = "private"
}

output "s3_bucket_name"{
  value = "${aws_s3_bucket.workshop_s3_bucket.bucket}"
}
