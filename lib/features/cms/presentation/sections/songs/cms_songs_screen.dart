import '../../../cms_index.dart';

class CMSSongsScreen extends StatefulWidget {
  const CMSSongsScreen({super.key});

  @override
  State<CMSSongsScreen> createState() => _CMSSongsScreenState();
}

class _CMSSongsScreenState extends State<CMSSongsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SongBloc>().add(LoadSongs());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      appBar: AppBar(
        title: const Text('Songs'),
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          SearchBar(
            placeholder: 'Search songs by name, artist, or album...',
            controller: _searchController,
            onChanged: (query) {
              context.read<SongBloc>().add(SearchSongs(query));
            },
          ),

          // Songs List
          Expanded(
            child: BlocBuilder<SongBloc, SongState>(
              builder: (context, state) {
                if (state is SongLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ThemeColors.primaryColor,
                    ),
                  );
                }

                if (state is SongError) {
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
                          'Error loading songs',
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
                            context.read<SongBloc>().add(LoadSongs());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is SongLoaded) {
                  return _buildSongsList(context, state.songs);
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "cms_songs_fab",
        onPressed: _navigateToAddSong,
        backgroundColor: ThemeColors.primaryColor,
        foregroundColor: ThemeColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSongsList(BuildContext context, List<SongModel> songs) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (songs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.music_off,
              size: 64,
              color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
            ),
            const SizedBox(height: 16),
            Text(
              'No songs found',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Add your first song to get started',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return _buildSongCard(context, song);
      },
    );
  }

  Widget _buildSongCard(BuildContext context, SongModel song) {
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
          backgroundImage: song.thumbnailUrl.isNotEmpty
              ? NetworkImage(song.thumbnailUrl)
              : null,
          child: song.thumbnailUrl.isEmpty
              ? Icon(
                  Icons.music_note,
                  color: ThemeColors.primaryColor,
                  size: 24,
                )
              : null,
        ),
        title: Text(
          song.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.artist,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
              ),
            ),
            Text(
              song.genres.join(', '),
              style: theme.textTheme.bodySmall?.copyWith(
                color: ThemeColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                _navigateToEditSong(song);
                break;
              case 'delete':
                _showDeleteConfirmation(context, song);
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
          // Navigate to song details
        },
      ),
    );
  }

  void _navigateToAddSong() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CMSAddSongScreen(),
      ),
    );
  }

  void _navigateToEditSong(SongModel song) {
    // TODO: Implement edit song screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit ${song.name} - To be implemented'),
        backgroundColor: ThemeColors.primaryColor,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, SongModel song) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Song'),
        content: Text('Are you sure you want to delete "${song.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<SongBloc>().add(DeleteSong(song.id));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${song.name} deleted successfully'),
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
