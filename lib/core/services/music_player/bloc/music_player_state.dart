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
  final bool isNext;
  final bool isPrevious;
  final ProcessingState processingState;
  final bool isFavorite;
  const MusicPlayerState({
    this.currentSong,
    this.isPlaying = false,
    this.isLoading = false,
    this.isCompleted = false,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.processingState = ProcessingState.idle,
    this.isNext = true,
    this.isPrevious = true,
    this.isFavorite = false,
  });

  MusicPlayerState copyWith({
    SongModel? currentSong,
    bool? isPlaying,
    bool? isLoading,
    bool? isCompleted,
    Duration? position,
    Duration? duration,
    ProcessingState? processingState,
    bool? isNext,
    bool? isPrevious,
    bool? isFavorite,
  }) {
    return MusicPlayerState(
      currentSong: currentSong ?? this.currentSong,
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      processingState: processingState ?? this.processingState,
      isNext: isNext ?? this.isNext,
      isPrevious: isPrevious ?? this.isPrevious,
      isFavorite: isFavorite ?? this.isFavorite,
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
        isNext,
        isPrevious,
        isFavorite,
      ];
}
