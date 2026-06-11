#cloud-config

hostname: ${hostname}

package_update: true
package_upgrade: true

packages:
  - bash
  - curl
  - git
  - openssh
  - htop

users:
  - name: ${username}
    shell: /bin/bash
    groups: wheel
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${ssh_key}

ssh_pwauth: false

runcmd:
  - rc-update add sshd default
  - service sshd start
  - echo "Cloud-init completed"