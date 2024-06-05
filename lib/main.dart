

import 'package:auth_app1/cach/cache_helper.dart';
import 'package:auth_app1/core/api/dio_consumer.dart';
import 'package:auth_app1/repositories/user_repo.dart';
import 'package:auth_app1/screens/sign_in_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(
    BlocProvider(
      create: (context) => UserCubit(
       userRepo: UserRepo(api: DioConsumer(dio: Dio()))
        //  DioConsumer(dio: Dio())
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
