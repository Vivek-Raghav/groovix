// Project imports:
import "package:groovix/core/utils/generic_typedef.dart";
import "package:groovix/features/cms/cms_index.dart";
import "package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart";

abstract class CmsSongRepository {
  EitherDynamic<List<SongModel>> searchSongs(String query);
  Future<SongModel> updateSongFields(
      String songId, CmsSongUpdateModel updateModel);
  EitherDynamic<dynamic> deleteSong(String songId);
  EitherDynamic<UploadSongResponse> uploadSong(UploadSongModel params);
}
