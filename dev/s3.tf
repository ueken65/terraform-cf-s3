resource "aws_s3_bucket" "public_bucket" {
  bucket = "${var.project}-public"
  acl    = "private"

  tags = {
    Name = var.project
    Env  = var.env
    Role = "cdn"
  }

  website {
    index_document = "index.html"
  }

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjets",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.project}-public/*"
        }
    ]
}
POLICY

}
