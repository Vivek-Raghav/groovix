// Project imports:
import 'package:groovix/core/error/server_exception.dart';
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/core/services/api/api_service.dart';
import 'package:groovix/core/services/api/api_urls.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_to_genre_request.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_params.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_update.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_list_response.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';
import 'package:groovix/injection_container/injection_index.dart';
import 'genre_datasource.dart';

class GenreRemoteDatasourceImpl implements GenreDatasource {
  final ApiService _apiService = getIt<ApiService>();

  @override
  Future<GenreModel> createGenre(GenreParams params) async {
    try {
      final response = await _apiService.postMultipart(
        url: ApiUrls.genresCreate,
        files: {
          'cover_url': params.coverFile,
        },
        fields: {
          'name': params.name,
          'bio': params.bio,
        },
      );

      if (response.statusCode == 201) {
        return GenreModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to create genre: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<GenresListResponse> getGenresList(GenresQueryModel params) async {
    try {
      final response = await _apiService.get(
        ApiUrls.genresList,
        queryParams: params.toJson(),
      );

      if (response.statusCode == 200) {
        return GenresListResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to get genres list: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<GenreModel> getGenreById(String genreId) async {
    try {
      final response = await _apiService.get('${ApiUrls.genresBase}/$genreId');

      if (response.statusCode == 200) {
        return GenreModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Genre not found');
      } else {
        throw ServerException(
            error: 'Failed to get genre: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<GenreModel> updateGenre(String genreId, GenreUpdate update) async {
    try {
      final response = await _apiService.put(
        url: '${ApiUrls.genresUpdate}/$genreId',
        data: update.toJson(),
      );

      if (response.statusCode == 200) {
        return GenreModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Genre not found');
      } else {
        throw ServerException(
            error: 'Failed to update genre: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<DeleteResponse> deleteGenre(String genreId) async {
    try {
      final response =
          await _apiService.delete('${ApiUrls.genresDelete}/$genreId');

      if (response.statusCode == 200) {
        return DeleteResponse(
            message: response.data['message'] ?? 'Genre deleted successfully');
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Genre not found');
      } else {
        throw ServerException(
            error: 'Failed to delete genre: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<AssignSongsResponse> assignSongsToGenre(
      String genreId, AssignSongsToGenreRequest request) async {
    try {
      final response = await _apiService.post(
        ApiUrls.genresAssignSongs(genreId),
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AssignSongsResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to assign songs to genre: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<AssignSongsResponse> removeSongsFromGenre(
      String genreId, AssignSongsToGenreRequest request) async {
    try {
      final response = await _apiService.delete(
        ApiUrls.genresRemoveSongs(genreId),
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return AssignSongsResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to remove songs from genre: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<GenreSongsResponse> getGenreSongs(String genreId,
      {int? page, int? size}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (page != null) queryParams['page'] = page;
      if (size != null) queryParams['size'] = size;

      final response = await _apiService.get(
        ApiUrls.getGenreSongs(genreId),
        queryParams: queryParams.isEmpty ? null : queryParams,
      );

      if (response.statusCode == 200) {
        return GenreSongsResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Genre not found');
      } else {
        throw ServerException(
            error: 'Failed to get genre songs: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }
}
