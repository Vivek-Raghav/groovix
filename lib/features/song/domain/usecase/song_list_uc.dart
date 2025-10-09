import 'package:groovix/features/song/song_index.dart';

class SongListUc extends UseCase<SongsListResponse, SongsQueryModel> {
  SongListUc({required this.songRepository});
  final SongRepository songRepository;
  @override
  EitherDynamic<SongsListResponse> call(SongsQueryModel params) =>
      songRepository.getSongList(params);
}
