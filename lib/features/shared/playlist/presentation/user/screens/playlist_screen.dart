import 'package:groovix/features/shared/playlist/playlist_index.dart'
    hide PlaylistModel;

// Project imports:
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/injection_container/injection_initializer.dart';
import 'package:groovix/routes/app_routes.dart';

class UserPlaylistScreen extends StatefulWidget {
  const UserPlaylistScreen({super.key});

  @override
  State<UserPlaylistScreen> createState() => _UserPlaylistScreenState();
}

class _UserPlaylistScreenState extends State<UserPlaylistScreen> {
  int _currentPage = 1;
  int _pageSize = 100;

  @override
  void initState() {
    super.initState();
    context.read<PlaylistBloc>().add(FetchPlaylistsList(
        PlaylistsQueryModel(page: _currentPage, size: _pageSize)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refetch playlists when screen becomes visible again
    if (ModalRoute.of(context)?.isCurrent == true) {
      context.read<PlaylistBloc>().add(FetchPlaylistsList(
          PlaylistsQueryModel(page: _currentPage, size: _pageSize)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocListener<PlaylistBloc, PlaylistState>(
        listener: (context, state) {
          if (state is CreatePlaylistLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.playlist.name} created successfully'),
                backgroundColor: ThemeColors.clrGreen,
              ),
            );
            getIt<PlaylistBloc>().add(FetchPlaylistsList(
                PlaylistsQueryModel(page: _currentPage, size: _pageSize)));
          } else if (state is UpdatePlaylistLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.playlist.name} updated successfully'),
                backgroundColor: ThemeColors.clrGreen,
              ),
            );
            getIt<PlaylistBloc>().add(FetchPlaylistsList(
                PlaylistsQueryModel(page: _currentPage, size: _pageSize)));
          } else if (state is PlaylistDeletedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Playlist deleted successfully'),
                backgroundColor: ThemeColors.clrGreen,
              ),
            );
            getIt<PlaylistBloc>().add(FetchPlaylistsList(
                PlaylistsQueryModel(page: _currentPage, size: _pageSize)));
          } else if (state is CreatePlaylistError ||
              state is UpdatePlaylistError ||
              state is PlaylistDeletedError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text((state as dynamic).message ?? 'An error occurred'),
                backgroundColor: ThemeColors.red,
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.surface,
              ],
            ),
          ),
          child: BlocBuilder<PlaylistBloc, PlaylistState>(
            builder: (context, state) {
              if (state is PlaylistLoading || state is DeletePlaylistLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is PlaylistError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: ThemeColors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading playlists',
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
                          getIt<PlaylistBloc>().add(FetchPlaylistsList(
                              PlaylistsQueryModel(
                                  page: _currentPage, size: _pageSize)));
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }
              if (state is PlaylistLoaded) {
                return _buildPlaylistsList(context, state.playlists);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "user_playlists_fab",
        onPressed: _navigateToAddPlaylist,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPlaylistsList(
      BuildContext context, List<PlaylistModel> playlists) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
              'No playlists yet',
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

  Widget _buildPlaylistCard(BuildContext context, PlaylistModel playlist) {
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
          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
          backgroundImage: playlist.coverUrl.isNotEmpty
              ? NetworkImage(playlist.coverUrl)
              : null,
          child: playlist.coverUrl.isEmpty
              ? Icon(
                  Icons.queue_music,
                  color: theme.colorScheme.primary,
                  size: 24,
                )
              : null,
        ),
        title: Text(
          playlist.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          playlist.bio,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
          onSelected: (value) {
            switch (value) {
              case 'add_songs':
                _navigateToAddSongs(playlist);
                break;
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
              value: 'add_songs',
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline,
                      color: ThemeColors.primaryColor),
                  SizedBox(width: 8),
                  Text('Add Songs'),
                ],
              ),
            ),
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
          _navigateToPlaylistSongs(playlist);
        },
      ),
    );
  }

  void _navigateToAddPlaylist() {
    context.push(AppRoutes.addPlaylist);
  }

  void _navigateToAddSongs(PlaylistModel playlist) {
    context.push(AppRoutes.addSongsToPlaylist, extra: playlist);
  }

  void _navigateToEditPlaylist(PlaylistModel playlist) {
    context.push(AppRoutes.editPlaylist, extra: playlist);
  }

  void _navigateToPlaylistSongs(PlaylistModel playlist) {
    context.push(AppRoutes.playlistSongs, extra: playlist);
  }

  void _showDeleteConfirmation(BuildContext context, PlaylistModel playlist) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Playlist'),
        content: Text('Are you sure you want to delete "${playlist.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              getIt<PlaylistBloc>().add(DeletePlaylist(playlist.id));
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.pop(context);
              });
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
