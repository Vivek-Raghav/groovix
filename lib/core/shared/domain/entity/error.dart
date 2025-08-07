class ErrorEntity {
  ErrorEntity({
    this.message,
    this.httpErrorCode,
    this.code,
    this.explanation,
    this.additionalInfo,
  });

  String? message;
  int? httpErrorCode;
  String? code;
  String? explanation;
  Map<String, dynamic>? additionalInfo;
}
