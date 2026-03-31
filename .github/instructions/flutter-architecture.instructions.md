---
description: "Use when creating new features, setting up folder structure, or implementing business logic layers in Flutter. Covers project structure patterns."
---
# Flutter Architecture Guidelines

## Project Folder Structure
The application follows this exact structure:
```
lib/
├── firebase_options.dart
├── main.dart
├── bloc/                # BLoC state management
│   ├── parent/          # BLoCs for parent flows
│   ├── shared/          # Shared BLoCs (login, OTP, splash, etc.)
│   └── teacher/         # BLoCs for teacher flows
├── domain/
│   ├── config/          # keys, secure storage, shared prefs
│   ├── data_model/      # onboarding model
│   └── db_client/       # Supabase clients (auth, branch, dashboard, etc.)
├── model/               # 27 data models (user, student, notification, etc.)
├── repository/          # Repository layer for data access
│   ├── auth_repository.dart
│   └── ...
├── resources/
│   ├── enum.dart
│   ├── l10n/            # Localizations (EN, AR, MS)
│   ├── styles/          # Colors, themes, text styles
│   └── values/          # Asset paths
├── services/            # Biometric, Firebase/local notifications, splash
├── ui/
│   └── pages/           # All application pages/screens
├── utils/               # Constants, utilities, routing
    ├── include.dart     # Centralized imports file
    └── routes/          # Route definitions and names
```

## BLoC Folder Structure
Each feature has its own bloc folder with three files:
```
lib/bloc/
├── feature_name/
│   ├── feature_name_bloc.dart    # BLoC logic and event handlers
│   ├── feature_name_event.dart   # Events that trigger state changes
│   └── feature_name_state.dart   # States emitted by the BLoC
```

## Shared Widget Structure
Reusable widgets that are used across multiple pages:
```
lib/shared/
└── widgets/
    ├── button_widget.dart         # Reusable button components
    ├── app_bar_widget.dart        # Custom app bar widget
    ├── bottom_nav_widget.dart     # Bottom navigation bar
    ├── drawer_widget.dart         # Navigation drawer
    ├── text_field_widget.dart     # Text input fields
    ├── dialog_widget.dart         # Modal dialogs and alerts
    └── card_widget.dart           # Card components
```

## Layer Organization Rules
- **Domain**: Configuration, data models, and database clients
- **Model**: Data models for entities (user, student, notification, etc.)
- **BLoC**: State management organized by user type (parent/shared/teacher)
- **Repository**: Data access layer between BLoC and data sources
- **Resources**: Assets, localization, styles, and values
- **Services**: External service integrations
- **UI**: All application pages and screens
- **Utils**: Constants, utilities, and routing logic

## Widget Organization Rules
- **Page widgets** (`lib/ui/pages/`) contain full screen implementations
- **Shared widgets** (`lib/ui/widgets/`) are reusable across multiple pages
- Before creating a new widget, check if a similar shared widget exists
- Shared widgets must be configurable through constructor parameters
- Pages can use shared widgets, but shared widgets CANNOT depend on page-specific code
- One widget per file with the same name pattern: `widget_name_widget.dart` → `WidgetNameWidget`

## BLoC Organization
- **Parent BLoCs** (`lib/bloc/parent/`) - For parent-specific flows and data
- **Shared BLoCs** (`lib/bloc/shared/`) - Common BLoCs (login, OTP, splash, etc.)
- **Teacher BLoCs** (`lib/bloc/teacher/`) - For teacher-specific flows and data
- Each BLoC has separate files for: bloc, events, and states
- Use `Equatable` for states and events
- Repository injection via constructor: `MyBloc({required MyRepository repository})`

## Repository Layer
- All data access goes through repositories
- Repositories abstract data sources (API, database, local storage)
- One repository per domain entity or feature
- Inject repositories into BLoCs via constructor

## Model Structure
- All data models go in `lib/model/`
- Use consistent naming: `user.dart` → `User` class
- Include JSON serialization methods
- Document model relationships and purposes

## Widget Categorization
Essential widget types to maintain:
- **Buttons**: Action triggers with different styles and states (`button_widget.dart`)
- **App Bar**: Custom application bar components (`app_bar_widget.dart`)
- **Bottom Navigation**: Bottom navigation bar widget (`bottom_nav_widget.dart`)
- **Drawer**: Navigation drawer component (`drawer_widget.dart`)
- **Text Fields**: Input fields with validation and styling (`text_field_widget.dart`)
- **Dialogs**: Modal dialogs, alerts, confirmations (`dialog_widget.dart`)
- **Cards**: Content display containers with consistent styling (`card_widget.dart`)

## Resources Organization
- **Enums** (`resources/enum.dart`) - All application enums in one file
- **Localization** (`resources/l10n/`) - Support for EN, AR, MS languages
- **Styles** (`resources/styles/`) - Colors, themes, text styles (AppColors, AppStyles)
- **Values** (`resources/values/`) - Asset paths, constants, dimensions

## Services Structure
- **Biometric services** - Fingerprint, face recognition authentication
- **Firebase services** - Push notifications, analytics, cloud messaging
- **Local notifications** - Local notification scheduling and handling
- **Splash services** - App initialization and startup logic
- Keep services focused on single responsibilities
- Use dependency injection for service access

## Routing Structure
- **Route definitions** (`utils/routes/`) - All route names and configurations
- **Navigation utilities** (`utils/`) - Helper functions for navigation
- **Centralized imports** (`utils/include.dart`) - Single import file for all common dependencies
- Use named routes consistently: `Navigator.pushNamed(context, Routes.loginPage)`
- Keep route names as constants: `static const String loginPage = '/login';`

## Import Strategy
- **Single import file** (`utils/include.dart`) - Contains all commonly used imports
- Pages and widgets import only: `import 'package:your_app/utils/include.dart';`
- The include.dart file re-exports:
  - Flutter framework (`package:flutter/material.dart`)
  - State management (`package:flutter_bloc/flutter_bloc.dart`)
  - App colors (`../resources/styles/app_colors.dart`)
  - App styles (`../resources/styles/app_styles.dart`)
  - Localizations (`../resources/l10n/app_localizations.dart`)
  - Common shared widgets
  - Utilities and constants

## Domain Layer Guidelines
- **Config** (`domain/config/`) - API keys, storage keys, shared preferences keys
- **Data Models** (`domain/data_model/`) - Onboarding and setup models
- **Database Clients** (`domain/db_client/`) - Supabase clients for different services
- Keep domain layer independent of UI concerns
- Use clear naming for database client files: `auth_client.dart`, `dashboard_client.dart`

## Dependency Injection
- Use `get_it` or `injectable` for dependency injection
- Register repositories and BLoCs in a central setup file
- Inject dependencies via constructor, not service locator patterns in widgets
