// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/models/song_model.dart';
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_bloc.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_event.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_state.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class PlaylistSongsScreen extends StatefulWidget {
  final PlaylistModel playlist;

  const PlaylistSongsScreen({super.key, required this.playlist});

  @override
  State<PlaylistSongsScreen> createState() => _PlaylistSongsScreenState();
}

class _PlaylistSongsScreenState extends State<PlaylistSongsScreen> {
  final Set<String> _selectedSongIds = {};
  bool _isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    getIt<PlaylistBloc>().add(FetchPlaylistSongs(widget.playlist.id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocListener<PlaylistBloc, PlaylistState>(
      listener: (context, state) {
        if (state is RemoveSongsFromPlaylistLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: ThemeColors.clrGreen,
            ),
          );
          setState(() {
            _selectedSongIds.clear();
            _isSelectionMode = false;
          });
          context
              .read<PlaylistBloc>()
              .add(FetchPlaylistSongs(widget.playlist.id));
        } else if (state is RemoveSongsFromPlaylistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ThemeColors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isSelectionMode
              ? '${_selectedSongIds.length} selected'
              : widget.playlist.name),
          backgroundColor: ThemeColors.primaryColor,
          foregroundColor: ThemeColors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(_isSelectionMode ? Icons.close : Icons.arrow_back),
            onPressed: () {
              if (_isSelectionMode) {
                setState(() {
                  _selectedSongIds.clear();
                  _isSelectionMode = false;
                });
              } else {
                context.pop();
              }
            },
          ),
          actions: [
            if (_isSelectionMode && _selectedSongIds.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: _showDeleteConfirmation,
              ),
            if (!_isSelectionMode)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  setState(() {
                    _isSelectionMode = true;
                  });
                },
              ),
          ],
        ),
        body: BlocBuilder<PlaylistBloc, PlaylistState>(
          builder: (context, state) {
            if (state is GetPlaylistSongsLoading) {
              return const Center(
                child:
                    CircularProgressIndicator(color: ThemeColors.primaryColor),
              );
            }

            if (state is GetPlaylistSongsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 64, color: ThemeColors.red),
                    const SizedBox(height: 16),
                    Text('Error loading songs',
                        style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(state.message, style: theme.textTheme.bodyMedium),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<PlaylistBloc>()
                            .add(FetchPlaylistSongs(widget.playlist.id));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is GetPlaylistSongsLoaded) {
              if (state.songs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.music_off,
                        size: 64,
                        color:
                            isDark ? ThemeColors.white70 : ThemeColors.grey600,
                      ),
                      const SizedBox(height: 16),
                      Text('No songs in this playlist',
                          style: theme.textTheme.titleLarge),
                    ],
                  ),
                );
              }

              return Stack(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.songs.length,
                    itemBuilder: (context, index) {
                      final song = state.songs[index];
                      final isSelected = _selectedSongIds.contains(song.id);
                      return _buildSongCard(context, song, isDark, isSelected);
                    },
                  ),
                  if (state is RemoveSongsFromPlaylistLoading)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                            color: ThemeColors.primaryColor),
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSongCard(
      BuildContext context, SongModel song, bool isDark, bool isSelected) {
    final theme = Theme.of(context);
    return GestureDetector(
      onLongPress: () {
        if (!_isSelectionMode) {
          setState(() {
            _isSelectionMode = true;
            _selectedSongIds.add(song.id);
          });
        }
      },
      onTap: () {
        if (_isSelectionMode) {
          setState(() {
            if (isSelected) {
              _selectedSongIds.remove(song.id);
            } else {
              _selectedSongIds.add(song.id);
            }
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ThemeColors.primaryColor.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Card(
          elevation: isSelected ? 4 : 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: ThemeColors.primaryColor.withOpacity(0.1),
                  backgroundImage: song.thumbnailUrl.isNotEmpty
                      ? NetworkImage(song.thumbnailUrl)
                      : null,
                  child: song.thumbnailUrl.isEmpty
                      ? const Icon(Icons.music_note,
                          color: ThemeColors.primaryColor, size: 24)
                      : null,
                ),
                if (_isSelectionMode)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? ThemeColors.primaryColor : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        isSelected ? Icons.check : Icons.circle_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            title: Text(
              song.songName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? ThemeColors.white : ThemeColors.black,
              ),
            ),
            subtitle: Text(
              song.artistName,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
              ),
            ),
            trailing:
                _isSelectionMode ? null : const Icon(Icons.play_circle_outline),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Songs'),
        content: Text(
          'Are you sure you want to remove ${_selectedSongIds.length} song${_selectedSongIds.length > 1 ? 's' : ''} from "${widget.playlist.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _removeSongs();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColors.red,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _removeSongs() {
    if (_selectedSongIds.isEmpty) return;

    final request = AddSongsToPlaylistRequest(
      songIds: _selectedSongIds.toList(),
    );

    getIt<PlaylistBloc>().add(
      RemoveSongsFromPlaylist(
        widget.playlist.id,
        request,
      ),
    );
  }
}
