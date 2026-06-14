# E-CommerceStore Deployment using Terraform and Docker on AWS

## Project Overview

This project demonstrates the deployment of a multi-service Node.js E-Commerce application using Docker containers on AWS infrastructure provisioned with Terraform.

The application consists of:

* Frontend (React)
* User Service
* Product Service
* Cart Service
* Order Service

All services are containerized using Docker and deployed on an AWS EC2 instance automatically using Terraform.

---

## Architecture

```text
AWS
│
├── VPC
│
├── Public Subnet
│
├── Internet Gateway
│
├── Route Table
│
├── Security Group
│
└── EC2 Instance
      │
      ├── Docker
      ├── Frontend Container
      ├── User Service Container
      ├── Product Service Container
      ├── Cart Service Container
      └── Order Service Container
```

---

## Technology Stack

* AWS EC2
* AWS VPC
* Terraform
* Docker
* Node.js
* React
* GitHub
* DockerHub

---

## Service Ports

| Service         | Port |
| --------------- | ---- |
| Frontend        | 3000 |
| User Service    | 3001 |
| Product Service | 3002 |
| Cart Service    | 3003 |
| Order Service   | 3004 |

---

## Prerequisites

Install the following tools:

```bash
brew install git
brew install awscli
brew install terraform
```

---

## AWS Configuration

Configure AWS CLI:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Region = ap-south-1
Output = json
```

Verify:

```bash
aws sts get-caller-identity
```

---

## Docker Image Creation

Build Docker images for all services.

### User Service

```bash
cd backend/user-service

docker build -t user-service .
```

### Product Service

```bash
cd backend/product-service

docker build -t product-service .
```

### Cart Service

```bash
cd backend/cart-service

docker build -t cart-service .
```

### Order Service

```bash
cd backend/order-service

docker build -t order-service .
```

### Frontend

```bash
cd frontend

docker build -t frontend .
```

---

## DockerHub Push

Login:

```bash
docker login
```

Tag Images:

```bash
docker tag user-service USERNAME/user-service:latest

docker tag product-service USERNAME/product-service:latest

docker tag cart-service USERNAME/cart-service:latest

docker tag order-service USERNAME/order-service:latest

docker tag frontend USERNAME/frontend:latest
```

Push Images:

```bash
docker push USERNAME/user-service:latest

docker push USERNAME/product-service:latest

docker push USERNAME/cart-service:latest

docker push USERNAME/order-service:latest

docker push USERNAME/frontend:latest
```

---

## Terraform Infrastructure

Terraform provisions:

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Route Table Association
* Security Group
* EC2 Instance

---

## Terraform Commands

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Review Plan:

```bash
terraform plan
```

Create Infrastructure:

```bash
terraform apply
```

Confirm:

```text
yes
```

---

## Retrieve Application URL

Get Public IP:

```bash
terraform output
```

Example:

```text
public_ip = 13.233.xx.xx
```

Access:

```text
http://13.233.xx.xx
```

---

## Docker Deployment on EC2

Docker is automatically installed through Terraform user-data script.

Containers started:

```bash
docker run -d -p 3001:3001 USERNAME/user-service

docker run -d -p 3002:3002 USERNAME/product-service

docker run -d -p 3003:3003 USERNAME/cart-service

docker run -d -p 3004:3004 USERNAME/order-service

docker run -d -p 80:3000 USERNAME/frontend
```

---

## Verification

Verify containers:

```bash
docker ps
```

Verify frontend:

```text
http://PUBLIC_IP
```

Verify backend services:

```text
http://PUBLIC_IP:3001
http://PUBLIC_IP:3002
http://PUBLIC_IP:3003
http://PUBLIC_IP:3004
```

---

## Project Structure

```text
E-CommerceStore/
│
├── frontend/
│
├── backend/
│   ├── user-service/
│   ├── product-service/
│   ├── cart-service/
│   └── order-service/
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   └── userdata.sh
│
└── README.md
```

---

## Cleanup

Destroy all AWS resources after testing:

```bash
terraform destroy
```

Confirm:

```text
yes
```

This prevents unnecessary AWS charges.

---

## Author

Rajendra Pansare

DevOps Assignment Submission

