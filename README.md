# Tugas Besar Identifikasi dan Estimasi

Departemen Teknik Fisika, Institut Teknologi Sepuluh Nopember (ITS)
Semester Genap 2025/2026

## Anggota Kelompok

| Nama | NRP |
|---|---|
| Fauzan Randy Susanto | 5009231012 |
| Rifqi Fadhillah Husien | 5009231049 |
| Kania Indah Ramadhan | 5009231083 |
| Mamluatul 'Azazah | 5009231106 |
| Nurussyawal Latansa Fitri | 5009231127 |

## Deskripsi Proyek

Repository ini berisi tugas besar identifikasi sistem yang membandingkan beberapa pendekatan pemodelan, baik linear maupun nonlinear, menggunakan tiga dataset berbeda. Tujuan tugas ini adalah memahami konsep system identification, menerapkan berbagai metode pemodelan pada data nyata, serta membandingkan performa model linear dan nonlinear.

Tiga studi kasus yang dibahas:

1. ARX vs NLARX pada dataset iddata1
2. Transfer Function vs Hammerstein-Wiener pada dataset iddata2
3. State Space vs NLARX Wavenet pada dataset dryer2

## Struktur Repository

```
.
├── model-1-arx-nlarx/
│   └── ARX_NLARX/
│       ├── arx_nlarx_model.m
│       ├── Model 1 - Raw Data.png
│       ├── Model 1 - ARX Residual Analysis.png
│       └── Model 1 - Comparison.png
├── model-2-tf-hammerstein-wiener/
│   └── iddata2/
│       ├── buat_dataset.m
│       ├── identifikasi_tf.m
│       ├── identifikasi_hw.m
│       ├── analisis_model.m
│       ├── perbandingan_akurasi.m
│       ├── test_y.m
│       ├── iddata2.mat
│       ├── bestTF.mat
│       └── HW.mat
├── model-3-state-space-nlarx-wavenet/
│   └── dryer2-state-space-nlarx/
│       ├── data/
│       ├── src/
│       ├── models/
│       ├── results/figures/
│       ├── resources/
│       └── dryer2-state-space-nlarx.prj
├── slides/
├── docs/
└── README.md
```

### model-1-arx-nlarx

Identifikasi sistem dataset iddata1 dengan pendekatan ARX dan NLARX.

| File | Keterangan |
|---|---|
| `arx_nlarx_model.m` | Script MATLAB untuk membangun dan membandingkan model ARX dan NLARX |
| `Model 1 - Raw Data.png` | Visualisasi data mentah |
| `Model 1 - ARX Residual Analysis.png` | Hasil analisis residual model ARX |
| `Model 1 - Comparison.png` | Perbandingan performa ARX vs NLARX |

### model-2-tf-hammerstein-wiener

Identifikasi sistem dataset iddata2 dengan pendekatan Transfer Function dan Hammerstein-Wiener.

| File | Keterangan |
|---|---|
| `buat_dataset.m` | Script pembuatan dataset |
| `identifikasi_tf.m` | Script identifikasi model Transfer Function |
| `identifikasi_hw.m` | Script identifikasi model Hammerstein-Wiener |
| `analisis_model.m` | Script analisis hasil model |
| `perbandingan_akurasi.m` | Script perbandingan akurasi kedua model |
| `test_y.m` | Script pengujian output model |
| `iddata2.mat` | Data identifikasi yang digunakan |
| `bestTF.mat` | Model Transfer Function terbaik hasil identifikasi |
| `HW.mat` | Model Hammerstein-Wiener hasil identifikasi |

### model-3-state-space-nlarx-wavenet

Identifikasi sistem dataset dryer2 dengan pendekatan State Space dan NLARX Wavenet.

| File / Folder | Keterangan |
|---|---|
| `data/dryer2.mat` | Data mentah dryer2 |
| `data/dryer2_preprocessed.mat` | Data dryer2 setelah preprocessing |
| `src/preprocessing.m` | Script preprocessing data |
| `src/dataset_dryer2.m` | Script penyiapan dataset identifikasi |
| `src/identifikasi_statespace.m` | Script identifikasi model State Space |
| `src/perbandingan_model.m` | Script perbandingan model State Space vs NLARX Wavenet |
| `src/analisis_model.m` | Script analisis hasil model |
| `src/standalone.m` | Script standalone untuk menjalankan keseluruhan alur identifikasi |
| `models/bestSS.mat` | Model State Space terbaik hasil identifikasi |
| `results/figures/raw_data.png` | Visualisasi data mentah dryer2 |
| `results/figures/detrended.png`, `detrended_data.png` | Hasil proses detrending data |
| `results/figures/training_validation.png` | Pembagian data training dan validasi |
| `results/figures/step_response.png` | Respon step model State Space |
| `results/figures/pzmap.png` | Peta pole zero model State Space |
| `results/figures/validation_ss.png` | Hasil validasi model State Space |
| `dryer2-state-space-nlarx.prj` | File project MATLAB |
| `resources/` | Metadata internal project MATLAB, dibuat otomatis oleh MATLAB Project Tool |

### slides

Berisi file presentasi (PPT atau PDF) hasil tugas kelompok.

### docs

Berisi dokumen pendukung tambahan jika diperlukan, misalnya laporan tertulis.

## Pembagian Tugas 

| Anggota | Tanggung Jawab |
|---|---|
| Rifqi Fadhillah Husien | Cover, latar belakang, tujuan, penjelasan singkat system identification, tools dan software yang digunakan, gambaran umum alur identifikasi sistem |
| Nurussyawal Latansa Fitri | Model 1 ARX dan NLARX (iddata1): deskripsi dataset, metodologi, konsep ARX, konsep NLARX, hasil dan analisis perbandingan ARX vs NLARX |
| Kania Indah Ramadhan | Model 2 Transfer Function dan Hammerstein-Wiener (iddata2): deskripsi dataset, metodologi, konsep Transfer Function, konsep Hammerstein-Wiener, hasil dan analisis perbandingan TF vs Hammerstein-Wiener |
| Fauzan Randy Susanto | Model 3 State Space dan NLARX Wavenet (dryer2): deskripsi dataset, preprocessing data, konsep State Space, konsep NLARX Wavenet, hasil dan analisis perbandingan State Space vs NLARX Wavenet |
| Mamluatul 'Azazah | Perbandingan ketiga model, analisis kelebihan dan kekurangan masing-masing metode, ringkasan hasil identifikasi linear vs nonlinear, kesimpulan, push GitHub beserta link, referensi |

## Tools dan Software

MATLAB dengan System Identification Toolbox digunakan untuk seluruh proses identifikasi sistem pada tugas ini.

## Cara Menjalankan

1. Buka MATLAB.
2. Arahkan current folder ke salah satu folder model yang ingin dijalankan: `model-1-arx-nlarx`, `model-2-tf-hammerstein-wiener`, atau `model-3-state-space-nlarx-wavenet`.
3. Jalankan file script `.m` sesuai urutan, dimulai dari script pembuatan atau pemrosesan dataset, kemudian script identifikasi model, lalu script analisis dan perbandingan.

