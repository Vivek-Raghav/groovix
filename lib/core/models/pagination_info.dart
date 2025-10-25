class PaginationInfo {
  final int total;
  final int page;
  final int size;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  const PaginationInfo({
    required this.total,
    required this.page,
    required this.size,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      total: json['total'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      totalPages: json['total_pages'] as int,
      hasNext: json['has_next'] as bool,
      hasPrevious: json['has_previous'] as bool,
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

  @override
  String toString() {
    return 'PaginationInfo(total: $total, page: $page, size: $size, totalPages: $totalPages, hasNext: $hasNext, hasPrevious: $hasPrevious)';
  }
}
