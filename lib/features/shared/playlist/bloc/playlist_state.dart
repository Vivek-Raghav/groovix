import 'package:equatable/equatable.dart';
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/models/song_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_response.dart';

abstract class PlaylistState extends Equatable {
  const PlaylistState();
  @override
  List<Object> get props => [];
}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<PlaylistModel> playlists;
  
  const PlaylistLoaded(this.playlists);
  @override
  List<Object> get props => [playlists];
}

class PlaylistError extends PlaylistState {
  final String message;
  const PlaylistError(this.message);
  @override
  List<Object> get props => [message];
}

class CreatePlaylistLoading extends PlaylistState {}

class CreatePlaylistLoaded extends PlaylistState {
  final PlaylistModel playlist;
  const CreatePlaylistLoaded(this.playlist);
  @override
  List<Object> get props => [playlist];
}

class CreatePlaylistError extends PlaylistState {
  final String message;
  const CreatePlaylistError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdatePlaylistLoading extends PlaylistState {}

class UpdatePlaylistLoaded extends PlaylistState {
  final PlaylistModel playlist;
  const UpdatePlaylistLoaded(this.playlist);
  @override
  List<Object> get props => [playlist];
}

class UpdatePlaylistError extends PlaylistState {
  final String message;
  const UpdatePlaylistError(this.message);
  @override
  List<Object> get props => [message];
}

class DeletePlaylistLoading extends PlaylistState {}

class PlaylistDeletedSuccess extends PlaylistState {
  final String playlistId;
  const PlaylistDeletedSuccess(this.playlistId);
  @override
  List<Object> get props => [playlistId];
}

class PlaylistDeletedError extends PlaylistState {
  final String message;
  const PlaylistDeletedError(this.message);
  @override
  List<Object> get props => [message];
}

// Add Songs States
class AddSongsToPlaylistLoading extends PlaylistState {}

class AddSongsToPlaylistLoaded extends PlaylistState {
  final AddSongsResponse response;
  const AddSongsToPlaylistLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class AddSongsToPlaylistError extends PlaylistState {
  final String message;
  const AddSongsToPlaylistError(this.message);
  @override
  List<Object> get props => [message];
}

// Remove Songs States
class RemoveSongsFromPlaylistLoading extends PlaylistState {}

class RemoveSongsFromPlaylistLoaded extends PlaylistState {
  final AddSongsResponse response;
  const RemoveSongsFromPlaylistLoaded(this.response);
  @override
  List<Object> get props => [response];
}

class RemoveSongsFromPlaylistError extends PlaylistState {
  final String message;
  const RemoveSongsFromPlaylistError(this.message);
  @override
  List<Object> get props => [message];
}

// Get Playlist Songs States
class GetPlaylistSongsLoading extends PlaylistState {}

class GetPlaylistSongsLoaded extends PlaylistState {
  final List<SongModel> songs;
  const GetPlaylistSongsLoaded(this.songs);
  @override
  List<Object> get props => [songs];
}

class GetPlaylistSongsError extends PlaylistState {
  final String message;
  const GetPlaylistSongsError(this.message);
  @override
  List<Object> get props => [message];
}
