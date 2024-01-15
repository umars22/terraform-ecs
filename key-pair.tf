#was created in a diff DIR 

provider "aws"{
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

resource "aws_key_pair" "terraform-key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

output "key-pair" {
  value = aws_key_pair.terraform-key.key_name
}
