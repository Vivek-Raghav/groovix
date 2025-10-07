import 'dart:convert';
import 'package:groovix/features/song/song_index.dart';

class SongRemoteDataSourceImpl extends SongRemoteDataSource {
  final LocalCache _cache = getIt<LocalCache>();
  final apiService = getIt<ApiService>();

  @override
  Future<UploadSongResponse> uploadSong(UploadSongModel params) async {
    final token = _cache.getString(PrefKeys.token);
    try {
      final response =
          await apiService.postMultipart(url: ApiUrls.uploadSong, files: {
        'song': params.song,
        'thumbnail': params.thumbnailFile,
      }, fields: {
        'artist': params.artist,
        'song_name': params.songName,
        'hexcode': params.hexcode,
      }, headers: {
        'Authorization': '$token',
      });
      if (response.statusCode == 201) {
        return UploadSongResponse.fromJson(response.data);
      } else {
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
