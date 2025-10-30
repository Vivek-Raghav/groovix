import 'package:groovix/features/auth/auth_index.dart';

class LikedSongsUc extends UseCase<List<SongModel>, NoParams> {
  final SongRepository songRepository;
  LikedSongsUc({required this.songRepository});

  @override
  EitherDynamic<List<SongModel>> call(NoParams params) {
    return songRepository.getLikedSongs();
  }
}
