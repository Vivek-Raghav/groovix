// Project imports:
import 'package:groovix/core/models/pagination_info.dart';
import 'package:groovix/core/models/song_model.dart';

class SongsListResponse {
  final List<SongModel> songs;
  final PaginationInfo pagination;

  SongsListResponse({
    required this.songs,
    required this.pagination,
  });

  factory SongsListResponse.fromJson(Map<String, dynamic> json) {
    return SongsListResponse(
      songs: (json['songs'] as List<dynamic>?)
              ?.map((song) => SongModel.fromJson(song))
              .toList() ??
          [],
      pagination: PaginationInfo.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'songs': songs.map((song) => song.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}
