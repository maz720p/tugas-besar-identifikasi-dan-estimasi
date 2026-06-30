Tugas System Identification - ARX, NLARX, Transfer Function, Hammerstein Wiener, State Space, NLARX Wavenet

Deskripsi Proyek

Repository ini berisi tugas identifikasi sistem yang membandingkan beberapa pendekatan pemodelan, baik linear maupun nonlinear, menggunakan tiga dataset berbeda. Tujuan tugas ini adalah memahami konsep system identification, menerapkan berbagai metode pemodelan pada data nyata, serta membandingkan performa model linear dan nonlinear.

Struktur Folder

model-1-arx-nlarx
Berisi hasil identifikasi sistem menggunakan dataset iddata1 dengan pendekatan ARX dan NLARX.
Isi folder:
ARX_NLARX/arx_nlarx_model.m, script MATLAB untuk membangun dan membandingkan model ARX dan NLARX
ARX_NLARX/Model 1 - Raw Data.png, visualisasi data mentah
ARX_NLARX/Model 1 - ARX Residual Analysis.png, hasil analisis residual model ARX
ARX_NLARX/Model 1 - Comparison.png, perbandingan performa ARX vs NLARX

model-2-tf-hammerstein-wiener
Berisi hasil identifikasi sistem menggunakan dataset iddata2 dengan pendekatan Transfer Function dan Hammerstein Wiener.
Isi folder:
iddata2/buat_dataset.m, script pembuatan dataset
iddata2/identifikasi_tf.m, script identifikasi model Transfer Function
iddata2/identifikasi_hw.m, script identifikasi model Hammerstein Wiener
iddata2/analisis_model.m, script analisis hasil model
iddata2/perbandingan_akurasi.m, script perbandingan akurasi kedua model
iddata2/test_y.m, script pengujian output model
iddata2/iddata2.mat, data identifikasi yang digunakan
iddata2/bestTF.mat, model Transfer Function terbaik hasil identifikasi
iddata2/HW.mat, model Hammerstein Wiener hasil identifikasi

model-3-state-space-nlarx-wavenet
Berisi hasil identifikasi sistem menggunakan dataset dryer2 dengan pendekatan State Space dan NLARX Wavenet.
Isi folder:
dryer2-state-space-nlarx/data/dryer2.mat, data mentah dryer2
dryer2-state-space-nlarx/data/dryer2_preprocessed.mat, data dryer2 setelah preprocessing
dryer2-state-space-nlarx/src/preprocessing.m, script preprocessing data
dryer2-state-space-nlarx/src/dataset_dryer2.m, script penyiapan dataset identifikasi
dryer2-state-space-nlarx/src/identifikasi_statespace.m, script identifikasi model State Space
dryer2-state-space-nlarx/src/perbandingan_model.m, script perbandingan model State Space vs NLARX Wavenet
dryer2-state-space-nlarx/src/analisis_model.m, script analisis hasil model
dryer2-state-space-nlarx/src/standalone.m, script standalone untuk menjalankan keseluruhan alur identifikasi
dryer2-state-space-nlarx/models/bestSS.mat, model State Space terbaik hasil identifikasi
dryer2-state-space-nlarx/results/figures/raw_data.png, visualisasi data mentah dryer2
dryer2-state-space-nlarx/results/figures/detrended.png dan detrended_data.png, hasil proses detrending data
dryer2-state-space-nlarx/results/figures/training_validation.png, pembagian data training dan validasi
dryer2-state-space-nlarx/results/figures/step_response.png, respon step model State Space
dryer2-state-space-nlarx/results/figures/pzmap.png, peta pole zero model State Space
dryer2-state-space-nlarx/results/figures/validation_ss.png, hasil validasi model State Space
dryer2-state-space-nlarx/dryer2-state-space-nlarx.prj, file project MATLAB
dryer2-state-space-nlarx/resources, folder metadata internal project MATLAB, dibuat otomatis oleh MATLAB Project Tool dan tidak perlu diubah

slides
Berisi file presentasi (PPT atau PDF) hasil tugas kelompok.

docs
Berisi dokumen pendukung tambahan jika diperlukan, misalnya laporan tertulis.

Pembagian Tugas

Orang 1, mengerjakan cover, latar belakang, tujuan, penjelasan singkat system identification, tools dan software yang digunakan, serta gambaran umum alur identifikasi sistem.

Orang 2, mengerjakan Model 1 ARX dan NLARX menggunakan dataset iddata1, mencakup deskripsi dataset, metodologi, konsep ARX, konsep NLARX, serta hasil dan analisis perbandingan ARX vs NLARX.

Orang 3, mengerjakan Model 2 Transfer Function dan Hammerstein Wiener menggunakan dataset iddata2, mencakup deskripsi dataset, metodologi, konsep Transfer Function, konsep Hammerstein Wiener, serta hasil dan analisis perbandingan TF vs Hammerstein Wiener.

Orang 4, mengerjakan Model 3 State Space dan NLARX Wavenet menggunakan dataset dryer2, mencakup deskripsi dataset, preprocessing data, konsep State Space, konsep NLARX Wavenet, serta hasil dan analisis perbandingan State Space vs NLARX Wavenet.

Orang 5, mengerjakan perbandingan ketiga model, analisis kelebihan dan kekurangan masing masing metode, ringkasan hasil identifikasi linear vs nonlinear, kesimpulan, push ke Github beserta link Github, dan referensi.

Tools dan Software

MATLAB dengan System Identification Toolbox digunakan untuk seluruh proses identifikasi sistem pada tugas ini.

Cara Menjalankan

Buka MATLAB lalu arahkan current folder ke salah satu folder model yang ingin dijalankan, misalnya model-1-arx-nlarx, model-2-tf-hammerstein-wiener, atau model-3-state-space-nlarx-wavenet. Jalankan file script .m sesuai urutan, dimulai dari script pembuatan atau pemrosesan dataset, kemudian script identifikasi model, lalu script analisis dan perbandingan.

Link Github

Tambahkan link repository Github di sini setelah proses push selesai.

Referensi

Tambahkan daftar referensi yang digunakan dalam tugas ini, misalnya dokumentasi System Identification Toolbox MATLAB dan sumber lain yang relevan.
