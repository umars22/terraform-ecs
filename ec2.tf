provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "infrastructure" {
  backend = "s3"

  config = {
    region = "us-east-1"
    bucket = "my-terraform-backend-bruh"
    key    = "key/default.tfstate"
  }
}

resource "aws_instance" "my-instance" {
  key_name      = data.terraform_remote_state.infrastructure.outputs.key-pair
  ami           = "ami-05548f9cecf47b442"
  instance_type = "t2.micro"
