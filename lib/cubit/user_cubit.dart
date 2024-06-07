import 'package:auth_app1/cach/cache_helper.dart';
import 'package:auth_app1/core/api/end_points.dart';
import 'package:auth_app1/cubit/user_state.dart';
import 'package:auth_app1/models/logOut_model.dart';
import 'package:auth_app1/models/signIn_model.dart';
import 'package:auth_app1/models/signUp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../repositories/user_repo.dart';

class UserCubit extends Cubit<UserState> {
  //final ApiConsumer api;
  final UserRepo userRepo;

  UserCubit(
      // this.api
      {required this.userRepo})
      : super(UserInitial());



  //Sign in email
  TextEditingController signInEmail = TextEditingController();

  //Sign in password
  TextEditingController signInPassword = TextEditingController();




  //Profile Pic
  XFile? profilePic;

  //Sign up name
  TextEditingController signUpName = TextEditingController();

  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();

  //Sign up email
  TextEditingController signUpEmail = TextEditingController();

  //Sign up password
  TextEditingController signUpPassword = TextEditingController();

  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  //update name
  TextEditingController newName = TextEditingController();

  //update Phone
  TextEditingController newPhone = TextEditingController();

  SignInModel? user;
  SignUpModel? signUpModel;


  signIn() async {
    // دي اول مرحلة في التعامل مع ميثود من ال api ولكن دي مش كلين كود لان ممكن يحصل مشاكل في الدايو نفسها فلازم مخليش اعتمادي ع الدايو وافصل كل حاجة عن بعضها عشان اقلل الاعتمادية وكمان اخلي الكلام ف متغيرات عشان اللغبطة واهندل حوار الايرورز
    // try {
    //   emit(SignInLoading());
    //   final response = await Dio().post('https://food-api-omega.vercel.app/api/v1/user/signin',data: {
    //     "email": signInEmail.text,
    //     "password": signInPassword.text
    //   });
    //   emit(SignInSuccess());
    //
    // } on Exception catch (e) {
    //   print(e.toString());
    // }

//==================================================================================================================================
// دي المرحلة التانية بعد م عملنا 3 طبقات عشان اعتمادي ف الريكويست مش يكون ع الدايو لا ببساطه لو عاوز اغيرها واخليها http فبسهوله هغير ملف الدايو واحوله http  وكمان عملنا حوار الايرورز وانه ف كل حاله منه هعمل اي
//       try {
//         emit(SignInLoading());
//         final response = await api.post(
//          EndPoints.signIn,
//           data: {
//             ApiKeys.email: signInEmail.text,
//             ApiKeys.password: signInPassword.text,
//           },
//         );
//         emit(SignInSuccess());
//       } on ServerException catch (e) {
//         emit(SignInFailure(errMessage: e.errorModel.errorMessage));
//       }
//      }
//===================================================================================================================================

    //المرحلة التالتة بقا هتكون التعامل مع الريسبونس اللي راجعلي لازم اعمله موديل عشان اقدر اوصل لمحتوياته وكمان هعوز اخزن التوكين اللي راجع وافك تشفيره عشان ارجع ال id وكمان اخزنه باستخدام sharedPrefs
    // try {
    //   emit(SignInLoading());
    //   final response = await api.post(EndPoints.signIn, data: {
    //     ApiKeys.email: signInEmail.text,
    //     ApiKeys.password: signInPassword.text,
    //   });
    //   emit(SignInSuccess());
    //   user = SignInModel.fromJson(response);
    //   // من باكدج jwt عشان تفكلي تشفير التوكين بتاعي وتطلع ال id
    //   final decodedToken = JwtDecoder.decode(user!.token);
    //   // print(decodedToken['id']);
    //   CacheHelper().saveData(
    //       key: ApiKeys.token, value: user!.token); // هنخزن التوكين بتاعنا
    //   CacheHelper().saveData(
    //       key: ApiKeys.id,
    //       value: decodedToken[ApiKeys.id]); // هنخزن id اللي هيطلع من التوكين
    // } on ServerException catch (e) {
    //   emit(SignInFailure(errMessage: e.errorModel.errorMessage));
    // }
    //============================================================================================================================================

    // رابع مرحلة واخر مرحلة ان عشان الكود يكون كلين اكتر ممكن اي ميثود من اللي انا مستخدمهم جوا الكيوبت دا اعوز استخدمها جوا كيوبت تاني فهضطر اني اكتب كل محتوايتها تاني ودا مش كويس لا ف الحل اني اعمل كلاس اسمه ريبو احط فيه الميثود بتاعتي وانده عليها واحطلها شغل الكيوبت والايميت بتاعها ف الكيوبيت اللي هستخدمها فيه كدا بقيت اقدر استخدمها ف اكتر من كيوبت عادي
    emit(SignInLoading());
    final response = await userRepo.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errMessage) => emit(SignInFailure(errMessage: errMessage)),
      (signInModel) => emit(SignInSuccess()),
    );
  }

  uploadProfilePic(XFile image) {
    profilePic = image;
    emit(UploadProfilePic());
  }

  signUp() async {
    // try {
    //   emit(SignUpLoading());
    //   final response = await api.post(
    //     EndPoints.signUp,
    //     isFormData: true,
    //     data: {
    //       ApiKeys.name: signUpName.text,
    //       ApiKeys.email: signUpEmail.text,
    //       ApiKeys.password: signUpPassword.text,
    //       ApiKeys.confirmPassword: confirmPassword.text,
    //       ApiKeys.phone: signUpPhoneNumber.text,
    //       ApiKeys.profilePic: await uploadProfilePic(profilePic!),
    //       ApiKeys.location:
    //           '{"name":"methalfa","address":"meet halfa","coordinates":[30.1572709,31.224779]}',
    //     },
    //   );
    //   signUpModel = SignUpModel.fromJson(response);
    //   emit(SignUpSuccess(message: signUpModel!.message));
    // } on ServerException catch (e) {
    //   emit(SignUpFailure(errMessage: e.errorModel.errorMessage));
    // }
    emit(SignUpLoading());
    final response = await userRepo.signUp(
      name: signUpName.text,
      email: signUpEmail.text,
      password: signUpPassword.text,
      confirmPassword: confirmPassword.text,
      phone: signUpPhoneNumber.text,
      profilePic: profilePic!,
    );
    response.fold(
      (errMessage) => emit(SignUpFailure(errMessage: errMessage)),
      (signUpModel) => emit(SignUpSuccess(message: signUpModel.message)),
    );
  }

  getUserProfile() async {
    //   try {
    //     emit(GetUserLoading());
    //     final response = await api.get(
    //       EndPoints.getUserDataEndPoint(
    //         CacheHelper().getData(key: ApiKeys.id),
    //       ),
    //     );
    //     emit(GetUserSuccess(
    //       user: UserModel.fromJson(response),
    //     ));
    //   } on ServerException catch (e) {
    //     emit(GetUserFailure(errMessage: e.errorModel.errorMessage));
    //   }
    emit(GetUserLoading());
    final response = await userRepo.getUserProfile();
    response.fold(
      (errorMessage) => emit(GetUserFailure(errMessage: errorMessage)),
      (userModel) => emit(GetUserSuccess(user: userModel)),
    );
  }

  logOut() async {
    emit(LogOutLoading());
    final response = await userRepo.logOut();
    response.fold(
      (errMessage) => emit(LogOutFailure(errMessage: errMessage)),
      (logOutModel) => LogOutModel(message: logOutModel.message),
    );
  }

  updateUserInfo() async {
    emit(UpdateLoading());
    final response = await userRepo.updateUserInfo(
      name: newName.text.isEmpty ? CacheHelper().getData(key: ApiKeys.name) : newName.text,
      phone: newPhone.text.isEmpty ? CacheHelper().getData(key: ApiKeys.id) : newPhone.text,
      profilePic: profilePic
    );

    response.fold(
      (errMessage) => emit(LogOutFailure(errMessage: errMessage)),
      (updateModel) =>emit (LogOutSuccess(message:updateModel.message )) ,
    );
  }
}
