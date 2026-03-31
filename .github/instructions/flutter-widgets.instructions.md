---
description: "Use when creating or editing Flutter widgets, screens, pages, or UI components. Covers widget structure, naming, and composition patterns."
applyTo: "lib/**/*.dart"
---
# Flutter Widget & Component Standards

## Widget Structure
- Every widget file should contain ONE primary widget class
- Use `const` constructors with named parameters
- Place private helper widgets in the same file, below the main widget
- Extract complex build logic into separate private methods (e.g., `_buildHeader()`)

## Widget Organization
- **Page widgets**: `lib/ui/pages/`
  - Full screen implementations
  - Can import and use shared widgets
- **Page-specific widgets**: `lib/ui/widgets/`
  - Only used within specific pages
  - Can import and use shared widgets
  - All widgets in single folder (no subfolders)
- **Shared widgets**: `lib/ui/widgets/`
  - Reusable across multiple pages
  - Must accept configuration via constructor parameters
  - Cannot depend on page-specific code
  - All widgets in single folder (no subfolders)

## Widget Selection Guidelines
Before creating a new widget:
1. Check if a similar shared widget exists in `lib/ui/widgets/`
2. If creating a new shared widget, ensure it's truly reusable
3. Page-specific widgets go in `lib/ui/widgets/`
4. Complex widgets should be broken down into smaller, composable widgets

## Naming
- Screens/Pages: `page_name.dart` → class `PageName`
- Widgets: `widget_name_widget.dart` → class `WidgetNameWidget`
- Models: `model_name.dart` → class `ModelName`
- BLoCs: `feature_bloc.dart` → class `FeatureBloc`
- Events: `feature_event.dart` → class `FeatureEvent`
- States: `feature_state.dart` → class `FeatureState`

## Import Ordering
- **Single import file**: Use `import 'package:your_app/utils/include.dart';` for all common imports
- Only add additional imports if they're NOT included in include.dart
- Order additional imports as: `dart:` imports, `package:flutter/`, third-party `package:`, local imports

## State Management
- Use BLoC pattern for state management
- Keep business logic OUT of widget files
- Widgets should only handle UI rendering and user interaction
- Use `BlocBuilder` for reactive UI rebuilds
- Use `BlocListener` for side effects (navigation, snackbars)
- Use `BlocConsumer` when both are needed

## Reusable Components
- Check `lib/ui/widgets/` for existing components before creating new ones
- **Buttons**: `button_widget.dart` - Action triggers with different styles and states
- **App Bar**: `app_bar_widget.dart` - Custom application bar components
- **Bottom Navigation**: `bottom_nav_widget.dart` - Bottom navigation bar components
- **Drawer**: `drawer_widget.dart` - Navigation drawer components
- **Text Fields**: `text_field_widget.dart` - Input fields with validation and styling
- **Dialogs**: `dialog_widget.dart` - Modal dialogs, alerts, confirmations
- **Cards**: `card_widget.dart` - Content containers with consistent styling
- Shared widgets must accept configuration via constructor parameters
- Use `AppColors` and `AppStyles` design tokens instead of hardcoded values
