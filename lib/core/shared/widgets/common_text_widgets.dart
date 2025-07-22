import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TextWidget(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.style,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    TextStyle? defaultStyle = Theme.of(context).textTheme.bodyMedium;
    return Text(
      text,
      style: style ??
          defaultStyle?.copyWith(
              fontSize: fontSize, fontWeight: fontWeight, color: color),
      textAlign: textAlign,
    );
  }
}
