import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_params.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_update.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_list_response.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_to_genre_request.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_response.dart';
import 'package:groovix/features/cms/genres/domain/models/genre_songs_response.dart';
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/core/utils/generic_typedef.dart';

abstract class GenreRepository {
  EitherDynamic<GenreModel> createGenre(GenreParams params);
  EitherDynamic<GenresListResponse> getGenresList(GenresQueryModel params);
  EitherDynamic<GenreModel> getGenreById(String genreId);
  EitherDynamic<GenreModel> updateGenre(String genreId, GenreUpdate update);
  EitherDynamic<DeleteResponse> deleteGenre(String genreId);
  EitherDynamic<AssignSongsResponse> assignSongsToGenre(
      String genreId, AssignSongsToGenreRequest request);
  EitherDynamic<AssignSongsResponse> removeSongsFromGenre(
      String genreId, AssignSongsToGenreRequest request);
  EitherDynamic<GenreSongsResponse> getGenreSongs(String genreId,
      {int? page, int? size});
}
