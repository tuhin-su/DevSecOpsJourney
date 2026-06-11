#cloud-config

hostname: ${hostname}

package_update: true
package_upgrade: true

packages:
  - bash
  - curl
  - git
  - openssh-server
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
  - systemctl enable ssh --now
  - curl -fsSL https://tailscale.com/install.sh | sh
  - systemctl enable tailscaled --now
  - tailscale up --auth-key=${tailscale_auth_key}
  - echo "Cloud-init completed"