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

---

## Docker Image Creation

Build Docker images for all services.

### User Service

### Product Service

### Cart Service

### Order Service

### Frontend

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

Validate:

Review Plan:

Create Infrastructure:

Confirm:

---

## Retrieve Application URL

Get Public IP:



---

## Verification

Verify containers:

```bash
docker ps
```

<img width="1130" height="119" alt="Screenshot 2026-06-15 at 2 02 56 AM" src="https://github.com/user-attachments/assets/97d33669-a4ef-4f55-b984-0fcfaa9e0a86" />


Verify frontend:

```text
http://PUBLIC_IP
```
<img width="551" height="237" alt="Screenshot 2026-06-15 at 5 15 45 AM" src="https://github.com/user-attachments/assets/9298d788-a8eb-43d5-bee4-d071c22caf35" />

Verify backend services:

<img width="1720" height="1039" alt="Screenshot 2026-06-15 at 1 59 54 AM" src="https://github.com/user-attachments/assets/c7b454ab-a2e1-4ec4-ac66-15e1a85a778c" />

<img width="585" height="116" alt="Screenshot 2026-06-15 at 1 59 11 AM" src="https://github.com/user-attachments/assets/fbbbefd5-cffd-4b57-b315-97ee3092f2fa" />


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
│   
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

<img width="661" height="325" alt="Screenshot 2026-06-15 at 5 05 08 AM" src="https://github.com/user-attachments/assets/0abee856-2279-472c-a5bb-62f8a2f1d9c2" />


<img width="1470" height="309" alt="Screenshot 2026-06-15 at 5 05 57 AM" src="https://github.com/user-attachments/assets/f0e28736-0b3d-4674-8d16-83c87b575aef" />

<img width="851" height="761" alt="Screenshot 2026-06-15 at 5 07 22 AM" src="https://github.com/user-attachments/assets/8c1b75de-03d9-4ee8-b611-c1d614957c1b" />


<img width="1483" height="390" alt="Screenshot 2026-06-15 at 5 07 37 AM" src="https://github.com/user-attachments/assets/30df33e9-9f73-443d-9615-a8f72e964a27" />


<img width="1436" height="319" alt="Screenshot 2026-06-15 at 5 08 21 AM" src="https://github.com/user-attachments/assets/339d5d0c-53e6-40a9-a671-bdf6a414193d" />


This prevents unnecessary AWS charges.

---

## Author

Rajendra Pansare

DevOps Assignment Submission

