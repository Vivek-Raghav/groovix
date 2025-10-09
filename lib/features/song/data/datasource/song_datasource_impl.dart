// Project imports:
import 'package:groovix/features/song/song_index.dart';

class SongRemoteDataSourceImpl extends SongRemoteDataSource {
  final apiService = getIt<ApiService>();

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
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Song Upload Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }

  @override
  Future<SongsListResponse> getSongList(SongsQueryModel params) async {
    try {
      final response = await apiService.get(ApiUrls.getSongList,
          queryParams: params.toJson());
      if (response.statusCode == 200) {
        return SongsListResponse.fromJson(response.data);
      } else {
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Song List Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }
}
