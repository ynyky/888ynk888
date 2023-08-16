terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = ">=2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://wa-pve-lotr.intra.codilime.com:8006/api2/json"
  pm_debug = true
}

# resource "proxmox_vm_qemu" "cloudinit-test" {
#   name        = "tftest1.xyz.com"
#   desc        = "tf description"
#   target_node = "prod-pve01"
#   pool = "smartnic-cc"
#   clone = "template-ubuntu22.04"
# }

resource "proxmox_vm_qemu" "cloudinit-test" {
  name        = "wa-lab-smartnic-cc01"
  desc        = "tf description"
  target_node = "wa-pve-goulum"

  clone = "playground-template-template"

  # The destination resource pool for the new VM
  pool = "smartnic-cc"
  vmid = 701
  storage = "ceph_pool0"
  cores   = 1
  sockets = 1
  memory  = 2048
  disk_gb = 4
  nic     = "virtio"
  bridge  = "vmbr0"
  ssh_user        = "root"
  ssh_private_key = <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
EOF

  os_type   = "cloud-init"
  ipconfig0 = "ip=10.5.66.41/24,gw=10.5.66.254"

  sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgPeZR8pwqETm+/B+xlyLL2AOIJ3JtCHkB4T0BUQ16O2vZmoAN4tGYtrWB1K3ZcV/27lQ4fgZNvA6IE4lG36s2CxgQ5JqWBQ3XGYCzU+KFJz/P+LU23ORURBYJUESq4FLKE9g6sSptyjOI5UdhHUG29kfxMLW/K6LU/kLWNzgLe3DEW5TnGq4Du6XtvF3H5fdJQXzKEorBvwRvY0s1th+SP+jd4JTO3AiUREL6PAij6iS2GKGkn9PIy35Qb+TfBDrL7PkgZ6ODbv8T+/UPwtJxIWv19SbOPQ6uLNsBh/8SV9NOsjT73sIC0ewrh82mUw/qNmTO/dVPPXVtlpgxtxLHLdpihQilYVYKN5uKK+IYsG/g4ZLbHNrm5rCby26pebt3AbDO/X3kaEtZ7KsHgVamj/LnhTijP2ERloh193ZbcRdy19NCpKDonN5Km1dXpJloFjMJKJsZn7cRSgTF2yiZPNAdmsrjoYxRQV5MZirtwz5+765Ap32SAHYn6SxmJyc= michal@michal-ThinkPad-E595
EOF

  provisioner "remote-exec" {
    inline = [
      "ip a"
    ]
  }
}