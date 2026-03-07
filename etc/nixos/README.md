Fast, minimal NixOS setup for `archie`, focused on performance and clean defaults.

Download and boot the latest minimal ISO:

```bash
# https://nixos.org/download.html
```

Partition disk `/dev/nvme0n1`, e.g., EFI + root (+ optional /home):

```bash
sudo mkfs.fat -F32 /dev/nvme0n1p1
sudo mkfs.btrfs /dev/nvme0n1p2
sudo mkfs.btrfs /dev/nvme0n1p3  # optional
sudo mount /dev/nvme0n1p2 /mnt
sudo mkdir -p /mnt/{boot,home}
sudo mount /dev/nvme0n1p1 /mnt/boot
sudo mount /dev/nvme0n1p3 /mnt/home  # if used
```

Install system:

```bash
sudo nixos-generate-config --root /mnt
sudo nixos-install
sudo reboot
```

Apply custom config:

```bash
curl -sSL https://raw.githubusercontent.com/KiraStack/nixos-config/main/install.sh | sudo bash
```

Rebuild or switch configuration:

```bash
sudo nixos-rebuild switch --flake /etc/nixos/
home-manager switch
```
