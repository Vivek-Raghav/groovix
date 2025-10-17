// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/theme/app_theme.dart';

/// PrimaryButton - reusable elevated button for main actions
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isExpanded;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.deepPurple,
        foregroundColor: ThemeColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
    return isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}

/// SecondaryButton - reusable outlined button for secondary actions
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isExpanded;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(icon, size: 20, color: ThemeColors.deepPurple)
          : const SizedBox.shrink(),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ThemeColors.deepPurple),
        foregroundColor: ThemeColors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
    return isExpanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
