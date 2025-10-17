import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:groovix/core/core_index.dart';
import 'package:groovix/features/song/domain/models/song_flags_params.dart';
import 'package:groovix/features/song/domain/usecase/get_song_flags_uc.dart';
import 'package:groovix/features/song/domain/usecase/update_song_flags_uc.dart';
import 'package:groovix/injection_container/injected/inject_blocs.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final MusicPlayerManager _manager;
  final UpdateSongFlagsUc updateSongFlagsUc;
  final GetSongFlagsUc getSongFlagsUc;
  StreamSubscription? _positionSub;
  StreamSubscription? _playerStateSub;

  MusicPlayerBloc(this._manager, this.updateSongFlagsUc, this.getSongFlagsUc)
      : super(const MusicPlayerState()) {
    on<PlaySongEvent>(_onPlaySong);
    on<PauseSongEvent>(_onPauseSong);
    on<ResumeSongEvent>(_onResumeSong);
    on<SeekSongEvent>(_onSeekSong);
    on<SongCompletedEvent>(_onSongCompleted);
    on<NextSongEvent>(_onNextSong);
    on<PreviousSongEvent>(_onPreviousSong);
    on<UpdatePlayerStateEvent>(_onUpdatePlayerState);
    on<LoadFlagsEvent>(_onLoadFlags);
    on<ToggleFavoriteEvent>(_toggleFavorite);
    _listenToStreams();
  }

  List<SongModel> loadedSongs = [];
  int currentIndex = 0;
  final userId = getIt<LocalCache>().getMap(PrefKeys.userDetails);

  void _listenToStreams() {
    _positionSub = _manager.positionStream.listen((pos) {
      if (state.processingState != ProcessingState.loading) {
        add(UpdatePlayerStateEvent(
            position: pos,
            isPlaying: state.isPlaying,
            processingState: state.processingState));
      }
    });

    _playerStateSub = _manager.playerStateStream.listen((playerState) {
      add(UpdatePlayerStateEvent(processingState: playerState.processingState));
      if (playerState.processingState == ProcessingState.completed) {
        add(SongCompletedEvent());
      } else if (playerState.processingState == ProcessingState.buffering) {
      } else if (playerState.processingState == ProcessingState.ready) {}
    });
  }

  Future<void> _onPlaySong(
      PlaySongEvent event, Emitter<MusicPlayerState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      if (loadedSongs.isEmpty ||
          loadedSongs.length != event.songs.length ||
          !listEquals(loadedSongs, event.songs)) {
        loadedSongs = event.songs;
      }
      currentIndex = event.currentIndex;
      await _manager.loadAndPlay(loadedSongs[event.currentIndex]);

      emit(state.copyWith(
          currentSong: loadedSongs[event.currentIndex],
          isPlaying: true,
          duration: _manager.duration,
          isLoading: false,
          isNext: currentIndex == (loadedSongs.length - 1) ? false : true,
          isPrevious: currentIndex == 0 ? false : true));
      add(const LoadFlagsEvent());
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onNextSong(
      NextSongEvent event, Emitter<MusicPlayerState> emit) async {
    if (state.isNext) {
      currentIndex++;
      await _manager.loadAndPlay(loadedSongs[currentIndex]);
      emit(state.copyWith(
          currentSong: loadedSongs[currentIndex],
          isPlaying: true,
          duration: _manager.duration,
          isLoading: false,
          isNext: currentIndex == (loadedSongs.length - 1) ? false : true,
          isPrevious: currentIndex == 0 ? false : true));
      add(const LoadFlagsEvent());
    }
  }

  Future<void> _onPreviousSong(
      PreviousSongEvent event, Emitter<MusicPlayerState> emit) async {
    if (state.isPrevious) {
      currentIndex--;
      await _manager.loadAndPlay(loadedSongs[currentIndex]);
      emit(state.copyWith(
          currentSong: loadedSongs[currentIndex],
          isPlaying: true,
          duration: _manager.duration,
          isLoading: false,
          isNext: currentIndex == (loadedSongs.length - 1) ? false : true,
          isPrevious: currentIndex == 0 ? false : true));
      add(const LoadFlagsEvent());
    }
  }

  void _onPauseSong(PauseSongEvent event, Emitter<MusicPlayerState> emit) {
    _manager.pause();
    emit(state.copyWith(isPlaying: false));
  }

  void _onResumeSong(ResumeSongEvent event, Emitter<MusicPlayerState> emit) {
    _manager.resume();
    emit(state.copyWith(isPlaying: true));
  }

  Future<void> _onSeekSong(
      SeekSongEvent event, Emitter<MusicPlayerState> emit) async {
    _manager.seek(event.position);
    emit(state.copyWith(position: event.position));
  }

  Future<void> _onSongCompleted(
      SongCompletedEvent event, Emitter<MusicPlayerState> emit) async {
    if (state.isNext) {
      add(NextSongEvent());
    } else {
      await _manager.stop();
      await _manager.seek(Duration.zero);
      emit(state.copyWith(isPlaying: false, position: Duration.zero));
    }
  }

  Future<void> _onUpdatePlayerState(
      UpdatePlayerStateEvent event, Emitter<MusicPlayerState> emit) async {
    emit(state.copyWith(
        position: event.position ?? state.position,
        isPlaying: event.isPlaying ?? state.isPlaying,
        processingState: event.processingState ?? state.processingState));
  }

  Future<void> _onLoadFlags(
      LoadFlagsEvent event, Emitter<MusicPlayerState> emit) async {
    final result = await getSongFlagsUc.call(GetSongFlagParams(
        songId: state.currentSong?.id ?? '', userId: userId?['id'] ?? ''));
    result.fold((failure) => emit(state.copyWith(isFavorite: false)),
        (success) => emit(state.copyWith(isFavorite: success.isLiked)));
  }

  Future<void> _toggleFavorite(
      ToggleFavoriteEvent event, Emitter<MusicPlayerState> emit) async {
    final result = await updateSongFlagsUc.call(UpdateSongFlagParams(
        songId: state.currentSong?.id ?? '',
        userId: userId?['id'] ?? '',
        isLiked: !state.isFavorite));
    result.fold((failure) => emit(state.copyWith(isFavorite: false)),
        (success) => emit(state.copyWith(isFavorite: success.isLiked)));
  }

  @override
  Future<void> close() {
    _positionSub?.cancel();
    _playerStateSub?.cancel();
    return super.close();
  }
}
