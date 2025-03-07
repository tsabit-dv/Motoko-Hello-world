# HelloMotoko Smart Contract

## Overview
**HelloMotoko** adalah smart contract berbasis **Motoko** yang berjalan di **Internet Computer (ICP)**. Kontrak ini menyediakan dua fungsi utama:

1. **greet** - Menghasilkan pesan sapaan berbasis nama pengguna.
2. **sortArray** - Mengurutkan array bilangan bulat menggunakan algoritma **Insertion Sort**.

## Features
- Dibangun dengan **Motoko**, bahasa pemrograman khusus untuk **Internet Computer**.
- **Asynchronous execution**, memastikan efisiensi dalam pemrosesan data.
- Menggunakan fungsi **query** untuk memastikan performa optimal dalam operasi yang tidak mengubah state.

## What is a Canister?
Dalam ekosistem **Internet Computer**, **Canister** adalah bentuk khusus dari smart contract yang mencakup kode dan state yang dapat dieksekusi dalam lingkungan **Internet Computer Protocol (ICP)**. Canister memungkinkan pengembang untuk membuat aplikasi yang skalabel, dapat diperbarui, dan berjalan secara terdesentralisasi. 

Setiap canister memiliki:
- **Kode aplikasi** yang ditulis dalam Motoko atau Rust.
- **Memori yang dikelola secara otomatis**, mendukung stateful computing.
- **Interaksi asynchronous** yang memungkinkan komunikasi efisien antar canister.

## Perbedaan Canister dan Smart Contract
Meskipun **Canister** sering dianggap sebagai smart contract di **Internet Computer**, ada beberapa perbedaan utama antara canister dan smart contract tradisional:

| Aspek           | Smart Contract Tradisional | Canister (ICP) |
|----------------|--------------------------|---------------|
| **Eksekusi**   | Sinkron, terbatas         | Asinkron, skalabel |
| **Penyimpanan** | Terbatas (biasanya hanya kode) | Termasuk state & kode |
| **Komunikasi** | Transaksi blockchain biasa | Dapat berkomunikasi dengan canister lain |
| **Upgrade**    | Sulit atau tidak mungkin  | Dapat diperbarui tanpa kehilangan state |
| **Performa**   | Terbatas oleh blockchain  | Lebih cepat dengan model berbasis wasmtime |

Dengan fitur-fitur tersebut, **Canister** memberikan fleksibilitas lebih besar dibandingkan smart contract tradisional, memungkinkan pembuatan aplikasi yang lebih kompleks dan efisien.

## Installation & Deployment
### Prerequisites
Sebelum menjalankan atau mendeploy smart contract ini, pastikan Anda telah menginstal:
- **DFX SDK** (Dfinity Execution Environment)
- **Motoko Compiler**

### Steps
1. **Clone repository** (jika menggunakan GitHub):
   ```sh
   git clone <repository-url>
   cd HelloMotoko
   ```

2. **Jalankan lokal dengan DFX**:
   ```sh
   dfx start --background
   ```

3. **Deploy smart contract**:
   ```sh
   dfx deploy
   ```

## Smart Contract Code
Berikut adalah kode utama dalam **Motoko**:
```motoko
import Array "mo:base/Array";
import Nat "mo:base/Nat";     

actor HelloMotoko {
    public query func greet(name : Text) : async Text {
        return "Hello, " # name # "!";
    };

    public query func sortArray(arr: [Int]) : async [Int] {
        let n : Nat = arr.size();
        var sortedArr : [var Int] = Array.thaw<Int>(arr);

        for (i in Array.tabulate<Nat>(n - 1, func(x : Nat) : Nat { x + 1 }).vals()) {  
            let key : Int = sortedArr[i];
            var j : Nat = i;  
            
            while (j > 0 and sortedArr[j - 1] > key) {
                sortedArr[j] := sortedArr[j - 1];
                j -= 1;
            };
            sortedArr[j] := key;
        };

        return Array.freeze(sortedArr); 
    };
};
```

## Usage
### 1. Memanggil Fungsi **greet**
Gunakan perintah berikut untuk mendapatkan sapaan:
```sh
dfx canister call HelloMotoko greet '("Alice")'
```
#### **Output:**
```sh
("Hello, Alice!")
```

### 2. Memanggil Fungsi **sortArray**
Gunakan perintah berikut untuk mengurutkan array:
```sh
dfx canister call HelloMotoko sortArray '(vec {5; 2; 9; 1; 5; 6})'
```
#### **Output:**
```sh
(vec {1; 2; 5; 5; 6; 9})
```

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
**Developed with ❤️ using Motoko & Internet Computer.**

