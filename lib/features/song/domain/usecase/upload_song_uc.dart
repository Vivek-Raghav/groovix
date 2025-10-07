import 'package:groovix/features/song/song_index.dart';

class UploadSongUc extends UseCase<UploadSongResponse, UploadSongModel> {
  UploadSongUc({required this.songRepository});
  final SongRepository songRepository;
  @override
  EitherDynamic<UploadSongResponse> call(UploadSongModel params) =>
      songRepository.uploadSong(params);
}
