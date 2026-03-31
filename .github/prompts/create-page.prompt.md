---
description: "Generate a complete Flutter page/screen following the project's BLoC + BlocBuilder architecture, AppBarWidget, LayoutBuilder scroll pattern, and coding conventions."
agent: "agent"
argument-hint: "Describe the page (e.g., 'settings page with profile info, notifications toggle, and logout button')"
---
Create a Flutter page/screen with these requirements:

**Page to create**: {{input}}

## Mandatory Pattern

Read `.github/instructions/reference-repo.instructions.md` first. Every page MUST follow this exact structure:

```dart
import 'package:demo_repo/utils/include.dart';
// Import specific bloc files (not included in include.dart):
import 'package:demo_repo/bloc/shared/xxx/xxx_bloc.dart';
import 'package:demo_repo/bloc/shared/xxx/xxx_event.dart';
import 'package:demo_repo/bloc/shared/xxx/xxx_state.dart';

class XxxPage extends StatelessWidget {
  const XxxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => XxxBloc(
        repository: context.read<XxxRepository>(),
      )..add(XxxInitialized()),
      child: const _XxxPageView(),
    );
  }
}

class _XxxPageView extends StatelessWidget {
  const _XxxPageView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<XxxBloc, XxxState>(
      listener: (context, state) {
        if (state is XxxFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        if (state is XxxSuccess) {
          Navigator.pushNamed(context, RoutesName.nextPage);
        }
      },
      builder: (context, state) {
        final isLoading = state is XxxLoading;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.pageTitle, // TODO: Add 'pageTitle' to localization
              style: AppStyles.headingMedium,
            ),
            backgroundColor: AppColors.surface,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primary),
          ),
          backgroundColor: AppColors.surface,
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
                        // Use imported widget components:
                        CardWidget(
                          title: AppLocalizations.of(context)!.cardTitle, // TODO: Add 'cardTitle' to localization
                          description: AppLocalizations.of(context)!.cardDescription, // TODO: Add 'cardDescription' to localization
                        ),
                        const SizedBox(height: 16),
                        
                        const Spacer(),
                        // Bottom action buttons using imported widgets:
                        ButtonWidget(
                          text: AppLocalizations.of(context)!.submitButton, // TODO: Add 'submitButton' to localization
                          onPressed: () => context.read<XxxBloc>().add(XxxSubmitted()),
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

## STRICT LOCALIZATION REQUIREMENTS

🚨 **CRITICAL**: ALL user-visible text MUST come from `AppLocalizations.of(context)!.keyName`

## NO PRIVATE HELPER WIDGETS & NO SPREAD OPERATORS

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
              PageHeaderWidget(state: state),      // ✅ Separate widget
              ContentSectionWidget(state: state),  // ✅ Separate widget  
              PageFooterWidget(state: state),      // ✅ Separate widget
            ],
          ),
        );
      },
    );
  }
}
```

### Text Types That Must Be Localized:
- **Page titles** → `AppLocalizations.of(context)!.pageTitle`
- **Button labels** → `AppLocalizations.of(context)!.buttonLabel` 
- **Field labels** → `AppLocalizations.of(context)!.fieldLabel`
- **Hint text** → `AppLocalizations.of(context)!.hintText`
- **Error messages** → `AppLocalizations.of(context)!.errorMessage`
- **Descriptions** → `AppLocalizations.of(context)!.description`

## STRICT COLOR & STYLING REQUIREMENTS

🎨 **CRITICAL**: ALL colors MUST come from `AppColors` — NEVER hardcode color values
✨ **CRITICAL**: ALL text styles MUST come from `AppStyles` — NEVER hardcode TextStyle values

### Required Import:
```dart
import 'package:demo_repo/utils/include.dart';
// Import specific bloc files (not included in include.dart):
import 'package:demo_repo/bloc/shared/feature/feature_bloc.dart';
import 'package:demo_repo/bloc/shared/feature/feature_event.dart';
import 'package:demo_repo/bloc/shared/feature/feature_state.dart';
```

## Rules

1. **Import**: Use single include.dart import: `package:demo_repo/utils/include.dart` (contains flutter_bloc, AppColors, AppStyles, AppLocalizations)
2. **State management**: BLoC + BlocConsumer pattern (never Provider/Riverpod/GetX)
3. **Widget organization**: 
   - **NO private helper widgets** (`_buildSomething()`) in page files
   - **Create separate widget files** for complex/reusable components
4. **Naming**: `feature_page.dart` → `FeaturePage` + `feature_bloc.dart` → `FeatureBloc`
5. **Localization**: ALL strings via `AppLocalizations.of(context)!.keyName` — NO hardcoded strings
6. **Colors**: ALL colors via `AppColors.colorName` — NO hardcoded color values
7. **Styling**: ALL text styles via `AppStyles.styleName` — NO hardcoded TextStyle
8. **Const**: Use `const` constructors everywhere possible
9. **Controllers/FocusNodes**: Keep at page level (StatefulWidget inner view) for forms

## Steps
1. **Check existing widgets**: Look in `lib/ui/widgets/` for reusable components
2. **Create BLoC files** with events, states, and bloc logic:
   - Place in: `lib/bloc/shared/`, `lib/bloc/parent/`, or `lib/bloc/teacher/`
   - Use Equatable for events and states
   - Repository injection via constructor
3. Create Page file in `lib/ui/pages/` following the exact template
4. **For complex/reusable components**: Create separate widget files
5. **Add route entries**: Update route classes
6. **Add localization keys**: Add to ARB files

## BLoC Pattern

### Event File (`feature_event.dart`):
```dart
import 'package:equatable/equatable.dart';

abstract class FeatureEvent extends Equatable {
  const FeatureEvent();
  
  @override
  List<Object?> get props => [];
}

class FeatureInitialized extends FeatureEvent {}

class FeatureSubmitted extends FeatureEvent {
  final String value;
  
  const FeatureSubmitted(this.value);
  
  @override
  List<Object?> get props => [value];
}
```

### State File (`feature_state.dart`):
```dart
import 'package:equatable/equatable.dart';

abstract class FeatureState extends Equatable {
  const FeatureState();
  
  @override
  List<Object?> get props => [];
}

class FeatureInitial extends FeatureState {}

class FeatureLoading extends FeatureState {}

class FeatureSuccess extends FeatureState {
  final Data data;
  
  const FeatureSuccess(this.data);
  
  @override
  List<Object?> get props => [data];
}

class FeatureFailure extends FeatureState {
  final String error;
  
  const FeatureFailure(this.error);
  
  @override
  List<Object?> get props => [error];
}
```

### BLoC File (`feature_bloc.dart`):
```dart
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  final FeatureRepository _repository;
  
  FeatureBloc({required FeatureRepository repository})
      : _repository = repository,
        super(FeatureInitial()) {
    on<FeatureInitialized>(_onInitialized);
    on<FeatureSubmitted>(_onSubmitted);
  }
  
  Future<void> _onInitialized(
    FeatureInitialized event,
    Emitter<FeatureState> emit,
  ) async {
    emit(FeatureLoading());
    try {
      final data = await _repository.fetchData();
      emit(FeatureSuccess(data));
    } catch (e) {
      emit(FeatureFailure(e.toString()));
    }
  }
  
  Future<void> _onSubmitted(
    FeatureSubmitted event,
    Emitter<FeatureState> emit,
  ) async {
    emit(FeatureLoading());
    try {
      await _repository.submit(event.value);
      emit(FeatureSuccess(/* result */));
    } catch (e) {
      emit(FeatureFailure(e.toString()));
    }
  }
}
```
