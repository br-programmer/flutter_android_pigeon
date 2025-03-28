# QR Biometrics App

[![codecov](https://codecov.io/gh/br-programmer/flutter_android_pigeon/branch/main/graph/badge.svg?style=flat-square)](https://codecov.io/gh/br-programmer/flutter_android_pigeon)

**QR Biometrics App** is a mobile application developed with **Flutter** that allows scanning QR codes, authenticating via biometrics, and storing scans locally using **Room Database** and **encrypted SharedPreferences**. The app supports multiple environments (dev, stg, prod) and multilingual localization with **slang**.

---

## 📱 Technologies Used

- **Flutter**
- **Dart**
- **Room Database** (Kotlin/Android)
- **Encrypted SharedPreferences** (Security Crypto)
- **Pigeon** (Flutter ↔ Native communication)
- **slang** (Internationalization)
- **BLoC** (State management)
- **CameraX** + **MLKit Barcode Scanning** (QR scanning)
- **Android Biometrics** (Local authentication)
- **FlutterGen** (Asset management)

---

## 📂 Project Structure

```
lib/
├── core/                # Common logic (Result, Failure, utils)
├── features/            # Modular features (auth, scanner, storage, etc.)
├── i18n/                # Translations generated by slang
pigeons/                 # Pigeon files to generate native bindings
android/                 # Android native code (Room, QR, Biometrics, Storage)
test/                    # Unit and bloc tests (100% coverage)
```

---

## ⚙️ Generation Commands

### 1. Generate bindings with Pigeon

```bash
dart run pigeon --input pigeons/session/session_api.dart
dart run pigeon --input pigeons/biometrics/biometrics_api.dart
dart run pigeon --input pigeons/scanner/qr_scanner_api.dart
dart run pigeon --input pigeons/storage/local_storage_api.dart
```

### 2. Generate translations with slang

```bash
dart run slang
```

### 3. Generate assets with flutter_gen

```bash
fluttergen
```

---

## 🧪 Testing

- **Test coverage: 100%** for unit and bloc tests.
- Repositories are tested with custom failures (`Failure`) and functional programming using `Result`.

---

## 🚧 Current Status

- [x] Complete functionality for scanning, authentication, and storage.
- [x] Stable logic and UI, **no further changes** planned.
- [x] Technical documentation pending (will be completed gradually).
- [x] **CI/CD** setup in progress.

---

## 📤 Delivery

- APK available via email.