import '../../cms_index.dart';

class SearchBar extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;

  const SearchBar({
    super.key,
    required this.placeholder,
    this.onChanged,
    this.onSearch,
    this.margin,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.primaryColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: (_) => onSearch?.call(),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
            fontFamily: ThemeFonts.lexend,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ThemeColors.primaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
            ),
            onPressed: () {
              controller?.clear();
              onChanged?.call('');
            },
          ),
          filled: true,
          fillColor: isDark ? ThemeColors.clrBlack50 : ThemeColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: ThemeColors.primaryColor.withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: ThemeColors.primaryColor.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: ThemeColors.primaryColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
        style: TextStyle(
          color: isDark ? ThemeColors.white : ThemeColors.black,
          fontFamily: ThemeFonts.lexend,
        ),
      ),
    );
  }
}
