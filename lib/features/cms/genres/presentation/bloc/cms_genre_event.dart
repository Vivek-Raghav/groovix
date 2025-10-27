import 'package:groovix/features/cms/genres/domain/models/genre_params.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';
import 'package:groovix/features/cms/genres/domain/models/update_genre_params.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_to_genre_request.dart';

abstract class GenreEvent {}

class FetchGenresList extends GenreEvent {
  final GenresQueryModel genresQueryModel;
  FetchGenresList(this.genresQueryModel);
}

class GetGenreById extends GenreEvent {
  final String genreId;
  GetGenreById(this.genreId);
}

class CreateGenre extends GenreEvent {
  final GenreParams genreParams;
  CreateGenre(this.genreParams);
}

class UpdateGenre extends GenreEvent {
  final String genreId;
  final UpdateGenreParams updateGenreParams;
  UpdateGenre(this.genreId, this.updateGenreParams);
}

class DeleteGenre extends GenreEvent {
  final String genreId;
  DeleteGenre(this.genreId);
}

class SearchGenres extends GenreEvent {
  final String query;
  SearchGenres(this.query);
}

class AssignSongsToGenre extends GenreEvent {
  final String genreId;
  final AssignSongsToGenreRequest request;
  AssignSongsToGenre(this.genreId, this.request);
}

class RemoveSongsFromGenre extends GenreEvent {
  final String genreId;
  final AssignSongsToGenreRequest request;
  RemoveSongsFromGenre(this.genreId, this.request);
}

class FetchGenreSongs extends GenreEvent {
  final String genreId;
  final int? page;
  final int? size;
  FetchGenreSongs(this.genreId, {this.page, this.size});
}
