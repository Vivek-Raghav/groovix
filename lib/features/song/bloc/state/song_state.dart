import 'package:equatable/equatable.dart';
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
