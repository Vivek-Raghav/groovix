// States

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import "package:groovix/features/cms/cms_index.dart";

abstract class CmsSongState extends Equatable {
  const CmsSongState();
  @override
  List<Object> get props => [];
}

class CmsSongInitial extends CmsSongState {}

// Get All Songs

class CmsSongLoading extends CmsSongState {}

class CmsSongLoaded extends CmsSongState {
  final List<SongModel> songs;
  const CmsSongLoaded(this.songs);
}

class CmsSongError extends CmsSongState {
  final String message;
  const CmsSongError(this.message);
}

// Delete Song states

class SongDeletedLoading extends CmsSongState {}

class SongDeleted extends CmsSongState {
  final String songId;
  const SongDeleted(this.songId);
}

class SongDeletedError extends CmsSongState {
  final String message;
  const SongDeletedError(this.message);
}

// Upload Song states

class UploadCmsSongLoading extends CmsSongState {}

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

// Update Song Fields states

class UpdateSongFieldsLoading extends CmsSongState {}

class UpdateSongFieldsSuccess extends CmsSongState {
  final SongModel song;
  const UpdateSongFieldsSuccess(this.song);
  @override
  List<Object> get props => [song];
}

class UpdateSongFieldsFailure extends CmsSongState {
  final String error;
  const UpdateSongFieldsFailure({required this.error});
  @override
  List<Object> get props => [error];
}
