// States
import 'package:equatable/equatable.dart';
import "package:groovix/features/cms/cms_index.dart";

abstract class CmsSongState extends Equatable {
  const CmsSongState();
  @override
  List<Object> get props => [];
}

class SongInitial extends CmsSongState {}

class SongLoading extends CmsSongState {}

class SongUploadLoading extends CmsSongState {}

class SongLoaded extends CmsSongState {
  final List<SongModel> songs;
  const SongLoaded(this.songs);
}

class SongError extends CmsSongState {
  final String message;
  const SongError(this.message);
}

class SongCreated extends CmsSongState {
  final SongModel song;
  const SongCreated(this.song);
}

class SongUpdated extends CmsSongState {
  final SongModel song;
  const SongUpdated(this.song);
}

class SongUploadSuccess extends CmsSongState {
  final SongModel song;
  const SongUploadSuccess(this.song);
}

class SongDeleted extends CmsSongState {
  final String songId;
  const SongDeleted(this.songId);
}

class UploadSongLoading extends CmsSongState {}

class UploadSongSuccess extends CmsSongState {
  final UploadSongResponse uploadSongResponse;
  const UploadSongSuccess({required this.uploadSongResponse});
  @override
  List<Object> get props => [uploadSongResponse];
}

class UploadSongFailure extends CmsSongState {
  final String error;
  const UploadSongFailure({required this.error});
  @override
  List<Object> get props => [error];
}
