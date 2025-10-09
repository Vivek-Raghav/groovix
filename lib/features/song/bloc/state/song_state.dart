// Package imports:
import 'package:equatable/equatable.dart';
import 'package:groovix/features/song/domain/models/song_list_response.dart';

// Project imports:
import 'package:groovix/features/song/domain/models/upload_song_response.dart';

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
