variable "vpc-cidr" {
    default="10.0.0.0/16"
  
}
# variable "vpc" {
  
# }
variable "vpc-region" {
    default = "ap-northeast-1"
  
}
variable "az" {
  default = ["ap-northeast-1a","ap-northeast-1c"]
}
variable "public_subnet" {
  default="10.0.1.0/24"
}

variable "private_subnet_1" {
    default = "10.0.2.0/24"
  
}
variable "private_subnet_2" {
    default = "10.0.3.0/24"
  
}