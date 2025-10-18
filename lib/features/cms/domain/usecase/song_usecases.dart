import '../models/song_model.dart';
import '../repositories/cms_song_repository.dart';

class GetAllSongsUseCase {
  final CMSSongRepository _repository;

  GetAllSongsUseCase(this._repository);

  Future<List<SongModel>> call() async {
    return await _repository.getAllSongs();
  }
}

class GetSongByIdUseCase {
  final CMSSongRepository _repository;

  GetSongByIdUseCase(this._repository);

  Future<SongModel?> call(String id) async {
    return await _repository.getSongById(id);
  }
}

class SearchSongsUseCase {
  final CMSSongRepository _repository;

  SearchSongsUseCase(this._repository);

  Future<List<SongModel>> call(String query) async {
    return await _repository.searchSongs(query);
  }
}

class CreateSongUseCase {
  final CMSSongRepository _repository;

  CreateSongUseCase(this._repository);

  Future<SongModel> call(SongModel song) async {
    return await _repository.createSong(song);
  }
}

class UpdateSongUseCase {
  final CMSSongRepository _repository;

  UpdateSongUseCase(this._repository);

  Future<SongModel> call(SongModel song) async {
    return await _repository.updateSong(song);
  }
}

class DeleteSongUseCase {
  final CMSSongRepository _repository;

  DeleteSongUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteSong(id);
  }
}

class GetRecentSongsUseCase {
  final CMSSongRepository _repository;

  GetRecentSongsUseCase(this._repository);

  Future<List<SongModel>> call({int limit = 10}) async {
    return await _repository.getRecentSongs(limit: limit);
  }
}
