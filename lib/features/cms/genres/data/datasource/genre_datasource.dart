// Project imports:
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_to_genre_request.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_params.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_update.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_list_response.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';

abstract class GenreDatasource {
  Future<GenreModel> createGenre(GenreParams params);
  Future<GenresListResponse> getGenresList(GenresQueryModel params);
  Future<GenreModel> getGenreById(String genreId);
  Future<GenreModel> updateGenre(String genreId, GenreUpdate update);
  Future<DeleteResponse> deleteGenre(String genreId);
  Future<AssignSongsResponse> assignSongsToGenre(
      String genreId, AssignSongsToGenreRequest request);
  Future<AssignSongsResponse> removeSongsFromGenre(
      String genreId, AssignSongsToGenreRequest request);
  Future<GenreSongsResponse> getGenreSongs(String genreId,
      {int? page, int? size});
}
