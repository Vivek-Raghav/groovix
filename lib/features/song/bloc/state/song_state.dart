import 'package:equatable/equatable.dart';
import 'package:groovix/features/song/domain/models/song_flag_response.dart';
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

class SongListLoading extends SongState {}

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
