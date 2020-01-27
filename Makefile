CREATE_TFSTATE_BUCKET?=create_tfstate_bucket.sh
PROJECT_NAME?="ueken65"
BUCKET_NAME?="$(PROJECT_NAME)-tfstate"
WORKING_DIR?=dev/

.PHONY: all

echo-tfstate-bucket:
	echo $(BUCKET_NAME)

create-tfstate-bucket:
	./$(CREATE_TFSTATE_BUCKET) $(BUCKET_NAME)

setup:
	brew install terraform

init:
	cd $(WORKING_DIR) && terraform init && terraform fmt && terraform validate

plan:
	cd $(WORKING_DIR) && terraform plan
