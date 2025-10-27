import 'package:groovix/core/utils/generic_typedef.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_query_model.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlists_list_response.dart';
import 'package:groovix/features/shared/playlist/domain/repositories/playlist_repository.dart';
import 'package:groovix/core/shared/domain/usecase/usecase.dart';

class GetPlaylistsListUc
    extends UseCase<PlaylistsListResponse, PlaylistsQueryModel> {
  GetPlaylistsListUc({required this.playlistRepository});
  final PlaylistRepository playlistRepository;

  @override
  EitherDynamic<PlaylistsListResponse> call(PlaylistsQueryModel params) =>
      playlistRepository.getPlaylistsList(params);
}
