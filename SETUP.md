# 🛠️ Руководство по настройке

Подробное руководство по настройке и запуску приложения погоды.

## 📋 Содержание

- [Предварительные требования](#предварительные-требования)
- [Установка Flutter](#установка-flutter)
- [Настройка проекта](#настройка-проекта)
- [Получение API ключей](#получение-api-ключей)
- [Запуск приложения](#запуск-приложения)
- [Решение проблем](#решение-проблем)

## 🔧 Предварительные требования

### Системные требования

- **Windows**: Windows 10 или новее
- **macOS**: macOS 10.14 или новее  
- **Linux**: Ubuntu 18.04 или новее
- **RAM**: минимум 4GB, рекомендуется 8GB
- **Свободное место**: минимум 2GB

### Необходимое ПО

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.0.0)
- [Dart SDK](https://dart.dev/get-dart) (>=3.0.0)
- [Git](https://git-scm.com/downloads)
- IDE на выбор:
  - [Android Studio](https://developer.android.com/studio) (рекомендуется)
  - [VS Code](https://code.visualstudio.com/) с расширением Flutter
  - [IntelliJ IDEA](https://www.jetbrains.com/idea/)

## 📱 Установка Flutter

### Windows

1. **Скачайте Flutter SDK**
   ```bash
   # Скачайте архив с https://flutter.dev/docs/get-started/install/windows
   # Распакуйте в C:\flutter
   ```

2. **Добавьте в PATH**
   - Откройте "Переменные среды"
   - Добавьте `C:\flutter\bin` в переменную PATH

3. **Проверьте установку**
   ```bash
   flutter doctor
   ```

### macOS

1. **Установите через Homebrew**
   ```bash
   brew install --cask flutter
   ```

2. **Или скачайте вручную**
   ```bash
   # Скачайте с https://flutter.dev/docs/get-started/install/macos
   # Распакуйте в ~/development/flutter
   ```

3. **Добавьте в PATH**
   ```bash
   echo 'export PATH="$PATH:~/development/flutter/bin"' >> ~/.zshrc
   source ~/.zshrc
   ```

### Linux

1. **Скачайте Flutter SDK**
   ```bash
   cd ~/development
   wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
   tar xf flutter_linux_3.16.0-stable.tar.xz
   ```

2. **Добавьте в PATH**
   ```bash
   echo 'export PATH="$PATH:~/development/flutter/bin"' >> ~/.bashrc
   source ~/.bashrc
   ```

## 🚀 Настройка проекта

### 1. Клонирование репозитория

```bash
git clone https://github.com/your-username/flutter_weather_app.git
cd flutter_weather_app
```

### 2. Установка зависимостей

```bash
flutter pub get
```

### 3. Генерация кода

```bash
# Генерация Freezed классов и Injectable
dart run build_runner build --delete-conflicting-outputs

# Если нужно перегенерировать
dart run build_runner build --delete-conflicting-outputs
```

### 4. Проверка настройки

```bash
flutter doctor
```

Убедитесь, что все галочки зеленые. Если есть проблемы, следуйте инструкциям `flutter doctor`.

## 🔑 Получение API ключей

### OpenWeatherMap API

1. **Регистрация**
   - Перейдите на [OpenWeatherMap](https://openweathermap.org/api)
   - Нажмите "Sign Up"
   - Заполните форму регистрации
   - Подтвердите email

2. **Получение ключа**
   - Войдите в аккаунт
   - Перейдите в "API keys"
   - Скопируйте "Default" ключ

3. **Использование в проекте**
   
   API ключи передаются как параметры при запуске приложения:
   ```bash
   flutter run --dart-define=WEATHER_API_KEY=your_openweather_key
   ```

### Amadeus API

1. **Регистрация**
   - Перейдите на [Amadeus for Developers](https://developers.amadeus.com/)
   - Нажмите "Get Started"
   - Заполните форму регистрации

2. **Создание приложения**
   - Войдите в аккаунт
   - Перейдите в "My Self-Service Workspace"
   - Нажмите "Create New App"
   - Выберите "Self-Service" план
   - Заполните данные приложения

3. **Получение ключей**
   - В разделе "API Keys & Secret"
   - Скопируйте "API Key" и "API Secret"

4. **Использование в проекте**
   
   API ключи передаются как параметры при запуске приложения:
   ```bash
   flutter run --dart-define=AMADEUS_API_KEY=your_amadeus_key --dart-define=AMADEUS_API_SECRET=your_amadeus_secret
   ```

## 🏃‍♂️ Запуск приложения

### 1. Подготовка устройства

**Android:**
```bash
# Включите режим разработчика на устройстве
# Включите USB отладку
# Подключите устройство к компьютеру

# Или запустите эмулятор
flutter emulators --launch <emulator_id>
```

**iOS (только на macOS):**
```bash
# Откройте Xcode
# Запустите симулятор iOS
open -a Simulator
```

### 2. Запуск приложения

```bash
# Запуск с API ключами (режим отладки)
flutter run --dart-define=WEATHER_API_KEY=your_openweather_key --dart-define=AMADEUS_API_KEY=your_amadeus_key --dart-define=AMADEUS_API_SECRET=your_amadeus_secret

# Запуск в режиме релиза
flutter run --release --dart-define=WEATHER_API_KEY=your_openweather_key --dart-define=AMADEUS_API_KEY=your_amadeus_key --dart-define=AMADEUS_API_SECRET=your_amadeus_secret

# Запуск на конкретном устройстве
flutter run -d <device_id> --dart-define=WEATHER_API_KEY=your_openweather_key --dart-define=AMADEUS_API_KEY=your_amadeus_key --dart-define=AMADEUS_API_SECRET=your_amadeus_secret
```

### 3. Проверка работы

1. Откройте приложение
2. Введите название города (например, "Moscow")
3. Выберите город из списка
4. Убедитесь, что отображается погода

## 🧪 Тестирование

### Запуск тестов

```bash
# Все тесты
flutter test

# Тесты с покрытием
flutter test --coverage

# Конкретный тест
flutter test test/features/weather/presentation/bloc/weather_cubit_test.dart
```

### Проверка качества кода

```bash
# Анализ кода
flutter analyze

# Форматирование кода
dart format .

# Проверка зависимостей
flutter pub deps
```

## 📦 Сборка для продакшена

### Android APK

```bash
# Debug APK
flutter build apk --dart-define=WEATHER_API_KEY=your_key --dart-define=AMADEUS_API_KEY=your_key --dart-define=AMADEUS_API_SECRET=your_secret

# Release APK
flutter build apk --release --dart-define=WEATHER_API_KEY=your_key --dart-define=AMADEUS_API_KEY=your_key --dart-define=AMADEUS_API_SECRET=your_secret

# Split APK (меньший размер)
flutter build apk --split-per-abi --release --dart-define=WEATHER_API_KEY=your_key --dart-define=AMADEUS_API_KEY=your_key --dart-define=AMADEUS_API_SECRET=your_secret
```

### Android App Bundle

```bash
flutter build appbundle --release --dart-define=WEATHER_API_KEY=your_key --dart-define=AMADEUS_API_KEY=your_key --dart-define=AMADEUS_API_SECRET=your_secret
```

### iOS

```bash
# Только на macOS
flutter build ios --release --dart-define=WEATHER_API_KEY=your_key --dart-define=AMADEUS_API_KEY=your_key --dart-define=AMADEUS_API_SECRET=your_secret
```

### Web

```bash
flutter build web --release --dart-define=WEATHER_API_KEY=your_key --dart-define=AMADEUS_API_KEY=your_key --dart-define=AMADEUS_API_SECRET=your_secret
```

## 🐛 Решение проблем

### Частые проблемы

**1. Flutter doctor показывает ошибки**
```bash
# Обновите Flutter
flutter upgrade

# Очистите кэш
flutter clean
flutter pub get
```

**2. Ошибки сборки**
```bash
# Очистите проект
flutter clean
rm -rf build/
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

**3. Проблемы с эмулятором**
```bash
# Перезапустите эмулятор
flutter emulators --launch <emulator_id>

# Или создайте новый
flutter emulators --create
```

**4. Ошибки API**
- Проверьте правильность API ключей
- Убедитесь, что ключи активны
- Проверьте квоты API

**5. Проблемы с локализацией**
```bash
# Перегенерируйте локализацию
flutter gen-l10n
```













---

