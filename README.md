# Auto VPS Setup Script

This script automates the initial setup of a VPS (Virtual Private Server). It performs the following tasks:

1. **OS Detection**: Automatically detects the operating system.
2. **System Update & Upgrade**: Ensures the system is up-to-date.
3. **Required Tools Installation**: Installs necessary tools like `dnsutils` or `bind-utils` for hostname validation.
4. **Hostname Configuration**: Prompts the user to enter a hostname, validates its DNS A record, and applies it.
5. **Timezone Setup**: Allows the user to set the server timezone.
6. **SSH Port Change**: Provides an option to change the SSH port for added security.
7. **Server Restart**: Optionally restarts the server after setup.

---

## Prerequisites

Ensure your VPS has access to the internet and supports the following commands:
- `hostnamectl`
- `timedatectl`
- `host`
- `sed`
- `systemctl`

---

## Installation and Usage

### 1. Clone the Repository
```bash
git clone https://github.com/<your-username>/<your-repository>.git
cd <your-repository>
```

### 2. Make the Script Executable
```bash
chmod +x auto_setup_vps.sh
```

### 3. Run the Script
Run the script with `sudo`:
```bash
sudo ./auto_setup_vps.sh
```

---

## Workflow

1. The script detects the operating system.
2. It updates and upgrades the system to the latest release.
3. It installs necessary tools like `dnsutils` or `bind-utils`.
4. Prompts the user to:
   - Set a hostname (with A record validation).
   - Configure the server timezone.
   - Change the SSH port for enhanced security.
5. Optionally restarts the server to apply changes.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
