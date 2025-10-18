import '../../../cms_index.dart';

class PlaylistsScreen extends StatefulWidget {
  const PlaylistsScreen({super.key});

  @override
  State<PlaylistsScreen> createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      appBar: AppBar(
        title: const Text('Playlists'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _buildPlaylistsList(context),
      floatingActionButton: FloatingActionButton(
        heroTag: "cms_playlists_fab",
        onPressed: _navigateToAddPlaylist,
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPlaylistsList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Mock playlists data
    final playlists = [
      {
        'id': '1',
        'name': 'Summer Hits 2024',
        'songCount': 12,
        'coverImageUrl': 'https://example.com/playlist1.jpg',
        'createdAt': DateTime.now().subtract(const Duration(days: 3)),
      },
      {
        'id': '2',
        'name': 'Chill Vibes',
        'songCount': 8,
        'coverImageUrl': 'https://example.com/playlist2.jpg',
        'createdAt': DateTime.now().subtract(const Duration(days: 7)),
      },
      {
        'id': '3',
        'name': 'Workout Mix',
        'songCount': 15,
        'coverImageUrl': 'https://example.com/playlist3.jpg',
        'createdAt': DateTime.now().subtract(const Duration(days: 10)),
      },
    ];

    if (playlists.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.queue_music_outlined,
              size: 64,
              color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
            ),
            const SizedBox(height: 16),
            Text(
              'No playlists found',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first playlist to get started',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return _buildPlaylistCard(context, playlist);
      },
    );
  }

  Widget _buildPlaylistCard(
      BuildContext context, Map<String, dynamic> playlist) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: ThemeColors.primaryColor.withOpacity(0.1),
          backgroundImage: playlist['coverImageUrl'] != null
              ? NetworkImage(playlist['coverImageUrl'])
              : null,
          child: playlist['coverImageUrl'] == null
              ? Icon(
                  Icons.queue_music,
                  color: ThemeColors.primaryColor,
                  size: 24,
                )
              : null,
        ),
        title: Text(
          playlist['name'],
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${playlist['songCount']} Songs',
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _navigateToEditPlaylist(playlist);
                break;
              case 'delete':
                _showDeleteConfirmation(context, playlist);
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, color: ThemeColors.primaryColor),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: ThemeColors.red),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to playlist details
        },
      ),
    );
  }

  void _navigateToAddPlaylist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CMSAddPlaylistScreen(),
      ),
    );
  }

  void _navigateToEditPlaylist(Map<String, dynamic> playlist) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPlaylistScreen(playlist: playlist),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, Map<String, dynamic> playlist) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Playlist'),
        content: Text('Are you sure you want to delete "${playlist['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${playlist['name']} deleted successfully'),
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

// Placeholder screens
class AddPlaylistScreen extends StatelessWidget {
  const AddPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Playlist'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
      ),
      body: const Center(
        child: Text('Add Playlist Form - To be implemented'),
      ),
    );
  }
}

class EditPlaylistScreen extends StatelessWidget {
  final Map<String, dynamic> playlist;

  const EditPlaylistScreen({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Playlist'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
      ),
      body: Center(
        child: Text('Edit Playlist Form for: ${playlist['name']}'),
      ),
    );
  }
}
