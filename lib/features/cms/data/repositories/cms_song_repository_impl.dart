import '../../domain/models/song_model.dart';
import '../../domain/repositories/cms_song_repository.dart';
import '../datasources/cms_song_datasource.dart';

class CMSSongRepositoryImpl implements CMSSongRepository {
  final CMSSongDataSource _dataSource;

  CMSSongRepositoryImpl(this._dataSource);

  @override
  Future<List<SongModel>> getAllSongs() async {
    return await _dataSource.getAllSongs();
  }

  @override
  Future<SongModel?> getSongById(String id) async {
    return await _dataSource.getSongById(id);
  }

  @override
  Future<List<SongModel>> searchSongs(String query) async {
    return await _dataSource.searchSongs(query);
  }

  @override
  Future<SongModel> createSong(SongModel song) async {
    return await _dataSource.createSong(song);
  }

  @override
  Future<SongModel> updateSong(SongModel song) async {
    return await _dataSource.updateSong(song);
  }

  @override
  Future<void> deleteSong(String id) async {
    return await _dataSource.deleteSong(id);
  }

  @override
  Future<List<SongModel>> getRecentSongs({int limit = 10}) async {
    return await _dataSource.getRecentSongs(limit: limit);
  }
}
