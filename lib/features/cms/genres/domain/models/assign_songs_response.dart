class AssignSongsResponse {
  final String message;
  final int addedCount;
  final int failedCount;

  AssignSongsResponse({
    required this.message,
    required this.addedCount,
    required this.failedCount,
  });

  factory AssignSongsResponse.fromJson(Map<String, dynamic> json) =>
      AssignSongsResponse(
        message: json['message'] as String,
        addedCount: json['added_count'] as int,
        failedCount: json['failed_count'] as int,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'added_count': addedCount,
        'failed_count': failedCount,
      };
}
