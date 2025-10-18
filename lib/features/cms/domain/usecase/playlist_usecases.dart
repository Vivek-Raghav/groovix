import '../models/playlist_model.dart';
import '../repositories/playlist_repository.dart';

class GetAllPlaylistsUseCase {
  final PlaylistRepository _repository;

  GetAllPlaylistsUseCase(this._repository);

  Future<List<PlaylistModel>> call() async {
    return await _repository.getAllPlaylists();
  }
}

class GetPlaylistByIdUseCase {
  final PlaylistRepository _repository;

  GetPlaylistByIdUseCase(this._repository);

  Future<PlaylistModel?> call(String id) async {
    return await _repository.getPlaylistById(id);
  }
}

class SearchPlaylistsUseCase {
  final PlaylistRepository _repository;

  SearchPlaylistsUseCase(this._repository);

  Future<List<PlaylistModel>> call(String query) async {
    return await _repository.searchPlaylists(query);
  }
}

class CreatePlaylistUseCase {
  final PlaylistRepository _repository;

  CreatePlaylistUseCase(this._repository);

  Future<PlaylistModel> call(PlaylistModel playlist) async {
    return await _repository.createPlaylist(playlist);
  }
}

class UpdatePlaylistUseCase {
  final PlaylistRepository _repository;

  UpdatePlaylistUseCase(this._repository);

  Future<PlaylistModel> call(PlaylistModel playlist) async {
    return await _repository.updatePlaylist(playlist);
  }
}

class DeletePlaylistUseCase {
  final PlaylistRepository _repository;

  DeletePlaylistUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deletePlaylist(id);
  }
}
