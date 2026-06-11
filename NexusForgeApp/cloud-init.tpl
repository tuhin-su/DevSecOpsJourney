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
  # SSH
  - rc-update add sshd default
  - service sshd start

  # Tailscale
  - curl -fsSL https://tailscale.com/install.sh | sh
  - rc-update add tailscale default
  - service tailscale start

  # Authenticate (optional)
  # Uncomment if using an auth key
  - tailscale up --auth-key=${tailscale_auth_key}

  - echo "Cloud-init completed"