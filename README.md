# ☁️ Hyper-Converged Home Lab: Kubernetes on Windows Hyper-V

![Kubernetes](https://img.shields.io/badge/kubernetes-%23326ce5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Ceph](https://img.shields.io/badge/ceph-%23E1242A.svg?style=for-the-badge&logo=ceph&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/postgresql-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)

A production-grade, hyper-converged Kubernetes cluster deployed locally on Windows Hyper-V. This project utilizes modern Infrastructure as Code (IaC) and GitOps practices to provision compute, distributed storage, and highly available databases.

## 🏗 Architecture Overview

* **Hypervisor:** Windows Hyper-V
* **Infrastructure Provisioning:** Terraform (`taliesins/hyperv` provider)
* **Configuration Management:** Ansible
* **Container Orchestration:** Kubernetes (deployed via `kubeadm`)
* **CNI (Networking):** Calico
* **Distributed Storage:** Rook-Ceph (Raw VHDX block devices)
* **Databases:** PostgreSQL (Managed via CloudNativePG Operator)
* **Observability:** Prometheus & Grafana
* **GitOps & CI/CD:** ArgoCD & GitHub Actions

## 🚀 Quick Start & Deployment Guide

Due to the complexity of a hyper-converged stack, deployment is broken down into distinct phases. Please follow the documentation in order:

1. [Phase 1: Infrastructure Provisioning (Terraform)](docs/01-infrastructure.md)
2. [Phase 2: OS Prep & Kubernetes Bootstrap (Ansible)](docs/02-kubernetes-setup.md)
3. [Phase 3: Storage Layer (Rook-Ceph)](docs/03-storage-ceph.md)
4. [Phase 4: Observability & GitOps](docs/04-observability.md)

## 📁 Repository Structure

* `/terraform` - Definitions for 3 Control Plane nodes and 5 Worker nodes, including secondary raw disks for Ceph OSDs.
* `/ansible` - Playbooks to prepare Ubuntu 24.04, install `containerd`, and execute `kubeadm init/join`.
* `/kubernetes` - YAML manifests monitored and automatically applied by ArgoCD (GitOps).

## 🛡️ GitOps Workflow

This repository serves as the single source of truth for the cluster state. Any changes merged into the `main` branch under the `/kubernetes` directory are automatically synchronized to the cluster via ArgoCD. Pull Requests are validated via GitHub Actions YAML linting.
