import '../../cms_index.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              backgroundColor ?? ThemeColors.primaryColor.withOpacity(0.1),
              backgroundColor ?? ThemeColors.primaryColor.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: iconColor ?? ThemeColors.primaryColor,
                ),
                Text(
                  value,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCardGrid extends StatelessWidget {
  final List<StatCardData> items;
  final EdgeInsetsGeometry? padding;
  final double spacing;

  const StatCardGrid({
    super.key,
    required this.items,
    this.padding,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return StatCard(
            title: item.title,
            value: item.value,
            icon: item.icon,
            backgroundColor: item.backgroundColor,
            iconColor: item.iconColor,
          );
        },
      ),
    );
  }
}

class StatCardData {
  final String title;
  final String value;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;

  StatCardData({
    required this.title,
    required this.value,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
  });
}
