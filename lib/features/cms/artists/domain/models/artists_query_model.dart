class ArtistsQueryModel {
  final int page;
  final int size;
  final String? sortBy;
  final String? order;

  ArtistsQueryModel({
    required this.page,
    required this.size,
    this.sortBy,
    this.order,
  });

  factory ArtistsQueryModel.fromJson(Map<String, dynamic> json) {
    return ArtistsQueryModel(
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
    return 'ArtistsQueryModel(page: $page, size: $size, sortBy: $sortBy, order: $order)';
  }
}
