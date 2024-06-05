import 'package:auth_app1/core/api/end_points.dart';

class UserModel {
  final String name;
  final String phone;
  final String email;
  final String profilePic;
  final Map<String, dynamic> address;

  UserModel(
      {required this.profilePic,
      required this.name,
      required this.phone,
      required this.email,
      required this.address});

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        name: jsonData['user'][ApiKeys.name],
        phone: jsonData['user'][ApiKeys.phone],
        email: jsonData['user'][ApiKeys.email],
        profilePic: jsonData['user'][ApiKeys.profilePic],
        address: jsonData['user'][ApiKeys.location]);
  }
}
