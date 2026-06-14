# main.tf - Complete working configuration with Key Pair

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

# Generate a private key locally
resource "tls_private_key" "ecommerce_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the AWS Key Pair
resource "aws_key_pair" "ecommerce_key_pair" {
  key_name   = "ecommerce-key-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  public_key = tls_private_key.ecommerce_key.public_key_openssh

  tags = {
    Name = "ecommerce-key-pair"
  }
}

# Save private key locally (for SSH access)
resource "local_file" "private_key" {
  content  = tls_private_key.ecommerce_key.private_key_pem
  filename = "${path.module}/ecommerce-key.pem"
  
  provisioner "local-exec" {
    command = "chmod 400 ${path.module}/ecommerce-key.pem"
  }
}

# Use existing default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets in the VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security Group
resource "aws_security_group" "ecommerce" {
  name        = "ecommerce-sg"
  description = "Security group for e-commerce application"
  vpc_id      = data.aws_vpc.default.id

  # Frontend access (port 3000)
  ingress {
    description = "Frontend access"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Backend services access (ports 3001-3004)
  ingress {
    description = "Backend services"
    from_port   = 3001
    to_port     = 3004
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Consider restricting to your IP for better security
  }

  # HTTP access (optional - if you want to serve on port 80)
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound internet access
  egress {
    description = "Outbound internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecommerce-sg"
  }
}

# EC2 Instance
resource "aws_instance" "ecommerce" {
  ami                    = "ami-0c7217cdde317cfec"  # Ubuntu 22.04 LTS (us-east-1)
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.ecommerce_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.ecommerce.id]
  
  # Use the first default subnet
  subnet_id = data.aws_subnets.default.ids[0]

  # Associate public IP
  associate_public_ip_address = true

  # User data script to install Docker and run containers
  user_data = <<-EOF
    #!/bin/bash
    set -e
    
    # Update system
    apt-get update -y
    
    # Install Docker
    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    
    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
    # Add Docker repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Install Docker Engine
    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    
    # Add ubuntu user to docker group
    usermod -aG docker ubuntu
    
    # Start Docker
    systemctl start docker
    systemctl enable docker
    
    # Wait for Docker to be ready
    sleep 10
    
    # Pull Docker images from DockerHub
    docker pull rajurpansare/user-service:latest
    docker pull rajurpansare/product-service:latest
    docker pull rajurpansare/cart-service:latest
    docker pull rajurpansare/order-service:latest
    docker pull rajurpansare/frontend:latest
    
    # Run containers
    docker run -d --name user-service --restart always -p 3001:3001 rajurpansare/user-service:latest
    docker run -d --name product-service --restart always -p 3002:3002 rajurpansare/product-service:latest
    docker run -d --name cart-service --restart always -p 3003:3003 rajurpansare/cart-service:latest
    docker run -d --name order-service --restart always -p 3004:3004 rajurpansare/order-service:latest
    docker run -d --name frontend --restart always -p 3000:3000 rajurpansare/frontend:latest
    
    # Wait for containers to start
    sleep 5
    
    # Verify containers are running
    docker ps
    
    # Create status file
    echo "Deployment completed at $(date)" > /home/ubuntu/deployment-status.txt
    docker ps >> /home/ubuntu/deployment-status.txt
    
    # Output success message
    echo "All services deployed successfully!"
    echo "Frontend available at: http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):3000"
  EOF

  tags = {
    Name = "Ecommerce-App"
  }
}

# Outputs
output "public_ip" {
  value       = aws_instance.ecommerce.public_ip
  description = "Public IP of the EC2 instance"
}

output "frontend_url" {
  value       = "http://${aws_instance.ecommerce.public_ip}:3000"
  description = "URL to access the frontend"
}

output "ssh_connection_command" {
  value       = "ssh -i ecommerce-key.pem ubuntu@${aws_instance.ecommerce.public_ip}"
  description = "SSH command to connect to the EC2 instance"
}

output "private_key_path" {
  value       = "${path.module}/ecommerce-key.pem"
  description = "Path to the private key file"
  sensitive   = true
}

output "service_urls" {
  value = {
    frontend = "http://${aws_instance.ecommerce.public_ip}:3000"
    user     = "http://${aws_instance.ecommerce.public_ip}:3001/health"
    product  = "http://${aws_instance.ecommerce.public_ip}:3002/health"
    cart     = "http://${aws_instance.ecommerce.public_ip}:3003/health"
    order    = "http://${aws_instance.ecommerce.public_ip}:3004/health"
  }
  description = "URLs for all services"
}

output "key_name" {
  value       = aws_key_pair.ecommerce_key_pair.key_name
  description = "Name of the key pair"
}
