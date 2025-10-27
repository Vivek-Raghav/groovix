// Project imports:
import 'package:groovix/features/home/home_index.dart';
import 'package:groovix/features/song/song_index.dart';

class SongListTile extends StatelessWidget {
  final List<SongModel> songs;
  final int currentIndex;
  const SongListTile(
      {super.key, required this.songs, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final musicPlayerBloc = getIt<MusicPlayerBloc>();

    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        final currentMusicSong = musicPlayerBloc.state.currentSong;

        // print("SongListTile: $currentMusicSong == ${songs[currentIndex]}");
        return ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            if (currentMusicSong == songs[currentIndex]) {
              context.push(AppRoutes.fullMusic);
            } else {
              musicPlayerBloc.add(PlaySongEvent(songs, currentIndex));
              context.push(AppRoutes.fullMusic);
            }
          },
          title: Text(
            songs[currentIndex].artistName,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(
            songs[currentIndex].songName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis),
          ),
          leading: CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
            backgroundImage: NetworkImage(songs[currentIndex].thumbnailUrl),
          ),
          trailing: IconButton(
            onPressed: () {
              if (currentMusicSong == songs[currentIndex]) {
                if (musicPlayerBloc.state.isPlaying) {
                  musicPlayerBloc.add(PauseSongEvent());
                } else {
                  musicPlayerBloc.add(ResumeSongEvent());
                }
              } else {
                musicPlayerBloc.add(PlaySongEvent(songs, currentIndex));
              }
            },
            icon: currentMusicSong == songs[currentIndex] &&
                    musicPlayerBloc.state.isPlaying
                ? Icon(Icons.pause,
                    color: Theme.of(context).colorScheme.primary)
                : Icon(Icons.play_arrow,
                    color: Theme.of(context).colorScheme.primary),
          ),
        );
      },
    );
  }
}
