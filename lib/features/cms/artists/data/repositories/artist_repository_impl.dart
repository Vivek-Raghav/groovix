import 'package:dartz/dartz.dart';
import 'package:groovix/features/cms/cms_index.dart';

class ArtistRepositoryImpl implements ArtistRepository {
  final ArtistDatasource _datasource;

  ArtistRepositoryImpl({required ArtistDatasource datasource})
      : _datasource = datasource;

  @override
  EitherDynamic<ArtistModel> createArtist(ArtistParams params) async {
    try {
      final artist = await _datasource.createArtist(params);
      return Right(artist);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<ArtistsListResponse> getArtistsList(
      ArtistsQueryModel params) async {
    try {
      final response = await _datasource.getArtistsList(params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<ArtistModel> getArtistById(String artistId) async {
    try {
      final artist = await _datasource.getArtistById(artistId);
      return Right(artist);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<ArtistModel> updateArtist(
      String artistId, ArtistUpdate update) async {
    try {
      final artist = await _datasource.updateArtist(artistId, update);
      return Right(artist);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<DeleteResponse> deleteArtist(String artistId) async {
    try {
      final response = await _datasource.deleteArtist(artistId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
