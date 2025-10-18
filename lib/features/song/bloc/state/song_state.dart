import 'package:equatable/equatable.dart';
import 'package:groovix/features/song/song_index.dart';

abstract class SongState extends Equatable {
  const SongState();
  @override
  List<Object?> get props => [];
}

class SongInitial extends SongState {}

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
