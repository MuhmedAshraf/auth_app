import 'package:auth_app1/core/api/end_points.dart';

class UpdateModel {
  final String message;

  UpdateModel({required this.message});

  factory UpdateModel.fromJson(Map<String, dynamic> jsonData) {
    return UpdateModel(
      message: jsonData[ApiKeys.message],
    );
  }
}