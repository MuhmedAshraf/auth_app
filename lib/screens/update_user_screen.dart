import 'package:auth_app1/cubit/user_state.dart';
import 'package:auth_app1/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/user_cubit.dart';
import '../widgets/custom_form_button.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/page_header.dart';
import '../widgets/page_heading.dart';
import '../widgets/pick_image_widget.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errMessage)));
          } else if (state is UpdateSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
             context.read<UserCubit>().getUserProfile();
            Navigator.push(
              context,MaterialPageRoute(builder: (context)=> const ProfileScreen())
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xffEEF1F3),
            body: SingleChildScrollView(
              child: Form(
                key: context.read<UserCubit>().updateFormKey,
                child: Column(
                  children: [
                    const PageHeader(),
                    const PageHeading(title: 'Update-Info'),
                    const PickImageWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      labelText: 'Name',
                      hintText: 'Your name',
                      isDense: true,
                      controller: context.read<UserCubit>().newName,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomInputField(
                      labelText: 'Phone number',
                      hintText: 'Your phone number ex:01234567890',
                      isDense: true,
                      controller: context.read<UserCubit>().newPhone,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    state is UpdateLoading
                        ? const CircularProgressIndicator()
                        : CustomFormButton(
                            innerText: 'Update',
                            onPressed: () {
                              context.read<UserCubit>().updateUserInfo();
                            },
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
