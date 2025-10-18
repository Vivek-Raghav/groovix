import 'package:groovix/features/cms/presentation/sections/songs/domain/usecase/upload_song_uc.dart';

import "package:groovix/features/cms/cms_index.dart";

class CmsSongBloc extends Bloc<SongEvent, CmsSongState> {
  final CmsSongRepository _songRepository;

  CmsSongBloc(this._songRepository, {required this.uploadSongUc})
      : super(SongInitial()) {
    on<LoadSongs>(_onLoadSongs);
    on<SearchSongs>(_onSearchSongs);
    on<CreateSong>(_onCreateSong);
    on<UpdateSong>(_onUpdateSong);
    on<DeleteSong>(_onDeleteSong);
    on<LoadRecentSongs>(_onLoadRecentSongs);
  }

  final UploadSongUc uploadSongUc;

  Future<void> uploadSong(UploadSongModel uploadSongModel) async {
    emit(SongUploadLoading());
    final result = await uploadSongUc.call(uploadSongModel);
    result.fold((failure) => emit(UploadSongFailure(error: failure.toString())),
        (success) => emit(UploadSongSuccess(uploadSongResponse: success)));
  }

  Future<void> _onLoadSongs(LoadSongs event, Emitter<CmsSongState> emit) async {
    emit(SongLoading());
    try {
      final songs = await _songRepository.getAllSongs();
      emit(SongLoaded(songs));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onSearchSongs(
      SearchSongs event, Emitter<CmsSongState> emit) async {
    emit(SongLoading());
    try {
      final songs = await _songRepository.searchSongs(event.query);
      emit(SongLoaded(songs));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onCreateSong(
      CreateSong event, Emitter<CmsSongState> emit) async {
    try {
      final song = await _songRepository.createSong(event.song);
      emit(SongCreated(song));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onUpdateSong(
      UpdateSong event, Emitter<CmsSongState> emit) async {
    try {
      final song = await _songRepository.updateSong(event.song);
      emit(SongUpdated(song));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onDeleteSong(
      DeleteSong event, Emitter<CmsSongState> emit) async {
    try {
      await _songRepository.deleteSong(event.songId);
      emit(SongDeleted(event.songId));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }

  Future<void> _onLoadRecentSongs(
      LoadRecentSongs event, Emitter<CmsSongState> emit) async {
    try {
      final songs = await _songRepository.getRecentSongs(limit: event.limit);
      emit(SongLoaded(songs));
    } catch (e) {
      emit(SongError(e.toString()));
    }
  }
}
