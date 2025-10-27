import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/models/pagination_info.dart';

class PlaylistsListResponse {
  final List<PlaylistModel> playlists;
  final PaginationInfo pagination;

  const PlaylistsListResponse({
    required this.playlists,
    required this.pagination,
  });

  factory PlaylistsListResponse.fromJson(Map<String, dynamic> json) {
    return PlaylistsListResponse(
      playlists: (json['playlists'] as List)
          .map((playlist) => PlaylistModel.fromJson(playlist))
          .toList(),
      pagination: PaginationInfo.fromJson(json['pagination']),
    );
  }

  @override
  String toString() {
    return 'PlaylistsListResponse(playlists: ${playlists.length}, pagination: $pagination)';
  }
}
