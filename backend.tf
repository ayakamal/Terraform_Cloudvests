terraform {
  backend "s3" {
    bucket         = "cloudvests-state-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "cloudvests"
  }
}
