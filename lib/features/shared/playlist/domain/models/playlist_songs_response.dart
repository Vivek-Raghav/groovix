import 'package:groovix/core/models/song_model.dart';
import 'package:groovix/core/models/pagination_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist_songs_response.g.dart';

@JsonSerializable()
class PlaylistSongsResponse {
  final List<SongModel> songs;
  final PaginationInfo pagination;

  PlaylistSongsResponse({
    required this.songs,
    required this.pagination,
  });

  factory PlaylistSongsResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaylistSongsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlaylistSongsResponseToJson(this);
}
