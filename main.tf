resource "aws_instance" "web" {
  ami                    = "ami-0c7217cdde317cfec"   
  instance_type          = "t2.medium"
  key_name               = "dev"
  vpc_security_group_ids = [aws_security_group.jen-security.id]
  user_data              = templatefile("./jenkins.sh", {})
  tags = {
    Name = "Jenkins"
  }
  root_block_device {
    volume_size = 10
  }
}
resource "aws_instance" "web1" {
  ami                    = "ami-0c7217cdde317cfec"   
  instance_type          = "t2.medium"
  key_name               = "dev"
  vpc_security_group_ids = [aws_security_group.sonar12.id]
  user_data              = templatefile("./sonar.sh", {})
  tags = {
    Name = "sonarqube"
  }
  root_block_device {
    volume_size = 10
  }
}
resource "aws_security_group" "jen-security" {
  name        = "jenkins-security"
  description = "Allow TLS inbound traffic"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "jenkins-security"
  }
}
resource "aws_security_group" "sonar12" {
  name        = "Sonar-sg"
  description = "Allow TLS inbound traffic"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sonar-sg"
  }
}
