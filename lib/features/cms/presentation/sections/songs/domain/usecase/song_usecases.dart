import "package:groovix/features/cms/cms_index.dart";

class GetAllSongsUseCase {
  final CmsSongRepository _repository;

  GetAllSongsUseCase(this._repository);

  Future<List<SongModel>> call() async {
    return await _repository.getAllSongs();
  }
}

class GetSongByIdUseCase {
  final CmsSongRepository _repository;

  GetSongByIdUseCase(this._repository);

  Future<SongModel?> call(String id) async {
    return await _repository.getSongById(id);
  }
}

class SearchSongsUseCase {
  final CmsSongRepository _repository;

  SearchSongsUseCase(this._repository);

  Future<List<SongModel>> call(String query) async {
    return await _repository.searchSongs(query);
  }
}

class CreateSongUseCase {
  final CmsSongRepository _repository;

  CreateSongUseCase(this._repository);

  Future<SongModel> call(SongModel song) async {
    return await _repository.createSong(song);
  }
}

class UpdateSongUseCase {
  final CmsSongRepository _repository;

  UpdateSongUseCase(this._repository);

  Future<SongModel> call(SongModel song) async {
    return await _repository.updateSong(song);
  }
}

class DeleteSongUseCase {
  final CmsSongRepository _repository;

  DeleteSongUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteSong(id);
  }
}

class GetRecentSongsUseCase {
  final CmsSongRepository _repository;

  GetRecentSongsUseCase(this._repository);

  Future<List<SongModel>> call({int limit = 10}) async {
    return await _repository.getRecentSongs(limit: limit);
  }
}
