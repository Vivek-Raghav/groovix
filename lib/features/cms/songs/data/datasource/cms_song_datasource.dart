// Project imports:
import "package:groovix/features/cms/cms_index.dart";
import "package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart";

abstract class CmsSongRemoteDataSource {
  Future<List<SongModel>> searchSongs(String query);
  Future<SongModel> updateSongFields(
      String songId, CmsSongUpdateModel updateModel);
  Future<dynamic> deleteSong(String songId);
  Future<UploadSongResponse> uploadSong(UploadSongModel params);
}
