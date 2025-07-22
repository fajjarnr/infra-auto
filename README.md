# Pengaturan Terraform

## Kunci SSH untuk Bastion Host

File `terraform.tfvars` ini berisi variabel yang digunakan oleh konfigurasi Terraform untuk membuat infrastruktur.

### `bastion_public_key`

Variabel `bastion_public_key` digunakan untuk menentukan kunci publik SSH yang akan digunakan untuk mengakses bastion host EC2.

**Cara Membuat Kunci SSH:**

Jika Anda belum memiliki kunci SSH, Anda dapat membuatnya menggunakan perintah berikut di terminal Anda:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Perintah ini akan membuat dua file:
*   `id_ed25519` (kunci privat)
*   `id_ed25519.pub` (kunci publik)

**Cara Menggunakan Kunci Publik:**

1.  Buka file `id_ed25519.pub` dengan editor teks.
2.  Salin seluruh konten file tersebut.
3.  Tempel konten tersebut sebagai nilai untuk variabel `bastion_public_key` di dalam file `terraform.tfvars`, seperti contoh di bawah ini:

```hcl
bastion_public_key = "ssh-ed25519 AAAA..."
```

**PENTING:** Jaga kerahasiaan kunci privat (`id_ed25519`) Anda. Jangan pernah membagikannya atau menyimpannya di dalam repositori ini.
