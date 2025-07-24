import 'package:flutter/material.dart';

/// SectionHeader - reusable widget for section titles
class SectionHeader extends StatelessWidget {
  final String text;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const SectionHeader({
    super.key,
    required this.text,
    this.trailing,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// SubtitleText - reusable widget for subtitles or secondary text
class SubtitleText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;

  const SubtitleText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color ?? Colors.grey[600],
          ),
    );
  }
}
