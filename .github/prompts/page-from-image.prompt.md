---
description: "Generate a complete Flutter page from a UI design image, screenshot, or mockup. Analyzes the attached image and produces code matching the project's exact BLoC patterns. Use when: design to code, image to flutter, mockup to page, screenshot to widget, UI image."
agent: "agent"
argument-hint: "Attach a UI image and optionally describe the page name/feature (e.g., 'profile screen')"
---
# Updated Prompt Instructions

Analyze the attached UI design image and generate a complete Flutter page following the project's exact BLoC patterns.

## Step 1 — Read Project Patterns
Load `.github/instructions/reference-repo.instructions.md` before writing any code.

## Step 2 — Analyze the Image
Extract from the image:
- **Page title** — text shown in the app bar
- **Layout sections** — top to bottom order of all visible sections
- **Every UI element** — text labels, input fields, buttons, icons, images, lists, cards, dividers, checkboxes, toggles, dropdowns
- **Text styles** — headings, body text, labels, hints (map to `AppStyles.*`)
- **Colors** — backgrounds, text, borders, icons (map to `AppColors.*`)
- **Spacing** — gaps between elements (use standard `SizedBox(height: N)` values: 6, 8, 12, 16, 20, 24, 30)
- **Icons/Images** — identify icon types; reference `AssetValues.*` or `Icons.*`
- **Interactive elements** — buttons, tappable rows, checkboxes, toggles, navigation links

## Step 3 — Map UI Elements to Widgets
Use the project's reusable widgets wherever possible:
- Text input → `TextFieldWidget`
- Primary button → `ButtonWidget`
- App bar → `AppBarWidget`
- SVG image → `SvgPicture.asset(AssetValues.xxx)`
- Required field label → `RichText` with red asterisk `TextSpan`
- Password field → `TextFieldWidget` with `suffixIcon` toggle
- Phone/code field → `TextFieldWidget` with `hasDropDown: true`
- Scrollable content → `LayoutBuilder` → `SingleChildScrollView` → `ConstrainedBox` → `IntrinsicHeight`
- Bottom-pinned button → `const Spacer()` before it inside the `Column`

## Step 4 — Generate the BLoC Files
Create BLoC files in `lib/bloc/shared/<feature_name>/`:

### Event File (`feature_name_event.dart`):
```dart
import 'package:equatable/equatable.dart';

abstract class FeatureNameEvent extends Equatable {
  const FeatureNameEvent();
  
  @override
  List<Object?> get props => [];
}

class FeatureNameInitialized extends FeatureNameEvent {}

class FeatureNameSubmitted extends FeatureNameEvent {
  final String email;
  final String password;
  
  const FeatureNameSubmitted({
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [email, password];
}

class FeatureNameEmailChanged extends FeatureNameEvent {
  final String email;
  
  const FeatureNameEmailChanged(this.email);
  
  @override
  List<Object?> get props => [email];
}

class FeatureNamePasswordVisibilityToggled extends FeatureNameEvent {}
```

### State File (`feature_name_state.dart`):
```dart
import 'package:equatable/equatable.dart';

abstract class FeatureNameState extends Equatable {
  final bool isPasswordVisible;
  
  const FeatureNameState({
    this.isPasswordVisible = false,
  });
  
  @override
  List<Object?> get props => [isPasswordVisible];
}

class FeatureNameInitial extends FeatureNameState {
  const FeatureNameInitial() : super();
}

class FeatureNameLoading extends FeatureNameState {
  const FeatureNameLoading({super.isPasswordVisible});
}

class FeatureNameSuccess extends FeatureNameState {
  final User user;
  
  const FeatureNameSuccess(this.user, {super.isPasswordVisible});
  
  @override
  List<Object?> get props => [user, isPasswordVisible];
}

class FeatureNameFailure extends FeatureNameState {
  final String error;
  
  const FeatureNameFailure(this.error, {super.isPasswordVisible});
  
  @override
  List<Object?> get props => [error, isPasswordVisible];
}
```

### BLoC File (`feature_name_bloc.dart`):
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature_name_event.dart';
import 'feature_name_state.dart';

class FeatureNameBloc extends Bloc<FeatureNameEvent, FeatureNameState> {
  final FeatureNameRepository _repository;
  
  FeatureNameBloc({required FeatureNameRepository repository})
      : _repository = repository,
        super(const FeatureNameInitial()) {
    on<FeatureNameInitialized>(_onInitialized);
    on<FeatureNameSubmitted>(_onSubmitted);
    on<FeatureNamePasswordVisibilityToggled>(_onPasswordVisibilityToggled);
  }
  
  Future<void> _onInitialized(
    FeatureNameInitialized event,
    Emitter<FeatureNameState> emit,
  ) async {
    // Initialization logic
  }
  
  Future<void> _onSubmitted(
    FeatureNameSubmitted event,
    Emitter<FeatureNameState> emit,
  ) async {
    emit(FeatureNameLoading(isPasswordVisible: state.isPasswordVisible));
    try {
      final result = await _repository.submit(event.email, event.password);
      emit(FeatureNameSuccess(result, isPasswordVisible: state.isPasswordVisible));
    } catch (e) {
      emit(FeatureNameFailure(e.toString(), isPasswordVisible: state.isPasswordVisible));
    }
  }
  
  void _onPasswordVisibilityToggled(
    FeatureNamePasswordVisibilityToggled event,
    Emitter<FeatureNameState> emit,
  ) {
    emit(FeatureNameInitial().copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    ));
  }
}
```

## Step 5 — Generate the Page
Create `lib/ui/pages/<feature_name>_page.dart` using this EXACT structure:

```dart
import 'package:demo_repo/utils/include.dart';
import 'package:demo_repo/bloc/shared/feature_name/feature_name_bloc.dart';
import 'package:demo_repo/bloc/shared/feature_name/feature_name_event.dart';
import 'package:demo_repo/bloc/shared/feature_name/feature_name_state.dart';

class FeatureNamePage extends StatelessWidget {
  const FeatureNamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeatureNameBloc(
        repository: context.read<FeatureNameRepository>(),
      )..add(FeatureNameInitialized()),
      child: const _FeatureNamePageView(),
    );
  }
}

class _FeatureNamePageView extends StatefulWidget {
  const _FeatureNamePageView();

  @override
  State<_FeatureNamePageView> createState() => _FeatureNamePageViewState();
}

class _FeatureNamePageViewState extends State<_FeatureNamePageView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeatureNameBloc, FeatureNameState>(
      listener: (context, state) {
        if (state is FeatureNameFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        if (state is FeatureNameSuccess) {
          Navigator.pushNamed(context, RoutesName.nextPage);
        }
      },
      builder: (context, state) {
        final isLoading = state is FeatureNameLoading;
        
        return Scaffold(
          appBar: AppBarWidget(
            title: AppLocalizations.of(context)!.pageTitle, // TODO: Add to localization
          ),
          backgroundColor: Colors.white,
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- UI elements from image go here ---

                        const Spacer(),
                        // --- Bottom action button(s) go here ---
                        ButtonWidget(
                          text: AppLocalizations.of(context)!.submitButton, // TODO: Add to localization
                          onPressed: () => context.read<FeatureNameBloc>().add(
                            FeatureNameSubmitted(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          ),
                          isLoading: isLoading,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
```

### STRICT LOCALIZATION REQUIREMENTS

🌐 **CRITICAL**: ALL user-visible text MUST come from `AppLocalizations.of(context)!.keyName`

### ZERO HARDCODED TEXT POLICY:
- NO hardcoded strings anywhere in the UI
- NO placeholder text like "Hello", "Submit", "Cancel" 
- NO temporary text during development
- ALL text must be localized from day one

### Every Text Widget Must Use Localization:
```dart
// ✅ CORRECT - All text from localization
Text(AppLocalizations.of(context)!.welcomeMessage), // TODO: Add 'welcomeMessage' to localization

// ❌ WRONG - No hardcoded text allowed
Text('Welcome to the app'), // ❌ DON'T DO THIS
Text("Hello User"), // ❌ DON'T DO THIS  
Text('Submit'), // ❌ DON'T DO THIS
```

### NO PRIVATE HELPER WIDGETS & NO SPREAD OPERATORS

**❌ NEVER DO THIS:**
```dart
Widget _buildHeader() { ... }  // ❌ Private helper method
Widget _buildContent() { ... } // ❌ Private helper method

children: [
  if (showItems) ...[          // ❌ Spread operator
    Item1(),
    Item2(),
  ],
]
```

**✅ DO THIS INSTEAD:**
```dart
// Extract into separate widget files:
// lib/ui/widgets/page_header_widget.dart
class PageHeaderWidget extends StatelessWidget { ... }

// lib/ui/widgets/content_section_widget.dart  
class ContentSectionWidget extends StatelessWidget { ... }

// Use explicit conditionals instead of spread:
children: [
  if (showItems)
    Item1(),
  if (showItems)
    Item2(),
]
```

// lib/ui/widgets/page_footer_widget.dart
class PageFooterWidget extends StatelessWidget { ... }

// Page uses composed widgets with BLoC:
class SomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SomeBloc, SomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWidget(...),
          body: Column(
            children: [
              PageHeaderWidget(state: state),       // ✅ Separate widget
              ContentSectionWidget(state: state),   // ✅ Separate widget  
              PageFooterWidget(state: state),       // ✅ Separate widget
            ],
          ),
        );
      },
    );
  }
}
```
