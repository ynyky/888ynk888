#!/bin/bash
cd /home/stack
source stackrc
for i in $(openstack baremetal node list -f value -c UUID); do openstack baremetal node maintenance set ${i}; echo "Setting maintenance mode for node $i"; done
for i in $(openstack baremetal node list -f value -c UUID); do openstack baremetal node delete ${i}; echo "Deleting node $i"; done
openstack overcloud node import nodes.yaml
echo "imported nodes"
openstack overcloud node introspect --all-manageable --provide
echo "--provided"
