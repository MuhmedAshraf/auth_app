import 'package:auth_app1/core/api/end_points.dart';

class LogOutModel {
  final String message;

  LogOutModel({required this.message});

  factory LogOutModel.fromJson(Map<String, dynamic> jsonData) {
    return LogOutModel(
      message: jsonData[ApiKeys.message],
    );
  }
}
