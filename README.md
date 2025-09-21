# 🌤️ Приложение Погоды

Flutter приложение для просмотра погоды в любом городе мира с поддержкой многоязычности.

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
- 🔄 **Retry** - обработка сетевых ошибок
- ✅ **Валидация данных** - проверка входных данных на уровне домена
- 🏗️ **Clean Architecture** - масштабируемая архитектура приложения

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

## 🏗️ Архитектура

Приложение построено с использованием **Clean Architecture** и следующих технологий:

### 🎯 Основные технологии
- **Flutter** - кроссплатформенная разработка
- **BLoC/Cubit** - управление состоянием
- **Dependency Injection** - внедрение зависимостей (GetIt + Injectable)
- **Repository Pattern** - абстракция доступа к данным
- **Use Cases** - инкапсуляция бизнес-логики

### 🔧 Дополнительные инструменты
- **Freezed** - генерация immutable классов
- **Easy Localization** - интернационализация
- **SharedPreferences** - локальное кеширование
- **Dio** - HTTP клиент с перехватчиками
- **Logger** - логирование

## 📁 Структура проекта

```
lib/
├── core/                           # Основная функциональность
│   ├── constants/                  # Константы API
│   │   └── api_constants.dart      # API endpoints и настройки
│   ├── data/                      # Слой данных
│   │   ├── api/                   # API клиенты
│   │   │   ├── cities_api.dart    # API для поиска городов
│   │   │   └── weather_api.dart   # API для погоды
│   │   ├── datasources/           # Источники данных
│   │   │   ├── cities_local_datasource.dart      # Локальный кеш городов
│   │   │   ├── cities_remote_datasource.dart     # Удаленный API городов
│   │   │   ├── weather_local_datasource.dart     # Локальный кеш погоды
│   │   │   └── weather_remote_datasource.dart    # Удаленный API погоды
│   │   ├── mappers/               # Мапперы данных
│   │   │   ├── city_mapper.dart   # Маппер городов
│   │   │   └── weather_mapper.dart # Маппер погоды
│   │   ├── models/                # Модели данных
│   │   │   ├── city_model.dart    # Модель города
│   │   │   └── weather_model.dart # Модель погоды
│   │   └── repositories/          # Репозитории
│   │       ├── cities_repository_impl.dart  # Реализация репозитория городов
│   │       └── weather_repository_impl.dart # Реализация репозитория погоды
│   ├── di/                        # Dependency Injection
│   │   ├── app_module.dart        # Централизованный модуль DI
│   │   ├── injection.dart         # Конфигурация DI
│   │   └── injection.config.dart  # Сгенерированный код
│   ├── domain/                    # Бизнес-логика
│   │   ├── entities/              # Сущности
│   │   │   ├── city.dart          # Сущность города
│   │   │   └── weather.dart       # Сущность погоды
│   │   ├── repositories/          # Интерфейсы репозиториев
│   │   │   ├── cities_repository.dart  # Интерфейс репозитория городов
│   │   │   └── weather_repository.dart # Интерфейс репозитория погоды
│   │   └── usecases/              # Use Cases
│   │       ├── search_cities_usecase.dart  # Поиск городов
│   │       └── get_weather_usecase.dart    # Получение погоды
│   ├── errors/                    # Обработка ошибок
│   │   ├── exceptions.dart        # Исключения
│   │   ├── failures.dart          # Ошибки домена
│   │   └── error_handler.dart     # Глобальный обработчик ошибок
│   ├── localization/              # Локализация
│   │   └── app_localization.dart  # Статические строки
│   └── network/                   # Сетевой слой
│       ├── dio_client.dart        # HTTP клиент
│       └── retry_interceptor.dart # Перехватчик повторов
├── features/                      # Функциональные модули
│   └── weather_by_city_screen/    # Главный экран
│       └── weather_page.dart      # Страница погоды
├── shared/                        # Общие компоненты
│   └── components/
│       ├── cities_search_field/   # Компонент поиска городов
│       │   └── presentation/      # UI слой
│       │       ├── bloc/          # BLoC/Cubit
│       │       │   ├── cities_cubit.dart    # Cubit для поиска городов
│       │       │   └── cities_state.dart    # Состояния поиска городов
│       │       └── widgets/       # Виджеты
│       │           ├── city_search_field.dart      # Поле поиска
│       │           ├── cities_loaded_widget.dart   # Список городов
│       │           ├── cities_loading_widget.dart  # Индикатор загрузки
│       │           ├── cities_empty_widget.dart    # Пустое состояние
│       │           └── cities_error_widget.dart    # Ошибка
│       └── weather_widget/        # Компонент погоды
│           └── presentation/      # UI слой
│               ├── bloc/          # BLoC/Cubit
│               │   ├── weather_cubit.dart    # Cubit для погоды
│               │   └── weather_state.dart    # Состояния погоды
│               └── widgets/       # Виджеты
│                   ├── weather_display.dart        # Основной виджет
│                   ├── weather_loaded_widget.dart  # Загруженная погода
│                   ├── weather_loading_widget.dart # Индикатор загрузки
│                   ├── weather_initial_widget.dart # Начальное состояние
│                   └── weather_error_widget.dart   # Ошибка
├── main.dart                      # Точка входа
└── assets/                        # Ресурсы
    └── translations/              # Файлы локализации
        ├── ru.json               # Русский язык
        └── en.json               # Английский язык
```

## 🌍 Локализация

Приложение поддерживает русский и английский языки. Файлы переводов находятся в `assets/translations/`:

- `ru.json` - русский язык
- `en.json` - английский язык

Для добавления нового языка:
1. Создайте файл `assets/translations/{код_языка}.json`
2. Добавьте переводы всех строк
3. Обновите `supportedLocales` в `main.dart`