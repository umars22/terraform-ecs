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
    bucket = "bucket name"
    key    = "key/default.tfstate"              #this will get the tf state for other resources that we created in different dirs
  }
}

resource "aws_instance" "my-instance" {
  key_name      = data.terraform_remote_state.infrastructure.outputs.key-pair
  ami           = "ami-05548f9cecf47b442"
  instance_type = "t2.micro"
