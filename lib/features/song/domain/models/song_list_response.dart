import 'package:groovix/core/shared/model/song_model.dart';

class SongsListResponse {
  final List<SongModel> songs;
  final SongPaginationModel pagination;

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
      pagination: SongPaginationModel.fromJson(json['pagination'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'songs': songs.map((song) => song.toJson()).toList(),
      'pagination': pagination.toJson(),
    };
  }
}

class SongPaginationModel {
  final int total;
  final int page;
  final int size;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  SongPaginationModel({
    required this.total,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory SongPaginationModel.fromJson(Map<String, dynamic> json) {
    return SongPaginationModel(
      total: json['total'] ?? 0,
      page: json['page'] ?? 1,
      size: json['size'] ?? 10,
      totalPages: json['total_pages'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrevious: json['has_previous'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'size': size,
      'total_pages': totalPages,
      'has_next': hasNext,
      'has_previous': hasPrevious,
    };
  }
}
