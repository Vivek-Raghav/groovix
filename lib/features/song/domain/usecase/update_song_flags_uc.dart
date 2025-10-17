import 'package:groovix/features/song/song_index.dart';

class UpdateSongFlagsUc
    extends UseCase<UserSongFlagsResponse, UpdateSongFlagParams> {
  UpdateSongFlagsUc({required this.songRepository});
  final SongRepository songRepository;
  @override
  EitherDynamic<UserSongFlagsResponse> call(UpdateSongFlagParams params) =>
      songRepository.updateSongFlags(params);
}
