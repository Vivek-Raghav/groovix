// Project imports:
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/models/user_playlist_params.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';

class CreatePlaylistUc extends UseCase<PlaylistModel, UserPlaylistParams> {
  CreatePlaylistUc({required this.playlistRepository});
  final PlaylistRepository playlistRepository;

  @override
  EitherDynamic<PlaylistModel> call(UserPlaylistParams params) =>
      playlistRepository.createPlaylist(params);
}
