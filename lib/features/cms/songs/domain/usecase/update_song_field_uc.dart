import "package:groovix/features/cms/cms_index.dart";
import "package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart";

class UpdateSongFieldsUseCase {
  final CmsSongRepository _repository;

  UpdateSongFieldsUseCase(this._repository);

  Future<SongModel> call(String songId, CmsSongUpdateModel updateModel) async {
    return await _repository.updateSongFields(songId, updateModel);
  }
}