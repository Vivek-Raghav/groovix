// Project imports:
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';
import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/models/update_playlist_params.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';

class UpdatePlaylistUc extends UseCase<PlaylistModel, UpdatePlaylistParams> {
  UpdatePlaylistUc({required this.playlistRepository});
  final PlaylistRepository playlistRepository;

  @override
  EitherDynamic<PlaylistModel> call(UpdatePlaylistParams params) =>
      playlistRepository.updatePlaylist(params.playlistId, params.update);
}
