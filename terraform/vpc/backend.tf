terraform {
  backend "s3" {
    bucket = "kubernetes-terraform-aws-demo-backend"
    key    = "vpc.tfstate"
    region = "ap-southeast-1"
  }
}
