provider "aws" {
  version = "2.43.0"
  region  = "ap-northeast-1"
  profile = "ueken65"
}

terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    bucket  = "terraform-cf-s3-dev-tfstate"
    key     = "terraform-network.tfstate.aws" // この文字列でtfファイルが作られてS3に置かれる
    region  = "ap-northeast-1"
    profile = "ueken65"
  }
}
