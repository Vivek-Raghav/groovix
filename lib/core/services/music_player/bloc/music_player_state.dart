import 'package:equatable/equatable.dart';
import 'package:groovix/core/shared/model/song_model.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerState extends Equatable {
  final SongModel? currentSong;
  final bool isPlaying;
  final bool isLoading;
  final Duration position;
  final Duration duration;
  final bool isCompleted;
  final ProcessingState processingState;

  const MusicPlayerState({
    this.currentSong,
    this.isPlaying = false,
    this.isLoading = false,
    this.isCompleted = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.processingState = ProcessingState.idle,
  });

  MusicPlayerState copyWith({
    SongModel? currentSong,
    bool? isPlaying,
    bool? isLoading,
    bool? isCompleted,
    Duration? position,
    Duration? duration,
    ProcessingState? processingState,
  }) {
    return MusicPlayerState(
      currentSong: currentSong ?? this.currentSong,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      processingState: processingState ?? this.processingState,
    );
  }

  @override
  List<Object?> get props => [
        currentSong,
        isPlaying,
        isLoading,
        isCompleted,
        position,
        duration,
      ];
}
