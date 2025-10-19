import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/genre_model.dart';
import '../../domain/usecase/genre_usecases.dart';

// Events
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

// States
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

// BLoC
class GenreBloc extends Bloc<GenreEvent, GenreState> {
  final GetAllGenresUseCase _getAllGenresUseCase;
  final SearchGenresUseCase _searchGenresUseCase;
  final CreateGenreUseCase _createGenreUseCase;
  final UpdateGenreUseCase _updateGenreUseCase;
  final DeleteGenreUseCase _deleteGenreUseCase;

  GenreBloc({
    required GetAllGenresUseCase getAllGenresUseCase,
    required SearchGenresUseCase searchGenresUseCase,
    required CreateGenreUseCase createGenreUseCase,
    required UpdateGenreUseCase updateGenreUseCase,
    required DeleteGenreUseCase deleteGenreUseCase,
  })  : _getAllGenresUseCase = getAllGenresUseCase,
        _searchGenresUseCase = searchGenresUseCase,
        _createGenreUseCase = createGenreUseCase,
        _updateGenreUseCase = updateGenreUseCase,
        _deleteGenreUseCase = deleteGenreUseCase,
        super(GenreInitial()) {
    on<LoadGenres>(_onLoadGenres);
    on<SearchGenres>(_onSearchGenres);
    on<CreateGenre>(_onCreateGenre);
    on<UpdateGenre>(_onUpdateGenre);
    on<DeleteGenre>(_onDeleteGenre);
  }

  Future<void> _onLoadGenres(LoadGenres event, Emitter<GenreState> emit) async {
    emit(GenreLoading());
    try {
      final genres = await _getAllGenresUseCase();
      emit(GenreLoaded(genres));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }

  Future<void> _onSearchGenres(
      SearchGenres event, Emitter<GenreState> emit) async {
    emit(GenreLoading());
    try {
      final genres = await _searchGenresUseCase(event.query);
      emit(GenreLoaded(genres));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }

  Future<void> _onCreateGenre(
      CreateGenre event, Emitter<GenreState> emit) async {
    try {
      final genre = await _createGenreUseCase(event.genre);
      emit(GenreCreated(genre));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }

  Future<void> _onUpdateGenre(
      UpdateGenre event, Emitter<GenreState> emit) async {
    try {
      final genre = await _updateGenreUseCase(event.genre);
      emit(GenreUpdated(genre));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }

  Future<void> _onDeleteGenre(
      DeleteGenre event, Emitter<GenreState> emit) async {
    try {
      await _deleteGenreUseCase(event.id);
      emit(GenreDeleted(event.id));
    } catch (e) {
      emit(GenreError(e.toString()));
    }
  }
}
