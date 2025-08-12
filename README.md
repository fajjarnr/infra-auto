# Infrastruktur AWS dengan Terraform

Repo ini men-deploy komponen VPC, optional Bastion (EC2), dan optional EKS menggunakan Terraform modular.

## Prasyarat
- Terraform >= 1.5
- Kredensial AWS telah terkonfigurasi (profil/ENV)

## Cara Pakai Singkat
1. Salin contoh variabel dan sesuaikan:
   - `cp terraform.tfvars.example terraform.tfvars`
   - Isi `bastion_public_key`, opsional `region` dan `default_tags`.
2. Inisialisasi dan validasi:
   - `terraform init`
   - `terraform fmt -recursive`
   - `terraform validate`
3. Terapkan:
   - `terraform apply`

## Kunci SSH untuk Bastion (opsional)
Jika mengaktifkan Bastion module (contoh di `02-bastion.tf`), sediakan kunci publik SSH.

Cara membuat kunci SSH:

```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

Isi nilai `bastion_public_key` di `terraform.tfvars`:

```
bastion_public_key = "ssh-ed25519 AAAA..."
```

PENTING: Jaga kerahasiaan kunci privat Anda dan jangan commit `terraform.tfvars`.

## Default Tags
Gunakan `default_tags` untuk men-tag resource secara konsisten melalui provider:

```
default_tags = {
  Project = "infra-auto"
  Owner   = "your-name"
}
```

## Catatan Keamanan Lab
Security Group default di VPC module saat ini mengizinkan semua inbound untuk keperluan lab. Ubah sesuai kebutuhan untuk lingkungan non-lab.

## Modul
- `modules/vpc`: Membuat VPC, subnet publik/privat, IGW, NAT (opsional), endpoint S3, dan SG default.
- `modules/ec2`: Instance EC2 dengan dukungan SSM (role/profil IAM otomatis) dan pilihan OS/arsitektur.
- `modules/eks`: EKS Cluster + Node Group, addon inti, dan role IAM yang diperlukan.
