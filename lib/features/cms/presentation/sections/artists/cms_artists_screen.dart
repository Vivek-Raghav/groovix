import '../../../cms_index.dart';

class CMSArtistsScreen extends StatefulWidget {
  const CMSArtistsScreen({super.key});

  @override
  State<CMSArtistsScreen> createState() => _CMSArtistsScreenState();
}

class _CMSArtistsScreenState extends State<CMSArtistsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artists'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _buildArtistsList(context),
      floatingActionButton: FloatingActionButton(
        heroTag: "cms_artists_fab",
        onPressed: _navigateToAddArtist,
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildArtistsList(BuildContext context) {
    // Mock artists data
    final artists = [
      {
        'id': '1',
        'name': 'Taylor Swift',
        'songCount': 45,
        'followers': '2.5M',
        'imageUrl': 'https://example.com/artist1.jpg',
        'genres': ['Pop', 'Country'],
        'createdAt': DateTime.now().subtract(const Duration(days: 5)),
      },
      {
        'id': '2',
        'name': 'Ed Sheeran',
        'songCount': 32,
        'followers': '1.8M',
        'imageUrl': 'https://example.com/artist2.jpg',
        'genres': ['Pop', 'Folk'],
        'createdAt': DateTime.now().subtract(const Duration(days: 3)),
      },
      {
        'id': '3',
        'name': 'Billie Eilish',
        'songCount': 28,
        'followers': '3.2M',
        'imageUrl': 'https://example.com/artist3.jpg',
        'genres': ['Alternative', 'Pop'],
        'createdAt': DateTime.now().subtract(const Duration(days: 7)),
      },
      {
        'id': '4',
        'name': 'The Weeknd',
        'songCount': 38,
        'followers': '2.1M',
        'imageUrl': 'https://example.com/artist4.jpg',
        'genres': ['R&B', 'Pop'],
        'createdAt': DateTime.now().subtract(const Duration(days: 2)),
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return _buildArtistCard(context, artist);
      },
    );
  }

  Widget _buildArtistCard(BuildContext context, Map<String, dynamic> artist) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: ThemeColors.primaryColor.withOpacity(0.1),
          backgroundImage: NetworkImage(artist['imageUrl']),
          child: artist['imageUrl'] == null
              ? Icon(
                  Icons.person,
                  size: 30,
                  color: ThemeColors.primaryColor,
                )
              : null,
        ),
        title: Text(
          artist['name'],
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${artist['songCount']} Songs • ${artist['followers']} Followers',
              style: theme.textTheme.bodySmall?.copyWith(
                color: ThemeColors.grey600,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: (artist['genres'] as List<String>).map((genre) {
                return Chip(
                  label: Text(
                    genre,
                    style: const TextStyle(fontSize: 10),
                  ),
                  backgroundColor: ThemeColors.primaryColor.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: ThemeColors.primaryColor,
                    fontSize: 10,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: ThemeColors.grey600,
          ),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _navigateToEditArtist(artist);
                break;
              case 'delete':
                _showDeleteConfirmation(context, artist);
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
          // Navigate to artist details
        },
      ),
    );
  }

  void _navigateToAddArtist() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CMSAddArtistScreen(),
      ),
    );
  }

  void _navigateToEditArtist(Map<String, dynamic> artist) {
    // TODO: Implement edit artist screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit ${artist['name']} - To be implemented'),
        backgroundColor: ThemeColors.primaryColor,
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, Map<String, dynamic> artist) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Artist'),
        content: Text('Are you sure you want to delete "${artist['name']}"?'),
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
                  content: Text('${artist['name']} deleted successfully'),
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
