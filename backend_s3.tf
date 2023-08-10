terraform {
  backend "s3" {
    bucket = "abhishekm89"
    key = "terraform/backend"
    region = "us-east-1"
  }
}