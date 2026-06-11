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

disable_root: true
ssh_pwauth: false

users:
  - name: ${username}
    shell: /bin/bash
    groups: sudo
    sudo: ALL=(ALL) NOPASSWD:ALL
    lock_passwd: false
    passwd: "$6$rounds=4096$RandomHashHere"
    ssh_authorized_keys:
      - ${ssh_key}

write_files:
  - path: /etc/ssh/sshd_config.d/99-custom.conf
    permissions: '0644'
    content: |
      PubkeyAuthentication yes
      PasswordAuthentication no
      KbdInteractiveAuthentication no
      ChallengeResponseAuthentication no
      PermitRootLogin no
      PermitEmptyPasswords no
      AuthorizedKeysFile .ssh/authorized_keys

runcmd:
  - systemctl enable ssh --now
  - curl -fsSL https://tailscale.com/install.sh | sh
  - systemctl enable tailscaled --now
  - tailscale up --auth-key=${tailscale_auth_key}
  - echo "Cloud-init completed"