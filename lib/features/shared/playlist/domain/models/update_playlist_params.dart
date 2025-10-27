import 'package:groovix/features/shared/playlist/domain/models/playlist_update.dart';

class UpdatePlaylistParams {
  final String playlistId;
  final PlaylistUpdate update;

  const UpdatePlaylistParams({
    required this.playlistId,
    required this.update,
  });

  @override
  String toString() {
    return 'UpdatePlaylistParams(playlistId: $playlistId, update: $update)';
  }
}
