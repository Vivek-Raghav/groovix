import 'package:groovix/features/shared/playlist/playlist_index.dart'
    hide PlaylistModel;
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/injection_container/injection_initializer.dart';
import 'package:groovix/routes/app_routes.dart';

class UserPlaylistScreen extends StatefulWidget {
  const UserPlaylistScreen({super.key});

  @override
  State<UserPlaylistScreen> createState() => _UserPlaylistScreenState();
}

class _UserPlaylistScreenState extends State<UserPlaylistScreen> {
  @override
  void initState() {
    super.initState();
    getIt<PlaylistBloc>()
        .add(FetchPlaylistsList(PlaylistsQueryModel(page: 1, size: 100)));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refetch playlists when screen becomes visible again
    if (ModalRoute.of(context)?.isCurrent == true) {
      context
          .read<PlaylistBloc>()
          .add(FetchPlaylistsList(PlaylistsQueryModel(page: 1, size: 100)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: BlocBuilder<PlaylistBloc, PlaylistState>(
          builder: (context, state) {
            if (state is PlaylistLoading) {
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
                        size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading playlists',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
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
    );
  }

  Widget _buildPlaylistsList(
      BuildContext context, List<PlaylistModel> playlists) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              context.push(AppRoutes.addPlaylist);
            },
            icon: const Icon(Icons.add, size: 20),
            label: const Text('Create New Playlist'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
          ),
        ),
        const SizedBox(height: 24),
        if (playlists.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.queue_music_outlined,
                  size: 64,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No playlists yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Create your first playlist to get started',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        else
          for (final playlist in playlists)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  backgroundImage: playlist.coverUrl.isNotEmpty
                      ? NetworkImage(playlist.coverUrl)
                      : null,
                  child: playlist.coverUrl.isEmpty
                      ? Icon(Icons.album,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24)
                      : null,
                ),
                title: Text(
                  playlist.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface),
                ),
                subtitle: Text(
                  playlist.bio,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                trailing: Icon(Icons.arrow_forward_ios,
                    color: Theme.of(context).colorScheme.primary),
                onTap: () {
                  // Navigate to playlist details
                },
              ),
            ),
      ],
    );
  }
}
