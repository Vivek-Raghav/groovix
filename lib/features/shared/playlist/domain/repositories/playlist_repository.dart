// Project imports:
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_update.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_list_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_query_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/user_playlist_params.dart';

abstract class PlaylistRepository {
  EitherDynamic<PlaylistModel> createPlaylist(UserPlaylistParams params);
  EitherDynamic<PlaylistsListResponse> getPlaylistsList(
      PlaylistsQueryModel params);
  EitherDynamic<PlaylistModel> getPlaylistById(String playlistId);
  EitherDynamic<PlaylistModel> updatePlaylist(
      String playlistId, PlaylistUpdate update);
  EitherDynamic<DeleteResponse> deletePlaylist(String playlistId);
  EitherDynamic<AddSongsResponse> addSongsToPlaylist(
      String playlistId, AddSongsToPlaylistRequest request);
  EitherDynamic<AddSongsResponse> removeSongsFromPlaylist(
      String playlistId, AddSongsToPlaylistRequest request);
  EitherDynamic<PlaylistSongsResponse> getPlaylistSongs(String playlistId,
      {int? page, int? size});
}
