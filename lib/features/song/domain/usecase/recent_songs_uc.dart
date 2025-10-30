// Project imports:
import 'package:groovix/features/auth/auth_index.dart';

class RecentSongsUc extends UseCase<List<SongModel>, NoParams>{
  final SongRepository songRepository;
  RecentSongsUc({required this.songRepository});
  @override
  EitherDynamic<List<SongModel>> call(NoParams params) {
    return songRepository.getRecentSongs();
  }
}
