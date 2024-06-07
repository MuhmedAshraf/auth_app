import 'package:auth_app1/core/api/api_consumer.dart';
import 'package:auth_app1/core/function/upload_image_to_api.dart';
import 'package:auth_app1/models/logOut_model.dart';
import 'package:auth_app1/models/signIn_model.dart';
import 'package:auth_app1/models/signUp_model.dart';
import 'package:auth_app1/models/update_model.dart';
import 'package:auth_app1/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../cach/cache_helper.dart';
import '../core/api/end_points.dart';
import '../core/errors/exceptions.dart';

class UserRepo {
  final ApiConsumer api;

  UserRepo({required this.api});

  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(EndPoints.signIn,
          data: {ApiKeys.email: email, ApiKeys.password: password});

      final user = SignInModel.fromJson(response);

      final decodedToken = JwtDecoder.decode(user.token);

      CacheHelper().saveData(key: ApiKeys.token, value: user.token);
      CacheHelper().saveData(key: ApiKeys.id, value: decodedToken[ApiKeys.id]);
      CacheHelper().saveData(key: ApiKeys.name, value: decodedToken[ApiKeys.name]);
      CacheHelper().saveData(key: ApiKeys.phone, value: decodedToken["iat"]);


      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required XFile profilePic,
  }) async {
    try {
      final response = await api.post(
        EndPoints.signUp,
        isFormData: true,
        data: {
          ApiKeys.name: name,
          ApiKeys.email: email,
          ApiKeys.password: password,
          ApiKeys.confirmPassword: confirmPassword,
          ApiKeys.phone: phone,
          ApiKeys.profilePic: await uploadImageToApi(profilePic),
          ApiKeys.location:
              '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
        },
      );

      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final response = await api.get(
        EndPoints.getUserDataEndPoint(
          CacheHelper().getData(key: ApiKeys.id),
        ),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, LogOutModel>> logOut() async {
    try {
      final response = await api.get(EndPoints.logOut);
      return Right(LogOutModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, UpdateModel>> updateUserInfo({
    required String name,
    required String phone,
     XFile? profilePic,
  }
      ) async {
    try {
      final response = await api.patch(
        EndPoints.update,
        isFormData: true,
        data: {
          ApiKeys.name: name,
          ApiKeys.phone: phone,
          ApiKeys.location:
          '{"name":"Bishbish","address":"Bishbish","coordinates":[30.1572709,31.224779]}',
           ApiKeys.profilePic: await uploadImageToApi(profilePic!),
        },
      );


      final updateModel = UpdateModel.fromJson(response);
      return Right(updateModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
