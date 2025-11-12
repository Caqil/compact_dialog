import 'package:flutter/material.dart';
import 'dialog_theme.dart';
import 'dialog_colors.dart';
import 'dialog_icons.dart';

/// Compact dialog system with beautiful animations and design
class CompactDialog {
  /// Show a modern alert dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String description,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
    bool showCloseButton = true,
    bool isDestructive = false,
    CompactDialogTheme? theme,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final dialogTheme = theme ?? CompactDialogTheme.of(context);
        final colorScheme = dialogTheme.colorScheme;

        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: FadeTransition(
                opacity: animation,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: colorScheme.background,
                    borderRadius: BorderRadius.circular(dialogTheme.borderRadius),
                    border: Border.all(
                      color: colorScheme.border,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Row(
                          children: [
                            if (icon != null) ...[
                              Icon(
                                icon,
                                color: iconColor ?? colorScheme.foreground,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                            ],
                            Expanded(
                              child: Text(
                                title,
                                style: dialogTheme.titleStyle ??
                                    TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.foreground,
                                      letterSpacing: -0.01,
                                    ),
                              ),
                            ),
                            if (showCloseButton)
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(
                                    DialogIcons.close,
                                    size: 20,
                                    color: colorScheme.mutedForeground,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Content
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                        child: Text(
                          description,
                          style: dialogTheme.descriptionStyle ??
                              TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: colorScheme.mutedForeground,
                              ),
                        ),
                      ),

                      // Actions
                      if (primaryButtonText != null ||
                          secondaryButtonText != null)
                        Container(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Row(
                            children: [
                              if (secondaryButtonText != null)
                                Expanded(
                                  child: SizedBox(
                                    height: dialogTheme.buttonHeight,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        onSecondaryPressed?.call();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: colorScheme.foreground,
                                        backgroundColor: Colors.transparent,
                                        side: BorderSide(
                                          color: colorScheme.input,
                                          width: 1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: Text(
                                        secondaryButtonText,
                                        style: dialogTheme.buttonStyle ??
                                            const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (primaryButtonText != null &&
                                  secondaryButtonText != null)
                                const SizedBox(width: 12),
                              if (primaryButtonText != null)
                                Expanded(
                                  child: SizedBox(
                                    height: dialogTheme.buttonHeight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        onPrimaryPressed?.call();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colorScheme.primary,
                                        foregroundColor: colorScheme.primaryForeground,
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: Text(
                                        primaryButtonText,
                                        style: dialogTheme.buttonStyle ??
                                            const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Show a destructive dialog (for dangerous actions like delete, logout, etc.)
  static Future<T?> showDestructive<T>({
    required BuildContext context,
    required String title,
    required String description,
    String primaryButtonText = 'Confirm',
    String secondaryButtonText = 'Cancel',
    VoidCallback? onConfirm,
    IconData? icon,
    CompactDialogTheme? theme,
  }) {
    return show<T>(
      context: context,
      title: title,
      description: description,
      icon: icon ?? DialogIcons.delete,
      iconColor: DialogColors.error,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      onPrimaryPressed: onConfirm,
      isDestructive: true,
      theme: theme,
    );
  }

  /// Show a success dialog
  static Future<T?> showSuccess<T>({
    required BuildContext context,
    required String title,
    required String description,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    CompactDialogTheme? theme,
  }) {
    return show<T>(
      context: context,
      title: title,
      description: description,
      icon: DialogIcons.success,
      iconColor: DialogColors.success,
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
      showCloseButton: false,
      theme: theme,
    );
  }

  /// Show an info dialog
  static Future<T?> showInfo<T>({
    required BuildContext context,
    required String title,
    required String description,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    CompactDialogTheme? theme,
  }) {
    return show<T>(
      context: context,
      title: title,
      description: description,
      icon: DialogIcons.info,
      iconColor: DialogColors.info,
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
      theme: theme,
    );
  }

  /// Show a warning dialog
  static Future<T?> showWarning<T>({
    required BuildContext context,
    required String title,
    required String description,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    CompactDialogTheme? theme,
  }) {
    return show<T>(
      context: context,
      title: title,
      description: description,
      icon: DialogIcons.warning,
      iconColor: DialogColors.warning,
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
      theme: theme,
    );
  }

  /// Show an error dialog
  static Future<T?> showError<T>({
    required BuildContext context,
    required String title,
    required String description,
    String buttonText = 'OK',
    VoidCallback? onPressed,
    CompactDialogTheme? theme,
  }) {
    return show<T>(
      context: context,
      title: title,
      description: description,
      icon: DialogIcons.error,
      iconColor: DialogColors.error,
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
      showCloseButton: false,
      theme: theme,
    );
  }

  /// Show a custom content dialog with a widget
  static Future<T?> showCustom<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    IconData? icon,
    Color? iconColor,
    bool barrierDismissible = true,
    bool showCloseButton = true,
    CompactDialogTheme? theme,
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final dialogTheme = theme ?? CompactDialogTheme.of(context);
        final colorScheme = dialogTheme.colorScheme;

        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: FadeTransition(
                opacity: animation,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: colorScheme.background,
                    borderRadius: BorderRadius.circular(dialogTheme.borderRadius),
                    border: Border.all(
                      color: colorScheme.border,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                        child: Row(
                          children: [
                            if (icon != null) ...[
                              Icon(
                                icon,
                                color: iconColor ?? colorScheme.foreground,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                            ],
                            Expanded(
                              child: Text(
                                title,
                                style: dialogTheme.titleStyle ??
                                    TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.foreground,
                                      letterSpacing: -0.01,
                                    ),
                              ),
                            ),
                            if (showCloseButton)
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(4),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(
                                    DialogIcons.close,
                                    size: 20,
                                    color: colorScheme.mutedForeground,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Custom Content
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: content,
                        ),
                      ),

                      // Actions
                      if (primaryButtonText != null ||
                          secondaryButtonText != null)
                        Container(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Row(
                            children: [
                              if (secondaryButtonText != null)
                                Expanded(
                                  child: SizedBox(
                                    height: dialogTheme.buttonHeight,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        onSecondaryPressed?.call();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: colorScheme.foreground,
                                        backgroundColor: Colors.transparent,
                                        side: BorderSide(
                                          color: colorScheme.input,
                                          width: 1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: Text(
                                        secondaryButtonText,
                                        style: dialogTheme.buttonStyle ??
                                            const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (primaryButtonText != null &&
                                  secondaryButtonText != null)
                                const SizedBox(width: 12),
                              if (primaryButtonText != null)
                                Expanded(
                                  child: SizedBox(
                                    height: dialogTheme.buttonHeight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        onPrimaryPressed?.call();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colorScheme.primary,
                                        foregroundColor: colorScheme.primaryForeground,
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: Text(
                                        primaryButtonText,
                                        style: dialogTheme.buttonStyle ??
                                            const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Show a loading dialog (cannot be dismissed by user)
  static Future<void> showLoading({
    required BuildContext context,
    String title = 'Loading',
    String? message,
    CompactDialogTheme? theme,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final dialogTheme = theme ?? CompactDialogTheme.of(context);
        final colorScheme = dialogTheme.colorScheme;

        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: FadeTransition(
                opacity: animation,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  constraints: const BoxConstraints(maxWidth: 320),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colorScheme.background,
                    borderRadius: BorderRadius.circular(dialogTheme.borderRadius),
                    border: Border.all(
                      color: colorScheme.border,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.foreground,
                        ),
                      ),
                      if (message != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: colorScheme.mutedForeground,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Show an input dialog
  static Future<String?> showInput({
    required BuildContext context,
    required String title,
    String? description,
    String? hint,
    String? initialValue,
    String primaryButtonText = 'Submit',
    String secondaryButtonText = 'Cancel',
    IconData? icon,
    Color? iconColor,
    TextInputType? keyboardType,
    int? maxLines = 1,
    int? maxLength,
    String? Function(String?)? validator,
    CompactDialogTheme? theme,
  }) {
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();
    final focusNode = FocusNode();

    return showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final dialogTheme = theme ?? CompactDialogTheme.of(context);
        final colorScheme = dialogTheme.colorScheme;

        // Request focus after dialog animation completes
        if (animation.status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (context.mounted) {
              focusNode.requestFocus();
            }
          });
        } else {
          animation.addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Future.delayed(const Duration(milliseconds: 100), () {
                if (context.mounted) {
                  focusNode.requestFocus();
                }
              });
            }
          });
        }

        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutBack,
                ),
                child: FadeTransition(
                  opacity: animation,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      constraints: const BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        color: colorScheme.background,
                        borderRadius: BorderRadius.circular(dialogTheme.borderRadius),
                        border: Border.all(
                          color: colorScheme.border,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colorScheme.border.withValues(alpha: 0.3),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              if (icon != null) ...[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: (iconColor ?? colorScheme.primary)
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    icon,
                                    color: iconColor ?? colorScheme.primary,
                                    size: dialogTheme.iconSize,
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                              Expanded(
                                child: Text(
                                  title,
                                  style: dialogTheme.titleStyle ??
                                      TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: colorScheme.foreground,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Content
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (description != null) ...[
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.mutedForeground,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                              TextFormField(
                                controller: controller,
                                focusNode: focusNode,
                                keyboardType: keyboardType,
                                maxLines: maxLines,
                                maxLength: maxLength,
                                validator: validator,
                                style: TextStyle(
                                  color: colorScheme.foreground,
                                ),
                                decoration: InputDecoration(
                                  hintText: hint,
                                  hintStyle: TextStyle(
                                    color: colorScheme.mutedForeground,
                                  ),
                                  filled: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: colorScheme.input,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: colorScheme.input,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: colorScheme.ring,
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: DialogColors.error,
                                      width: 1,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                      color: DialogColors.error,
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Actions
                        Container(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: dialogTheme.buttonHeight,
                                  child: OutlinedButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: colorScheme.foreground,
                                      backgroundColor: Colors.transparent,
                                      side: BorderSide(
                                        color: colorScheme.input,
                                        width: 1,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                    ),
                                    child: Text(
                                      secondaryButtonText,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: dialogTheme.buttonHeight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState?.validate() ?? true) {
                                        Navigator.of(context).pop(controller.text);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.primaryForeground,
                                      elevation: 0,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                    ),
                                    child: Text(
                                      primaryButtonText,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() {
      focusNode.dispose();
      controller.dispose();
    });
  }

  /// Show a confirmation dialog with optional checkbox (useful for "don't show again")
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String description,
    String primaryButtonText = 'Confirm',
    String secondaryButtonText = 'Cancel',
    IconData? icon,
    Color? iconColor,
    String? checkboxLabel,
    bool checkboxInitialValue = false,
    CompactDialogTheme? theme,
  }) {
    bool checkboxValue = checkboxInitialValue;

    return showGeneralDialog<bool>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final dialogTheme = theme ?? CompactDialogTheme.of(context);
        final colorScheme = dialogTheme.colorScheme;

        return StatefulBuilder(
          builder: (context, setState) {
            return Center(
              child: Material(
                type: MaterialType.transparency,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: FadeTransition(
                    opacity: animation,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      constraints: const BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        color: colorScheme.background,
                        borderRadius: BorderRadius.circular(dialogTheme.borderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: colorScheme.border.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                if (icon != null) ...[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: (iconColor ?? colorScheme.primary)
                                          .withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      icon,
                                      color: iconColor ?? colorScheme.primary,
                                      size: dialogTheme.iconSize,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
                                Expanded(
                                  child: Text(
                                    title,
                                    style: dialogTheme.titleStyle ??
                                        TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: colorScheme.foreground,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Content
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: colorScheme.mutedForeground,
                                  ),
                                ),
                                if (checkboxLabel != null) ...[
                                  const SizedBox(height: 16),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        checkboxValue = !checkboxValue;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Checkbox(
                                              value: checkboxValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  checkboxValue = value ?? false;
                                                });
                                              },
                                              activeColor: colorScheme.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              checkboxLabel,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: colorScheme.foreground,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Actions
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 44,
                                    child: OutlinedButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: colorScheme.foreground,
                                        side: BorderSide(
                                          color: colorScheme.border,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        secondaryButtonText,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: SizedBox(
                                    height: 44,
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colorScheme.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        primaryButtonText,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Show a progress dialog with progress indicator
  static Future<void> showProgress({
    required BuildContext context,
    required String title,
    String? message,
    required Stream<double> progressStream,
    bool showPercentage = true,
    CompactDialogTheme? theme,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        final dialogTheme = theme ?? CompactDialogTheme.of(context);
        final colorScheme = dialogTheme.colorScheme;

        return StreamBuilder<double>(
          stream: progressStream,
          initialData: 0.0,
          builder: (context, snapshot) {
            final progress = snapshot.data ?? 0.0;

            return Center(
              child: Material(
                type: MaterialType.transparency,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutBack,
                  ),
                  child: FadeTransition(
                    opacity: animation,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      constraints: const BoxConstraints(maxWidth: 320),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: colorScheme.background,
                        borderRadius: BorderRadius.circular(dialogTheme.borderRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.foreground,
                            ),
                          ),
                          if (message != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: colorScheme.mutedForeground,
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: colorScheme.muted,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.primary,
                            ),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          if (showPercentage) ...[
                            const SizedBox(height: 12),
                            Text(
                              '${(progress * 100).toStringAsFixed(0)}%',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.foreground,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
