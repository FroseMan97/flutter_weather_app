# 🌤️ Приложение Погоды

Flutter приложение для просмотра погоды в любом городе мира с поддержкой многоязычности и модульной архитектурой.

## 📸 Скриншоты

<div align="center">
  <img src="screens/11.png" alt="Главный экран" width="300"/>
  <img src="screens/22.png" alt="Поиск по городам" width="300"/>
  <img src="screens/33.png" alt="Экран с информацией о погоде" width="300"/>
</div>

## ✨ Особенности

- 🔍 **Поиск городов** - поиск по названию города
- 🌡️ **Детальная погода** - температура, влажность, скорость ветра, ощущаемая температура
- 🌍 **Многоязычность** - поддержка русского и английского языков
- 💾 **Кеширование** - работа с кешированными данными
- 🔄 **Retry** - обработка сетевых ошибок с возможностью повтора
- ✅ **Валидация данных** - проверка входных данных на уровне домена
- 🏗️ **Модульная архитектура** - разделение на независимые пакеты

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

3. **Сгенерируйте код для всех пакетов**
   ```bash
   # Генерация для weather_data
   cd packages/weather_data
   dart run build_runner build --delete-conflicting-outputs
   cd ../..
   
   # Генерация для weather_domain
   cd packages/weather_domain
   dart run build_runner build --delete-conflicting-outputs
   cd ../..
   
   # Генерация для weather_ui_components
   cd packages/weather_ui_components
   dart run build_runner build --delete-conflicting-outputs
   cd ../..
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

## 🔧 Настройка API

Приложение использует два внешних API:

### OpenWeatherMap (погода)

**Пошаговая инструкция:**

1. **Регистрация**
   - Перейдите на [OpenWeatherMap](https://openweathermap.org/api)
   - Нажмите кнопку "Sign Up" в правом верхнем углу
   - Заполните форму регистрации (email, пароль, имя)
   - Подтвердите email через письмо

2. **Получение API ключа**
   - Войдите в аккаунт
   - Перейдите в раздел "API keys" в личном кабинете
   - Скопируйте "Default" ключ (начинается с букв и цифр)
   - Ключ будет активен через 10-15 минут

3. **Использование**
   - Передайте ключ как параметр `WEATHER_API_KEY` при запуске приложения
   - Бесплатный план: 1000 запросов в день

### Amadeus (поиск городов)

**Пошаговая инструкция:**

1. **Регистрация**
   - Перейдите на [Amadeus for Developers](https://developers.amadeus.com/)
   - Нажмите "Get Started" и создайте аккаунт
   - Подтвердите email

2. **Создание приложения**
   - Войдите в "My Self-Service Workspace"
   - Нажмите "Create New App"
   - Выберите "Self-Service" план (бесплатный)
   - Заполните информацию о приложении

3. **Получение ключей**
   - В разделе "API Keys & Secret" скопируйте:
     - **API Key** (Client ID)
     - **API Secret** (Client Secret)
   - Ключи активируются сразу

4. **Использование**
   - Передайте ключи как параметры `AMADEUS_API_KEY` и `AMADEUS_API_SECRET`
   - Бесплатный план: 2000 запросов в месяц

## 🏗️ Модульная архитектура

Приложение построено с использованием **Clean Architecture** и разделено на независимые пакеты:

### 📦 Структура пакетов

```
packages/
├── weather_core/           # Базовые утилиты (сеть, ошибки, DI)
├── weather_domain/         # Бизнес-логика (сущности, use cases)
├── weather_data/           # Слой данных (API, репозитории, модели)
├── weather_localization/   # Локализация и переводы
└── weather_ui_components/  # UI компоненты с BLoC/Cubit
```

### 🎯 Основные технологии
- **Flutter** - кроссплатформенная разработка
- **BLoC/Cubit** - управление состоянием
- **Dependency Injection** - внедрение зависимостей (GetIt)
- **Repository Pattern** - абстракция доступа к данным
- **Use Cases** - инкапсуляция бизнес-логики
- **bloc_test** - тестирование BLoC логики

### 🔧 Дополнительные инструменты
- **Freezed** - генерация immutable классов
- **Easy Localization** - интернационализация
- **SharedPreferences** - локальное кеширование
- **Dio** - HTTP клиент с перехватчиками
- **Logger** - логирование

### 📐 Зависимости пакетов

- **`weather_core`** - базовые утилиты, не зависит от других пакетов
- **`weather_domain`** - бизнес-логика, не зависит от других пакетов
- **`weather_data`** - зависит от `weather_core` и `weather_domain`
- **`weather_localization`** - локализация, не зависит от других пакетов
- **`weather_ui_components`** - зависит от всех остальных пакетов

### 🎯 Принципы организации

- **Модульность** - каждый пакет решает свою задачу
- **Инверсия зависимостей** - пакеты зависят от абстракций
- **Переиспользование** - UI компоненты можно использовать в разных проектах
- **Тестируемость** - каждый пакет тестируется независимо
- **Независимость** - пакеты можно разрабатывать и тестировать отдельно

## 📁 Структура проекта

```
lib/
├── app_features/                  # Функциональные модули приложения
│   └── weather_by_city_screen/    # Главный экран
│       └── weather_page.dart      # Страница погоды
├── di/                            # Dependency Injection
│   └── injection.dart             # Конфигурация DI
├── main.dart                      # Точка входа
└── packages/                      # Модульные пакеты
    ├── weather_core/              # Базовые утилиты
    │   ├── constants/             # API константы
    │   ├── errors/                # Обработка ошибок
    │   ├── network/               # Сетевой слой
    │   └── weather_core.dart      # Экспорт пакета
    ├── weather_domain/            # Бизнес-логика
    │   ├── domain/                # Доменный слой
    │   │   ├── entities/          # Сущности
    │   │   ├── repositories/      # Интерфейсы репозиториев
    │   │   └── usecases/          # Use Cases
    │   └── weather_domain.dart    # Экспорт пакета
    ├── weather_data/              # Слой данных
    │   ├── api/                   # API клиенты
    │   ├── data/                  # Данные
    │   │   ├── datasources/       # Источники данных
    │   │   ├── mappers/           # Мапперы
    │   │   ├── models/            # Модели данных
    │   │   └── repositories_impl/ # Реализации репозиториев
    │   └── weather_data.dart      # Экспорт пакета
    ├── weather_localization/      # Локализация
    │   ├── assets/                # Файлы переводов
    │   │   └── translations/      # JSON файлы
    │   ├── localization/          # Логика локализации
    │   └── weather_localization.dart # Экспорт пакета
    └── weather_ui_components/     # UI компоненты
        ├── cities_search_field/   # Поиск городов
        │   └── presentation/      # UI слой
        │       ├── bloc/          # BLoC/Cubit
        │       └── widgets/       # Виджеты
        ├── weather_widget/        # Виджет погоды
        │   └── presentation/      # UI слой
        │       ├── bloc/          # BLoC/Cubit
        │       └── widgets/       # Виджеты
        └── weather_ui_components.dart # Экспорт пакета
```

## 🧩 Переиспользуемые компоненты

### UI Components

Проект содержит переиспользуемые UI компоненты в папке `ui_components/`:

#### **Cities Search Field**
- **`CitySearchField`** - поле поиска с автодополнением

#### **Weather Widget**
- **`WeatherDisplay`** - основной виджет погоды

### Преимущества

- ✅ **Переиспользование** - компоненты можно использовать в разных частях приложения
- ✅ **Консистентность** - единообразный дизайн и поведение
- ✅ **Тестируемость** - каждый компонент можно тестировать отдельно
- ✅ **Масштабируемость** - легко добавлять новые компоненты

## 🌍 Локализация

Приложение поддерживает русский и английский языки. Файлы переводов находятся в `packages/weather_localization/assets/translations/`:

- `ru.json` - русский язык
- `en.json` - английский язык

### 🔧 Особенности локализации

- **Модульная локализация** - переводы вынесены в отдельный пакет
- **Статические строки** - использование `AppLocalization` для консистентности
- **Локализованные ошибки** - все сообщения об ошибках переведены