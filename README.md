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

* k8s-home-lab/
├── .github/
│   └── workflows/
│       └── lint.yaml                  # CI pipeline for automated YAML syntax validation
├── docs/
│   ├── 01-infrastructure.md           # Hyper-V and Terraform instructions
│   ├── 02-kubernetes-setup.md         # Ansible OS prep and kubeadm bootstrap
│   ├── 03-storage-ceph.md             # Rook-Ceph configuration and storage classes
│   ├── 04-observability.md            # Prometheus, Grafana, and dashboard IDs
│   ├── 05-ingress-and-routing.md      # NGINX Ingress and cert-manager configuration
│   └── 06-load-balancing-metallb.md   # MetalLB bare-metal networking setup
├── terraform/
│   ├── main.tf                        # VM definitions, vCPU, RAM, and RAW Ceph disks
│   ├── providers.tf                   # Hyper-V WinRM connection details
│   └── variables.tf                   # Path and network variables
├── ansible/
│   ├── inventory/
│   │   └── hosts.ini                  # Control plane and worker IP addresses/credentials
│   ├── playbooks/
│   │   ├── k8s-prep.yaml              # OS prerequisites, swap disable, containerd install
│   │   └── k8s-bootstrap.yaml         # Kubeadm init, Calico CNI, and worker node join
│   └── ansible.cfg                    # (Optional) Default Ansible behaviors
├── kubernetes/                        # 🎯 The ArgoCD GitOps Root Directory
│   ├── cert-manager.yaml              # ArgoCD app deploying Jetstack cert-manager
│   ├── cluster-issuer.yaml            # Self-signed TLS issuer for local HTTPS
│   ├── ingress-controller.yaml        # ArgoCD app deploying NGINX (LoadBalancer type)
│   ├── metallb.yaml                   # ArgoCD app deploying MetalLB controller
│   ├── metallb-config.yaml            # Layer 2 advertisement and your 192.168.1.x IP pool
│   ├── storage/
│   │   ├── my-ceph-cluster.yaml       # Rook-Ceph cluster grabbing your unformatted disks
│   │   └── my-storage-class.yaml      # 3x Replicated CephBlockPool and StorageClass
│   └── workloads/
│       ├── databases/
│       │   └── postgres-cluster.yaml  # CloudNativePG 5-node highly available cluster
│       └── web/
│           └── web-deployment.yaml    # 5 Nginx pods, NodePort Service, and Ingress route
├── .gitignore                         # 🛡️ CRITICAL: Excludes tfstate, secrets, and keys
├── credentials-velero                 # ⚠️ Local S3 keys (Make sure this is in .gitignore!)
├── LICENSE                            # Open source license (e.g., MIT)
└── README.md                          # Architecture overview and Quick Start guide

