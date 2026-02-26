# Phase 2: OS Preparation and Kubernetes Setup

This phase uses Ansible to configure the underlying Ubuntu operating systems and bootstrap the Kubernetes cluster using `kubeadm`.

## Prerequisites

* Ensure all 8 VMs are running and accessible via SSH.
* Update `/ansible/inventory/hosts.ini` with the correct IP addresses and credentials.

## Playbook 1: OS Preparation (`k8s-prep.yaml`)

This playbook configures the strict requirements for running Kubernetes:
* Disables Swap immediately and removes it from `/etc/fstab`.
* Loads required kernel modules (`overlay`, `br_netfilter`).
* Configures `sysctl` parameters for IPv4 forwarding and iptables routing.
* Installs `containerd` and configures it to use the `systemd` cgroup driver.
* Installs `kubelet`, `kubeadm`, and `kubectl` from the official Kubernetes APT repositories.

**Execution:**
```bash
ansible-playbook -i ansible/inventory/hosts.ini ansible/playbooks/k8s-prep.yaml
