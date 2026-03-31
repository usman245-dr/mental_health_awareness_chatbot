---
description: "Generate a reusable Flutter widget following the project's StatelessWidget pattern, AppStyles/AppColors conventions, InputDecoration pattern, and single barrel import."
agent: "agent"
argument-hint: "Describe the widget (e.g., 'a custom card with title, subtitle, and action button')"
---
Create a Flutter widget/component with these requirements:

**Widget to create**: {{input}}

## Mandatory Pattern

Read `.github/instructions/reference-repo.instructions.md` first. Every widget MUST follow this exact structure:

```dart
import 'package:demo_repo/utils/include.dart';

class XxxWidget extends StatelessWidget {
  final TypeA fieldA;
  final TypeB? optionalFieldB;
  final bool flagField;

  const XxxWidget({
    super.key,
    required this.fieldA,
    this.optionalFieldB,
    this.flagField = false,
  });

  @override
  Widget build(BuildContext context) {
    return ...;
  }
}
```

## Rules

1. **Import**: Single barrel import `package:demo_repo/utils/include.dart` only
2. **Base class**: `StatelessWidget` always; use `StatefulWidget` only if internal animation/focus is required
3. **Fields**: All `final`, declared before constructor
4. **Constructor**: `const`, named params, `required` only for mandatory fields, default values for booleans/strings
5. **Naming**: `widget_name_widget.dart` → `WidgetNameWidget`
6. **Styling**: `AppStyles` for text, `AppColors` for colors — never hardcode values
7. **Color transparency**: Use `.withValues(alpha: value)` instead of deprecated `.withOpacity(value)`
8. **SVG assets**: `SvgPicture.asset(AssetValues.iconName, fit: BoxFit.scaleDown)` with `AssetValues` defaults
9. **InputDecoration** (for form fields):
   - `contentPadding: EdgeInsets.all(0)`
   - borders: radius 12 for `border`, radius 8 + `AppColors.lightGrey` for `enabledBorder`/`focusedBorder`
   - `filled: true`, `fillColor: AppColors.white`
   - `onTapOutside: (event) { Utilities.unfocusField(context); }`
   - Conditional prefix/suffix: always fall back to `SizedBox()` (not `null`)
10. **readOnly support**: when applicable, set `enabled: !readOnly` and disable callbacks
11. **Localization**: user-visible strings via `AppLocalizations.of(context)!`
12. **NO private helper widgets**: Never create `_buildSomething()` methods. Extract complex UI into separate public widget classes
13. **NO spread operators**: Never use `...` spread syntax. Use explicit conditional widgets: `if (condition) Widget()` instead of `if (condition) ...[Widget()]`
14. **Component extraction**: For complex widgets with multiple sections, create separate widget files instead of helper methods
15. **Place correctly**: shared widgets in common/shared folder; feature-specific in feature widgets folder

## Widget Architecture Rules

**❌ BAD - Private Helper Methods:**
```dart
class ComplexWidget extends StatelessWidget {
  Widget _buildHeader() { ... }      // ❌ Private helper
  Widget _buildContent() { ... }     // ❌ Private helper
  Widget _buildFooter() { ... }      // ❌ Private helper
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),    // ❌ Using private helpers
        _buildContent(),   // ❌ Using private helpers
        _buildFooter(),    // ❌ Using private helpers
      ],
    );
  }
}
```

**✅ GOOD - Separate Widget Classes:**
```dart
// lib/ui/widgets/complex_header_widget.dart
class ComplexHeaderWidget extends StatelessWidget { ... }

// lib/ui/widgets/complex_content_widget.dart  
class ComplexContentWidget extends StatelessWidget { ... }

// lib/ui/widgets/complex_footer_widget.dart
class ComplexFooterWidget extends StatelessWidget { ... }

// Main widget uses composed widgets:
class ComplexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ComplexHeaderWidget(),   // ✅ Reusable component
        ComplexContentWidget(),  // ✅ Reusable component  
        ComplexFooterWidget(),   // ✅ Reusable component
      ],
    );
  }
}
```

## Conditional Widget Rules

**❌ BAD - Spread Operators:**
```dart
children: [
  if (showIcon) ...[          // ❌ Spread operator
    Icon(Icons.star),
    const SizedBox(width: 8),
  ],
  Text('Content'),
]
```

**✅ GOOD - Explicit Conditionals:**
```dart
children: [
  if (showIcon)               // ✅ Direct conditional
    Icon(Icons.star),
  if (showIcon)               // ✅ Separate condition
    const SizedBox(width: 8),
  Text('Content'),
]
```

## Output
- Single widget file in the correct location
- Single barrel import
- All fields `final`, `const` constructor, named parameters
- Matches the exact widget class structure from the project
