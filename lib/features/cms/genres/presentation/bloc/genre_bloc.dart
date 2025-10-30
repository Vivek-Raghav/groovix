// Project imports:
import 'package:groovix/core/models/genre_model.dart';

abstract class GenreEvent {}

class LoadGenres extends GenreEvent {}

class SearchGenres extends GenreEvent {
  final String query;
  SearchGenres(this.query);
}

class CreateGenre extends GenreEvent {
  final GenreModel genre;
  CreateGenre(this.genre);
}

class UpdateGenre extends GenreEvent {
  final GenreModel genre;
  UpdateGenre(this.genre);
}

class DeleteGenre extends GenreEvent {
  final String id;
  DeleteGenre(this.id);
}

abstract class GenreState {}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final List<GenreModel> genres;
  GenreLoaded(this.genres);
}

class GenreError extends GenreState {
  final String message;
  GenreError(this.message);
}

class GenreCreated extends GenreState {
  final GenreModel genre;
  GenreCreated(this.genre);
}

class GenreUpdated extends GenreState {
  final GenreModel genre;
  GenreUpdated(this.genre);
}

class GenreDeleted extends GenreState {
  final String id;
  GenreDeleted(this.id);
}
