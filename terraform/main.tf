
resource "aws_security_group" "oneclick_sg" {
  name        = "oneclick-sg"
  description = "Security Group for OneClick Jenkins"
  vpc_id      = "vpc-046b15733df0caeb1"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "oneclick-sg"
  }
}

resource "aws_instance" "jenkins" {
  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t3.micro"
  key_name               = "oneclick-key-v2"

  subnet_id              = "subnet-0f8a3016c99cc1213"
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.oneclick_sg.id]

  tags = {
    Name = "OneClick-Jenkins"
  }
}