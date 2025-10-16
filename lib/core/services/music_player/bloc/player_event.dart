import 'package:equatable/equatable.dart';
import 'package:groovix/core/shared/model/song_model.dart';
import 'package:just_audio/just_audio.dart';

abstract class MusicPlayerEvent extends Equatable {
  const MusicPlayerEvent();

  @override
  List<Object?> get props => [];
}

// User actions
class PlaySongEvent extends MusicPlayerEvent {
  final List<SongModel> songs;
  final int currentIndex;
  const PlaySongEvent(this.songs, this.currentIndex);

  @override
  List<Object?> get props => [songs];
}

class PauseSongEvent extends MusicPlayerEvent {}

class ResumeSongEvent extends MusicPlayerEvent {}

class SeekSongEvent extends MusicPlayerEvent {
  final Duration position;
  const SeekSongEvent(this.position);

  @override
  List<Object?> get props => [position];
}

class SongCompletedEvent extends MusicPlayerEvent {}

class SongPositionChangedEvent extends MusicPlayerEvent {
  final Duration position;
  const SongPositionChangedEvent(this.position);

  @override
  List<Object?> get props => [position];
}

class UpdatePlayerStateEvent extends MusicPlayerEvent {
  final Duration? position;
  final bool? isPlaying;
  final ProcessingState? processingState;
  const UpdatePlayerStateEvent(
      {this.position, this.isPlaying, this.processingState});

  @override
  List<Object?> get props => [position, isPlaying, processingState];
}

class NextSongEvent extends MusicPlayerEvent {}

class PreviousSongEvent extends MusicPlayerEvent {}

class CallFlagsEvent extends MusicPlayerEvent {
  final String songId;
  final String userId;
  const CallFlagsEvent(this.songId, this.userId);
}
