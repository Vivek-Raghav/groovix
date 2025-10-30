// Project imports:
import 'package:groovix/core/models/genre_model.dart';
import 'package:groovix/core/models/pagination_info.dart';

class GenresListResponse {
  final List<GenreModel> genres;
  final PaginationInfo pagination;

  const GenresListResponse({
    required this.genres,
    required this.pagination,
  });

  factory GenresListResponse.fromJson(Map<String, dynamic> json) {
    return GenresListResponse(
      genres: (json['genres'] as List)
          .map((genre) => GenreModel.fromJson(genre))
          .toList(),
      pagination: PaginationInfo.fromJson(json['pagination']),
    );
  }

  @override
  String toString() {
    return 'GenresListResponse(genres: ${genres.length}, pagination: $pagination)';
  }
}
