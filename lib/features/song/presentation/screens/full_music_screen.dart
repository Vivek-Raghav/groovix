import 'package:groovix/features/playlist/playlist_index.dart';
import 'package:groovix/features/song/bloc/cubit/song_cubit.dart';
import 'package:groovix/features/song/bloc/state/song_state.dart';
import 'package:groovix/features/song/domain/models/song_flags_params.dart';
import 'package:groovix/injection_container/injected/inject_blocs.dart';

class FullMusicPage extends StatelessWidget {
  const FullMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<SongCubit>()),
      ],
      child: const FullMusicScreen(),
    );
  }
}

class FullMusicScreen extends StatelessWidget {
  const FullMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerBloc = getIt<MusicPlayerBloc>();

    return Scaffold(
      body: StreamBuilder<MusicPlayerState>(
        stream: musicPlayerBloc.stream,
        initialData: musicPlayerBloc.state,
        builder: (context, snapshot) {
          final state = snapshot.data ?? musicPlayerBloc.state;

          if (state.isLoading) {
            return _buildNoSongScreen(context, state.isLoading);
          } else if (state.currentSong == null) {
            return _buildNoSongScreen(context, state.isLoading);
          }

          final song = state.currentSong!;
          return _buildMusicPlayerScreen(context, state, song, musicPlayerBloc);
        },
      ),
    );
  }

  Widget _buildNoSongScreen(BuildContext context, bool isLoading) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            const Color(0xFF121212),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.music_note,
              size: 80,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            Text(
              isLoading ? "Loading..." : "No song playing",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicPlayerScreen(BuildContext context, MusicPlayerState state,
      dynamic song, MusicPlayerBloc musicBloc) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            const Color(0xFF121212)
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              // Header with song title and menu
              _buildHeader(context, song),
              const SizedBox(height: 30),

              // Album Art with Circular Progress
              _buildAlbumArt(context, state, song),
              const SizedBox(height: 30),

              // Song Info
              _buildSongInfo(context, song),
              const SizedBox(height: 20),

              // Progress Bar
              _buildProgressBar(context, state, musicBloc),
              const SizedBox(height: 30),

              // Playback Controls
              _buildPlaybackControls(context, state, musicBloc),
              const SizedBox(height: 20),

              // Skip Counter
              _buildSkipCounter(context),
              const SizedBox(height: 40),

              // Additional Controls
              _buildAdditionalControls(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic song) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.keyboard_arrow_down, size: 28),
        ),
        Expanded(
          child: Text(
            song.songName ?? "Unknown Song",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_horiz, size: 28),
        ),
      ],
    );
  }

  Widget _buildAlbumArt(
      BuildContext context, MusicPlayerState state, dynamic song) {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Album Art
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              song.thumbnailUrl ?? '',
              width: 280,
              height: 280,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.music_note,
                    size: 80,
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),

          // Loading Overlay with Circular Progress
          if (state.isLoading)
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Loading...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSongInfo(BuildContext context, SongModel song) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.songName,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              song.artist,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        BlocBuilder<SongCubit, SongState>(builder: (context, state) {
          final userId = getIt<LocalCache>().getMap(PrefKeys.userDetails);
          if (state is SongFlagsLoading) {
            return SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary, strokeWidth: 2),
            );
          } else if (state is SongFlagsSuccess) {
            return IconButton(
              onPressed: () {
                getIt<SongCubit>().updateSongFlags(SongFlagParams(
                    songId: song.id,
                    userId: userId?['id'] ?? '',
                    isLiked: !state.songFlagsResponse.isLiked));
              },
              icon: Icon(
                  state.songFlagsResponse.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: state.songFlagsResponse.isLiked
                      ? Colors.red
                      : Colors.white54,
                  size: 24),
            );
          }
          return const SizedBox.shrink();
        }),
      ],
    );
  }

  Widget _buildProgressBar(
      BuildContext context, MusicPlayerState state, MusicPlayerBloc musicBloc) {
    final progress = state.duration.inSeconds > 0
        ? state.position.inSeconds / state.duration.inSeconds
        : 0.0;

    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            padding: EdgeInsets.zero,
            activeTrackColor: Theme.of(context).colorScheme.primary,
            inactiveTrackColor: Colors.white24,
            thumbColor: Theme.of(context).colorScheme.primary,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            trackHeight: 3,
          ),
          child: Slider(
            value: progress.clamp(0.0, 1.0),
            onChanged: (value) {
              final newPosition = Duration(
                seconds: (value * state.duration.inSeconds).round(),
              );
              musicBloc.add(SeekSongEvent(newPosition));
            },
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDuration(state.position),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              Text(
                _formatDuration(state.duration),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaybackControls(
      BuildContext context, MusicPlayerState state, MusicPlayerBloc musicBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: state.isPrevious
              ? () {
                  musicBloc.add(PreviousSongEvent());
                }
              : null,
          icon: Icon(Icons.skip_previous,
              color: state.isPrevious ? Colors.white : Colors.white54,
              size: 32),
        ),

        // Play/Pause Button with Loading State
        AbsorbPointer(
          absorbing: state.isLoading,
          child: GestureDetector(
            onTap: () {
              if (state.isPlaying) {
                musicBloc.add(PauseSongEvent());
              } else {
                musicBloc.add(ResumeSongEvent());
              }
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: state.isLoading ? Colors.white70 : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Circular Progress Background
                  if (state.isLoading)
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),

                  // Play/Pause Icon
                  Center(
                    child: Icon(
                      state.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        IconButton(
          onPressed: state.isNext
              ? () {
                  musicBloc.add(NextSongEvent());
                }
              : null,
          icon: Icon(Icons.skip_next,
              color: state.isNext ? Colors.white : Colors.white54, size: 32),
        ),
      ],
    );
  }

  Widget _buildSkipCounter(BuildContext context) {
    return const Text(
      "You have 5/7 skips",
      style: TextStyle(
        color: Colors.white54,
        fontSize: 12,
      ),
    );
  }

  Widget _buildAdditionalControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.thumb_down_outlined,
              color: Colors.white54, size: 24),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.repeat, color: Colors.white54, size: 24),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.podcasts, color: Colors.white54, size: 24),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.shuffle, color: Colors.white54, size: 24),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.thumb_up_outlined,
              color: Colors.white54, size: 24),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
