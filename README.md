# ?? Hyper-Converged Home Lab: Kubernetes on Windows Hyper-V

A production-grade, hyper-converged Kubernetes cluster deployed locally on Windows Hyper-V. This project utilizes modern Infrastructure as Code (IaC) and GitOps practices to provision compute, distributed storage, and highly available databases.

## ?? Architecture Overview
* **Hypervisor:** Windows Hyper-V
* **Provisioning:** Terraform (	aliesins/hyperv provider)
* **Config Management:** Ansible
* **Orchestration:** Kubernetes (kubeadm)
* **CNI / Storage:** Calico / Rook-Ceph
* **Databases:** PostgreSQL (CloudNativePG)
* **GitOps:** ArgoCD & GitHub Actions
* **Networking:** MetalLB & Ingress-NGINX
