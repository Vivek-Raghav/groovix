import 'package:flutter/material.dart';
import 'package:groovix/core/theme/app_theme.dart';

/// GenreChip - reusable chip for displaying a music genre or category
class GenreChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const GenreChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label),
        backgroundColor:
            selected ? ThemeColors.deepPurple : ThemeColors.grey200,
        labelStyle: TextStyle(
          color: selected ? ThemeColors.white : ThemeColors.black,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }
}

/// SelectableChip - reusable chip for multi-select or filter options
class SelectableChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  const SelectableChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap?.call(),
      selectedColor: ThemeColors.deepPurple,
      backgroundColor: ThemeColors.grey200,
      labelStyle: TextStyle(
        color: selected ? ThemeColors.white : ThemeColors.black,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }
}
