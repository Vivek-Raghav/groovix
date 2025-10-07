// Project imports:
import 'package:groovix/features/song/song_index.dart';

abstract class SongRemoteDataSource {
  Future<UploadSongResponse> uploadSong(UploadSongModel params);
}
