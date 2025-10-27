class AddSongsResponse {
  final String message;
  final int addedCount;
  final int failedCount;

  AddSongsResponse({
    required this.message,
    required this.addedCount,
    required this.failedCount,
  });

  factory AddSongsResponse.fromJson(Map<String, dynamic> json) =>
      AddSongsResponse(
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
