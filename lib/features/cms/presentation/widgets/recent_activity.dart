import '../../cms_index.dart';

class RecentActivityItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? thumbnailUrl;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;

  const RecentActivityItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.thumbnailUrl,
    this.onTap,
    this.onMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: ThemeColors.primaryColor.withOpacity(0.1),
          backgroundImage:
              thumbnailUrl != null ? NetworkImage(thumbnailUrl!) : null,
          child: thumbnailUrl == null
              ? Icon(
                  Icons.music_note,
                  color: ThemeColors.primaryColor,
                  size: 24,
                )
              : null,
        ),
        title: Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          onPressed: onMorePressed,
        ),
        onTap: onTap,
      ),
    );
  }
}

class RecentActivitySection extends StatelessWidget {
  final String title;
  final List<RecentActivityData> items;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onViewAll;

  const RecentActivitySection({
    super.key,
    required this.title,
    required this.items,
    this.padding,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? ThemeColors.white : ThemeColors.black,
                ),
              ),
              if (onViewAll != null)
                TextButton(
                  onPressed: onViewAll,
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: ThemeColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: ThemeFonts.lexend,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: RecentActivityItem(
                  title: item.title,
                  subtitle: item.subtitle,
                  thumbnailUrl: item.thumbnailUrl,
                  onTap: item.onTap,
                  onMorePressed: item.onMorePressed,
                ),
              )),
        ],
      ),
    );
  }
}

class RecentActivityData {
  final String title;
  final String subtitle;
  final String? thumbnailUrl;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;

  RecentActivityData({
    required this.title,
    required this.subtitle,
    this.thumbnailUrl,
    this.onTap,
    this.onMorePressed,
  });
}
