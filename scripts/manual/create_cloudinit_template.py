from proxmoxer import ProxmoxAPI
import os
PROXMOX_USERNAME = os.environ['PROXMOX_USERNAME_1']
PROXMOX_USERNAME_PASSWORD = os.environ['PROXMOX_USERNAME_PASSWORD']
PROXMOX_URL = os.environ['PROXMOX_URL']
proxmox = ProxmoxAPI(
    PROXMOX_URL, user=PROXMOX_USERNAME , password=PROXMOX_USERNAME_PASSWORD, verify_ssl=False
)
phy_node="wa-pve-golum"
j_vmid=703
j_vm_name="cloud-init-template"
disk_size=10

size_cloudinit='5M'
size_vm='10250M'
memory=2048
cores=2
proxmox.nodes( phy_node ).storage( 'jurassic-ceph' ).content.post(
    filename='vm-{}-cloudinit'.format(j_vmid),
    node=phy_node,
    size=size_cloudinit,
    vmid=j_vmid
    )

##todo
##already disk imported from admins console
##example
##qm importdisk 9000 bionic-server-cloudimg-amd64.img local-lvm


proxmox.nodes( phy_node ).storage( 'jurassic-ceph' ).content.post(
    filename='vm-{}-disk-1'.format(j_vmid),
    node=phy_node,
    size=size_vm,
    vmid=j_vmid
    )

proxmox.nodes( phy_node ).qemu.post(
    vmid=j_vmid,
    node=phy_node,
    cores=cores,
    memory=memory,
    hotplug='network,disk,usb,memory',
    name=j_vm_name,
    pool="smartnic-cc",
    autostart=1,
    numa=1,
    scsi0="jurassic-ceph:vm-{0}-disk-1,size={1}".format(j_vmid, disk_size),
    ide2="jurassic-ceph:vm-{0}-cloudinit,size={1},media=cdrom".format(j_vmid, disk_size),
    scsihw='virtio-scsi-pci',
    # serial0="socket",
    # vga="serial0",
    net0='bridge=vmbr1300,firewall=1,model=virtio'
)

