terraform {
  backend "s3" {
    bucket = "kubernetes-terraform-aws-demo-backend"
    key    = "eks.tfstate"
    region = "ap-southeast-1"
  }
}
