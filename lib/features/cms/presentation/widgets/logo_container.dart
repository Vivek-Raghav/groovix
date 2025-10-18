import '../../cms_index.dart';

class LogoContainer extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  const LogoContainer({
    super.key,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 80,
      width: width ?? 220,
      decoration: BoxDecoration(
        color: backgroundColor ?? ThemeColors.primaryColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? ThemeColors.white,
            fontSize: fontSize ?? 24,
            fontWeight: fontWeight ?? FontWeight.bold,
            fontFamily: ThemeFonts.lexend,
          ),
        ),
      ),
    );
  }
}
