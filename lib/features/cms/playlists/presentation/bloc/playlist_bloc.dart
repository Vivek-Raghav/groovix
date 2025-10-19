import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/playlist_model.dart';
import '../../domain/usecase/playlist_usecases.dart';

// Events
abstract class PlaylistEvent {}

class LoadPlaylists extends PlaylistEvent {}

class SearchPlaylists extends PlaylistEvent {
  final String query;
  SearchPlaylists(this.query);
}

class CreatePlaylist extends PlaylistEvent {
  final PlaylistModel playlist;
  CreatePlaylist(this.playlist);
}

class UpdatePlaylist extends PlaylistEvent {
  final PlaylistModel playlist;
  UpdatePlaylist(this.playlist);
}

class DeletePlaylist extends PlaylistEvent {
  final String id;
  DeletePlaylist(this.id);
}

// States
abstract class PlaylistState {}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<PlaylistModel> playlists;
  PlaylistLoaded(this.playlists);
}

class PlaylistError extends PlaylistState {
  final String message;
  PlaylistError(this.message);
}

class PlaylistCreated extends PlaylistState {
  final PlaylistModel playlist;
  PlaylistCreated(this.playlist);
}

class PlaylistUpdated extends PlaylistState {
  final PlaylistModel playlist;
  PlaylistUpdated(this.playlist);
}

class PlaylistDeleted extends PlaylistState {
  final String id;
  PlaylistDeleted(this.id);
}

// BLoC
class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  final GetAllPlaylistsUseCase _getAllPlaylistsUseCase;
  final SearchPlaylistsUseCase _searchPlaylistsUseCase;
  final CreatePlaylistUseCase _createPlaylistUseCase;
  final UpdatePlaylistUseCase _updatePlaylistUseCase;
  final DeletePlaylistUseCase _deletePlaylistUseCase;

  PlaylistBloc({
    required GetAllPlaylistsUseCase getAllPlaylistsUseCase,
    required SearchPlaylistsUseCase searchPlaylistsUseCase,
    required CreatePlaylistUseCase createPlaylistUseCase,
    required UpdatePlaylistUseCase updatePlaylistUseCase,
    required DeletePlaylistUseCase deletePlaylistUseCase,
  })  : _getAllPlaylistsUseCase = getAllPlaylistsUseCase,
        _searchPlaylistsUseCase = searchPlaylistsUseCase,
        _createPlaylistUseCase = createPlaylistUseCase,
        _updatePlaylistUseCase = updatePlaylistUseCase,
        _deletePlaylistUseCase = deletePlaylistUseCase,
        super(PlaylistInitial()) {
    on<LoadPlaylists>(_onLoadPlaylists);
    on<SearchPlaylists>(_onSearchPlaylists);
    on<CreatePlaylist>(_onCreatePlaylist);
    on<UpdatePlaylist>(_onUpdatePlaylist);
    on<DeletePlaylist>(_onDeletePlaylist);
  }

  Future<void> _onLoadPlaylists(
      LoadPlaylists event, Emitter<PlaylistState> emit) async {
    emit(PlaylistLoading());
    try {
      final playlists = await _getAllPlaylistsUseCase();
      emit(PlaylistLoaded(playlists));
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }

  Future<void> _onSearchPlaylists(
      SearchPlaylists event, Emitter<PlaylistState> emit) async {
    emit(PlaylistLoading());
    try {
      final playlists = await _searchPlaylistsUseCase(event.query);
      emit(PlaylistLoaded(playlists));
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }

  Future<void> _onCreatePlaylist(
      CreatePlaylist event, Emitter<PlaylistState> emit) async {
    try {
      final playlist = await _createPlaylistUseCase(event.playlist);
      emit(PlaylistCreated(playlist));
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }

  Future<void> _onUpdatePlaylist(
      UpdatePlaylist event, Emitter<PlaylistState> emit) async {
    try {
      final playlist = await _updatePlaylistUseCase(event.playlist);
      emit(PlaylistUpdated(playlist));
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }

  Future<void> _onDeletePlaylist(
      DeletePlaylist event, Emitter<PlaylistState> emit) async {
    try {
      await _deletePlaylistUseCase(event.id);
      emit(PlaylistDeleted(event.id));
    } catch (e) {
      emit(PlaylistError(e.toString()));
    }
  }
}
