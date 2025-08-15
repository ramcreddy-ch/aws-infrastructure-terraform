# AWS Infrastructure with Terraform

Infrastructure as Code (IaC) project to provision a complete AWS environment including VPC, EKS, and RDS.

## Architecture

```
┌──────────────────────────────────────┐
│ AWS VPC (10.0.0.0/16)                │
│                                      │
│  ┌─────────────┐    ┌─────────────┐  │
│  │ Public      │    │ Private     │  │
│  │ Subnets     │    │ Subnets     │  │
│  │ (IGW)       │    │ (NAT)       │  │
│  └─────────────┘    └──────┬──────┘  │
│                            │         │
│                     ┌──────▼──────┐  │
│                     │     EKS     │  │
│                     │   Cluster   │  │
│                     └─────────────┘  │
│                            │         │
│                     ┌──────▼──────┐  │
│                     │     RDS     │  │
│                     │ (Postgres)  │  │
│                     └─────────────┘  │
└──────────────────────────────────────┘
```

## Resources

- **VPC**: Multi-AZ network with public/private subnets
- **EKS**: Elastic Kubernetes Service for container orchestration
- **RDS**: Managed PostgreSQL database
- **S3**: Object storage

## Prerequisites

- Terraform >= 1.2
- AWS CLI configured

## Quick Start

### 1. Initialize

```bash
terraform init
```

### 2. Plan

```bash
terraform plan -var="db_password=securepassword123"
```

### 3. Apply

```bash
terraform apply -var="db_password=securepassword123"
```

## Modules

The project is structured into reusable modules:
- `modules/vpc`
- `modules/eks`
- `modules/rds`

## Environments

Support for multiple environments (dev, prod) via `environments/` directory content.

## Author

Ramchandra Chintala
