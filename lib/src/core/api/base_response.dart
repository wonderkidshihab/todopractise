abstract interface class BaseResponse {
  Map<String, dynamic>? data;
  String? message;
  int? statusCode;
  bool? success;

  BaseResponse({this.data, this.message, this.statusCode, this.success});

  @override
  String toString() {
    return 'BaseResponse{data: $data, message: $message, statusCode: $statusCode, success: $success}';
  }
}

class BaseResponseImpl implements BaseResponse {
  @override
  Map<String, dynamic>? data;

  @override
  String? message;

  @override
  int? statusCode;

  @override
  bool? success;

  BaseResponseImpl({this.data, this.message, this.statusCode, this.success});

  @override
  String toString() {
    return 'BaseResponseImpl{data: $data, message: $message, statusCode: $statusCode, success: $success}';
  }
}
