import 'package:groovix/features/cms/cms_index.dart';
import 'package:groovix/features/shared/settings/settings_index.dart';
import 'package:groovix/features/song/presentation/widgets/song_listile.dart';

class SongsScreen extends StatelessWidget {
  final List<SongModel> songs;
  const SongsScreen({required this.songs, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return SongListTile(songs: songs, currentIndex: index);
        },
      ),
    );
  }
}
