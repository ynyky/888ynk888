# Variables for proxmox configuration
variable "proxmox_url" {
  type = string
}

variable "proxmox_username" {
  type = string
}

variable "proxmox_token" {
  type = string
}

variable "scenario_name" {
  type    = string
  default = "example-scenario"
}

variable "token" {
  type    = string
}

variable "scenario_template_id" {
  type    = string
}

variable "from_template" {
  type    = string
}

packer {
  required_plugins {
    ansible = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/ansible"
    }
    proxmox = {
      version = ">= 1.0.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-clone" "training_template" {
  # Proxmox configuration
  proxmox_url = "https://${var.proxmox_url}/api2/json"
  username = var.proxmox_username
  token = var.proxmox_token
  node = "wa-pve-golum"

  clone_vm = "${var.from_template}"
  full_clone = false
  task_timeout = "3m"

  # New machine configuration
  vm_name = "${var.scenario_name}-template"
  pool = "smartnic-cc"
  vm_id = "${var.scenario_template_id}"
  qemu_agent = true

  memory = 512
  cores = 1
  sockets = 1
  cpu_type = "kvm64"
  os = "l26"
  scsi_controller = "virtio-scsi-pci"

  # disks {
  #   type = "scsi"
  #   disk_size = "10G"
  #   storage_pool = "pve-storage01"
  #   storage_pool_type = "nfs"
  #   format = "qcow2"
  # }

  # network_adapters {
  #   model = "virtio"
  #   bridge = "vmbr1315"
  #   firewall = true
  # }

  # Communicator configuration
  communicator = "ssh"
  ssh_username = "ubuntu"
}

build {
  name = "test-scenario-machine"
  sources = [
    "sources.proxmox-clone.training_template"
  ]

  provisioner "ansible" {
    playbook_file = "ansible/playbooks/default.yaml"
    ansible_env_vars = [
      "ANSIBLE_CONFIG=ansible/ansible.cfg"
    ]
    extra_arguments = ["-e", "gitlab_token=${var.token}", "-e", "scenario=${var.scenario_name}"]
    keep_inventory_file = true
    use_proxy = false
  }
    # User provision
  provisioner "ansible" {
    playbook_file = "${var.scenario_name}/ansible/main.yaml"
    ansible_env_vars = [
      "ANSIBLE_CONFIG=ansible/ansible.cfg"
    ]
    extra_arguments = ["-e", "gitlab_token=${var.token}", "-e", "scenario=${var.scenario_name}"]

    keep_inventory_file = true
    use_proxy = false
  }
}



