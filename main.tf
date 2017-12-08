provider "aws" {
  region = "ap-southeast-1"
  profile = "osg"
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = "${var.vpc_id}"
}
output "test0" {
  value = "${data.aws_subnet_ids.subnet_ids.ids}"
}

resource "aws_security_group" "allow_test" {
  name        = "allow_test"
  description = "Allow test inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 1000
    to_port     = 2000
    protocol    = "tcp"
    cidr_blocks = ["1.2.3.0/24", "2.3.4.0/24"]
  }

  ingress {
    from_port   = 22
    to_port     = 220
    protocol    = "tcp"
    cidr_blocks = ["125.227.33.50/32"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_test"
  }
}


# resource "aws_instance" "coreos" {
#   # CoreOS-stable-1576.4.0-hvm - ami-cb096db7
#   # ubuntu = ami-10acfb73
#   count = 3
#   ami = "ami-cb096db7"
#   instance_type = "t2.nano"
#   key_name = "st"
#   subnet_id = "${element(data.aws_subnet_ids.subnet_ids.ids, count.index)}"
#   vpc_security_group_ids = ["${aws_security_group.allow_test.id}"]
#   tags {
#     Name = "coreos-${count.index}"
#   }
# }

