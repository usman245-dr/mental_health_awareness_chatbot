---
description: "Reference patterns extracted from the project's codebase. Apply these patterns to ALL new pages, widgets, and features. Use when: creating pages, widgets, features, screens, components, blocs, cubits, state management."
applyTo: "lib/**/*.dart"
---
# Reference Repository Patterns

## Architecture Pattern
- **Feature-first** folder structure
- **BLoC** (package:flutter_bloc) for state management
- **BlocBuilder** widget for rebuilding UI on state changes
- **BlocProvider** for providing blocs to widget tree
- `context.read<T>()` for one-time bloc access (e.g., in callbacks)
- `context.watch<T>()` for reactive UI rebuilds

## Page/Screen Structure
Every page follows this exact pattern:
1. `StatelessWidget` wrapped with `BlocProvider`
2. `BlocBuilder<XxxBloc, XxxState>` wrapping the `Scaffold`
3. Scaffold uses `AppBarWidget`, `LayoutBuilder` → `SingleChildScrollView` → `ConstrainedBox` → `IntrinsicHeight` → `Column`
4. Initialize bloc with event in `create` callback or separate listener

## Imports
- Single barrel import: `package:queue_management_app/utils/include.dart`
- All shared utilities, widgets, styles, colors, assets, routes re-exported from this file

## Naming Conventions
- Pages: `login_page.dart` → `LoginPage` / `_LoginPageState`
- BLoCs: `login_bloc.dart` → `LoginBloc`
- Events: `login_event.dart` → `LoginEvent`, `LoginSubmitted`, `LoginEmailChanged`
- States: `login_state.dart` → `LoginState`, `LoginInitial`, `LoginLoading`, `LoginSuccess`, `LoginFailure`
- Widgets: `text_field_widget.dart` → `TextFieldWidget`
- Routes: `RoutesName.forgotPasswordPage`
- Assets: `AssetValues.logIn`, `AssetValues.biometric`
- Styles: `AppStyles.descriptionText`
- Colors: `AppColors.primary`, `AppColors.zincShade700`

## Reusable Widgets
- `AppBarWidget(title: ...)` — custom app bar
- `TextFieldWidget(...)` — custom text field with icon, dropdown, focus support
- `ButtonWidget(text: ..., onPressed: ..., isBusy: ...)` — primary action button
- `SvgPicture.asset(...)` — SVG asset rendering with placeholder

## Widget Class Structure
Every reusable widget follows this exact pattern:
1. `StatelessWidget` (use `StatefulWidget` only when internal animation/state is unavoidable)
2. All fields declared as `final` at the top of the class
3. `const` constructor with named parameters; `required` only for mandatory fields
4. Optional fields use nullable types (`String?`) or have default values
5. Single barrel import only
6. `build()` returns the widget tree directly — no helper methods unless genuinely complex

```dart
import 'package:queue_management_app/utils/include.dart';

class XxxWidget extends StatelessWidget {
  final String? optionalParam;
  final String requiredParam;
  final bool flagParam;

  const XxxWidget({
    super.key,
    this.optionalParam,
    required this.requiredParam,
    this.flagParam = false,
  });

  @override
  Widget build(BuildContext context) {
    return ...;
  }
}
```

## InputDecoration Pattern (TextFormField)
- `contentPadding: EdgeInsets.all(0)`
- `border`: `OutlineInputBorder(borderRadius: BorderRadius.circular(12))`
- `enabledBorder` / `focusedBorder`: radius 8, `BorderSide(color: AppColors.lightGrey)`
- `filled: true`, `fillColor: AppColors.white`
- `hintStyle: TextStyle(color: AppColors.lightGrey)`
- `prefixIconConstraints: BoxConstraints(minWidth: prefixIcon == null ? 14 : 48)`
- Conditional prefix: dropdown → `DropdownButton`, icon → `Icon`, none → `SizedBox()`
- Conditional suffix: tap wrapped in `GestureDetector` → SVG (`SvgPicture.asset`, `fit: BoxFit.scaleDown`) or `Icon`, none → `SizedBox()`
- `onTapOutside: (event) { Utilities.unfocusField(context); }`
- `readOnly` support: set `enabled: !readOnly`, `enableInteractiveSelection: !readOnly`

## SVG Usage
- `SvgPicture.asset(AssetValues.iconName, fit: BoxFit.scaleDown)`
- Default asset values live in `AssetValues` (e.g., `AssetValues.personIcon`)
- Always provide a default value in the constructor for SVG path params: `this.iconSvg = AssetValues.someIcon`

## Dropdown Pattern
- Use `DropdownButton<String>` as `prefixIcon` for country/code pickers
- `underline: SizedBox()` to remove underline
- `dropdownColor: AppColors.white`
- `icon: Icon(Icons.keyboard_arrow_down)`
- Disable when `readOnly`: `onChanged: readOnly ? null : dropDownOnChanges`

## Localization
- `AppLocalizations.of(context)!.keyName` for all user-visible strings
- Never hardcode strings in UI

## Styling
- `AppStyles` for text styles (e.g., `AppStyles.descriptionText`)
- `AppColors` for colors (e.g., `AppColors.primary`, `AppColors.zincShade700`)
- `const EdgeInsets.symmetric(horizontal: 24)` as standard horizontal padding
- `const EdgeInsets.symmetric(vertical: 24)` as standard vertical padding
- `const SizedBox(height: N)` for vertical spacing (common: 6, 16, 20, 30)

## BLoC Pattern
- BLoC holds all state + business logic
- Separate files for events, states, and bloc logic
- Use `Equatable` for states and events for proper comparison
- Controllers (`TextEditingController`) can be managed at page level or in bloc
- Focus nodes (`FocusNode`) typically managed at page level
- Use `emit()` to emit new states
- Loading states: `XxxLoading`, success: `XxxSuccess`, failure: `XxxFailure`

### BLoC File Structure
```
lib/bloc/
├── feature_name/
│   ├── feature_name_bloc.dart
│   ├── feature_name_event.dart
│   └── feature_name_state.dart
```

### Event Pattern
```dart
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  
  const LoginSubmitted({required this.email, required this.password});
  
  @override
  List<Object?> get props => [email, password];
}

class LoginEmailChanged extends LoginEvent {
  final String email;
  
  const LoginEmailChanged(this.email);
  
  @override
  List<Object?> get props => [email];
}
```

### State Pattern
```dart
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  
  const LoginSuccess(this.user);
  
  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;
  
  const LoginFailure(this.error);
  
  @override
  List<Object?> get props => [error];
}
```

### BLoC Pattern
```dart
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginEmailChanged>(_onEmailChanged);
  }
  
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await _authRepository.login(event.email, event.password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
  
  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    // Handle email change
  }
}
```

## Routing
- Named routes: `Navigator.pushNamed(context, RoutesName.pageName)`
- Route names defined in `RoutesName` class

## Key Patterns
- `const` constructors everywhere possible
- `Directionality(textDirection: TextDirection.ltr)` wrapping text fields
- `RichText` with `TextSpan` for labels with required-field asterisks
- `Utilities.fieldFocusChange(context, currentFocus, nextFocus)` for field navigation
- `FocusScope.of(context).unfocus()` before form submission
- `LayoutBuilder` + `ConstrainedBox(minHeight: constraints.maxHeight)` + `IntrinsicHeight` for full-height scrollable content with `Spacer()` pushing buttons to bottom
- Use `BlocListener` for side effects (navigation, snackbars)
- Use `BlocBuilder` for UI rebuilds
- Use `BlocConsumer` when both listening and building are needed
