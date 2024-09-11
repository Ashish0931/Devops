variable "ami" {
  description = "ami code"
}
variable "type" {
  description = "instance type"
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "myec2" {
  ami = var.ami
  instance_type = var.type
}t