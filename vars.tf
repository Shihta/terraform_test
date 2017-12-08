variable "vpc_id" {
  type = "string"
  default = "vpc-cf2881aa"
}
output "output_vpc_id" {
  value = "${var.vpc_id}"
}
