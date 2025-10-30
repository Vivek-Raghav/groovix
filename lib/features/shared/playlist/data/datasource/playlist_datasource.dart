// Project imports:
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_update.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_list_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_query_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/user_playlist_params.dart';

abstract class PlaylistDatasource {
  Future<PlaylistModel> createPlaylist(UserPlaylistParams params);
  Future<PlaylistsListResponse> getPlaylistsList(PlaylistsQueryModel params);
  Future<PlaylistModel> getPlaylistById(String playlistId);
  Future<PlaylistModel> updatePlaylist(
      String playlistId, PlaylistUpdate update);
  Future<DeleteResponse> deletePlaylist(String playlistId);
  Future<AddSongsResponse> addSongsToPlaylist(
      String playlistId, AddSongsToPlaylistRequest request);
  Future<AddSongsResponse> removeSongsFromPlaylist(
      String playlistId, AddSongsToPlaylistRequest request);
  Future<PlaylistSongsResponse> getPlaylistSongs(String playlistId,
      {int? page, int? size});
}
