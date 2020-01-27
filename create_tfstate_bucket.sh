#!/bin/sh

set -ex

BUCKET_NAME="terraform-cf-s3-dev-tfstate"
PROFILE="ueken65"
LEGION=${3:-ap-northeast-1}

# バケットの作成
# リージョンを指定しないとエラーになるので明示的に指定
# https://dev.classmethod.jp/cloud/aws/jaws-ug-cli-1/
aws s3api create-bucket --profile $PROFILE --bucket $BUCKET_NAME --create-bucket-configuration LocationConstraint=$LEGION

# バケットのバージョニング設定
# 何かやらかしたときに、復元できるようにしておく
aws s3api put-bucket-versioning --profile $PROFILE --bucket $BUCKET_NAME --versioning-configuration Status=Enabled

# バケットのデフォルト暗号化設定
# http://tech.withsin.net/2017/12/05/s3-bucket-encryption/
aws s3api put-bucket-encryption --profile $PROFILE --bucket $BUCKET_NAME --server-side-encryption-configuration '{
  "Rules": [
    {
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }
  ]
}'

aws s3api get-bucket-location --profile $PROFILE --bucket $BUCKET_NAME
aws s3api get-bucket-versioning --profile $PROFILE --bucket $BUCKET_NAME
aws s3api get-bucket-encryption --profile $PROFILE --bucket $BUCKET_NAME
