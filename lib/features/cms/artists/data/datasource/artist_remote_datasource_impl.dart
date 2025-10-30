// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class ArtistRemoteDatasourceImpl implements ArtistDatasource {
  final ApiService _apiService;

  ArtistRemoteDatasourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<ArtistModel> createArtist(ArtistParams params) async {
    try {
      final response = await _apiService.postMultipart(
        url: ApiUrls.artistsCreate,
        files: {
          'avatar_url': params.avatarFile,
        },
        fields: {
          'name': params.name,
          'bio': params.bio,
        },
      );

      if (response.statusCode == 201) {
        return ArtistModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to create artist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<ArtistsListResponse> getArtistsList(ArtistsQueryModel params) async {
    try {
      final response = await _apiService.get(
        ApiUrls.artistsList,
        queryParams: params.toJson(),
      );

      if (response.statusCode == 200) {
        return ArtistsListResponse.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
            error: 'Failed to get artists list: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<ArtistModel> getArtistById(String artistId) async {
    try {
      final response = await _apiService.get(
        '${ApiUrls.artistsBase}/$artistId',
      );

      if (response.statusCode == 200) {
        return ArtistModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Artist not found');
      } else {
        throw ServerException(
            error: 'Failed to get artist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<ArtistModel> updateArtist(String artistId, ArtistUpdate update) async {
    try {
      final response = await _apiService.put(
        url: '${ApiUrls.artistsUpdate}/$artistId',
        data: update.toJson(),
      );

      if (response.statusCode == 200) {
        return ArtistModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Artist not found');
      } else {
        throw ServerException(
            error: 'Failed to update artist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }

  @override
  Future<DeleteResponse> deleteArtist(String artistId) async {
    try {
      final response = await _apiService.delete(
        '${ApiUrls.artistsDelete}/$artistId',
      );

      if (response.statusCode == 200) {
        return DeleteResponse.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 404) {
        throw ServerException(error: 'Artist not found');
      } else {
        throw ServerException(
            error: 'Failed to delete artist: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(error: 'Network error: ${e.toString()}');
    } catch (e) {
      throw ServerException(error: 'Unexpected error: $e');
    }
  }
}
