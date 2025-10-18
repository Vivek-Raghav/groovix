// Project imports:
import 'package:groovix/features/song/song_index.dart';

abstract class SongRepository {
  EitherDynamic<SongsListResponse> getSongList(SongsQueryModel params);
  EitherDynamic<UserSongFlagsResponse> updateSongFlags(
      UpdateSongFlagParams params);
  EitherDynamic<UserSongFlagsResponse> getSongFlags(GetSongFlagParams params);
}
