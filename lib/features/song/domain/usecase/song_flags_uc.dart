
import 'package:groovix/features/song/song_index.dart';

class SongFlagsUc extends UseCase<UserSongFlagsResponse, SongFlagParams> {
  SongFlagsUc({required this.songRepository});
  final SongRepository songRepository;
  @override
  EitherDynamic<UserSongFlagsResponse> call(SongFlagParams params) =>
      songRepository.updateSongFlags(params);
}
