import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/services/api/api_service.dart';
import 'package:groovix/core/services/api/api_urls.dart';
import 'package:groovix/core/error/server_exception.dart';
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/user_playlist_params.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_update.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_query_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_list_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_songs_response.dart';
import 'package:groovix/injection_container/injection_index.dart';
import 'playlist_datasource.dart';

class PlaylistRemoteDatasourceImpl implements PlaylistDatasource {
  final ApiService _apiService = getIt<ApiService>();

  @override
  Future<PlaylistModel> createPlaylist(UserPlaylistParams params) async {
    try {
      final response = await _apiService.postMultipart(
        url: ApiUrls.playlistsCreate,
        files: {
          'cover_url': params.coverFile,
        },
        fields: {
          'name': params.name,
          'bio': params.bio,
          'is_public': params.isPublic.toString(),
        },
      );

      if (response.statusCode == 201) {
        return PlaylistModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to create playlist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<PlaylistsListResponse> getPlaylistsList(
      PlaylistsQueryModel params) async {
    try {
      final response = await _apiService.get(
        ApiUrls.playlistsList,
        queryParams: params.toJson(),
      );

      if (response.statusCode == 200) {
        return PlaylistsListResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to get playlists list: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<PlaylistModel> getPlaylistById(String playlistId) async {
    try {
      final response =
          await _apiService.get('${ApiUrls.playlistsBase}/$playlistId');

      if (response.statusCode == 200) {
        return PlaylistModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Playlist not found');
      } else {
        throw ServerException(
            error: 'Failed to get playlist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<PlaylistModel> updatePlaylist(
      String playlistId, PlaylistUpdate update) async {
    try {
      final response = await _apiService.put(
        url: '${ApiUrls.playlistsUpdate}/$playlistId',
        data: update.toJson(),
      );

      if (response.statusCode == 200) {
        return PlaylistModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Playlist not found');
      } else {
        throw ServerException(
            error: 'Failed to update playlist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<DeleteResponse> deletePlaylist(String playlistId) async {
    try {
      final response =
          await _apiService.delete('${ApiUrls.playlistsDelete}/$playlistId');
      if (response.statusCode == 200) {
        return DeleteResponse(
            message:
                response.data['message'] ?? 'Playlist deleted successfully');
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        throw ServerException(
            error: response.data["detail"] ?? 'Playlist not found');
      } else {
        throw ServerException(
            error: 'Failed to delete playlist: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(error: '$e');
    }
  }

  @override
  Future<AddSongsResponse> addSongsToPlaylist(
      String playlistId, AddSongsToPlaylistRequest request) async {
    try {
      final response = await _apiService.post(
        ApiUrls.playlistsAddSongs(playlistId),
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AddSongsResponse.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Playlist not found');
      } else if (response.statusCode == 403) {
        throw ServerException(
            error: 'You can only add songs to your own playlists');
      } else {
        throw ServerException(
            error: 'Failed to add songs to playlist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<AddSongsResponse> removeSongsFromPlaylist(
      String playlistId, AddSongsToPlaylistRequest request) async {
    try {
      final response = await _apiService.delete(
          ApiUrls.playlistsRemoveSongs(playlistId),
          data: request.toJson());

      if (response.statusCode == 200) {
        return AddSongsResponse.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Playlist not found');
      } else if (response.statusCode == 403) {
        throw ServerException(
            error: 'You can only remove songs from your own playlists');
      } else {
        throw ServerException(
            error:
                'Failed to remove songs from playlist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<PlaylistSongsResponse> getPlaylistSongs(String playlistId,
      {int? page, int? size}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (page != null) queryParams['page'] = page;
      if (size != null) queryParams['size'] = size;

      final response = await _apiService.get(
        ApiUrls.getPlaylistSongs(playlistId),
        queryParams: queryParams.isEmpty ? null : queryParams,
      );

      if (response.statusCode == 200) {
        return PlaylistSongsResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Playlist not found');
      } else if (response.statusCode == 403) {
        throw ServerException(error: 'You can only access your own playlists');
      } else {
        throw ServerException(
            error: 'Failed to get playlist songs: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }
}
