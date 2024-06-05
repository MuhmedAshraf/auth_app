import 'package:auth_app1/cubit/user_cubit.dart';
import 'package:auth_app1/cubit/user_state.dart';
import 'package:auth_app1/screens/sign_in_screen.dart';
import 'package:auth_app1/screens/update_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_form_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is GetUserFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          } else if (state is LogOutSuccess) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInScreen()));
          } else if (state is LogOutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errMessage),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state is GetUserLoading
                ? const CircularProgressIndicator()
                : state is GetUserSuccess
                    ? ListView(
                        children: [
                          const SizedBox(height: 16),
                          //! Profile Picture
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(state.user.profilePic),
                          ),
                          const SizedBox(height: 16),

                          //! Name
                          ListTile(
                            title: Text(state.user.name),
                            leading: const Icon(Icons.person),
                          ),
                          const SizedBox(height: 16),

                          //! Email
                          ListTile(
                            title: Text(state.user.email),
                            leading: const Icon(Icons.email),
                          ),
                          const SizedBox(height: 16),

                          //! Phone number
                          ListTile(
                            title: Text(state.user.phone),
                            leading: const Icon(Icons.phone),
                          ),
                          const SizedBox(height: 16),

                          //! Address
                          ListTile(
                            title: Text(state.user.address['type']),
                            leading: const Icon(Icons.location_city),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomFormButton(
                              innerText: 'update',
                              buttonColor: Colors.redAccent,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const UpdateScreen()));
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          state is LogOutLoading
                              ? const CircularProgressIndicator()
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomFormButton(
                                    innerText: 'Log Out',
                                    onPressed: () {
                                      context.read<UserCubit>().logOut();
                                    },
                                  ),
                                ),
                        ],
                      )
                    : Container(),
          );
        },
      ),
    );
  }
}
