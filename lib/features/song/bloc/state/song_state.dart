import 'package:equatable/equatable.dart';
import 'package:groovix/features/song/song_index.dart';

abstract class SongState extends Equatable {
  const SongState();
  @override
  List<Object?> get props => [];
}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongSuccess extends SongState {
  final UploadSongResponse uploadSongResponse;
  const SongSuccess({required this.uploadSongResponse});
  @override
  List<Object?> get props => [uploadSongResponse];
}

class SongFailure extends SongState {
  final String error;
  const SongFailure({required this.error});
  @override
  List<Object?> get props => [error];
}

// song list state
class SongListSuccess extends SongState {
  final SongsListResponse songsListResponse;
  const SongListSuccess({required this.songsListResponse});
  @override
  List<Object?> get props => [songsListResponse];
}

class SongListFailure extends SongState {
  final String error;
  const SongListFailure({required this.error});
  @override
  List<Object?> get props => [error];
}

class SongListLoading extends SongState {}

class SongFlagsLoading extends SongState {}

class SongFlagsSuccess extends SongState {
  final UserSongFlagsResponse songFlagsResponse;
  const SongFlagsSuccess({required this.songFlagsResponse});
  @override
  List<Object?> get props => [songFlagsResponse];
}

class SongFlagsFailure extends SongState {
  final String error;
  const SongFlagsFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
