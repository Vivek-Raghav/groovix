// Project imports:
import 'package:groovix/features/song/song_index.dart';

abstract class SongRepository {
  EitherDynamic<UploadSongResponse> uploadSong(UploadSongModel params);
}
