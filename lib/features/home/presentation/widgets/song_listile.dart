import 'package:groovix/features/home/home_index.dart';
import 'package:groovix/features/song/song_index.dart';

class SongListTile extends StatelessWidget {
  final SongModel song;
  const SongListTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    final musicPlayerBloc = getIt<MusicPlayerBloc>();

    return BlocBuilder<MusicPlayerBloc, MusicPlayerState>(
      builder: (context, state) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            if (musicPlayerBloc.state.currentSong == song) {
              context.push(AppRoutes.fullMusic);
            } else {
              musicPlayerBloc.add(PlaySongEvent(song));
              context.push(AppRoutes.fullMusic);
            }
          },
          title: Text(
            song.artist,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis),
          ),
          subtitle: Text(
            song.songName,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis),
          ),
          leading: CircleAvatar(
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
            backgroundImage: NetworkImage(song.thumbnailUrl),
          ),
          trailing: IconButton(
            onPressed: () {
              if (musicPlayerBloc.state.currentSong == song) {
                if (musicPlayerBloc.state.isPlaying) {
                  musicPlayerBloc.add(PauseSongEvent());
                } else {
                  musicPlayerBloc.add(ResumeSongEvent());
                }
              } else {
                musicPlayerBloc.add(PlaySongEvent(song));
              }
            },
            icon: musicPlayerBloc.state.currentSong == song &&
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
