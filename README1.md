E-Commerce Microservices Application : E-Commerce Microservices Deployment using Terraform, Docker & AWS
Deployed a full-stack microservices-based e-commerce application on AWS using Terraform, Docker, and MongoDB Atlas, automating infrastructure provisioning and container deployment on EC2.

📌 Project Overview
This project demonstrates a complete DevOps pipeline to deploy a multi-service Node.js e-commerce application using:

Terraform (Infrastructure as Code)
AWS EC2 (Cloud Infrastructure)
Docker (Containerization)
Git & GitHub (Version Control)
MongoDB Atlas (Database)
Nginx-ready microservices architecture
The application consists of 4 backend microservices and is deployed on AWS using automated infrastructure provisioning.

🏗️ Architecture
🔷 System Architecture
           ┌────────────────────┐
           │      User Browser   │
           └─────────┬──────────┘
                     │
                     ▼
          ┌──────────────────────┐
          │   AWS EC2 Instance   │
          │ (Terraform Created)  │
          └─────────┬────────────┘
                    │
┌───────────────────┼───────────────────┐
▼                   ▼                   ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│ User Service│ │ Product Svc │ │ Cart Service│ │ :3001 │ │ :3002 │ │ :3003 │ └──────┬──────┘ └──────┬──────┘ └──────┬──────┘ │ │ │ └──────────┬──────┴──────┬─────────┘ ▼ ▼ ┌────────────────────────┐ │ Order Service :3004 │ └────────────────────────┘ │ ▼ ┌────────────────────────┐ │ MongoDB Atlas Cloud │ └────────────────────────┘

Infrastructure
Terraform
AWS (EC2, VPC, Subnet, IGW, Route Table, Security Groups)
Containerization
Docker
DockerHub
Backend
Node.js
Express.js
MongoDB (Mongoose)
Cloud Database
MongoDB Atlas
DevOps Tools
Git
GitHub
Features
✔ Automated AWS infrastructure provisioning
✔ Multi-container microservices architecture
✔ Auto Docker deployment via EC2 user-data script
✔ Secure MongoDB Atlas integration
✔ Public IP-based service access
✔ Scalable cloud-ready setup

Microservices
Service	Port	Description
User Service	3001	Authentication & user management
Product Service	3002	Product catalog
Cart Service	3003	Shopping cart
Order Service	3004	Order processing
