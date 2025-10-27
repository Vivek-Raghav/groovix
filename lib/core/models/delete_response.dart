class DeleteResponse {
  final String message;

  const DeleteResponse({
    required this.message,
  });

  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResponse(
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  @override
  String toString() {
    return 'DeleteResponse(message: $message)';
  }
}
