import "package:groovix/features/cms/cms_index.dart";

abstract class CmsSongRepository {
  Future<List<SongModel>> getAllSongs();
  Future<SongModel?> getSongById(String id);
  Future<List<SongModel>> searchSongs(String query);
  Future<SongModel> createSong(SongModel song);
  Future<SongModel> updateSong(SongModel song);
  Future<void> deleteSong(String id);
  Future<List<SongModel>> getRecentSongs({int limit = 10});
  EitherDynamic<UploadSongResponse> uploadSong(UploadSongModel params);
}
