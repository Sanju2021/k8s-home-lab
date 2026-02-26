# Paste your Terraform VM configuration here
variable "base_vhdx" {
  description = "Path to the sysprepped Ubuntu base image"
  default     = "C:\\HyperV\\BaseImages\\ubuntu-24.04-base.vhdx"
}

variable "vm_path" {
  description = "Directory to store the cloned VM disks"
  default     = "C:\\HyperV\\Disks\\"
}

variable "network_switch" {
  default = "ExternalSwitch"
}

# ==========================================
# Control Plane Nodes (3 VMs)
# ==========================================
resource "hyperv_vhd" "master_os_disk" {
  count  = 3
  path   = "${var.vm_path}k8s-master-0${count.index + 1}-os.vhdx"
  source = var.base_vhdx
}

resource "hyperv_machine_instance" "master" {
  count                = 3
  name                 = "k8s-master-0${count.index + 1}"
  generation           = 2
  processor_count      = 2
  memory_startup_bytes = 4294967296 # 4GB RAM
  dynamic_memory       = false
  state                = "Running"

  network_adaptors {
    name        = "eth0"
    switch_name = var.network_switch
  }

  hard_disk_drives {
    controller_type     = "Scsi"
    path                = hyperv_vhd.master_os_disk[count.index].path
    controller_number   = 0
    controller_location = 0
  }
}

# ==========================================
# Worker / Ceph Nodes (5 VMs)
# ==========================================
resource "hyperv_vhd" "worker_os_disk" {
  count  = 5
  path   = "${var.vm_path}k8s-worker-0${count.index + 1}-os.vhdx"
  source = var.base_vhdx
}

# This is the RAW, empty disk Rook-Ceph will consume automatically
resource "hyperv_vhd" "worker_ceph_disk" {
  count = 5
  path  = "${var.vm_path}k8s-worker-0${count.index + 1}-ceph.vhdx"
  size  = 107374182400 # 100GB
}

resource "hyperv_machine_instance" "worker" {
  count                = 5
  name                 = "k8s-worker-0${count.index + 1}"
  generation           = 2
  processor_count      = 4
  memory_startup_bytes = 8589934592 # 8GB RAM
  dynamic_memory       = false
  state                = "Running"

  network_adaptors {
    name        = "eth0"
    switch_name = var.network_switch
  }

  # OS Disk
  hard_disk_drives {
    controller_type     = "Scsi"
    path                = hyperv_vhd.worker_os_disk[count.index].path
    controller_number   = 0
    controller_location = 0
  }

  # Ceph Disk (Attached to Location 1)
  hard_disk_drives {
    controller_type     = "Scsi"
    path                = hyperv_vhd.worker_ceph_disk[count.index].path
    controller_number   = 0
    controller_location = 1
  }
}

