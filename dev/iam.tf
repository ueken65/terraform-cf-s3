resource "aws_iam_user" "cf_s3_app" {
  name = var.project
  tags = {
    Name = var.project
    Env  = var.env
  }
}

resource "aws_iam_user_policy_attachment" "s3_full_access" {
  user       = aws_iam_user.cf_s3_app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
