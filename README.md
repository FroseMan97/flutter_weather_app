# 🌤️ Приложение Погоды

Flutter приложение для просмотра погоды в любом городе мира с поддержкой многоязычности.

## ✨ Особенности

- 🔍 **Поиск городов** - интеллектуальный поиск с автодополнением
- 🌡️ **Детальная погода** - температура, влажность, скорость ветра, ощущаемая температура
- 🌍 **Многоязычность** - поддержка русского и английского языков

## 📸 Скриншоты

<div align="center">
  <img src="screens/11.png" alt="гГлавный экран" width="300"/>
  <img src="screens/22.png" alt="Поиск по городам" width="300"/>
  <img src="screens/33.png" alt="Экран с информацией о погоде" width="300"/>
</div>

## 🏗️ Архитектура

Приложение построено с использованием **Clean Architecture** и следующих технологий:

- **Flutter** - кроссплатформенная разработка
- **BLoC/Cubit** - управление состоянием
- **Dependency Injection** - внедрение зависимостей (GetIt + Injectable)
- **Repository Pattern** - абстракция доступа к данным
- **Freezed** - генерация immutable классов
- **Easy Localization** - интернационализация

### 📁 Структура проекта

```
lib/
├── core/                    # Основная функциональность
│   ├── constants/          # Константы API
│   ├── di/                 # Dependency Injection
│   ├── errors/             # Обработка ошибок
│   ├── localization/       # Локализация
│   └── network/            # Сетевой слой
├── features/               # Функциональные модули
│   └── weather_by_city_screen/
├── shared/                 # Общие компоненты
│   └── components/
│       ├── cities/         # Модуль поиска городов
│       └── weather/        # Модуль погоды
└── main.dart              # Точка входа
```

## 📁 Структура проекта

```
lib/
├── core/                           # Основная функциональность
│   ├── constants/                  # Константы API
│   │   └── api_constants.dart     # API ключи и URL
│   ├── di/                        # Dependency Injection
│   │   ├── injection.dart         # Конфигурация DI
│   │   └── injection.config.dart  # Сгенерированный код
│   ├── errors/                    # Обработка ошибок
│   │   ├── exceptions.dart        # Исключения
│   │   └── failures.dart          # Ошибки домена
│   ├── localization/              # Локализация
│   │   └── static_strings.dart    # Статические строки
│   └── network/                   # Сетевой слой
│       └── dio_client.dart        # HTTP клиент
├── features/                      # Функциональные модули
│   └── weather_by_city_screen/    # Главный экран
│       └── weather_page.dart      # Страница погоды
├── shared/                        # Общие компоненты
│   └── components/
│       ├── cities/                # Модуль поиска городов
│       │   ├── data/              # Слой данных
│       │   │   ├── api/           # API клиенты
│       │   │   ├── datasources/   # Источники данных
│       │   │   ├── models/        # Модели данных
│       │   │   ├── mappers/       # Мапперы
│       │   │   └── repositories/  # Репозитории
│       │   ├── domain/            # Бизнес-логика
│       │   │   ├── entities/      # Сущности
│       │   │   └── repositories/  # Интерфейсы репозиториев
│       │   └── presentation/      # UI слой
│       │       ├── bloc/          # BLoC/Cubit
│       │       └── widgets/       # Виджеты
│       └── weather/               # Модуль погоды
│           └── [аналогичная структура]
├── main.dart                      # Точка входа
└── assets/                        # Ресурсы
    └── translations/              # Файлы локализации
        ├── ru.json               # Русский язык
        └── en.json               # Английский язык
```

## 🚀 Быстрый старт

### Предварительные требования

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Git

### Установка

1. **Клонируйте репозиторий**
   ```bash
   git clone https://github.com/FroseMan97/flutter_weather_app.git
   cd flutter_weather_app
   ```

2. **Установите зависимости**
   ```bash
   flutter pub get
   ```

3. **Сгенерируйте код**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Запустите приложение с API ключами**
   ```bash
   # Android
   flutter run --dart-define=WEATHER_API_KEY=your_openweather_key --dart-define=AMADEUS_API_KEY=your_amadeus_key --dart-define=AMADEUS_API_SECRET=your_amadeus_secret
   
   # iOS
   flutter run --dart-define=WEATHER_API_KEY=your_openweather_key --dart-define=AMADEUS_API_KEY=your_amadeus_key --dart-define=AMADEUS_API_SECRET=your_amadeus_secret
   
   # Web
   flutter run -d chrome --dart-define=WEATHER_API_KEY=your_openweather_key --dart-define=AMADEUS_API_KEY=your_amadeus_key --dart-define=AMADEUS_API_SECRET=your_amadeus_secret
   ```

## 🔧 Настройка

### API Ключи

Приложение использует два внешних API:

1. **OpenWeatherMap** - для получения данных о погоде
   - Зарегистрируйтесь на [OpenWeatherMap](https://openweathermap.org/api)
   - Получите бесплатный API ключ
   - Передайте ключ как параметр `WEATHER_API_KEY` при запуске

2. **Amadeus** - для поиска городов
   - Зарегистрируйтесь на [Amadeus for Developers](https://developers.amadeus.com/)
   - Создайте приложение и получите API ключ и секрет
   - Передайте их как параметры `AMADEUS_API_KEY` и `AMADEUS_API_SECRET` при запуске

### Получение API ключей

**OpenWeatherMap:**
1. Перейдите на [OpenWeatherMap](https://openweathermap.org/api)
2. Нажмите "Sign Up" и создайте аккаунт
3. Подтвердите email
4. Войдите в аккаунт и перейдите в "API keys"
5. Скопируйте "Default" ключ

**Amadeus:**
1. Перейдите на [Amadeus for Developers](https://developers.amadeus.com/)
2. Нажмите "Get Started" и создайте аккаунт
3. Войдите в "My Self-Service Workspace"
4. Нажмите "Create New App" и выберите "Self-Service" план
5. В разделе "API Keys & Secret" скопируйте ключи

### Локализация

Приложение поддерживает русский и английский языки. Файлы переводов находятся в `assets/translations/`:

- `ru.json` - русский язык
- `en.json` - английский язык

Для добавления нового языка:
1. Создайте файл `assets/translations/{код_языка}.json`
2. Добавьте переводы всех строк
3. Обновите `supportedLocales` в `main.dart`

## 📱 Использование

1. **Поиск города**
   - Введите название города в поле поиска, например, Moscow
   - Выберите город из списка предложений

2. **Просмотр погоды**
   - После выбора города отобразится текущая погода
   - Информация включает температуру, влажность, скорость ветра

## 🧪 Тестирование

Запустите тесты:
```bash
# Все тесты
flutter test

# Конкретный тест
flutter test test/features/weather/presentation/bloc/weather_cubit_test.dart
```
