// models/songs_query_model.dart
class SongsQueryModel {
  final int page;
  final int size;
  final String? sortBy;
  final String? order;

  SongsQueryModel({
    required this.page,
    required this.size,
    this.sortBy,
    this.order,
  });

  factory SongsQueryModel.fromJson(Map<String, dynamic> json) {
    return SongsQueryModel(
      page: json['page'] ?? 1,
      size: json['size'] ?? 10,
      sortBy: json['sort_by'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
      if (sortBy != null) 'sort_by': sortBy,
      if (order != null) 'order': order,
    };
  }

  @override
  String toString() {
    return 'SongsQueryModel(page: $page, size: $size, sortBy: $sortBy, order: $order)';
  }
}