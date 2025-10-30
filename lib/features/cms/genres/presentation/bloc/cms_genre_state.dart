// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/core/models/song_model.dart';
import 'package:groovix/features/cms/genres/domain/models/assign_songs_response.dart';

abstract class CmsGenreState extends Equatable {
  const CmsGenreState();
  @override
  List<Object> get props => [];
}

class CmsGenreInitial extends CmsGenreState {}

class CmsGenreLoading extends CmsGenreState {}

class CmsGenreLoaded extends CmsGenreState {
  final List<GenreModel> genres;
  const CmsGenreLoaded(this.genres);
  @override
  List<Object> get props => [genres];
}

class CmsGenreError extends CmsGenreState {
  final String message;
  const CmsGenreError(this.message);
  @override
  List<Object> get props => [message];
}

class CreateGenreLoading extends CmsGenreState {}

class CreateGenreLoaded extends CmsGenreState {
  final GenreModel genre;
  const CreateGenreLoaded(this.genre);
  @override
  List<Object> get props => [genre];
}

class CreateGenreError extends CmsGenreState {
  final String message;
  const CreateGenreError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateGenreLoading extends CmsGenreState {}

class UpdateGenreLoaded extends CmsGenreState {
  final GenreModel genre;
  const UpdateGenreLoaded(this.genre);
  @override
  List<Object> get props => [genre];
}

class UpdateGenreError extends CmsGenreState {
  final String message;
  const UpdateGenreError(this.message);
  @override
  List<Object> get props => [message];
}

class DeleteGenreLoading extends CmsGenreState {}

class GenreDeletedSuccess extends CmsGenreState {
  final String genreId;
  const GenreDeletedSuccess(this.genreId);
  @override
  List<Object> get props => [genreId];
}

class GenreDeletedError extends CmsGenreState {
  final String message;
  const GenreDeletedError(this.message);
  @override
  List<Object> get props => [message];
}

class AssignSongsToGenreLoading extends CmsGenreState {}

class AssignSongsToGenreLoaded extends CmsGenreState {
  final AssignSongsResponse response;
  const AssignSongsToGenreLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class AssignSongsToGenreError extends CmsGenreState {
  final String message;
  const AssignSongsToGenreError(this.message);
  @override
  List<Object> get props => [message];
}

class RemoveSongsFromGenreLoading extends CmsGenreState {}

class RemoveSongsFromGenreLoaded extends CmsGenreState {
  final AssignSongsResponse response;
  const RemoveSongsFromGenreLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class RemoveSongsFromGenreError extends CmsGenreState {
  final String message;
  const RemoveSongsFromGenreError(this.message);
  @override
  List<Object> get props => [message];
}

// Get Genre Songs States
class GetGenreSongsLoading extends CmsGenreState {}

class GetGenreSongsLoaded extends CmsGenreState {
  final List<SongModel> songs;
  const GetGenreSongsLoaded(this.songs);
  @override
  List<Object> get props => [songs];
}

class GetGenreSongsError extends CmsGenreState {
  final String message;
  const GetGenreSongsError(this.message);
  @override
  List<Object> get props => [message];
}
