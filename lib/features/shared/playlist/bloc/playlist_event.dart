// Project imports:
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_query_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/update_playlist_params.dart';
import 'package:groovix/features/shared/playlist/domain/models/user_playlist_params.dart';

abstract class PlaylistEvent {}

class FetchPlaylistsList extends PlaylistEvent {
  final PlaylistsQueryModel playlistsQueryModel;
  FetchPlaylistsList(this.playlistsQueryModel);
}

class GetPlaylistById extends PlaylistEvent {
  final String playlistId;
  GetPlaylistById(this.playlistId);
}

class CreatePlaylist extends PlaylistEvent {
  final UserPlaylistParams userPlaylistParams;
  CreatePlaylist(this.userPlaylistParams);
}

class UpdatePlaylist extends PlaylistEvent {
  final String playlistId;
  final UpdatePlaylistParams updatePlaylistParams;
  UpdatePlaylist(this.playlistId, this.updatePlaylistParams);
}

class DeletePlaylist extends PlaylistEvent {
  final String playlistId;
  DeletePlaylist(this.playlistId);
}

class AddSongsToPlaylist extends PlaylistEvent {
  final String playlistId;
  final AddSongsToPlaylistRequest request;
  AddSongsToPlaylist(this.playlistId, this.request);
}

class RemoveSongsFromPlaylist extends PlaylistEvent {
  final String playlistId;
  final AddSongsToPlaylistRequest request;
  RemoveSongsFromPlaylist(this.playlistId, this.request);
}

class SearchPlaylists extends PlaylistEvent {
  final String query;
  SearchPlaylists(this.query);
}

class FetchPlaylistSongs extends PlaylistEvent {
  final String playlistId;
  final int? page;
  final int? size;
  FetchPlaylistSongs(this.playlistId, {this.page, this.size});
}
