// Project imports:

import "package:groovix/features/cms/cms_index.dart";
import "package:groovix/features/cms/songs/domain/models/cms_song_update_model.dart";

class CmsSongRemoteDatasourceImpl extends CmsSongRemoteDataSource {
  final apiService = getIt<ApiService>();

  @override
  Future<List<SongModel>> searchSongs(String query) async {
    try {
      final response = await apiService.get('songs/search?q=$query');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => SongModel.fromJson(json))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      debugPrint("Search Songs Error: $e");
      return [];
    }
  }

  @override
  Future<SongModel> updateSongFields(
      String songId, CmsSongUpdateModel updateModel) async {
    try {
      final response = await apiService.put(
          url: "/songs/update/$songId", data: updateModel.toJson());

      if (response.statusCode == 200) {
        return SongModel.fromJson(response.data);
      } else {
        throw ServerException(error: 'Failed to update song');
      }
    } catch (e) {
      debugPrint("Update Song Fields Error: $e");
      throw ServerException(error: 'Failed to update song: ${e.toString()}');
    }
  }

  @override
  Future<dynamic> deleteSong(String songId) async {
    try {
      final response = await apiService.delete('/songs/delete/$songId');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException(error: 'Failed to delete song');
      }
    } catch (e) {
      debugPrint("Delete Song Error: $e");
      throw ServerException(error: 'Failed to delete song: ${e.toString()}');
    }
  }

  @override
  Future<UploadSongResponse> uploadSong(UploadSongModel params) async {
    try {
      final response =
          await apiService.postMultipart(url: ApiUrls.uploadSong, files: {
        'song': params.song,
        'thumbnail': params.thumbnailFile,
      }, fields: {
        'artist': params.artist,
        'song_name': params.songName,
        'hexcode': params.hexcode,
      });
      if (response.statusCode == 201) {
        return UploadSongResponse.fromJson(response.data);
      } else {
        debugPrint("Song Status Code: ${response.statusCode}");
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Song Upload Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }
}
