// Project imports:
import 'package:groovix/features/song/song_index.dart';

class SongRemoteDataSourceImpl extends SongRemoteDataSource {
  final apiService = getIt<ApiService>();

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

  @override
  Future<UserSongFlagsResponse> updateSongFlags(
      UpdateSongFlagParams params) async {
    try {
      final response =
          await apiService.post(ApiUrls.updateSongFlags, data: params.toJson());
      if (response.statusCode == 200) {
        return UserSongFlagsResponse.fromJson(response.data);
      } else {
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Song Flags Update Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }

  @override
  Future<UserSongFlagsResponse> getSongFlags(GetSongFlagParams params) async {
    try {
      final response = await apiService.get(
          "/flags/user/${params.userId}/song/${params.songId}",
          queryParams: params.toJson());
      if (response.statusCode == 200) {
        return UserSongFlagsResponse.fromJson(response.data);
      } else {
        return throw ServerException(
            error: StringConstants.strSomethingWentWrong);
      }
    } catch (e) {
      debugPrint("Song Flags Get Error: $e");
      return throw ServerException(
          error: StringConstants.strSomethingWentWrong);
    }
  }
}
