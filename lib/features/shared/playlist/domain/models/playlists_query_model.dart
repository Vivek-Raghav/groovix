class PlaylistsQueryModel {
  final int page;
  final int size;
  final String? sortBy;
  final String? order;

  PlaylistsQueryModel({
    required this.page,
    required this.size,
    this.sortBy,
    this.order,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'page': page, 'size': size};
    if (sortBy != null) data['sort_by'] = sortBy;
    if (order != null) data['order'] = order;
    return data;
  }

  @override
  String toString() {
    return 'PlaylistsQueryModel(page: $page, size: $size, sortBy: $sortBy, order: $order)';
  }
}
