import 'dart:async';
import 'package:flutter/material.dart';
import 'package:compact_dialog/compact_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CompactDialog Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const DialogDemoPage(),
    );
  }
}

class DialogDemoPage extends StatefulWidget {
  const DialogDemoPage({super.key});

  @override
  State<DialogDemoPage> createState() => _DialogDemoPageState();
}

class _DialogDemoPageState extends State<DialogDemoPage> {
  String _lastResult = '';

  void _showBasicDialog() {
    CompactDialog.show(
      context: context,
      title: 'Basic Dialog',
      description:
          'This is a basic dialog with a title, description, and two buttons.',
      icon: DialogIcons.info,
      primaryButtonText: 'OK',
      secondaryButtonText: 'Cancel',
      onPrimaryPressed: () {
        setState(() {
          _lastResult = 'Basic Dialog: OK pressed';
        });
      },
      onSecondaryPressed: () {
        setState(() {
          _lastResult = 'Basic Dialog: Cancel pressed';
        });
      },
    );
  }

  void _showSuccessDialog() {
    CompactDialog.showSuccess(
      context: context,
      title: 'Success!',
      description: 'Your action was completed successfully.',
      onPressed: () {
        setState(() {
          _lastResult = 'Success Dialog: Acknowledged';
        });
      },
    );
  }

  void _showErrorDialog() {
    CompactDialog.showError(
      context: context,
      title: 'Error Occurred',
      description: 'Something went wrong. Please try again.',
      onPressed: () {
        setState(() {
          _lastResult = 'Error Dialog: Acknowledged';
        });
      },
    );
  }

  void _showWarningDialog() {
    CompactDialog.showWarning(
      context: context,
      title: 'Warning',
      description: 'This action may have unintended consequences.',
      onPressed: () {
        setState(() {
          _lastResult = 'Warning Dialog: Acknowledged';
        });
      },
    );
  }

  void _showInfoDialog() {
    CompactDialog.showInfo(
      context: context,
      title: 'Information',
      description: 'Here is some important information for you.',
      onPressed: () {
        setState(() {
          _lastResult = 'Info Dialog: Acknowledged';
        });
      },
    );
  }

  void _showDestructiveDialog() {
    CompactDialog.showDestructive(
      context: context,
      title: 'Delete Account',
      description:
          'Are you sure you want to delete your account? This action cannot be undone.',
      onConfirm: () {
        setState(() {
          _lastResult = 'Destructive Dialog: Confirmed';
        });
      },
    );
  }

  Future<void> _showLoadingDialog() async {
    CompactDialog.showLoading(
      context: context,
      title: 'Loading',
      message: 'Please wait while we process your request...',
    );

    // Simulate some work
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pop(); // Close loading dialog
      setState(() {
        _lastResult = 'Loading Dialog: Completed';
      });
    }
  }

  Future<void> _showInputDialog() async {
    final result = await CompactDialog.showInput(
      context: context,
      title: 'Enter Your Name',
      description: 'Please enter your name below:',
      hint: 'John Doe',
      icon: DialogIcons.question,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Name cannot be empty';
        }
        return null;
      },
    );

    if (result != null) {
      setState(() {
        _lastResult = 'Input Dialog: Entered "$result"';
      });
    }
  }

  Future<void> _showMultilineInputDialog() async {
    final result = await CompactDialog.showInput(
      context: context,
      title: 'Enter Feedback',
      description: 'Please share your feedback with us:',
      hint: 'Type your feedback here...',
      maxLines: 4,
      maxLength: 200,
      icon: DialogIcons.info,
    );

    if (result != null) {
      setState(() {
        _lastResult = 'Multiline Input: "${result.substring(0, result.length > 30 ? 30 : result.length)}..."';
      });
    }
  }

  Future<void> _showConfirmationDialog() async {
    final result = await CompactDialog.showConfirmation(
      context: context,
      title: 'Confirm Action',
      description: 'Do you want to proceed with this action?',
      icon: DialogIcons.question,
      checkboxLabel: "Don't ask again",
    );

    if (result != null) {
      setState(() {
        _lastResult = 'Confirmation Dialog: ${result ? "Confirmed" : "Cancelled"}';
      });
    }
  }

  Future<void> _showProgressDialog() async {
    final controller = StreamController<double>();

    CompactDialog.showProgress(
      context: context,
      title: 'Downloading',
      message: 'Downloading files...',
      progressStream: controller.stream,
    );

    // Simulate progress
    for (var i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(milliseconds: 300));
      controller.add(i / 100);
    }

    await controller.close();

    if (mounted) {
      Navigator.of(context).pop(); // Close progress dialog
      setState(() {
        _lastResult = 'Progress Dialog: Download completed';
      });
    }
  }

  void _showCustomDialog() {
    CompactDialog.showCustom(
      context: context,
      title: 'Custom Content',
      icon: DialogIcons.info,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'This is a custom dialog with custom widgets.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You can put any widget here!',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'This demonstrates the flexibility of CompactDialog.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
      primaryButtonText: 'Got it',
      onPrimaryPressed: () {
        setState(() {
          _lastResult = 'Custom Dialog: Acknowledged';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CompactDialog Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Basic Dialogs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _DemoButton(
            label: 'Basic Dialog',
            icon: Icons.chat_bubble,
            onPressed: _showBasicDialog,
          ),
          _DemoButton(
            label: 'Success Dialog',
            icon: Icons.check_circle,
            color: Colors.green,
            onPressed: _showSuccessDialog,
          ),
          _DemoButton(
            label: 'Error Dialog',
            icon: Icons.error,
            color: Colors.red,
            onPressed: _showErrorDialog,
          ),
          _DemoButton(
            label: 'Warning Dialog',
            icon: Icons.warning,
            color: Colors.orange,
            onPressed: _showWarningDialog,
          ),
          _DemoButton(
            label: 'Info Dialog',
            icon: Icons.info,
            color: Colors.blue,
            onPressed: _showInfoDialog,
          ),
          _DemoButton(
            label: 'Destructive Dialog',
            icon: Icons.delete,
            color: Colors.red,
            onPressed: _showDestructiveDialog,
          ),
          const SizedBox(height: 24),
          const Text(
            'Extended Features',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _DemoButton(
            label: 'Loading Dialog',
            icon: Icons.hourglass_empty,
            color: Colors.purple,
            onPressed: _showLoadingDialog,
          ),
          _DemoButton(
            label: 'Input Dialog',
            icon: Icons.edit,
            color: Colors.teal,
            onPressed: _showInputDialog,
          ),
          _DemoButton(
            label: 'Multiline Input Dialog',
            icon: Icons.notes,
            color: Colors.teal,
            onPressed: _showMultilineInputDialog,
          ),
          _DemoButton(
            label: 'Confirmation Dialog',
            icon: Icons.help,
            color: Colors.indigo,
            onPressed: _showConfirmationDialog,
          ),
          _DemoButton(
            label: 'Progress Dialog',
            icon: Icons.download,
            color: Colors.cyan,
            onPressed: _showProgressDialog,
          ),
          _DemoButton(
            label: 'Custom Content Dialog',
            icon: Icons.widgets,
            color: Colors.deepPurple,
            onPressed: _showCustomDialog,
          ),
          const SizedBox(height: 24),
          if (_lastResult.isNotEmpty) ...[
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Last Action:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _lastResult,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DemoButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;
  final VoidCallback onPressed;

  const _DemoButton({
    required this.label,
    required this.icon,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
