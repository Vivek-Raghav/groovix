import 'package:groovix/core/models/song_model.dart';
import 'package:groovix/core/models/pagination_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genre_songs_response.g.dart';

@JsonSerializable()
class GenreSongsResponse {
  final List<SongModel> songs;
  final PaginationInfo pagination;

  GenreSongsResponse({
    required this.songs,
    required this.pagination,
  });

  factory GenreSongsResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreSongsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenreSongsResponseToJson(this);
}
