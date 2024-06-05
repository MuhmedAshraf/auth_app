 import 'package:auth_app1/models/user_model.dart';

class UserState {}

 class UserInitial extends UserState {}
 class SignInLoading extends UserState {}
 class SignInSuccess extends UserState {}
 class SignInFailure extends UserState {
 final String errMessage;

  SignInFailure({required this.errMessage});
 }
 class UploadProfilePic extends UserState{}
//================================================================
 class SignUpLoading extends UserState {}
 class SignUpSuccess extends UserState {
 final String message;

  SignUpSuccess({required this.message});
 }
 class SignUpFailure extends UserState {
  final String errMessage;

  SignUpFailure({required this.errMessage});
 }
 //================================================================
class GetUserSuccess extends UserState{
 final UserModel user ;

  GetUserSuccess({required this.user});

}
 class GetUserLoading extends UserState{}
 class GetUserFailure extends UserState{
 final String errMessage;

  GetUserFailure({required this.errMessage});
 }
 //==========================================================================
 class LogOutLoading extends UserState{}
 class LogOutSuccess extends UserState{
 final String message;

  LogOutSuccess({required this.message});
 }
 class LogOutFailure extends UserState{
 final String errMessage;

  LogOutFailure({required this.errMessage});

 }
 //============================================================================
 class UpdateLoading extends UserState{}
 class UpdateSuccess extends UserState{
  final String message;

  UpdateSuccess({required this.message});
 }
 class UpdateFailure extends UserState{
  final String errMessage;

  UpdateFailure({required this.errMessage});

 }