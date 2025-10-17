// Project imports:
import 'package:groovix/features/song/song_index.dart';

abstract class SongRemoteDataSource {
  Future<UploadSongResponse> uploadSong(UploadSongModel params);
  Future<SongsListResponse> getSongList(SongsQueryModel params);
  Future<UserSongFlagsResponse> updateSongFlags(UpdateSongFlagParams params);
  Future<UserSongFlagsResponse> getSongFlags(GetSongFlagParams params);
}
