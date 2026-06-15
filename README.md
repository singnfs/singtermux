# 🤖 SingTermux - Automation Suite

![Version](https://img.shields.io/badge/version-1.0-blue)
![Termux](https://img.shields.io/badge/Termux-Android-orange)
![License](https://img.shields.io/badge/license-MIT-green)

> Automation & Scripting Suite untuk Termux — powerful, modular, dan user-friendly.

---

## 🎯 Fitur Utama

| No | Fitur | Deskripsi |
|----|-------|----------|
| 1  | ⏰ Task Scheduler | Buat & jalankan task terjadwal |
| 2  | 🔄 Workflow Builder | Build workflow kompleks dengan multiple steps |
| 3  | 📚 Script Repository | Simpan & jalankan collection scripts |
| 4  | 💾 Backup Automation | Auto backup untuk files & directories |
| 5  | 🚨 Monitor & Alert | Monitor system, process, disk, & temperature |

---

## 🛠️ Instalasi

### Requirement
- Termux (Android)
- Koneksi internet
- Git (optional)

### Clone & Setup

```bash
git clone https://github.com/singnfs/SingTermux.git
cd SingTermux
chmod +x main.sh
bash main.sh
```

Atau langsung jalankan:

```bash
bash main.sh
```

---

## 📁 Struktur Repo

```
SingTermux/
├── main.sh                    ← Entry point utama
├── modules/
│   ├── colors.sh              ← ANSI colors & utilities
│   ├── menu.sh                ← Header ASCII & menu display
│   ├── task_scheduler.sh       ← Task scheduling
│   ├── workflow_builder.sh     ← Workflow creation & execution
│   ├── script_repo.sh          ← Script repository management
│   ├── backup_auto.sh          ← Backup automation
│   └── monitor_alert.sh        ← System monitoring
└── README.md
```

---

## 🚀 Quick Start

### 1. Task Scheduler
Buat task yang dijalankan secara terjadwal:

```bash
# Jalankan main.sh
bash main.sh

# Pilih [1] Task Scheduler
# Pilih [1] Create New Task
# Isi:
#   - Task name: daily_backup
#   - Command: tar -czf backup.tar.gz ~/important
#   - Schedule: 0 2 * * * (jam 2 pagi setiap hari)
```

### 2. Workflow Builder
Buat workflow dengan multiple steps:

```bash
# Pilih [2] Workflow Builder
# Pilih [1] Create New Workflow
# Edit workflow untuk menambah steps
# Jalankan dengan [3] Execute Workflow
```

### 3. Script Repository
Simpan & jalankan scripts favorit:

```bash
# Pilih [3] Script Repository
# Pilih [1] Add Script
# Isi nama & script akan dibuat
# Edit dengan editor favorit Anda
```

### 4. Backup Automation
Setup auto backup:

```bash
# Pilih [4] Backup Automation
# Pilih [1] Add Backup Source (tentukan folder mana)
# Pilih [3] Create Backup
# File backup disimpan di ~/.singtermux/backups/
```

### 5. Monitor & Alert
Monitor sistem real-time:

```bash
# Pilih [5] Monitor & Alert
# Pilih opsi monitor (system, process, disk, temp)
# View logs dengan [5] View Logs
```

---

## 📂 Data Storage

Semua data tersimpan di:
```
~/.singtermux/
├── tasks/           ← Task files
├── workflows/       ← Workflow files
├── scripts/         ← Script repository
├── backups/         ← Backup files
├── monitors/        ← Monitor configs
├── backup.config    ← Backup source list
└── monitor.log      ← Monitor logs
```

---

## 🔄 Update

```bash
cd SingTermux
git pull
```

Atau gunakan menu Settings → Update SingTermux

---

## 📝 Contoh Use Case

### Daily System Backup
```bash
# Create task
# Name: daily_backup
# Command: tar -czf ~/.singtermux/backups/backup_$(date +%Y%m%d).tar.gz ~/Documents ~/Photos
# Schedule: 0 3 * * * (jam 3 pagi setiap hari)
```

### Auto Update & Cleanup
```bash
# Create workflow:
# Step 1: apt update && apt upgrade -y
# Step 2: apt autoclean
# Step 3: apt autoremove -y
# Schedule dengan task scheduler
```

### Monitor & Alert
```bash
# Monitor disk usage setiap jam
# Catat log jika ada anomali
# Alert ke Telegram (upcoming feature)
```

---

## 🎨 Fitur Customization

Edit module sesuai kebutuhan:
- Ubah warna di `modules/colors.sh`
- Customize header di `modules/menu.sh`
- Tambah fitur di module masing-masing

---

## 📱 Requirements

- **OS:** Termux (Android)
- **Bash:** 4.0 atau lebih baru
- **Tools:** tar, gzip, awk, sed (usually pre-installed)

### Optional
- `git` - untuk clone & update
- `nano` atau `vim` - untuk edit files
- `neofetch` - untuk system info
- `curl` - untuk HTTP requests

---

## 🐛 Troubleshooting

### Permission Denied
```bash
chmod +x main.sh
chmod +x modules/*.sh
```

### Module Not Found
```bash
# Pastikan Anda di folder SingTermux
ls -la modules/
```

### Backup Failed
```bash
# Check backup directory
ls -la ~/.singtermux/backups/

# Check permissions
chmod -R 755 ~/.singtermux/
```

---

## 📄 License

MIT © SingOS

---

## 🤝 Kontribusi

Kontribusi sangat welcome! Silakan:
1. Fork repository
2. Buat feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

---

## 📞 Support

- 📧 GitHub Issues
- 🐦 Twitter: [@singnfs](https://twitter.com/singnfs)
- 💬 Discussions

---

## 🎉 Thank You

Terima kasih sudah menggunakan SingTermux! Happy automating! 🚀
