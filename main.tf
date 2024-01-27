resource "aws_instance" "linux"{
    ami = "ami-00952f27cf14db9cd"  // ami -id of Amazon linux 
    instance_type = "t2.micro"     // size
    key_name = "mykeys3"           // key use to connect ec2 instance
    security_groups = ["ec2group"]  // security group 8200,22,8201 open for vault

    tags = {
        Name = "vault-server"    // name of instance
    }
}

output "ip" {
  value = aws_instance.linux.public_ip  // ipv4 public IP as a output
}
