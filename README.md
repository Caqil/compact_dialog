# CompactDialog

A modern, beautiful, and compact dialog system for Flutter with **shadcn/ui inspired design**. Features smooth animations, rich functionality, and authentic shadcn/ui styling without any external UI dependencies.

[![pub package](https://img.shields.io/pub/v/compact_dialog.svg)](https://pub.dev/packages/compact_dialog)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

**[🚀 Try Live Demo](https://caqil.github.io/compact_dialog/)**

## ✨ Features

### 🎨 shadcn/ui Design System
- **Authentic Color Palette**: Faithful recreation of shadcn/ui's slate color scheme
- **Button Variants**: Proper filled primary, outline secondary, and destructive buttons
- **Ring Focus States**: Beautiful focus rings on input fields (2px ring color)
- **Typography**: Optimized font weights (600 for titles, 500 for buttons) and letter spacing
- **Subtle Shadows**: Elegant 10px blur shadows with minimal opacity
- **Consistent Border Radius**: 6px for buttons/inputs, 12px for dialogs

### 💎 Rich Features
- **Beautiful Animations**: Smooth scale (easeOutBack) and fade transitions
- **Multiple Dialog Types**: Success, Error, Warning, Info, Destructive, and more
- **Extended Features**:
  - Loading dialogs with circular progress indicator
  - Input dialogs with validation support and ring focus states
  - Confirmation dialogs with optional checkboxes
  - Progress dialogs with stream-based percentage updates
  - Custom content dialogs for maximum flexibility
- **Full Theme Support**: Light/dark modes with automatic Material theme adaptation
- **Zero Dependencies**: Built with pure Flutter (no shadcn_ui package required)
- **Type-Safe**: Fully typed with generic return values
- **Responsive**: Adapts to screen sizes with max-width constraints

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  compact_dialog: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Dialog

```dart
import 'package:compact_dialog/compact_dialog.dart';

CompactDialog.show(
  context: context,
  title: 'Welcome',
  description: 'This is a basic dialog with title and description.',
  icon: DialogIcons.info,
  primaryButtonText: 'OK',
  secondaryButtonText: 'Cancel',
  onPrimaryPressed: () {
    print('OK pressed');
  },
);
```

### Success Dialog

```dart
CompactDialog.showSuccess(
  context: context,
  title: 'Success!',
  description: 'Your action was completed successfully.',
  onPressed: () {
    print('Acknowledged');
  },
);
```

### Error Dialog

```dart
CompactDialog.showError(
  context: context,
  title: 'Error Occurred',
  description: 'Something went wrong. Please try again.',
);
```

### Warning Dialog

```dart
CompactDialog.showWarning(
  context: context,
  title: 'Warning',
  description: 'This action may have consequences.',
);
```

### Info Dialog

```dart
CompactDialog.showInfo(
  context: context,
  title: 'Information',
  description: 'Here is some important information.',
);
```

### Destructive Dialog

For dangerous actions like delete or logout:

```dart
CompactDialog.showDestructive(
  context: context,
  title: 'Delete Account',
  description: 'Are you sure? This action cannot be undone.',
  onConfirm: () {
    // Perform destructive action
  },
);
```

### Loading Dialog

```dart
// Show loading dialog
CompactDialog.showLoading(
  context: context,
  title: 'Loading',
  message: 'Please wait...',
);

// Later, close it
Navigator.of(context).pop();
```

### Input Dialog

```dart
final result = await CompactDialog.showInput(
  context: context,
  title: 'Enter Your Name',
  description: 'Please provide your name:',
  hint: 'John Doe',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  },
);

if (result != null) {
  print('User entered: $result');
}
```

### Multiline Input Dialog

```dart
final feedback = await CompactDialog.showInput(
  context: context,
  title: 'Feedback',
  description: 'Share your thoughts:',
  maxLines: 4,
  maxLength: 200,
  hint: 'Type here...',
);
```

### Confirmation Dialog with Checkbox

```dart
final confirmed = await CompactDialog.showConfirmation(
  context: context,
  title: 'Confirm Action',
  description: 'Do you want to proceed?',
  checkboxLabel: "Don't ask again",
);

if (confirmed == true) {
  print('User confirmed');
}
```

### Progress Dialog

```dart
final progressController = StreamController<double>();

CompactDialog.showProgress(
  context: context,
  title: 'Downloading',
  message: 'Downloading files...',
  progressStream: progressController.stream,
  showPercentage: true,
);

// Update progress
for (var i = 0; i <= 100; i += 10) {
  await Future.delayed(Duration(milliseconds: 300));
  progressController.add(i / 100);
}

await progressController.close();
Navigator.of(context).pop();
```

### Custom Content Dialog

```dart
CompactDialog.showCustom(
  context: context,
  title: 'Custom Dialog',
  icon: DialogIcons.info,
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Put any widget here'),
      SizedBox(height: 16),
      Image.network('https://example.com/image.png'),
      SizedBox(height: 16),
      Text('More custom content...'),
    ],
  ),
  primaryButtonText: 'Close',
);
```

## Theming

### Using Default Theme

CompactDialog automatically adapts to your Material theme:

```dart
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  // ... your app
);
```

### Custom Theme

Create a custom theme for all dialogs:

```dart
final customTheme = CompactDialogTheme(
  colorScheme: DialogColorScheme(
    background: Colors.white,
    foreground: Colors.black,
    primary: Colors.blue,
    border: Colors.grey[300]!,
    muted: Colors.grey[100]!,
    mutedForeground: Colors.grey[600]!,
  ),
  borderRadius: 24,
  iconSize: 24,
  titleStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
);

// Use in a specific dialog
CompactDialog.show(
  context: context,
  title: 'Themed Dialog',
  description: 'This uses custom theme',
  theme: customTheme,
);
```

### Global Theme Provider

Wrap your app with `CompactDialogThemeProvider` for consistent theming:

```dart
MaterialApp(
  home: CompactDialogThemeProvider(
    theme: CompactDialogTheme.dark(),
    child: YourHomePage(),
  ),
);
```

## Dialog Types Reference

| Method | Description | Icon | Color |
|--------|-------------|------|-------|
| `show()` | Basic customizable dialog | Custom | Custom |
| `showSuccess()` | Success message | Check circle | Green |
| `showError()` | Error message | Error circle | Red |
| `showWarning()` | Warning message | Warning | Orange |
| `showInfo()` | Information message | Info | Blue |
| `showDestructive()` | Dangerous actions | Delete | Red |
| `showLoading()` | Loading indicator | - | - |
| `showInput()` | Text input dialog | Custom | Custom |
| `showConfirmation()` | Confirmation with checkbox | Custom | Custom |
| `showProgress()` | Progress bar dialog | - | - |
| `showCustom()` | Custom widget content | Custom | Custom |

## Customization Options

### Dialog Parameters

- `title` - Dialog title text
- `description` - Dialog description/message
- `icon` - Icon to display (IconData)
- `iconColor` - Custom icon color
- `primaryButtonText` - Primary button label
- `secondaryButtonText` - Secondary button label
- `onPrimaryPressed` - Primary button callback
- `onSecondaryPressed` - Secondary button callback
- `barrierDismissible` - Can tap outside to dismiss (default: true)
- `showCloseButton` - Show close button in header (default: true)
- `theme` - Custom theme for this dialog

### Input Dialog Parameters

- `hint` - Placeholder text
- `initialValue` - Pre-filled value
- `keyboardType` - Input type (text, number, email, etc.)
- `maxLines` - Number of lines (1 for single line, >1 for multiline)
- `maxLength` - Maximum character length
- `validator` - Validation function

### Progress Dialog Parameters

- `progressStream` - Stream<double> with progress values (0.0 to 1.0)
- `showPercentage` - Display percentage text (default: true)

## Examples

Check out the [example](example/) directory for a complete demo app showcasing all dialog types.

**[🌐 View Live Demo](https://caqil.github.io/compact_dialog/)** - Try all dialog types directly in your browser!

To run the example locally:

```bash
cd example
flutter run
```

## Screenshots

![Demo](demo.gif)

## Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting PRs.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

Inspired by modern UI/UX design patterns and originally based on the shadcn/ui design system.

## Support

If you like this package, please give it a star on [GitHub](https://github.com/Caqil/compact_dialog) and like it on [pub.dev](https://pub.dev/packages/compact_dialog)!

For issues and feature requests, please use the [GitHub issue tracker](https://github.com/Caqil/compact_dialog/issues).
