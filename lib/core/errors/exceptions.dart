import 'package:auth_app1/core/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          //بخليه ف الحالة دي يرمي سيرفر اكسيبشن ودا كلاس انا عامله عشان اخليه يشيل حاجه معاه والحاجة دي هتعرفني نوع الايرور اللي طلع
          errorModel: ErrorModel.fromJson(e.response!.data));

    case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data)); // bad Request
        case 401:
          throw ServerException(
              errorModel:
                  ErrorModel.fromJson(e.response!.data)); // Un Authorized
        case 403:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data)); // forbidden
        case 404:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data)); // Not Found
        case 409:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data)); // coefficient
        case 422:
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response!.data),
          ); // Un Processable Entity
        case 504:
          throw ServerException(
              errorModel:
                  ErrorModel.fromJson(e.response!.data)); // Server Exception
      }
  }
}
