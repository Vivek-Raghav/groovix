import 'package:groovix/core/error/failure.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_query_model.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/create_playlist_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/get_playlists_list_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/get_playlist_by_id_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/update_playlist_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/delete_playlist_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/add_songs_to_playlist_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/remove_songs_from_playlist_uc.dart';
import 'package:groovix/features/shared/playlist/domain/usecase/get_playlist_songs_uc.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_event.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final CreatePlaylistUc _createPlaylistUc;
  final GetPlaylistsListUc _getPlaylistsListUc;
  final GetPlaylistByIdUc _getPlaylistByIdUc;
  final UpdatePlaylistUc _updatePlaylistUc;
  final DeletePlaylistUc _deletePlaylistUc;
  final AddSongsToPlaylistUc _addSongsToPlaylistUc;
  final RemoveSongsFromPlaylistUc _removeSongsFromPlaylistUc;
  final GetPlaylistSongsUc _getPlaylistSongsUc;

  PlaylistBloc({
    required CreatePlaylistUc createPlaylistUc,
    required GetPlaylistsListUc getPlaylistsListUc,
    required GetPlaylistByIdUc getPlaylistByIdUc,
    required UpdatePlaylistUc updatePlaylistUc,
    required DeletePlaylistUc deletePlaylistUc,
    required AddSongsToPlaylistUc addSongsToPlaylistUc,
    required RemoveSongsFromPlaylistUc removeSongsFromPlaylistUc,
    required GetPlaylistSongsUc getPlaylistSongsUc,
  })  : _createPlaylistUc = createPlaylistUc,
        _getPlaylistsListUc = getPlaylistsListUc,
        _getPlaylistByIdUc = getPlaylistByIdUc,
        _updatePlaylistUc = updatePlaylistUc,
        _deletePlaylistUc = deletePlaylistUc,
        _addSongsToPlaylistUc = addSongsToPlaylistUc,
        _removeSongsFromPlaylistUc = removeSongsFromPlaylistUc,
        _getPlaylistSongsUc = getPlaylistSongsUc,
        super(PlaylistInitial()) {
    on<FetchPlaylistsList>(_onFetchPlaylistsList);
    on<GetPlaylistById>(_onGetPlaylistById);
    on<CreatePlaylist>(_onCreatePlaylist);
    on<UpdatePlaylist>(_onUpdatePlaylist);
    on<DeletePlaylist>(_onDeletePlaylist);
    on<AddSongsToPlaylist>(_onAddSongsToPlaylist);
    on<RemoveSongsFromPlaylist>(_onRemoveSongsFromPlaylist);
    on<FetchPlaylistSongs>(_onFetchPlaylistSongs);
  }

  Future<void> _onFetchPlaylistsList(
      FetchPlaylistsList event, Emitter<PlaylistState> emit) async {
    emit(PlaylistLoading());
    final result = await _getPlaylistsListUc(event.playlistsQueryModel);
    result.fold(
      (failure) => emit(PlaylistError(_mapFailureToMessage(failure))),
      (response) => emit(PlaylistLoaded(response.playlists)),
    );
  }

  Future<void> _onGetPlaylistById(
      GetPlaylistById event, Emitter<PlaylistState> emit) async {
    emit(PlaylistLoading());
    final result = await _getPlaylistByIdUc(event.playlistId);
    result.fold(
      (failure) => emit(PlaylistError(_mapFailureToMessage(failure))),
      (playlist) => emit(PlaylistLoaded([playlist])),
    );
  }

  Future<void> _onCreatePlaylist(
      CreatePlaylist event, Emitter<PlaylistState> emit) async {
    emit(CreatePlaylistLoading());
    final result = await _createPlaylistUc(event.userPlaylistParams);
    result.fold(
      (failure) => emit(CreatePlaylistError(_mapFailureToMessage(failure))),
      (playlist) {
        emit(CreatePlaylistLoaded(playlist));
        add(FetchPlaylistsList(PlaylistsQueryModel(page: 1, size: 100)));
      },
    );
  }

  Future<void> _onUpdatePlaylist(
      UpdatePlaylist event, Emitter<PlaylistState> emit) async {
    emit(UpdatePlaylistLoading());
    final result = await _updatePlaylistUc(event.updatePlaylistParams);
    result.fold(
      (failure) => emit(UpdatePlaylistError(_mapFailureToMessage(failure))),
      (playlist) {
        emit(UpdatePlaylistLoaded(playlist));
        add(FetchPlaylistsList(PlaylistsQueryModel(page: 1, size: 100)));
      },
    );
  }

  Future<void> _onDeletePlaylist(
      DeletePlaylist event, Emitter<PlaylistState> emit) async {
    emit(DeletePlaylistLoading());
    final result = await _deletePlaylistUc(event.playlistId);
    result.fold(
      (failure) => emit(PlaylistDeletedError(_mapFailureToMessage(failure))),
      (_) {
        emit(PlaylistDeletedSuccess(event.playlistId));
        add(FetchPlaylistsList(PlaylistsQueryModel(page: 1, size: 100)));
      },
    );
  }

  Future<void> _onAddSongsToPlaylist(
      AddSongsToPlaylist event, Emitter<PlaylistState> emit) async {
    emit(AddSongsToPlaylistLoading());
    final result = await _addSongsToPlaylistUc({
      'playlistId': event.playlistId,
      'request': event.request,
    });
    result.fold(
      (failure) => emit(AddSongsToPlaylistError(_mapFailureToMessage(failure))),
      (response) => emit(AddSongsToPlaylistLoaded(response)),
    );
  }

  Future<void> _onRemoveSongsFromPlaylist(
      RemoveSongsFromPlaylist event, Emitter<PlaylistState> emit) async {
    emit(RemoveSongsFromPlaylistLoading());
    final result = await _removeSongsFromPlaylistUc({
      'playlistId': event.playlistId,
      'request': event.request,
    });
    result.fold(
      (failure) =>
          emit(RemoveSongsFromPlaylistError(_mapFailureToMessage(failure))),
      (response) => emit(RemoveSongsFromPlaylistLoaded(response)),
    );
  }

  Future<void> _onFetchPlaylistSongs(
      FetchPlaylistSongs event, Emitter<PlaylistState> emit) async {
    emit(GetPlaylistSongsLoading());
    final result = await _getPlaylistSongsUc({
      'playlistId': event.playlistId,
      'page': event.page,
      'size': event.size,
    });
    result.fold(
      (failure) => emit(GetPlaylistSongsError(_mapFailureToMessage(failure))),
      (response) => emit(GetPlaylistSongsLoaded(response.songs)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return (failure as ServerFailure).error ?? 'Server error occurred';
      case const (GeneralFailure):
        return (failure as GeneralFailure).error;
      default:
        return 'Unexpected error occurred';
    }
  }
}
