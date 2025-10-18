import '../../cms_index.dart';

// Events
abstract class SongEvent {}

class LoadSongs extends SongEvent {}

class SearchSongs extends SongEvent {
  final String query;
  SearchSongs(this.query);
}

class CreateSong extends SongEvent {
  final SongModel song;
  CreateSong(this.song);
}

class UpdateSong extends SongEvent {
  final SongModel song;
  UpdateSong(this.song);
}

class DeleteSong extends SongEvent {
  final String songId;
  DeleteSong(this.songId);
}

class LoadRecentSongs extends SongEvent {
  final int limit;
  LoadRecentSongs({this.limit = 10});
}

// States
abstract class SongState {}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongLoaded extends SongState {
  final List<SongModel> songs;
  SongLoaded(this.songs);
}

class SongError extends SongState {
  final String message;
  SongError(this.message);
}

class SongCreated extends SongState {
  final SongModel song;
  SongCreated(this.song);
}

class SongUpdated extends SongState {
  final SongModel song;
  SongUpdated(this.song);
}

class SongDeleted extends SongState {
  final String songId;
  SongDeleted(this.songId);
}

// BLoC
class SongBloc extends Bloc<SongEvent, SongState> {
  final CMSSongRepository _songRepository;

  SongBloc(this._songRepository) : super(SongInitial()) {
    on<LoadSongs>(_onLoadSongs);
    on<SearchSongs>(_onSearchSongs);
    on<CreateSong>(_onCreateSong);
    on<UpdateSong>(_onUpdateSong);
    on<DeleteSong>(_onDeleteSong);
    on<LoadRecentSongs>(_onLoadRecentSongs);
  }

  Future<void> _onLoadSongs(LoadSongs event, Emitter<SongState> emit) async {
    emit(SongLoading());
    try {
      final songs = await _songRepository.getAllSongs();
      emit(SongLoaded(songs));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onSearchSongs(
      SearchSongs event, Emitter<SongState> emit) async {
    emit(SongLoading());
    try {
      final songs = await _songRepository.searchSongs(event.query);
      emit(SongLoaded(songs));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onCreateSong(CreateSong event, Emitter<SongState> emit) async {
    try {
      final song = await _songRepository.createSong(event.song);
      emit(SongCreated(song));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onUpdateSong(UpdateSong event, Emitter<SongState> emit) async {
    try {
      final song = await _songRepository.updateSong(event.song);
      emit(SongUpdated(song));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onDeleteSong(DeleteSong event, Emitter<SongState> emit) async {
    try {
      await _songRepository.deleteSong(event.songId);
      emit(SongDeleted(event.songId));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onLoadRecentSongs(
      LoadRecentSongs event, Emitter<SongState> emit) async {
    try {
      final songs = await _songRepository.getRecentSongs(limit: event.limit);
      emit(SongLoaded(songs));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }
}
