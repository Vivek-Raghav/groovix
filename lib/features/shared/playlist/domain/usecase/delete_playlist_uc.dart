// Project imports:
import 'package:groovix/core/models/delete_response.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';

class DeletePlaylistUc extends UseCase<DeleteResponse, String> {
  DeletePlaylistUc({required this.playlistRepository});
  final PlaylistRepository playlistRepository;

  @override
  EitherDynamic<DeleteResponse> call(String playlistId) =>
      playlistRepository.deletePlaylist(playlistId);
}
