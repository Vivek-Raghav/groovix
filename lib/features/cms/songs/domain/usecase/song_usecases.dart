import "package:groovix/features/cms/cms_index.dart";

class SearchSongsUseCase {
  final CmsSongRepository _repository;

  SearchSongsUseCase(this._repository);

  Future<List<SongModel>> call(String query) async {
    return await _repository.searchSongs(query);
  }
}

