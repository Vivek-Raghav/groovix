// Project imports:
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/models/add_songs_to_playlist_request.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';

class RemoveSongsFromPlaylistUc
    extends UseCase<AddSongsResponse, Map<String, dynamic>> {
  RemoveSongsFromPlaylistUc({required this.playlistRepository});
  final PlaylistRepository playlistRepository;

  @override
  EitherDynamic<AddSongsResponse> call(Map<String, dynamic> params) =>
      playlistRepository.removeSongsFromPlaylist(
        params['playlistId'] as String,
        params['request'] as AddSongsToPlaylistRequest,
      );
}
