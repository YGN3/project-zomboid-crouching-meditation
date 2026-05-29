# Crouching Meditation Mod - Project Zomboid

## 📖 Deskripsi
Mod ini menambahkan mekanik meditasi melalui jongkok (crouch). Ketika kamu jongkok, stats ngantuk dan panik akan berkurang secara bertahap. Sempurna untuk istirahat dan menenangkan diri!

## ✨ Fitur
- 🧘 Jongkok mengurangi rasa ngantuk (2% per detik)
- 🧘 Jongkok mengurangi rasa panik (3% per detik)
- ⚡ Real-time stat reduction
- 🎮 Compatible dengan multiplayer

## 📥 Instalasi

### Cara 1: Download dari Repository
1. Klik tombol "Code" di repository ini
2. Pilih "Download ZIP"
3. Extract file ZIP
4. Copy folder `CrouchingMeditation` ke folder mods Project Zomboid kamu:
   - **Windows**: `C:\Users\[USERNAME]\Zomboid\mods\`
   - **Linux**: `~/.local/share/Zomboid/mods/`
   - **Mac**: `~/Library/Application Support/Zomboid/mods/`

### Cara 2: Manual Install
1. Buat folder baru dengan nama `CrouchingMeditation` di folder mods Project Zomboid
2. Copy semua file dari repository ke folder tersebut
3. Pastikan struktur folder sesuai dengan struktur di repository ini

## 🎮 Cara Menggunakan
1. Buka Project Zomboid Launcher
2. Cari mod "Crouching Meditation" di bagian Mods
3. Centang checkbox untuk mengaktifkan mod
4. Mulai game
5. Saat bermain, tekan tombol crouch default (biasanya **CTRL**)
6. Lihat stats ngantuk dan panik berkurang secara bertahap!

## ⚙️ Kustomisasi

Jika kamu ingin mengubah kecepatan pengurangan stats, edit file:
```
contents/mods/CrouchingMeditation/media/lua/shared/CrouchingStats.lua
```

Ubah nilai ini sesuai keinginan:
```lua
local TIREDNESS_REDUCTION = 0.02  -- Naik untuk effect lebih kuat
local PANIC_REDUCTION = 0.03      -- Naik untuk effect lebih kuat
```

## 📋 Requirements
- Project Zomboid versi 41.78 atau lebih baru
- Game terbaru/terbaru

## 🐛 Troubleshooting

**Mod tidak berfungsi?**
- Pastikan mod sudah dicentang di launcher
- Cek game console (tekan GRAVE/~) untuk error messages
- Restart game setelah mengaktifkan mod

**Stats tidak berkurang?**
- Pastikan kamu benar-benar jongkok (tekan CTRL)
- Tunggu beberapa detik untuk effect terlihat
- Cek settings kontrol game kamu untuk tombol crouch

## 📝 Versi
- **v1.0.0** - Initial release
- Compatible dengan Project Zomboid 41.78+

## 📄 Lisensi
Free to use and modify. Silakan modifikasi sesuai kebutuhan!

## 👨‍💻 Author
Dibuat oleh: YGN3

## 💡 Tips Penggunaan
- Gunakan saat kamu panic atau lelah
- Jongkok di tempat aman untuk hasil optimal
- Combine dengan item yang menenangkan untuk effect maksimal
- Great untuk roleplaying meditation/yoga!

---

**Enjoy your meditation breaks! 🧘‍♂️**