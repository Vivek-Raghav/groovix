import '../../../cms_index.dart';

class GenresScreen extends StatefulWidget {
  const GenresScreen({super.key});

  @override
  State<GenresScreen> createState() => _GenresScreenState();
}

class _GenresScreenState extends State<GenresScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      appBar: AppBar(
        title: const Text('Genres'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _buildGenresList(context),
      floatingActionButton: FloatingActionButton(
        heroTag: "cms_genres_fab",
        onPressed: _navigateToAddGenre,
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGenresList(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Mock genres data
    final genres = [
      {
        'id': '1',
        'name': 'Pop',
        'songCount': 45,
        'color': '#FF6B6B',
        'icon': 'Icons.music_note',
      },
      {
        'id': '2',
        'name': 'Rock',
        'songCount': 32,
        'color': '#4ECDC4',
        'icon': 'Icons.guitar',
      },
      {
        'id': '3',
        'name': 'Hip Hop',
        'songCount': 28,
        'color': '#45B7D1',
        'icon': 'Icons.mic',
      },
      {
        'id': '4',
        'name': 'Electronic',
        'songCount': 22,
        'color': '#96CEB4',
        'icon': 'Icons.speaker',
      },
      {
        'id': '5',
        'name': 'Jazz',
        'songCount': 18,
        'color': '#FFEAA7',
        'icon': 'Icons.piano',
      },
      {
        'id': '6',
        'name': 'Classical',
        'songCount': 15,
        'color': '#DDA0DD',
        'icon': 'Icons.audiotrack',
      },
    ];

    if (genres.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 64,
              color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
            ),
            const SizedBox(height: 16),
            Text(
              'No genres found',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first genre to get started',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: genres.length,
      itemBuilder: (context, index) {
        final genre = genres[index];
        return _buildGenreCard(context, genre);
      },
    );
  }

  Widget _buildGenreCard(BuildContext context, Map<String, dynamic> genre) {
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
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Color(int.parse(genre['color'].replaceFirst('#', '0xFF'))),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getIconFromString(genre['icon']),
            color: ThemeColors.white,
            size: 24,
          ),
        ),
        title: Text(
          genre['name'],
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '${genre['songCount']} Songs',
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
                _navigateToEditGenre(genre);
                break;
              case 'delete':
                _showDeleteConfirmation(context, genre);
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
          // Navigate to genre details
        },
      ),
    );
  }

  IconData _getIconFromString(String iconString) {
    switch (iconString) {
      case 'Icons.music_note':
        return Icons.music_note;
      case 'Icons.guitar':
        return Icons.music_note; // Using music_note as guitar is not available
      case 'Icons.mic':
        return Icons.mic;
      case 'Icons.speaker':
        return Icons.speaker;
      case 'Icons.piano':
        return Icons.piano;
      case 'Icons.audiotrack':
        return Icons.audiotrack;
      default:
        return Icons.music_note;
    }
  }

  void _navigateToAddGenre() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CMSAddGenreScreen(),
      ),
    );
  }

  void _navigateToEditGenre(Map<String, dynamic> genre) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditGenreScreen(genre: genre),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, Map<String, dynamic> genre) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Genre'),
        content: Text('Are you sure you want to delete "${genre['name']}"?'),
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
                  content: Text('${genre['name']} deleted successfully'),
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
class AddGenreScreen extends StatelessWidget {
  const AddGenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Genre'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
      ),
      body: const Center(
        child: Text('Add Genre Form - To be implemented'),
      ),
    );
  }
}

class EditGenreScreen extends StatelessWidget {
  final Map<String, dynamic> genre;

  const EditGenreScreen({super.key, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Genre'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
      ),
      body: Center(
        child: Text('Edit Genre Form for: ${genre['name']}'),
      ),
    );
  }
}
