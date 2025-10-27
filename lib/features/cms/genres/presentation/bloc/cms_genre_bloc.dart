import 'package:groovix/core/error/failure.dart';
import 'package:groovix/features/cms/genres/domain/usecase/create_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/get_genres_list_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/get_genre_by_id_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/update_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/delete_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/assign_songs_to_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/remove_songs_from_genre_uc.dart';
import 'package:groovix/features/cms/genres/domain/usecase/get_genre_songs_uc.dart';
import 'package:groovix/features/cms/genres/domain/models/genres_query_model.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_event.dart';
import 'package:groovix/features/cms/genres/presentation/bloc/cms_genre_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CmsGenreBloc extends Bloc<GenreEvent, CmsGenreState> {
  final CreateGenreUc _createGenreUc;
  final GetGenresListUc _getGenresListUc;
  final GetGenreByIdUc _getGenreByIdUc;
  final UpdateGenreUc _updateGenreUc;
  final DeleteGenreUc _deleteGenreUc;
  final AssignSongsToGenreUc _assignSongsToGenreUc;
  final RemoveSongsFromGenreUc _removeSongsFromGenreUc;
  final GetGenreSongsUc _getGenreSongsUc;

  CmsGenreBloc({
    required CreateGenreUc createGenreUc,
    required GetGenresListUc getGenresListUc,
    required GetGenreByIdUc getGenreByIdUc,
    required UpdateGenreUc updateGenreUc,
    required DeleteGenreUc deleteGenreUc,
    required AssignSongsToGenreUc assignSongsToGenreUc,
    required RemoveSongsFromGenreUc removeSongsFromGenreUc,
    required GetGenreSongsUc getGenreSongsUc,
  })  : _createGenreUc = createGenreUc,
        _getGenresListUc = getGenresListUc,
        _getGenreByIdUc = getGenreByIdUc,
        _updateGenreUc = updateGenreUc,
        _deleteGenreUc = deleteGenreUc,
        _assignSongsToGenreUc = assignSongsToGenreUc,
        _removeSongsFromGenreUc = removeSongsFromGenreUc,
        _getGenreSongsUc = getGenreSongsUc,
        super(CmsGenreInitial()) {
    on<FetchGenresList>(_onFetchGenresList);
    on<GetGenreById>(_onGetGenreById);
    on<CreateGenre>(_onCreateGenre);
    on<UpdateGenre>(_onUpdateGenre);
    on<DeleteGenre>(_onDeleteGenre);
    on<AssignSongsToGenre>(_onAssignSongsToGenre);
    on<RemoveSongsFromGenre>(_onRemoveSongsFromGenre);
    on<FetchGenreSongs>(_onFetchGenreSongs);
  }

  Future<void> _onFetchGenresList(
      FetchGenresList event, Emitter<CmsGenreState> emit) async {
    emit(CmsGenreLoading());
    final result = await _getGenresListUc(event.genresQueryModel);
    result.fold(
      (failure) => emit(CmsGenreError(_mapFailureToMessage(failure))),
      (response) => emit(CmsGenreLoaded(response.genres)),
    );
  }

  Future<void> _onGetGenreById(
      GetGenreById event, Emitter<CmsGenreState> emit) async {
    emit(CmsGenreLoading());
    final result = await _getGenreByIdUc(event.genreId);
    result.fold(
      (failure) => emit(CmsGenreError(_mapFailureToMessage(failure))),
      (genre) => emit(CmsGenreLoaded([genre])),
    );
  }

  Future<void> _onCreateGenre(
      CreateGenre event, Emitter<CmsGenreState> emit) async {
    emit(CreateGenreLoading());
    final result = await _createGenreUc(event.genreParams);
    result.fold(
      (failure) => emit(CreateGenreError(_mapFailureToMessage(failure))),
      (genre) {
        emit(CreateGenreLoaded(genre));
        add(FetchGenresList(GenresQueryModel(page: 1, size: 100)));
      },
    );
  }

  Future<void> _onUpdateGenre(
      UpdateGenre event, Emitter<CmsGenreState> emit) async {
    emit(UpdateGenreLoading());
    final result = await _updateGenreUc(event.updateGenreParams);
    result.fold(
      (failure) => emit(UpdateGenreError(_mapFailureToMessage(failure))),
      (genre) {
        emit(UpdateGenreLoaded(genre));
        add(FetchGenresList(GenresQueryModel(page: 1, size: 100)));
      },
    );
  }

  Future<void> _onDeleteGenre(
      DeleteGenre event, Emitter<CmsGenreState> emit) async {
    emit(DeleteGenreLoading());
    final result = await _deleteGenreUc(event.genreId);
    result.fold(
      (failure) => emit(GenreDeletedError(_mapFailureToMessage(failure))),
      (_) {
        emit(GenreDeletedSuccess(event.genreId));
        add(FetchGenresList(GenresQueryModel(page: 1, size: 100)));
      },
    );
  }

  Future<void> _onAssignSongsToGenre(
      AssignSongsToGenre event, Emitter<CmsGenreState> emit) async {
    emit(AssignSongsToGenreLoading());
    final result = await _assignSongsToGenreUc({
      'genreId': event.genreId,
      'request': event.request,
    });
    result.fold(
      (failure) => emit(AssignSongsToGenreError(_mapFailureToMessage(failure))),
      (response) => emit(AssignSongsToGenreLoaded(response)),
    );
  }

  Future<void> _onRemoveSongsFromGenre(
      RemoveSongsFromGenre event, Emitter<CmsGenreState> emit) async {
    emit(RemoveSongsFromGenreLoading());
    final result = await _removeSongsFromGenreUc({
      'genreId': event.genreId,
      'request': event.request,
    });
    result.fold(
      (failure) =>
          emit(RemoveSongsFromGenreError(_mapFailureToMessage(failure))),
      (response) => emit(RemoveSongsFromGenreLoaded(response)),
    );
  }

  Future<void> _onFetchGenreSongs(
      FetchGenreSongs event, Emitter<CmsGenreState> emit) async {
    emit(GetGenreSongsLoading());
    final result = await _getGenreSongsUc({
      'genreId': event.genreId,
      'page': event.page ?? 1,
      'size': event.size ?? 10,
    });
    result.fold(
      (failure) => emit(GetGenreSongsError(_mapFailureToMessage(failure))),
      (response) => emit(GetGenreSongsLoaded(response.songs)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).error ?? 'Server error occurred';
      case GeneralFailure:
        return (failure as GeneralFailure).error;
      default:
        return 'Unexpected error occurred';
    }
  }
}
