import 'package:groovix/features/song/song_index.dart';

class GetSongFlagsUc extends UseCase<UserSongFlagsResponse, GetSongFlagParams> {
  GetSongFlagsUc({required this.songRepository});
  final SongRepository songRepository;
  @override
  EitherDynamic<UserSongFlagsResponse> call(GetSongFlagParams params) =>
      songRepository.getSongFlags(params);
}
