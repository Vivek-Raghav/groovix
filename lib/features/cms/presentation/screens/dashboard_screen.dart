import '../../cms_index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardBloc>().add(LoadDashboardStats());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.primaryColor,
              ),
            );
          }

          if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: ThemeColors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading dashboard',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DashboardBloc>().add(LoadDashboardStats());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is DashboardLoaded) {
            return _buildDashboardContent(context, state.stats);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, DashboardStats stats) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Container
          Center(
            child: LogoContainer(
              text: 'Groovix CMS',
              height: 80,
              width: 220,
              borderRadius: 20,
              backgroundColor: ThemeColors.primaryColor,
            ),
          ),

          const SizedBox(height: 32),

          // Stats Grid
          StatCardGrid(
            items: [
              StatCardData(
                title: 'Total Songs',
                value: stats.totalSongs.toString(),
                icon: Icons.music_note,
                backgroundColor: ThemeColors.blue.withOpacity(0.1),
                iconColor: ThemeColors.blue,
              ),
              StatCardData(
                title: 'Playlists',
                value: stats.totalPlaylists.toString(),
                icon: Icons.queue_music,
                backgroundColor: ThemeColors.clrGreen.withOpacity(0.1),
                iconColor: ThemeColors.clrGreen,
              ),
              StatCardData(
                title: 'Genres',
                value: stats.totalGenres.toString(),
                icon: Icons.category,
                backgroundColor: ThemeColors.orange.withOpacity(0.1),
                iconColor: ThemeColors.orange,
              ),
              StatCardData(
                title: 'Artists',
                value: stats.totalArtists.toString(),
                icon: Icons.person,
                backgroundColor: ThemeColors.purple.withOpacity(0.1),
                iconColor: ThemeColors.purple,
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Recent Activity Section
          RecentActivitySection(
            title: 'Recent Uploads',
            items: _getRecentActivityItems(),
            onViewAll: () {
              // Navigate to songs screen
            },
          ),
        ],
      ),
    );
  }

  List<RecentActivityData> _getRecentActivityItems() {
    return [
      RecentActivityData(
        title: 'Summer Vibes',
        subtitle: 'John Doe • 2 days ago',
        thumbnailUrl: 'https://example.com/thumb1.jpg',
        onTap: () {
          // Navigate to song details
        },
        onMorePressed: () {
          _showSongOptions(context, 'Summer Vibes');
        },
      ),
      RecentActivityData(
        title: 'Midnight Dreams',
        subtitle: 'Jane Smith • 5 days ago',
        thumbnailUrl: 'https://example.com/thumb2.jpg',
        onTap: () {
          // Navigate to song details
        },
        onMorePressed: () {
          _showSongOptions(context, 'Midnight Dreams');
        },
      ),
      RecentActivityData(
        title: 'City Lights',
        subtitle: 'Mike Johnson • 1 week ago',
        thumbnailUrl: 'https://example.com/thumb3.jpg',
        onTap: () {
          // Navigate to song details
        },
        onMorePressed: () {
          _showSongOptions(context, 'City Lights');
        },
      ),
    ];
  }

  void _showSongOptions(BuildContext context, String songName) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              songName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.edit, color: ThemeColors.primaryColor),
              title: const Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to edit screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: ThemeColors.red),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, songName);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String songName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Song'),
        content: Text('Are you sure you want to delete "$songName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Delete song logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$songName deleted successfully'),
                  backgroundColor: ThemeColors.clrGreen,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
