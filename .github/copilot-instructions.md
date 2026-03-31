# Project Guidelines

## Framework
- **Flutter** with Dart
- Follow the reference repository structure for all new code

## Architecture
- Follow **Clean Architecture** or the architecture pattern defined in the reference repository
- Separate UI, business logic, and data layers
- Use **BLoC** (flutter_bloc) for state management

## Code Style
- Use `lowerCamelCase` for variables, functions, and parameters
- Use `UpperCamelCase` for classes, enums, typedefs, and type parameters
- Use `snake_case` for file and folder names
- Prefix private members with `_`
- Always use `const` constructors where possible
- Follow Dart effective style guide

## File Organization
- Mirror the folder structure of the reference repository exactly
- Group files by feature, not by type (unless the reference repo says otherwise)
- Keep reusable widgets in a shared/common folder as defined in the reference repo
- Keep constants, themes, and utilities in their designated folders

## Component Patterns
- Before creating a new widget, check if a similar reusable component exists in the reference repo
- Follow the same widget composition patterns (stateless vs stateful, extracted widgets)
- Use the same naming conventions for pages, screens, widgets, and models
- Follow the same import ordering: dart, flutter, packages, local

## Build and Test
- `flutter pub get` to install dependencies
- `flutter run` to run the app
- `flutter test` to run tests
- `flutter analyze` for static analysis

## Conventions
- Always add `const` keyword to constructors and widgets where possible
- Use named parameters for widget constructors
- Extract magic numbers into constants
- Follow the reference repo's pattern for routing, theming, and dependency injection
