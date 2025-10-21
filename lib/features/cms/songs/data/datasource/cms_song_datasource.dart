// Project imports:
import "package:groovix/features/cms/cms_index.dart";
import "package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart";

abstract class CmsSongRemoteDataSource {
  Future<List<SongModel>> getAllSongs();
  Future<SongModel?> getSongById(String id);
  Future<List<SongModel>> searchSongs(String query);
  Future<SongModel> createSong(SongModel song);
  Future<SongModel> updateSong(SongModel song);
  Future<SongModel> updateSongFields(
      String songId, CmsSongUpdateModel updateModel);
  Future<void> deleteSong(String id);
  Future<List<SongModel>> getRecentSongs({int limit = 10});
  Future<UploadSongResponse> uploadSong(UploadSongModel params);
}
