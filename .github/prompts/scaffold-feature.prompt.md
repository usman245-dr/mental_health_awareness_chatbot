---
description: "Scaffold a complete Flutter feature with BLoC, page, and widgets following the project's exact structure and coding conventions."
agent: "agent"
argument-hint: "Feature name and brief description (e.g., 'profile - view and edit user profile')"
---
Scaffold a complete Flutter feature following the project's architecture:

**Feature**: {{input}}

## Rules

1. **Read patterns**: Load `.github/instructions/reference-repo.instructions.md` first
2. **Import**: Single barrel import `package:queue_management_app/utils/include.dart`
3. **State management**: BLoC + BlocBuilder/BlocConsumer pattern only
4. **Page template**: Every page must follow the exact StatelessWidget + BlocProvider + BlocConsumer + LayoutBuilder + ScrollView pattern from reference-repo.instructions.md
5. **Naming**: `snake_case` files, `UpperCamelCase` classes, `_` prefix for private members
6. **Reuse**: Use `AppBarWidget`, `TextFieldWidget`, `ButtonWidget`, `AppStyles`, `AppColors`
7. **Localization**: All strings via `AppLocalizations.of(context)!`

## Steps
1. Create BLoC files (bloc, event, state) with state classes, events, and business logic
2. Create Repository class for data access if needed
3. Create Page class following the exact template (StatelessWidget + BlocProvider + BlocConsumer + LayoutBuilder scroll pattern)
4. Create feature-specific widgets if needed
5. Add route name to `RoutesName` class
6. Register BLoC in the app's bloc providers

## File Structure
```
lib/
├── bloc/
│   └── shared/
│       └── feature_name/
│           ├── feature_name_bloc.dart
│           ├── feature_name_event.dart
│           └── feature_name_state.dart
├── repository/
│   └── feature_name_repository.dart
└── ui/
    └── pages/
        └── feature_name_page.dart
```

## BLoC Pattern

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
  final String data;
  
  const FeatureNameSubmitted(this.data);
  
  @override
  List<Object?> get props => [data];
}
```

### State File (`feature_name_state.dart`):
```dart
import 'package:equatable/equatable.dart';

abstract class FeatureNameState extends Equatable {
  const FeatureNameState();
  
  @override
  List<Object?> get props => [];
}

class FeatureNameInitial extends FeatureNameState {}

class FeatureNameLoading extends FeatureNameState {}

class FeatureNameSuccess extends FeatureNameState {
  final Data data;
  
  const FeatureNameSuccess(this.data);
  
  @override
  List<Object?> get props => [data];
}

class FeatureNameFailure extends FeatureNameState {
  final String error;
  
  const FeatureNameFailure(this.error);
  
  @override
  List<Object?> get props => [error];
}
```

### BLoC File (`feature_name_bloc.dart`):
```dart
import 'package:flutter_bloc/flutter_bloc.dart';

class FeatureNameBloc extends Bloc<FeatureNameEvent, FeatureNameState> {
  final FeatureNameRepository _repository;
  
  FeatureNameBloc({required FeatureNameRepository repository})
      : _repository = repository,
        super(FeatureNameInitial()) {
    on<FeatureNameInitialized>(_onInitialized);
    on<FeatureNameSubmitted>(_onSubmitted);
  }
  
  Future<void> _onInitialized(
    FeatureNameInitialized event,
    Emitter<FeatureNameState> emit,
  ) async {
    emit(FeatureNameLoading());
    try {
      final data = await _repository.fetchData();
      emit(FeatureNameSuccess(data));
    } catch (e) {
      emit(FeatureNameFailure(e.toString()));
    }
  }
  
  Future<void> _onSubmitted(
    FeatureNameSubmitted event,
    Emitter<FeatureNameState> emit,
  ) async {
    emit(FeatureNameLoading());
    try {
      await _repository.submit(event.data);
      emit(FeatureNameSuccess(/* result */));
    } catch (e) {
      emit(FeatureNameFailure(e.toString()));
    }
  }
}
```

### Page File (`feature_name_page.dart`):
```dart
import 'package:demo_repo/utils/include.dart';

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

class _FeatureNamePageView extends StatelessWidget {
  const _FeatureNamePageView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeatureNameBloc, FeatureNameState>(
      listener: (context, state) {
        if (state is FeatureNameFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is FeatureNameLoading;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.featureTitle, // TODO: Add to localization
              style: AppStyles.headingMedium,
            ),
            backgroundColor: AppColors.surface,
            elevation: 0,
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
                        // Content here
                        
                        const Spacer(),
                        // Bottom action buttons
                        ButtonWidget(
                          text: AppLocalizations.of(context)!.submitButton,
                          onPressed: () => context.read<FeatureNameBloc>().add(
                            FeatureNameSubmitted('data'),
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

## Output
- BLoC files (bloc, event, state) with all state and logic
- Repository file for data access
- Page file matching the exact project structure template
- Feature-specific widget files if needed
- Placeholder TODOs where API/business logic needs to be filled in
