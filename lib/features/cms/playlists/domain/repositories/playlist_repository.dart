import '../models/playlist_model.dart';

abstract class PlaylistRepository {
  Future<List<PlaylistModel>> getAllPlaylists();
  Future<PlaylistModel?> getPlaylistById(String id);
  Future<List<PlaylistModel>> searchPlaylists(String query);
  Future<PlaylistModel> createPlaylist(PlaylistModel playlist);
  Future<PlaylistModel> updatePlaylist(PlaylistModel playlist);
  Future<void> deletePlaylist(String id);
}
