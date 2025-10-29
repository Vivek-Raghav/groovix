import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_event.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_state.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/features/cms/cms_index.dart'
    hide PlaylistModel, SearchBar;
import 'package:groovix/features/cms/shared/widgets/search_bar.dart'
    as CmsSearchBar;
import 'package:groovix/features/song/domain/models/song_query_model.dart';

class AddSongsToPlaylistScreen extends StatefulWidget {
  final PlaylistModel playlist;

  const AddSongsToPlaylistScreen({super.key, required this.playlist});

  @override
  State<AddSongsToPlaylistScreen> createState() =>
      _AddSongsToPlaylistScreenState();
}

class _AddSongsToPlaylistScreenState extends State<AddSongsToPlaylistScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedSongIds = {};
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    context
        .read<CmsSongBloc>()
        .add(FetchSongList(SongsQueryModel(page: 1, size: 100)));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaylistBloc, PlaylistState>(
      listener: (context, state) {
        if (state is AddSongsToPlaylistLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: ThemeColors.clrGreen,
            ),
          );
          context.pop(context);
        } else if (state is AddSongsToPlaylistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ThemeColors.red,
            ),
          );
        }
      },
      child: BlocBuilder<CmsSongBloc, CmsSongState>(
        builder: (context, songState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Songs to ${widget.playlist.name}'),
              backgroundColor: ThemeColors.primaryColor,
              foregroundColor: ThemeColors.white,
              elevation: 0,
              centerTitle: true,
              leading: const CommonBackButton(),
              actions: [
                if (_selectedSongIds.isNotEmpty)
                  TextButton(
                    onPressed: () => _addSongsToPlaylist(),
                    child: Text(
                      'Add ${_selectedSongIds.length}',
                      style: const TextStyle(
                        color: ThemeColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    CmsSearchBar.SearchBar(
                      placeholder: 'Search songs by name or artist...',
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _isSearching = true;
                        });
                      },
                      onSearch: (query) {
                        setState(() {
                          _isSearching = false;
                        });
                        getIt<CmsSongBloc>().add(SearchSongs(query));
                      },
                      onClear: _isSearching
                          ? () {}
                          : () {
                              getIt<CmsSongBloc>().add(FetchSongList(
                                  SongsQueryModel(page: 1, size: 100)));
                            },
                    ),
                    Expanded(
                      child: _buildSongsList(context, songState),
                    ),
                  ],
                ),
                BlocBuilder<PlaylistBloc, PlaylistState>(
                  builder: (context, state) {
                    if (state is AddSongsToPlaylistLoading) {
                      return LoadingOverlay(
                        title: 'Adding Songs',
                        message:
                            'Please wait while we add songs to your playlist...',
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSongsList(BuildContext context, CmsSongState state) {
    if (state is CmsSongLoading || state is SongDeletedLoading) {
      return const Center(
        child: CircularProgressIndicator(color: ThemeColors.primaryColor),
      );
    }

    if (state is CmsSongError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: ThemeColors.red),
            const SizedBox(height: 16),
            Text('Error loading songs',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context
                    .read<CmsSongBloc>()
                    .add(FetchSongList(SongsQueryModel(page: 1, size: 100)));
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is CmsSongLoaded) {
      if (state.songs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.music_off,
                size: 64,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ThemeColors.white70
                    : ThemeColors.grey600,
              ),
              const SizedBox(height: 16),
              Text(
                'No songs found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Add songs to your library first',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.songs.length,
        itemBuilder: (context, index) {
          final song = state.songs[index];
          final isSelected = _selectedSongIds.contains(song.id);
          return _buildSongCard(context, song, isSelected);
        },
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildSongCard(BuildContext context, SongModel song, bool isSelected) {
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
        leading: Checkbox(
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                _selectedSongIds.add(song.id);
              } else {
                _selectedSongIds.remove(song.id);
              }
            });
          },
          activeColor: ThemeColors.primaryColor,
        ),
        title: Text(
          song.songName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          song.artistName,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
          ),
        ),
        trailing: const Icon(Icons.music_note),
        onTap: () {
          setState(() {
            if (_selectedSongIds.contains(song.id)) {
              _selectedSongIds.remove(song.id);
            } else {
              _selectedSongIds.add(song.id);
            }
          });
        },
      ),
    );
  }

  void _addSongsToPlaylist() {
    if (_selectedSongIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one song'),
          backgroundColor: ThemeColors.red,
        ),
      );
      return;
    }

    final request = AddSongsToPlaylistRequest(
      songIds: _selectedSongIds.toList(),
    );

    getIt<PlaylistBloc>().add(
      AddSongsToPlaylist(
        widget.playlist.id,
        request,
      ),
    );
  }
}
