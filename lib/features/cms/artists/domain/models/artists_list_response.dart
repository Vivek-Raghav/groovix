// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

class ArtistsListResponse {
  final List<ArtistModel> artists;
  final PaginationInfo pagination;

  const ArtistsListResponse({
    required this.artists,
    required this.pagination,
  });

  factory ArtistsListResponse.fromJson(Map<String, dynamic> json) {
    return ArtistsListResponse(
      artists: (json['artists'] as List)
          .map((artist) => ArtistModel.fromJson(artist as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationInfo.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artists': artists.map((artist) => artist.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }

  @override
  String toString() {
    return 'ArtistsListResponse(artists: ${artists.length}, pagination: $pagination)';
  }
}
