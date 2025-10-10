import 'package:groovix/routes/routes_index.dart';

class MiniMusicScreen extends StatelessWidget {
  const MiniMusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final musicPlayerBloc = getIt<MusicPlayerBloc>();

    return StreamBuilder<MusicPlayerState>(
      stream: musicPlayerBloc.stream,
      initialData: musicPlayerBloc.state,
      builder: (context, snapshot) {
        final state = snapshot.data ?? musicPlayerBloc.state;

        if (state.currentSong == null) {
          return const SizedBox.shrink();
        } else if (state.isLoading) {
          return _loadingMiniScreen(context);
        } else if (state.currentSong != null) {
          return _buildMiniMusicScreen(
              context, state, state.currentSong!, musicPlayerBloc);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _loadingMiniScreen(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push(AppRoutes.fullMusic);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text('Loading...'),
          ),
        ));
  }

  Widget _noSongScreen(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push(AppRoutes.fullMusic);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
        ));
  }

  Widget _buildMiniMusicScreen(
    BuildContext context,
    MusicPlayerState state,
    SongModel song,
    MusicPlayerBloc musicPlayerBloc,
  ) {
    return GestureDetector(
        onTap: () {
          context.push(AppRoutes.fullMusic);
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              color: Color(int.parse("0xFF${song.hexcode}")),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          backgroundImage: NetworkImage(song.thumbnailUrl)),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(song.songName,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: ThemeColors.clrWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          Text(song.artist,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: ThemeColors.clrWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          if (musicPlayerBloc.state.isPlaying) {
                            musicPlayerBloc.add(PauseSongEvent());
                          } else {
                            musicPlayerBloc.add(ResumeSongEvent());
                          }
                        },
                        icon: Icon(
                          musicPlayerBloc.state.currentSong == song &&
                                  musicPlayerBloc.state.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: ThemeColors.clrWhite,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          musicPlayerBloc.add(CloseMusicPlayerEvent());
                        },
                        icon: const Icon(Icons.close,
                            color: ThemeColors.clrWhite),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  height: 6,
                  child: _buildProgressBar(context, state, musicPlayerBloc),
                )
              ],
            )));
  }

  Widget _buildProgressBar(
      BuildContext context, MusicPlayerState state, MusicPlayerBloc musicBloc) {
    final progress = state.duration.inSeconds > 0
        ? state.position.inSeconds / state.duration.inSeconds
        : 0.0;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
          padding: EdgeInsets.zero,
          activeTrackColor: Theme.of(context).colorScheme.primary,
          inactiveTrackColor: ThemeColors.clrGrey.withOpacity(0.4),
          thumbColor: Theme.of(context).colorScheme.primary,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
          trackHeight: 1.2),
      child: Slider(
        value: progress.clamp(0.0, 1.0),
        onChanged: (value) {
          final newPosition = Duration(
            seconds: (value * state.duration.inSeconds).round(),
          );
          musicBloc.add(SeekSongEvent(newPosition));
        },
      ),
    );
  }
}
