import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';

class GetPlaylistByIdUc extends UseCase<PlaylistModel, String> {
  GetPlaylistByIdUc({required this.playlistRepository});
  final PlaylistRepository playlistRepository;

  @override
  EitherDynamic<PlaylistModel> call(String playlistId) =>
      playlistRepository.getPlaylistById(playlistId);
}
