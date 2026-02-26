# Phase 1: Infrastructure Provisioning

This document outlines the steps to provision the foundational Virtual Machines on Windows Hyper-V using Terraform.

## Prerequisites

* **Hyper-V Host:** Windows Server or Windows 10/11 Pro/Enterprise with the Hyper-V role enabled.
* **WinRM:** Enabled on the host to allow the Terraform provider to communicate.
* **Base Image:** A sysprepped Ubuntu 24.04 VHDX image located at `C:\HyperV\BaseImages\ubuntu-24.04-base.vhdx`.
* **Network:** An External Virtual Switch named `ExternalSwitch`.

## Terraform Configuration

We use the `taliesins/hyperv` community provider to manage local Hyper-V resources. The configuration is defined in `/terraform/main.tf` and `/terraform/providers.tf`.

The architecture provisions:
* **3x Control Plane Nodes:** 2 vCPUs, 4GB RAM, 1 OS Disk.
* **5x Worker Nodes:** 4 vCPUs, 8GB RAM, 1 OS Disk, and 1 RAW 100GB Disk (for Ceph).

## Execution Steps

1. Navigate to the Terraform directory:
   ```bash
   cd terraform
