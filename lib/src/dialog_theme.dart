import 'package:flutter/material.dart';

/// Color scheme for CompactDialog matching shadcn/ui design
class DialogColorScheme {
  final Color background;
  final Color foreground;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color border;
  final Color input;
  final Color ring;
  final Color muted;
  final Color mutedForeground;
  final Color accent;
  final Color accentForeground;

  const DialogColorScheme({
    required this.background,
    required this.foreground,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.border,
    required this.input,
    required this.ring,
    required this.muted,
    required this.mutedForeground,
    required this.accent,
    required this.accentForeground,
  });

  /// Create a light color scheme matching shadcn/ui
  factory DialogColorScheme.light() {
    return const DialogColorScheme(
      background: Color(0xFFFFFFFF),
      foreground: Color(0xFF020817),
      primary: Color(0xFF0F172A),
      primaryForeground: Color(0xFFFAFAFA),
      secondary: Color(0xFFF1F5F9),
      secondaryForeground: Color(0xFF0F172A),
      destructive: Color(0xFFEF4444),
      destructiveForeground: Color(0xFFFAFAFA),
      border: Color(0xFFE2E8F0),
      input: Color(0xFFE2E8F0),
      ring: Color(0xFF020817),
      muted: Color(0xFFF1F5F9),
      mutedForeground: Color(0xFF64748B),
      accent: Color(0xFFF1F5F9),
      accentForeground: Color(0xFF0F172A),
    );
  }

  /// Create a dark color scheme matching shadcn/ui
  factory DialogColorScheme.dark() {
    return const DialogColorScheme(
      background: Color(0xFF020817),
      foreground: Color(0xFFFAFAFA),
      primary: Color(0xFFFAFAFA),
      primaryForeground: Color(0xFF0F172A),
      secondary: Color(0xFF1E293B),
      secondaryForeground: Color(0xFFFAFAFA),
      destructive: Color(0xFF7F1D1D),
      destructiveForeground: Color(0xFFFAFAFA),
      border: Color(0xFF1E293B),
      input: Color(0xFF1E293B),
      ring: Color(0xFFD4D4D8),
      muted: Color(0xFF1E293B),
      mutedForeground: Color(0xFF94A3B8),
      accent: Color(0xFF1E293B),
      accentForeground: Color(0xFFFAFAFA),
    );
  }

  /// Create from Material ThemeData
  factory DialogColorScheme.fromTheme(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return DialogColorScheme(
      background: theme.dialogTheme.backgroundColor ?? theme.colorScheme.surface,
      foreground: theme.colorScheme.onSurface,
      primary: theme.colorScheme.primary,
      primaryForeground: theme.colorScheme.onPrimary,
      secondary: theme.colorScheme.secondary,
      secondaryForeground: theme.colorScheme.onSecondary,
      destructive: theme.colorScheme.error,
      destructiveForeground: theme.colorScheme.onError,
      border: theme.dividerColor,
      input: theme.dividerColor,
      ring: theme.colorScheme.primary,
      muted: isDark ? theme.colorScheme.surfaceContainerHighest : theme.colorScheme.surfaceContainerLowest,
      mutedForeground: theme.colorScheme.onSurfaceVariant,
      accent: theme.colorScheme.secondaryContainer,
      accentForeground: theme.colorScheme.onSecondaryContainer,
    );
  }
}

/// Theme configuration for CompactDialog matching shadcn/ui
class CompactDialogTheme {
  final DialogColorScheme colorScheme;
  final double borderRadius;
  final double iconSize;
  final double buttonHeight;
  final double inputHeight;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final TextStyle? buttonStyle;
  final TextStyle? labelStyle;

  const CompactDialogTheme({
    required this.colorScheme,
    this.borderRadius = 12,
    this.iconSize = 20,
    this.buttonHeight = 40,
    this.inputHeight = 40,
    this.titleStyle,
    this.descriptionStyle,
    this.buttonStyle,
    this.labelStyle,
  });

  /// Create a light theme
  factory CompactDialogTheme.light() {
    return CompactDialogTheme(
      colorScheme: DialogColorScheme.light(),
    );
  }

  /// Create a dark theme
  factory CompactDialogTheme.dark() {
    return CompactDialogTheme(
      colorScheme: DialogColorScheme.dark(),
    );
  }

  /// Create from Material ThemeData
  factory CompactDialogTheme.fromMaterial(ThemeData theme) {
    return CompactDialogTheme(
      colorScheme: DialogColorScheme.fromTheme(theme),
    );
  }

  /// Get theme from context (either custom or from Material)
  static CompactDialogTheme of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<_InheritedDialogTheme>();
    if (inheritedTheme != null) {
      return inheritedTheme.theme;
    }
    // Fallback to Material theme
    return CompactDialogTheme.fromMaterial(Theme.of(context));
  }
}

/// Inherited widget to provide dialog theme
class CompactDialogThemeProvider extends InheritedWidget {
  final CompactDialogTheme theme;

  const CompactDialogThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  static CompactDialogTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedDialogTheme>()?.theme;
  }

  @override
  bool updateShouldNotify(CompactDialogThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }
}

class _InheritedDialogTheme extends InheritedWidget {
  final CompactDialogTheme theme;

  const _InheritedDialogTheme({
    required this.theme,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedDialogTheme oldWidget) {
    return theme != oldWidget.theme;
  }
}
