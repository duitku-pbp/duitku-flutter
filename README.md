[![Duitku CI](https://github.com/duitku-pbp/duitku-flutter/actions/workflows/ci.yml/badge.svg)](https://github.com/duitku-pbp/duitku-flutter/actions/workflows/ci.yml)
[![Pre-Release](https://github.com/duitku-pbp/duitku-flutter/actions/workflows/pre-release.yml/badge.svg)](https://github.com/duitku-pbp/duitku-flutter/actions/workflows/pre-release.yml)
[![Release](https://github.com/duitku-pbp/duitku-flutter/actions/workflows/release.yml/badge.svg)](https://github.com/duitku-pbp/duitku-flutter/actions/workflows/release.yml)
[![Microsoft App Center Build](https://build.appcenter.ms/v0.1/apps/4ef76913-7ec9-4788-ba73-11243bbb3a53/branches/main/badge)](https://appcenter.ms)

# duitku

## Members

- Nayyara Airlangga Raharjo
- Andrew Jeremy
- Arya Daffa Athaillah
- Nanda Tristan Ardiansyah
- Cinthya Yosephine Depari
- Nataya Shafira

## Story

Salah satu isu yang diangkat pada G20 adalah financial inclusion. Financial inclusion adalah kesetaraan peluang dalam mengakses layanan keuangan. G20 ingin meningkatkan financial inclusion. And that’s where we come in.

Duitku adalah aplikasi yang bertujuan untuk meningkatkan financial inclusion dengan memanfaatkan media digital yang sudah ada saat ini. Duitku menyediakan berbagai layanan untuk mendukung tujuan tersebut seperti manajemen uang, berita terkait dunia keuangan, blog keuangan, dll. Dengan berbagai layanan yang disediakan, kami berharap masyarakat dapat lebih mudah mengedukasi diri dan mengakses berbagai layanan keuangan yang ada.

Kini Duitku hadir dalam bentuk aplikasi mobile!

## Modules/Contracts

- Wallet - Angga<br>
  Fitur yang merepresentasikan dompet-dompet/tabungan seorang pengguna. Pengguna dapat memasukkan dan mengeluarkan uang ke dalam dompet-dompetnya setiap kali terjadi transaksi pemasukan dan pengeluaran. Fitur ini bertujuan agar pengguna dapat lebih terbiasa untuk melacak pemasukan dan pengeluarannya agar bisa lebih mengontrol keuangan mereka sendiri dan bisa lebih percaya diri dalam membeli/menjual instrumen keuangan yang sesuai dengan kondisi keuangan mereka.
- Blog - Andrew<br>
  Fitur ini akan menampilkan berbagai artikel informatif mengenai dunia keuangan untuk meningkatkan financial literacy masyarakat.
- Donasi - Arya<br>
  Fitur ini berfungsi sebagai donasi tracker yang akan mempermudah user untuk merencanakan kegiatan donasi yang akan dilakukan, seperti tujuan dan nominal donasi.
- Financial News - Cinthya<br>
- Investasi - Tristan

## User Roles

### Normal Users

- Authenticated
  - Mengakses fitur wallet, membuat dompet dan transaksi, melihat report dari wallet
  - Mengakses halaman blog dan halaman detailnya
  - Mengakses dan melakukan donasi
  - Mengakses berita-berita financial
  - Melakukan investasi
- Unauthenticated
  - Melihat halaman utama dan login/registrasi

### Admin/Super Users

- Melakukan administrasi dan pemantauan data via dashboard admin
- Mengunggah blog post baru serta update berita-berita

## Alur Integrasi dengan Web Service

Pada Proyek Tengah Semester, kami telah membuat Duitku dalam bentuk aplikasi web. Namun, kami juga menambahkan berbagai endpoint yang akan menerima dan mengirim data dalam
bentuk JSON yang akan bertindak sebagai API yang akan diakses oleh Duitku Mobile. Dari aplikasi mobile kami, akan dilakukan HTTP request ke endpoint-endpoint
yang sudah disiapkan sebelumnya untuk mengintegrasikan data Duitku dari web server ke aplikasi mobile tersebut.
