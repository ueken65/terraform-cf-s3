# terraform-cf-s3

CloudFront + S3 で静的コンテンツを配信する際の構成

## 環境構築

最初にローカルのファイルに以下を記述すること

~/.aws/config

```
[IAM USER NAME]
region = ap-northeast-1
output = json
```

~/.aws/credentials

```
[IAM USER NAME]
aws_access_key_id = [AWS ACCESS KEY ID]
aws_secret_access_key = [AWS SECRET ACCESS KEY]
```

- S3 Bucket の作成（最初にだれかが作ったら今後は不要）

```
# 作成するバケットの確認
make echo-tfstate-bucket
# 作成
./create-tfstate-bucket
```

- Route53 でドメインの登録・ACM で証明書の取得

- terraform の Setup

```
make setup
```

- 確認

```
$ terraform --version
Terraform v0.12.18
```

tfstate ファイルを置く S3 bucket の作成（作成されてなければ作成する）

```
terraform init -backend-config="bucket=terraform-cf-s3-tfstate"
```

事前に証明書を ACM に登録しておく。
※us-east-1 で作成しておかないと CloudFront に使用することはできません。

## Terraform で管理しないもの

- Route53
- ACM
