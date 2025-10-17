// Project imports:
import 'package:groovix/features/song/song_index.dart';

abstract class SongRepository {
  EitherDynamic<UploadSongResponse> uploadSong(UploadSongModel params);
  EitherDynamic<SongsListResponse> getSongList(SongsQueryModel params);
  EitherDynamic<UserSongFlagsResponse> updateSongFlags(
      UpdateSongFlagParams params);
  EitherDynamic<UserSongFlagsResponse> getSongFlags(GetSongFlagParams params);
}
