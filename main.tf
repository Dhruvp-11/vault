resource "aws_instance" "linux"{
    ami = "ami-00952f27cf14db9cd"
    instance_type = "t2.micro"
    count = 1
    key_name = "mykeys3"
    security_groups = ["ec2group"]

    tags = {
        Name = "vault-server" 
    }
}

output "ip" {
  value = aws_instance.linux.public_ip
}
