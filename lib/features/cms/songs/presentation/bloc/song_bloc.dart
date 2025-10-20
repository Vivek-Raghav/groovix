import '../../../cms_index.dart';

class CmsSongBloc extends Bloc<SongEvent, CmsSongState> {
  final CmsSongRepository _songRepository;

  CmsSongBloc(this._songRepository,
      {required this.uploadSongUc, required this.songListUc})
      : super(CmsSongInitial()) {
    on<SearchSongs>(_onSearchSongs);
    on<UpdateSong>(_onUpdateSong);
    on<DeleteSong>(_onDeleteSong);
    on<LoadRecentSongs>(_onLoadRecentSongs);
    on<UploadSong>(_uploadSong);
    on<FetchSongList>(_loadSongList);
  }

  final UploadSongUc uploadSongUc;
  final SongListUc songListUc;

  Future<void> _loadSongList(
      FetchSongList event, Emitter<CmsSongState> emit) async {
    emit(CmsSongLoading());
    final response = await songListUc.call(event.songsQueryModel);
    response.fold((failure) => emit(CmsSongError(failure.toString())),
        (response) => emit(CmsSongLoaded(response.songs)));
  }

  Future<void> _uploadSong(UploadSong event, Emitter<CmsSongState> emit) async {
    emit(UploadCmsSongLoading());
    final result = await uploadSongUc.call(event.uploadSongModel);
    result.fold((failure) => emit(UploadSongFailure(error: failure.toString())),
        (success) => emit(UploadSongSuccess(uploadSongResponse: success)));
  }

  Future<void> _onSearchSongs(
      SearchSongs event, Emitter<CmsSongState> emit) async {
    emit(CmsSongLoading());
    try {
      final songs = await _songRepository.searchSongs(event.query);
      emit(CmsSongLoaded(songs));
    } catch (e) {
      emit(CmsSongError(e.toString()));
    }
  }

  Future<void> _onUpdateSong(
      UpdateSong event, Emitter<CmsSongState> emit) async {
    try {
      final song = await _songRepository.updateSong(event.song);
      emit(CmsSongUpdated(song));
    } catch (e) {
      emit(CmsSongError(e.toString()));
    }
  }

  Future<void> _onDeleteSong(
      DeleteSong event, Emitter<CmsSongState> emit) async {
    try {
      await _songRepository.deleteSong(event.songId);
      emit(SongDeleted(event.songId));
    } catch (e) {
      emit(CmsSongError(e.toString()));
    }
  }

  Future<void> _onLoadRecentSongs(
      LoadRecentSongs event, Emitter<CmsSongState> emit) async {
    try {
      final songs = await _songRepository.getRecentSongs(limit: event.limit);
      emit(CmsSongLoaded(songs));
    } catch (e) {
      emit(CmsSongError(e.toString()));
    }
  }
}
