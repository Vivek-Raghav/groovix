import 'package:dartz/dartz.dart';
import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/core/error/failure.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_params.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_update.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_list_response.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_to_genre_request.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_songs_response.dart';
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/features/cms/genres/data/datasource/genre_datasource.dart';
import 'package:groovix/features/cms/genres/domain/repositories/genre_repository.dart';

class GenreRepositoryImpl implements GenreRepository {
  final GenreDatasource _datasource;

  GenreRepositoryImpl({required GenreDatasource datasource})
      : _datasource = datasource;

  @override
  EitherDynamic<GenreModel> createGenre(GenreParams params) async {
    try {
      final genre = await _datasource.createGenre(params);
      return Right(genre);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<GenresListResponse> getGenresList(
      GenresQueryModel params) async {
    try {
      final response = await _datasource.getGenresList(params);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<GenreModel> getGenreById(String genreId) async {
    try {
      final genre = await _datasource.getGenreById(genreId);
      return Right(genre);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<GenreModel> updateGenre(
      String genreId, GenreUpdate update) async {
    try {
      final genre = await _datasource.updateGenre(genreId, update);
      return Right(genre);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<DeleteResponse> deleteGenre(String genreId) async {
    try {
      final response = await _datasource.deleteGenre(genreId);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<AssignSongsResponse> assignSongsToGenre(
      String genreId, AssignSongsToGenreRequest request) async {
    try {
      final response = await _datasource.assignSongsToGenre(genreId, request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<AssignSongsResponse> removeSongsFromGenre(
      String genreId, AssignSongsToGenreRequest request) async {
    try {
      final response = await _datasource.removeSongsFromGenre(genreId, request);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  EitherDynamic<GenreSongsResponse> getGenreSongs(String genreId,
      {int? page, int? size}) async {
    try {
      final response =
          await _datasource.getGenreSongs(genreId, page: page, size: size);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
