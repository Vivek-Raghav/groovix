import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_songs_response.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';

class GetPlaylistSongsUc
    extends UseCase<PlaylistSongsResponse, Map<String, dynamic>> {
  GetPlaylistSongsUc({required this.playlistRepository});
  final PlaylistRepository playlistRepository;

  @override
  EitherDynamic<PlaylistSongsResponse> call(Map<String, dynamic> params) {
    final String playlistId = params['playlistId'] as String;
    final int? page = params['page'] as int?;
    final int? size = params['size'] as int?;
    return playlistRepository.getPlaylistSongs(playlistId,
        page: page, size: size);
  }
}
