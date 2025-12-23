terraform {
  backend "s3" {
    bucket         = "hamid-tf-state"
    key            = "eks/dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "hamid-tf-locks"
    encrypt        = true
  }
}
