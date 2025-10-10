import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovix/core/services/music_player/bloc/music_player_state.dart';
import 'package:groovix/core/services/music_player/bloc/player_event.dart';
import 'package:groovix/core/services/music_player/music_player_manager.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final MusicPlayerManager _manager;
  StreamSubscription? _positionSub;
  StreamSubscription? _playerStateSub;

  MusicPlayerBloc(this._manager) : super(const MusicPlayerState()) {
    on<PlaySongEvent>(_onPlaySong);
    on<PauseSongEvent>(_onPauseSong);
    on<ResumeSongEvent>(_onResumeSong);
    on<SeekSongEvent>(_onSeekSong);
    on<SongCompletedEvent>(_onSongCompleted);
    on<UpdatePlayerStateEvent>(_onUpdatePlayerState);

    _listenToStreams();
  }

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
      }
    });
  }

  Future<void> _onPlaySong(
      PlaySongEvent event, Emitter<MusicPlayerState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _manager.loadAndPlay(event.song);

      emit(state.copyWith(
          currentSong: event.song,
          isPlaying: true,
          duration: _manager.duration,
          isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
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
    await _manager.stop();
    await _manager.seek(Duration.zero);
    emit(state.copyWith(isPlaying: false, position: Duration.zero));
  }

  Future<void> _onUpdatePlayerState(
      UpdatePlayerStateEvent event, Emitter<MusicPlayerState> emit) async {
    emit(state.copyWith(
      position: event.position ?? state.position,
      isPlaying: event.isPlaying ?? state.isPlaying,
      processingState: event.processingState ?? state.processingState,
    ));
  }

  @override
  Future<void> close() {
    _positionSub?.cancel();
    _playerStateSub?.cancel();
    return super.close();
  }
}
