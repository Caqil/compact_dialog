import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compact_dialog/compact_dialog.dart';

void main() {
  group('DialogColors', () {
    test('should have correct color values', () {
      expect(DialogColors.success, const Color(0xFF10B981));
      expect(DialogColors.error, const Color(0xFFEF4444));
      expect(DialogColors.info, const Color(0xFF3B82F6));
      expect(DialogColors.warning, const Color(0xFFF59E0B));
    });
  });

  group('DialogColorScheme', () {
    test('light theme should have light background', () {
      final scheme = DialogColorScheme.light();
      expect(scheme.background, const Color(0xFFFFFFFF));
    });

    test('dark theme should have dark background', () {
      final scheme = DialogColorScheme.dark();
      expect(scheme.background, const Color(0xFF020817));
    });
  });

  group('CompactDialogTheme', () {
    test('should create light theme', () {
      final theme = CompactDialogTheme.light();
      expect(theme.colorScheme.background, const Color(0xFFFFFFFF));
      expect(theme.borderRadius, 12);
      expect(theme.iconSize, 20);
      expect(theme.buttonHeight, 40);
    });

    test('should create dark theme', () {
      final theme = CompactDialogTheme.dark();
      expect(theme.colorScheme.background, const Color(0xFF020817));
      expect(theme.borderRadius, 12);
      expect(theme.iconSize, 20);
      expect(theme.buttonHeight, 40);
    });
  });
}
