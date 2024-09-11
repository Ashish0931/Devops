variable "ami" {
  description = "ami code"
}
variable "type" {
  description = "instance type"
}
provider "aws" {
  region = "us-east-1"
}
module "my_module" {
  source = "./modules"

}
resource "aws_instance" "QA_server" {
  ami = var.ami
  instance_type = var.type
}