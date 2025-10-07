// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:groovix/features/song/domain/models/upload_song_model.dart';

abstract class SongEvent extends Equatable {
  const SongEvent();

  @override
  List<Object?> get props => [];
}

class UploadSongEvent extends SongEvent {
  final UploadSongModel uploadSongModel;
  const UploadSongEvent({required this.uploadSongModel});
  @override
  List<Object?> get props => [uploadSongModel];
}
